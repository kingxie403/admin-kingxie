package com.lte.service.impl;

import com.github.pagehelper.PageHelper;
import com.lte.dao.SysRoleDao;
import com.lte.entity.SysRole;
import com.lte.service.SysRoleService;
import com.lte.util.BeanUtil;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/11.
 */
@Service("sysRoleService")
public class SysRoleServiceImpl implements SysRoleService {
    @Autowired
    private SysRoleDao sysRoleDao;

    @Override
    public boolean saveRole(SysRole sysRole) {
        return sysRoleDao.saveRole(sysRole);
    }

    @Override
    public boolean deleteRole(SysRole sysRole) {
        return sysRoleDao.deleteRole(sysRole);
    }

    @Override
    public boolean updateRole(SysRole sysRole) {
        return sysRoleDao.updateRole(sysRole);
    }

    @Override
    public List<SysRole> queryAll() {
        return sysRoleDao.queryAll();
    }

    @Override
    public List<SysRole> queryByName(String roleName) {
        return sysRoleDao.queryByName(roleName);
    }

    @Override
    public PageResult<SysRole> queryByPage(String roleName, Integer pageNo, Integer pageSize) {
        pageNo= pageNo==null?1:pageNo;
        pageSize=pageSize==null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);
        return BeanUtil.toPageResult(sysRoleDao.queryByName(roleName));
    }

    @Override
    public SysRole queryById(Integer roleId) {
        return sysRoleDao.queryById(roleId);
    }
}
