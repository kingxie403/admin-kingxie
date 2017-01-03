package com.lte.controller.flow;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysUser;
import com.lte.controller.util.UserUtil;
import org.activiti.engine.FormService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.FormType;
import org.activiti.engine.form.StartFormData;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.zip.ZipInputStream;

/**
 * Created by think on 2016/12/12.
 */
@Controller
@RequestMapping("/flow")
public class FlowDefinitionController extends BaseController {

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private FormService formService;
    @Autowired
    private IdentityService identityService;
    /**
     * 获取流程定义列表
     *
     * @return
     */
    @RequestMapping(value = "/process/list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView modelAndView = new ModelAndView("admin/flow/definition/process-list");
        List<ProcessDefinition> processDefinitionList =
                repositoryService.createProcessDefinitionQuery().list();
        modelAndView.addObject("processDefinitionList", processDefinitionList);
        return modelAndView;
    }

    /**
     * 上传文件，定义新流程
     *
     * @param processFile
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/deployment")
    public String deploy(@RequestParam(value = "processInputFile") MultipartFile processFile) {
        Map<String, String> resMap = new HashMap<>();
        try {
            String fileName = processFile.getOriginalFilename();
            String extension = FilenameUtils.getExtension(fileName);
            InputStream inputStream = processFile.getInputStream();
            DeploymentBuilder deployment = repositoryService.createDeployment();
            if (extension.equals("zip")) {
                ZipInputStream zipInputStream = new ZipInputStream(inputStream);
                deployment.addZipInputStream(zipInputStream);
            } else {
                deployment.addInputStream(fileName, inputStream);
            }
            deployment.deploy();
            //校验流程定义是否部署成功
            ProcessDefinitionQuery pdq = repositoryService.createProcessDefinitionQuery();
            long count = pdq.processDefinitionKey("candidateUserInUserTask").count();
            System.out.println(count);
            resMap.put("msg", "suc");
        } catch (IOException e) {
            return responseFail(e.getMessage());
        }
        return responseSuccess(resMap);
    }

    /**
     * 读取流程定义XML
     *
     * @param processDefinitionId 流程定义ID
     * @param resourceName        资源名称
     * @param response
     */
    @RequestMapping(value = "/read/resource", method = RequestMethod.GET)
    public void readResource(@RequestParam("pdid") String processDefinitionId,
                             @RequestParam("resourceName") String resourceName,
                             HttpServletResponse response) {
        ProcessDefinitionQuery pdq = repositoryService.createProcessDefinitionQuery();
        ProcessDefinition pd = pdq.processDefinitionId(processDefinitionId).singleResult();
        InputStream resourceAsStream = repositoryService.getResourceAsStream(pd.getDeploymentId(), resourceName);

        byte[] b = new byte[1024];
        int len = -1;
        try {
            while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
                response.getOutputStream().write(b, 0, len);
            }
            resourceAsStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除部署的流程
     *
     * @param deploymentId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete/deployment/{deploymentId}", method = RequestMethod.POST)
    public String deleteProcess(@PathVariable("deploymentId") String deploymentId) {
        Map<String, String> resMap = new HashMap<>();
        repositoryService.deleteDeployment(deploymentId, true);
        resMap.put("msg", "suc");
        return responseSuccess(resMap);
    }

    /**
     * 读取启动流程的表单字段
     *
     * @param processDefinitionId
     * @return
     */
    @RequestMapping(value = "/form/process/start/{processDefinitionId}", method = RequestMethod.GET)
    public ModelAndView readStartForm(@PathVariable("processDefinitionId") String processDefinitionId) {
        ModelAndView mav = new ModelAndView("admin/flow/definition/start-process-form");
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(
                processDefinitionId).singleResult();
        boolean hasStartFormKey = processDefinition.hasStartFormKey();
        //判断是否有formkey属性
        if (hasStartFormKey) {
            Object renderedStartForm = formService.getRenderedStartForm(processDefinitionId);
            mav.addObject("startFormData", renderedStartForm);
            mav.addObject("processDefinition", processDefinition);
        } else {//动态表单字段
            StartFormData startFormData = formService.getStartFormData(processDefinitionId);
            mav.addObject("startFormData", startFormData);
        }
        mav.addObject("hasStartFormKey", hasStartFormKey);
        mav.addObject("processDefinitionId", processDefinitionId);
        return mav;
    }

    /**
     * 启动流程
     * @param processDefinitionId
     * @param request
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/process/start/{processDefinitionId}", method = RequestMethod.POST)
    public String startProcess(@PathVariable("processDefinitionId") String processDefinitionId,
                               HttpServletRequest request, RedirectAttributes redirectAttributes) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(
                processDefinitionId).singleResult();
        boolean hasStartFormKey = processDefinition.hasStartFormKey();
        Map<String, String> formValues = new HashMap<String, String>();
        if (hasStartFormKey) { // formkey表单
            Map<String, String[]> parameterMap = request.getParameterMap();
            Set<Map.Entry<String, String[]>> entrySet = parameterMap.entrySet();
            for (Map.Entry<String, String[]> entry : entrySet) {
                String key = entry.getKey();
                formValues.put(key, entry.getValue()[0]);
            }
        } else {// 动态表单
            // 先读取表单字段在根据表单字段的ID读取请求参数值
            StartFormData formData = formService.getStartFormData(processDefinitionId);

            // 从请求中获取表单字段的值
            List<FormProperty> formProperties = formData.getFormProperties();
            for (FormProperty formProperty : formProperties) {
                String value = request.getParameter(formProperty.getId());
                formValues.put(formProperty.getId(), value);
            }
            // 获取当前登录的用户
            SysUser sysUser = UserUtil.getUserFromSession(request);
            // 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
            if (sysUser == null || StringUtils.isBlank(sysUser.getUserName())) {
                return "redirect:/login?timeout=true";
            }
            identityService.setAuthenticatedUserId(String.valueOf(sysUser.getUserId()));

            // 提交表单字段并启动一个新的流程实例
            ProcessInstance processInstance = formService.submitStartFormData(processDefinitionId, formValues);
            logger.debug("start a processinstance: {}", processInstance);
            redirectAttributes.addFlashAttribute("message", "流程已启动，实例ID：" + processInstance.getId());
        }
        return "redirect:/flow/process/list";
    }


}
