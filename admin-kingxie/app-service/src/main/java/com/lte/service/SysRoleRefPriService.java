package com.lte.service;

import com.lte.entity.SysRoleRefPri;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
public interface SysRoleRefPriService {
    boolean insertSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean deleteSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean updateSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean deleteAllByRole(Integer roleId);
    List<SysRoleRefPri> queryByRoleId(Integer roleId);
}
