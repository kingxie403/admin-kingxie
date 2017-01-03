import org.activiti.engine.*;
import org.activiti.engine.history.HistoricDetail;
import org.activiti.engine.history.HistoricFormProperty;
import org.activiti.engine.history.HistoricVariableUpdate;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.test.Deployment;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/12/7.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/activiti.cfg.xml")
public class ProcessTest {

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private FormService formService;
    @Autowired
    private IdentityService identityService;
    @Autowired
    private HistoryService historyService;

    @Test
    public void deployProcess() {
        //repositoryService.createDeployment().addClasspathResource("bpm/VacationRequest.bpmn20.xml");
        repositoryService.createDeployment().addClasspathResource("bpmn-design/leave.bpmn20.xml");
        System.out.println(repositoryService.createDeploymentQuery().deploymentName("leave").count());
    }

    @Test
    public void startProcess(){
        Map<String,Object> variables = new HashMap<String,Object>();
        variables.put("employment","tom");
        variables.put("numberOfDays", new Integer(4));
        variables.put("vacationMotivation", "I'm really tired!");
        runtimeService.startProcessInstanceByKey("vacationRequest",variables);
        System.out.println(runtimeService.createProcessInstanceQuery().count());
    }

    @Test
    public void completeTask(){
        List<Task> tasks = taskService.createTaskQuery().taskCandidateGroup("management").list();
        for (Task task:tasks) {
            System.out.println(task.getName());
        }
        Task task = tasks.get(0);
        Map<String, Object> taskVariables = new HashMap<String, Object>();
        taskVariables.put("vacationApproved", "false");
        taskVariables.put("managerMotivation", "We have a tight deadline!");
        taskService.complete(task.getId(), taskVariables);
    }



    @Test
    public void allApproved() throws Exception {
        String currentUserId = "kingxie403";
        identityService.setAuthenticatedUserId(currentUserId);//设置当前用户
        //启动流程
        ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId("leave").singleResult();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Map<String, String> variables = new HashMap<>();
        Calendar calendar = Calendar.getInstance();
        String startDate = sdf.format(calendar.getTime());
        calendar.add(Calendar.DAY_OF_MONTH,2);
        String endDate = sdf.format(calendar.getTime());
        variables.put("startDate",startDate);
        variables.put("endDate",endDate);
        variables.put("reason","公休");
        ProcessInstance pi = formService.submitStartFormData(pd.getId(),variables);
        assert  pi != null;
    }

    //读取历史变量
    public Map<String, Object> readHistoryVariables(ProcessInstance processInstance) {
        Map<String, Object> historyVariables = new HashMap<>();
        List<HistoricDetail> historicDetails =
                historyService.createHistoricDetailQuery().processInstanceId(
                        processInstance.getId()).list();

        for (HistoricDetail historicDetail : historicDetails) {
            if (historicDetail instanceof HistoricFormProperty) { //表单中的字段
                HistoricFormProperty field = (HistoricFormProperty) historicDetail;
                historyVariables.put(field.getPropertyId(), field.getPropertyValue());
                System.out.println("form field: taskId=" + field.getTaskId() + " , " +
                        field.getPropertyId() + " , " +
                        field.getPropertyValue());
            } else if(historicDetail instanceof HistoricVariableUpdate) {//普通变量
                HistoricVariableUpdate  variable = (HistoricVariableUpdate) historicDetail;
                historyVariables.put(variable.getVariableName(),variable.getValue());
                System.out.println("variable: "+variable.getVariableName()+" , "+variable.getValue());
            }
        }
        return historyVariables;
    }
}
