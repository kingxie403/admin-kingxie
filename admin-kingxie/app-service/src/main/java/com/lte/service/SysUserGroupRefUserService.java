package com.lte.service;

import com.lte.entity.SysUserGroupRefUser;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
public interface SysUserGroupRefUserService {
    boolean insertSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean deleteSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean updateSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean deleteAllByUserId(Integer userId);
    List<SysUserGroupRefUser> queryByUserId(Integer userId);
}
