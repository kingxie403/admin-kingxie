package com.lte.entity;

/**
 * Created by think on 2016/11/22.
 * 组织与用户关系
 */
public class SysUserGroupRefUser {
    private Integer userGroupId;
    private Integer userId;

    public Integer getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Integer userGroupId) {
        this.userGroupId = userGroupId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "SysUserGroupRefUser{" +
                "userGroupId=" + userGroupId +
                ", userId=" + userId +
                '}';
    }
}
