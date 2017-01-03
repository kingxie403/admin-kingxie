package com.lte.service.impl;

import com.lte.dao.SysUserGroupRefUserDao;
import com.lte.entity.SysUserGroupRefUser;
import com.lte.service.SysUserGroupRefUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Service("sysUserGroupRefUserService")
public class SysUserGroupRefUserServiceImpl implements SysUserGroupRefUserService {
    @Autowired
    private SysUserGroupRefUserDao sysUserGroupRefUserDao;

    @Override
    public boolean insertSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser) {
        return sysUserGroupRefUserDao.insertSysUserGroupRefUser(sysUserGroupRefUser);
    }

    @Override
    public boolean deleteSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser) {
        return sysUserGroupRefUserDao.deleteSysUserGroupRefUser(sysUserGroupRefUser);
    }

    @Override
    public boolean updateSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser) {
        return sysUserGroupRefUserDao.updateSysUserGroupRefUser(sysUserGroupRefUser);
    }

    @Override
    public boolean deleteAllByUserId(Integer userId) {
        return sysUserGroupRefUserDao.deleteAllByUserId(userId);
    }

    @Override
    public List<SysUserGroupRefUser> queryByUserId(Integer userId) {
        return sysUserGroupRefUserDao.queryByUserId(userId);
    }
}
