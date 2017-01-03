package com.lte.entity;

/**
 * Created by think on 2016/11/15.
 * 数据字典类型
 */
public class SysDicType {
    private long id;
    private String dicCode;
    private String dicName;
    private int status;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDicCode() {
        return dicCode;
    }

    public void setDicCode(String dicCode) {
        this.dicCode = dicCode;
    }

    public String getDicName() {
        return dicName;
    }

    public void setDicName(String dicName) {
        this.dicName = dicName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "SysDicType{" +
                "id=" + id +
                ", dicCode='" + dicCode + '\'' +
                ", dicName='" + dicName + '\'' +
                ", status=" + status +
                '}';
    }
}
