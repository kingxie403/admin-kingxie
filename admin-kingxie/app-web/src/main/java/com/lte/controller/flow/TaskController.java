package com.lte.controller.flow;

import com.lte.controller.base.BaseController;
import com.lte.controller.util.UserUtil;
import com.lte.entity.SysUser;
import org.activiti.engine.FormService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by think on 2016/12/20.
 */
@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {
    @Autowired
    private TaskService taskService;
    @Autowired
    private FormService formService;

    /**
     * 未签收任务列表
     * @param httpServletRequest
     * @return
     */
    @RequestMapping(value = "not/claim/list",method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest httpServletRequest){
        ModelAndView mav = new ModelAndView("admin/task/not/list");
        SysUser sysUser = UserUtil.getUserFromSession(httpServletRequest);
        // 等待签收的任务
        List<Task> waitingClaimTasks = taskService.createTaskQuery().taskCandidateUser(String.valueOf(sysUser.getUserId())).list();
        mav.addObject("tasks", waitingClaimTasks);
        return mav;
    }

    /**
     * 已签收任务列表
     * @param httpServletRequest
     * @return
     */
    @RequestMapping(value = "claim/list",method = RequestMethod.GET)
    public ModelAndView dolist(HttpServletRequest httpServletRequest){
        ModelAndView mav = new ModelAndView("admin/task/list");
        SysUser sysUser = UserUtil.getUserFromSession(httpServletRequest);
        // 读取直接分配给当前人或者已经签收的任务
        List<Task> doingTasks = taskService.createTaskQuery().taskAssignee(String.valueOf(sysUser.getUserId())).list();
        mav.addObject("tasks", doingTasks);
        return mav;
    }

    /**
     * 签收任务
     * @param taskId
     * @param httpServletRequest
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "claim/{taskId}",method = RequestMethod.GET)
    public String claim(@PathVariable("taskId") String taskId,
                        HttpServletRequest httpServletRequest, RedirectAttributes redirectAttributes){
        SysUser sysUser = UserUtil.getUserFromSession(httpServletRequest);
        taskService.claim(taskId, String.valueOf(sysUser.getUserId()));
        redirectAttributes.addFlashAttribute("message", "任务已签收");
        return "redirect:/task/not/claim/list";
    }

    /**
     * 读取用户任务的表单字段
     * @param taskId
     * @return
     */
    @RequestMapping(value = "getform/{taskId}",method = RequestMethod.GET)
    public ModelAndView readTaskForm(@PathVariable("taskId") String taskId){
        ModelAndView mav = new ModelAndView("admin/task/task-form");
        TaskFormData taskFormData = formService.getTaskFormData(taskId);
        if (taskFormData.getFormKey() != null) {
            Object renderedTaskForm = formService.getRenderedTaskForm(taskId);
            Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
            mav.addObject("task", task);
            mav.addObject("taskFormData", renderedTaskForm);
            mav.addObject("hasFormKey", true);
        } else {
            mav.addObject("taskFormData", taskFormData);
        }
        return mav;

    }

    /**
     * 读取启动流程的表单字段
     */
    @RequestMapping(value = "complete/{taskId}")
    public String completeTask(@PathVariable("taskId") String taskId, HttpServletRequest request) throws Exception {
        TaskFormData taskFormData = formService.getTaskFormData(taskId);
        String formKey = taskFormData.getFormKey();
        // 从请求中获取表单字段的值
        List<FormProperty> formProperties = taskFormData.getFormProperties();
        Map<String, String> formValues = new HashMap<String, String>();

        if (StringUtils.isNotBlank(formKey)) { // formkey表单
            Map<String, String[]> parameterMap = request.getParameterMap();
            Set<Map.Entry<String, String[]>> entrySet = parameterMap.entrySet();
            for (Map.Entry<String, String[]> entry : entrySet) {
                String key = entry.getKey();
                formValues.put(key, entry.getValue()[0]);
            }
        } else { // 动态表单
            for (FormProperty formProperty : formProperties) {
                if (formProperty.isWritable()) {
                    String value = request.getParameter(formProperty.getId());
                    formValues.put(formProperty.getId(), value);
                }
            }
        }
        formService.submitTaskFormData(taskId, formValues);
        return "redirect:/task/claim/list";
    }



 }
