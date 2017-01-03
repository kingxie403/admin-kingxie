package com.lte.activiti;

import com.lte.entity.SysUser;
import org.activiti.engine.identity.User;

/**
 * Created by think on 2016/12/16.
 */
public class CustomUser implements User {
    private SysUser sysUser;

    public CustomUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    @Override
    public String getId() {
        return String.valueOf(sysUser.getUserId());
    }

    @Override
    public void setId(String s) {
        sysUser.setUserId(Long.parseLong(s));
    }

    @Override
    public String getFirstName() {
        return sysUser.getUserName();
    }

    @Override
    public void setFirstName(String s) {
        sysUser.setUserName(s);
    }

    @Override
    public void setLastName(String s) {

    }

    @Override
    public String getLastName() {
        return "";
    }

    @Override
    public void setEmail(String s) {
        sysUser.setEmail(s);
    }

    @Override
    public String getEmail() {
        return sysUser.getEmail();
    }

    @Override
    public String getPassword() {
        return sysUser.getPassword();
    }

    @Override
    public void setPassword(String s) {
       sysUser.setPassword(s);
    }

    @Override
    public boolean isPictureSet() {
        return false;
    }

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }
}
