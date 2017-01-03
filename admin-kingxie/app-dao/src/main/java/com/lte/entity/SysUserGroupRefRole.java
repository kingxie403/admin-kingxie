package com.lte.entity;

/**
 * Created by think on 2016/11/23.
 * 组织与角色关系
 */
public class SysUserGroupRefRole {
    private Integer userGroupId;
    private Integer roleId;

    public Integer getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Integer userGroupId) {
        this.userGroupId = userGroupId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "SysUserGroupRefRole{" +
                "userGroupId=" + userGroupId +
                ", roleId=" + roleId +
                '}';
    }
}
