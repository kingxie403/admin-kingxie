package com.lte.entity;

/**
 * Created by think on 2016/11/14.
 * 系统权限
 */
public class SysPrivilege {
    private Integer priId;
    private String priName;
    private String priType;

    public Integer getPriId() {
        return priId;
    }

    public void setPriId(Integer priId) {
        this.priId = priId;
    }

    public String getPriName() {
        return priName;
    }

    public void setPriName(String priName) {
        this.priName = priName;
    }

    public String getPriType() {
        return priType;
    }

    public void setPriType(String priType) {
        this.priType = priType;
    }

    @Override
    public String toString() {
        return "SysPrivilege{" +
                "priId=" + priId +
                ", priName='" + priName + '\'' +
                ", priType='" + priType + '\'' +
                '}';
    }
}
