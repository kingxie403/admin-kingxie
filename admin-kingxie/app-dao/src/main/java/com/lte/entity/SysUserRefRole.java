package com.lte.entity;

/**
 * Created by think on 2016/11/12.
 * 用户角色关联实体
 */
public class SysUserRefRole {
    private long userId;
    private long roleId;

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public long getRoleId() {
        return roleId;
    }

    public void setRoleId(long roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "SysUserRefRole{" +
                "userId=" + userId +
                ", roleId=" + roleId +
                '}';
    }
}
