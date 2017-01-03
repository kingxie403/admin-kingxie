package com.lte.service;

import com.lte.entity.SysUserRefRole;

import java.util.List;

/**
 * Created by think on 2016/11/12.
 */
public interface SysUserRefRoleService {
    boolean saveSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean deleteSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean updateSysUserRefRole(SysUserRefRole sysUserRefRole);
    Integer exitsSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean deleteAllByUserId(Integer userId);
    List<SysUserRefRole> queryByUserId(Integer userId);
}
