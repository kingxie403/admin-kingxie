package com.lte.controller.flow;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.lte.activiti.common.Page;
import com.lte.activiti.common.PageUtil;
import com.lte.controller.base.BaseController;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.NativeModelQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/12/29.
 */
@Controller
@RequestMapping("/flow")
public class ModelController extends BaseController{
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 模型列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/model/list",method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView("admin/flow/model/list");
        Page<Model> page = new Page<Model>(PageUtil.PAGE_SIZE);
        int[] pageParams = PageUtil.init(page, request);

        NativeModelQuery query =  repositoryService.createNativeModelQuery();
        String sql  = "select ams.* from act_re_model ams";
        List<Model> modelList = query.sql(sql).listPage(pageParams[0],pageParams[1]);
        page.setResult(modelList);
        page.setTotalCount(query.sql("select count(*) from (" + sql + ") count_ams").count());
        modelAndView.addObject("page",page);
        return modelAndView;
    }

    /**
     * 删除模型
     * @param modelId
     * @return
     */
    @RequestMapping(value = "/model/delete/{modelId}",method = RequestMethod.POST)
    public String delete(@PathVariable("modelId") String modelId){
        Map<String,String> map = new HashMap<>();
        try {
            repositoryService.deleteModel(modelId);
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    /**
     * 部署模型
     * @param modelId
     * @return
     */
    @RequestMapping(value = "/model/deploy/{modelId}",method = RequestMethod.POST)
    public String deploy(@PathVariable("modelId") String modelId){
        Map<String,String> map = new HashMap<>();
        Model modelData = repositoryService.getModel(modelId);
        try {
            ObjectNode modelNode = (ObjectNode) objectMapper.readTree(
                    repositoryService.getModelEditorSource(modelData.getId()));
            byte[] bpmnBytes = null;
            BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
            bpmnBytes = new BpmnXMLConverter().convertToXML(model);
            String processName = modelData.getName() + ".bpmn20.xml";
            Deployment deployment = repositoryService.createDeployment().name(modelData.getName()).addString(processName, new String(bpmnBytes,"utf-8")).deploy();
            map.put("msg", "sucs");
            return responseSuccess(map);
        } catch (IOException e) {
            return responseFail(e.getMessage());
        }
    }

}
