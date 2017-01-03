package com.lte.service;

import com.lte.entity.SysRole;
import com.lte.util.PageResult;

import java.util.List;

/**
 * Created by think on 2016/11/11.
 */
public interface SysRoleService {
    boolean saveRole(SysRole sysRole);
    boolean deleteRole(SysRole sysRole);
    boolean updateRole(SysRole sysRole);
    List<SysRole> queryAll();
    List<SysRole> queryByName(String roleName);
    PageResult<SysRole> queryByPage(String roleName, Integer pageNo, Integer pageSize);
    SysRole queryById(Integer roleId);
}
