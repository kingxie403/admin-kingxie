package com.lte.service.impl;

import com.lte.dao.SysUserGroupDao;
import com.lte.entity.SysUserGroup;
import com.lte.service.SysUserGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Service("sysUserGroupService")
public class SysUserGroupServiceImpl implements SysUserGroupService {
    @Autowired
    private SysUserGroupDao sysUserGroupDao;

    @Override
    public boolean saveUserGroup(SysUserGroup sysUserGroup) {
        return sysUserGroupDao.saveUserGroup(sysUserGroup);
    }

    @Override
    public boolean deleteUserGroup(SysUserGroup sysUserGroup) {
        return sysUserGroupDao.deleteUserGroup(sysUserGroup);
    }

    @Override
    public boolean updateUserGroup(SysUserGroup sysUserGroup) {
        return sysUserGroupDao.updateUserGroup(sysUserGroup);
    }

    @Override
    public List<SysUserGroup> queryAll() {
        return sysUserGroupDao.queryAll();
    }

    @Override
    public SysUserGroup queryById(Integer groupId) {
        return sysUserGroupDao.queryById(groupId);
    }
}
