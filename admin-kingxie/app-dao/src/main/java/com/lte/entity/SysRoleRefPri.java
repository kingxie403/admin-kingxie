package com.lte.entity;

/**
 * Created by think on 2016/11/22.
 * 角色权限关联类
 */
public class SysRoleRefPri {
    private Integer roleId;
    private Integer priId;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getPriId() {
        return priId;
    }

    public void setPriId(Integer priId) {
        this.priId = priId;
    }

    @Override
    public String toString() {
        return "SysRoleRefPri{" +
                "roleId=" + roleId +
                ", priId=" + priId +
                '}';
    }
}
