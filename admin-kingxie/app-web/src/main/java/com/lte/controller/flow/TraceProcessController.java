package com.lte.controller.flow;

import com.lte.activiti.common.Page;
import com.lte.activiti.common.PageUtil;
import com.lte.controller.base.BaseController;
import com.lte.controller.util.TraceUtil;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricDetail;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.NativeProcessInstanceQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.image.ProcessDiagramGenerator;
import org.activiti.image.impl.DefaultProcessDiagramGenerator;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/12/22.
 */
@Controller
@RequestMapping("/process/trace")
public class TraceProcessController extends BaseController {
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private HistoryService historyService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private ProcessEngineConfiguration processEngineConfiguration;


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/flow/trace/list");
        Page<TraceContent> page = new Page<TraceContent>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        NativeProcessInstanceQuery nativeProcessInstanceQuery = runtimeService.createNativeProcessInstanceQuery();
        // native query
        String sql = "select ahps.* from act_hi_procinst ahps";
        List<ProcessInstance> processInstanceList = nativeProcessInstanceQuery.sql(sql).listPage(pageParams[0],
                pageParams[1]);

        List<TraceContent> traceContentList = new ArrayList<>();
        for (ProcessInstance processInstance : processInstanceList) {
            ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInstance.getId
                    ()).singleResult();
            TraceContent traceContent = new TraceContent();
            traceContent.setProcessDefinitionId(processInstance.getProcessDefinitionId());
            traceContent.setProcessDefinitionName(processInstance.getName());
            traceContent.setProcessInstanceId(processInstance.getProcessInstanceId());
            if (pi == null) {
                traceContent.setCurrentTask("已结束");
            } else {
                traceContent.setCurrentTask("流程中");
            }
            traceContentList.add(traceContent);
        }

        // 查询流程定义对象
        Map<String, ProcessDefinition> definitionMap = new HashMap<String, ProcessDefinition>();
        for (ProcessInstance pi : processInstanceList) {
            String processDefinitionId = pi.getProcessDefinitionId();
            // 缓存ProcessDefinition对象到Map集合
            TraceUtil.definitionCache(definitionMap, processDefinitionId, repositoryService);
        }
        mav.addObject("definitions", definitionMap);
        page.setResult(traceContentList);
        page.setTotalCount(nativeProcessInstanceQuery.sql("select count(*) from (" + sql + ") running_ahps").count());
        mav.addObject("page", page);
        return mav;
    }

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public void view(String processInstanceId, HttpServletResponse response) {
        //获取历史流程实例
        HistoricProcessInstance processInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        //获取流程图
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
        ProcessDefinitionEntity definitionEntity = (ProcessDefinitionEntity) repositoryService.getProcessDefinition
                (processInstance.getProcessDefinitionId());

        List<HistoricActivityInstance> highLightedActivitList = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId).list();
        //高亮环节id集合
        List<String> highLightedActivitis = new ArrayList<String>();
        //高亮线路id集合
        List<String> highLightedFlows = TraceUtil.getHighLightedFlows(definitionEntity, highLightedActivitList);

        for (HistoricActivityInstance tempActivity : highLightedActivitList) {
            String activityId = tempActivity.getActivityId();
            ProcessInstance result = runtimeService.createProcessInstanceQuery().processInstanceId
                    (tempActivity.getProcessInstanceId()).singleResult();
            if(result != null){//流程中
                List<Execution> executions = runtimeService.createExecutionQuery().activityId(activityId).list();
                if(executions != null && executions.size()>0 ){
                    highLightedActivitis.add(activityId);
                }
            }else{//流程已结束
                if(tempActivity.getActivityType().equals("endEvent")){
                    highLightedActivitis.add(activityId);
                }
            }
        }
        String activityFontName = processEngineConfiguration.getActivityFontName();
        String labelFontName = processEngineConfiguration.getLabelFontName();
        String annotationFontName = processEngineConfiguration.getAnnotationFontName();
        try {
//            InputStream imageStream = dpdg.generateDiagram(bpmnModel, "png", activeActivityIds, highLightedFlows);
            InputStream imageStream = new DefaultProcessDiagramGenerator().generateDiagram(bpmnModel, "png",
                    highLightedActivitis, highLightedFlows,
                    activityFontName, labelFontName, annotationFontName, processEngineConfiguration.getClassLoader(),
                    1.0D);

            // 输出资源内容到相应对象
            IOUtils.copy(imageStream, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 读取历史数据
     *
     * @return
     */
    @RequestMapping(value = "view/{executionId}", method = RequestMethod.GET)
    public ModelAndView historyDatas(@PathVariable("executionId") String executionId) {
        ModelAndView mav = new ModelAndView("admin/flow/execution/trace-process");

        // 查询Execution对象
        Execution execution = runtimeService.createExecutionQuery().executionId(executionId).singleResult();

        // 查询所有的历史活动记录
        String processInstanceId = execution.getProcessInstanceId();
        List<HistoricActivityInstance> activityInstances = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId).list();

        // 查询历史流程实例
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();

        // 查询流程有关的变量
        List<HistoricVariableInstance> variableInstances = historyService.createHistoricVariableInstanceQuery()
                .processInstanceId(processInstanceId).list();

        List<HistoricDetail> formProperties = historyService.createHistoricDetailQuery().processInstanceId
                (processInstanceId).formProperties().list();

        // 查询流程定义对象
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(historicProcessInstance.getProcessDefinitionId()).singleResult();

        // 查询运行时流程实例
        ProcessInstance parentProcessInstance = runtimeService.createProcessInstanceQuery()
                .subProcessInstanceId(execution.getProcessInstanceId()).singleResult();

        mav.addObject("parentProcessInstance", parentProcessInstance);
        mav.addObject("historicProcessInstance", historicProcessInstance);
        mav.addObject("variableInstances", variableInstances);
        mav.addObject("activities", activityInstances);
        mav.addObject("formProperties", formProperties);
        mav.addObject("processDefinition", processDefinition);
        mav.addObject("executionId", executionId);

        return mav;
    }


    /**
     * 读取流程资源
     */
    @RequestMapping(value = "data/auto/{executionId}", method = RequestMethod.GET)
    public void readResource(@PathVariable("executionId") String executionId, HttpServletResponse response) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(executionId)
                .singleResult();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl)
                repositoryService)
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<String> activeActivityIds = runtimeService.getActiveActivityIds(executionId);
        List<String> highLightedFlows = TraceUtil.getHighLightedFlows(processDefinition, processInstance.getId(),
                historyService, runtimeService);
        ProcessDiagramGenerator diagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();
        /*InputStream imageStream =diagramGenerator.generateDiagram(bpmnModel, "png", activeActivityIds,
        highLightedFlows);*/
        // 输出资源内容到相应对象
        String activityFontName = processEngineConfiguration.getActivityFontName();
        String labelFontName = processEngineConfiguration.getLabelFontName();
        String annotationFontName = processEngineConfiguration.getAnnotationFontName();
        DefaultProcessDiagramGenerator dpdg = new DefaultProcessDiagramGenerator();
        try {
            InputStream imageStream = dpdg.generateDiagram(bpmnModel, "png", activeActivityIds, highLightedFlows);
        /*InputStream imageStream = new DefaultProcessDiagramGenerator().generateDiagram(bpmnModel,"png",
        activeActivityIds, highLightedFlows,
                activityFontName,labelFontName,annotationFontName,processEngineConfiguration.getClassLoader(),1.0D);*/

            // 输出资源内容到相应对象
            IOUtils.copy(imageStream, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
