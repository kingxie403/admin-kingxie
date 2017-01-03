package com.lte.service;

import com.lte.entity.SysUserGroup;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
public interface SysUserGroupService {
    boolean saveUserGroup(SysUserGroup sysUserGroup);
    boolean deleteUserGroup(SysUserGroup sysUserGroup);
    boolean updateUserGroup(SysUserGroup sysUserGroup);
    List<SysUserGroup> queryAll();
    SysUserGroup queryById(Integer groupId);
}
