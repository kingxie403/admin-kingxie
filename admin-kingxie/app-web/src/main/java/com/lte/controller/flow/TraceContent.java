package com.lte.controller.flow;

/**
 * Created by think on 2017/1/3.
 */
public class TraceContent {
    private String processDefinitionId;
    private String processDefinitionName;
    private String processInstanceId;
    private String currentTask;

    public String getProcessDefinitionId() {
        return processDefinitionId;
    }

    public void setProcessDefinitionId(String processDefinitionId) {
        this.processDefinitionId = processDefinitionId;
    }

    public String getProcessDefinitionName() {
        return processDefinitionName;
    }

    public void setProcessDefinitionName(String processDefinitionName) {
        this.processDefinitionName = processDefinitionName;
    }

    public String getProcessInstanceId() {
        return processInstanceId;
    }

    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    public String getCurrentTask() {
        return currentTask;
    }

    public void setCurrentTask(String currentTask) {
        this.currentTask = currentTask;
    }

    @Override
    public String toString() {
        return "TraceContent{" +
                "processDefinitionId='" + processDefinitionId + '\'' +
                ", processDefinitionName='" + processDefinitionName + '\'' +
                ", processInstanceId='" + processInstanceId + '\'' +
                ", currentTask='" + currentTask + '\'' +
                '}';
    }
}
