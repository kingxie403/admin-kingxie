package com.lte.service.impl;

import com.lte.dao.SysUserGroupRefRoleDao;
import com.lte.entity.SysUserGroupRefRole;
import com.lte.service.SysUserGroupRefRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/23.
 */
@Service("sysUserGroupRefRoleService")
public class SysUserGroupRefRoleServiceImpl implements SysUserGroupRefRoleService {
    @Autowired
    private SysUserGroupRefRoleDao sysUserGroupRefRoleDao;

    @Override
    public boolean insertSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole) {
        return sysUserGroupRefRoleDao.insertSysUserGroupRefRole(sysUserGroupRefRole);
    }

    @Override
    public boolean deleteSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole) {
        return sysUserGroupRefRoleDao.deleteSysUserGroupRefRole(sysUserGroupRefRole);
    }

    @Override
    public boolean updateSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole) {
        return sysUserGroupRefRoleDao.updateSysUserGroupRefRole(sysUserGroupRefRole);
    }

    @Override
    public boolean deleteAllByUserGroupId(Integer userGroupId) {
        return sysUserGroupRefRoleDao.deleteAllByUserGroupId(userGroupId);
    }

    @Override
    public List<SysUserGroupRefRole> queryByUserGroupId(Integer userGroupId) {
        return sysUserGroupRefRoleDao.queryByUserGroupId(userGroupId);
    }
}
