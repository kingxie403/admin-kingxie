package com.lte.activiti;

import com.lte.entity.SysRole;
import org.activiti.engine.identity.Group;

/**
 * Created by think on 2016/12/16.
 */
public class CustomGroup implements Group {
    public SysRole sysRole;

    public CustomGroup(SysRole sysRole) {
        this.sysRole = sysRole;
    }

    @Override
    public String getId() {
        return sysRole.getRoleCode();
    }

    @Override
    public void setId(String s) {
        sysRole.setRoleCode(s);
    }

    @Override
    public String getName() {
        return sysRole.getRoleName();
    }

    @Override
    public void setName(String s) {
        sysRole.setRoleName(s);
    }

    @Override
    public String getType() {
        return sysRole.getRoleCode();
    }

    @Override
    public void setType(String s) {
        sysRole.setRoleCode(s);
    }

    public SysRole getSysRole() {
        return sysRole;
    }

    public void setSysRole(SysRole sysRole) {
        this.sysRole = sysRole;
    }
}
