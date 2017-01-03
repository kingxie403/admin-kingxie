package com.lte.service;

import com.lte.entity.SysUserGroupRefRole;

import java.util.List;

/**
 * Created by think on 2016/11/23.
 */
public interface SysUserGroupRefRoleService {
    boolean insertSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean deleteSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean updateSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean deleteAllByUserGroupId(Integer userGroupId);
    List<SysUserGroupRefRole> queryByUserGroupId(Integer userGroupId);
}
