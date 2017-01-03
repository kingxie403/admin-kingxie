package com.lte.service.impl;

import com.lte.dao.SysUserRefRoleDao;
import com.lte.entity.SysUserRefRole;
import com.lte.service.SysUserRefRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/12.
 */
@Service("sysUserRefRoleService")
public class SysUserRefRoleServiceImpl implements SysUserRefRoleService {
    @Autowired
    private SysUserRefRoleDao sysUserRefRoleDao;
    @Override
    public boolean saveSysUserRefRole(SysUserRefRole sysUserRefRole) {
        return sysUserRefRoleDao.insertSysUserRefRole(sysUserRefRole);
    }

    @Override
    public boolean deleteSysUserRefRole(SysUserRefRole sysUserRefRole) {
        return sysUserRefRoleDao.deleteSysUserRefRole(sysUserRefRole);
    }

    @Override
    public boolean updateSysUserRefRole(SysUserRefRole sysUserRefRole) {
        return sysUserRefRoleDao.updateSysUserRefRole(sysUserRefRole);
    }

    @Override
    public Integer exitsSysUserRefRole(SysUserRefRole sysUserRefRole) {
        return sysUserRefRoleDao.exitsSysUserRefRole(sysUserRefRole);
    }

    @Override
    public boolean deleteAllByUserId(Integer userId) {
        return sysUserRefRoleDao.deleteAllByUserId(userId);
    }

    @Override
    public List<SysUserRefRole> queryByUserId(Integer userId) {
        return sysUserRefRoleDao.queryByUserId(userId);
    }
}
