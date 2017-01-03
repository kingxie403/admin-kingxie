package com.lte.entity;

/**
 * Created by think on 2016/11/22.
 */
public class SysUserGroup {
    private Integer groupId;
    private String groupName;
    private Integer parentId;

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    @Override
    public String toString() {
        return "SysUserGroup{" +
                "groupId=" + groupId +
                ", groupName='" + groupName + '\'' +
                ", parentId=" + parentId +
                '}';
    }
}
