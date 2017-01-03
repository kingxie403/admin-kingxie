package com.lte.controller.flow;

import com.lte.activiti.common.Page;
import com.lte.activiti.common.PageUtil;
import com.lte.controller.base.BaseController;
import com.lte.controller.util.TraceUtil;
import com.lte.controller.util.UserUtil;
import com.lte.entity.SysUser;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.NativeExecutionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/12/21.
 */
@Controller
@RequestMapping("/execution")
public class ExecutionController extends BaseController {
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private TaskService taskService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/flow/execution/list");
        SysUser user = UserUtil.getUserFromSession(request);
        Page<Execution> page = new Page<Execution>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);
        NativeExecutionQuery nativeExecutionQuery = runtimeService.createNativeExecutionQuery();

        // native query
        String sql = "select RES.* from ACT_RU_EXECUTION RES left join ACT_HI_TASKINST ART on ART.PROC_INST_ID_ = RES.PROC_INST_ID_ "
                + " where ART.ASSIGNEE_ = #{userId} and ACT_ID_ is not null and IS_ACTIVE_ = 1 order by START_TIME_ desc";

        nativeExecutionQuery.parameter("userId", user.getUserId());

        List<Execution> executionList = nativeExecutionQuery.sql(sql).listPage(pageParams[0], pageParams[1]);

        // 查询流程定义对象
        Map<String, ProcessDefinition> definitionMap = new HashMap<String, ProcessDefinition>();

        // 任务的英文-中文对照
        Map<String, Task> taskMap = new HashMap<String, Task>();

        // 每个Execution的当前活动ID，可能为多个
        Map<String, List<String>> currentActivityMap = new HashMap<String, List<String>>();

        // 设置每个Execution对象的当前活动节点
        for (Execution execution : executionList) {
            ExecutionEntity executionEntity = (ExecutionEntity) execution;
            String processInstanceId = executionEntity.getProcessInstanceId();
            String processDefinitionId = executionEntity.getProcessDefinitionId();

            // 缓存ProcessDefinition对象到Map集合
            TraceUtil.definitionCache(definitionMap, processDefinitionId,repositoryService);

            // 查询当前流程的所有处于活动状态的活动ID，如果并行的活动则会有多个
            List<String> activeActivityIds = runtimeService.getActiveActivityIds(execution.getId());
            currentActivityMap.put(execution.getId(), activeActivityIds);

            for (String activityId : activeActivityIds) {

                // 查询处于活动状态的任务
                Task task = taskService.createTaskQuery().taskDefinitionKey(activityId).executionId(execution.getId()).singleResult();

                // 调用活动
                if (task == null) {
                    ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                            .superProcessInstanceId(processInstanceId).singleResult();
                    task = taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId()).singleResult();
                    TraceUtil.definitionCache(definitionMap, processInstance.getProcessDefinitionId(),repositoryService);
                }
                taskMap.put(activityId, task);
            }
        }

        mav.addObject("taskMap", taskMap);
        mav.addObject("definitions", definitionMap);
        mav.addObject("currentActivityMap", currentActivityMap);

        page.setResult(executionList);
        page.setTotalCount(nativeExecutionQuery.sql("select count(*) from (" + sql + ") running_tasks").count());
        mav.addObject("page", page);
        return mav;
    }



}
