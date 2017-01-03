package com.lte.service.impl;

import com.github.pagehelper.PageHelper;
import com.lte.dao.SysPrivilegeDao;
import com.lte.entity.SysPrivilege;
import com.lte.service.SysPrivilegeService;
import com.lte.util.BeanUtil;
import com.lte.util.PageResult;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/14.
 */
@Service("sysPrivilegeService")
public class SysPrivilegeServiceImpl implements SysPrivilegeService {
    @Autowired
    private SysPrivilegeDao sysPrivilegeDao;

    @Override
    public boolean savePrivilege(SysPrivilege sysPrivilege) {
        return sysPrivilegeDao.savePrivilege(sysPrivilege);
    }

    @Override
    public boolean deleteSysPrivilege(SysPrivilege sysPrivilege) {
        return sysPrivilegeDao.deleteSysPrivilege(sysPrivilege);
    }

    @Override
    public boolean updateSysPrivilege(SysPrivilege sysPrivilege) {
        return sysPrivilegeDao.updateSysPrivilege(sysPrivilege);
    }

    @Override
    public List<SysPrivilege> queryAll() {
        return sysPrivilegeDao.queryAll();
    }

    @Override
    public List<SysPrivilege> queryByName(@Param("privilegeName") String privilegeName) {
        return sysPrivilegeDao.queryByName(privilegeName);
    }

    @Override
    public PageResult<SysPrivilege> queryByPage(String privilegeName, Integer pageNo, Integer pageSize) {
        pageNo= pageNo==null?1:pageNo;
        pageSize=pageSize==null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);
        return BeanUtil.toPageResult(sysPrivilegeDao.queryByName(privilegeName));
    }

    @Override
    public SysPrivilege queryById(Integer priId) {
        return sysPrivilegeDao.queryById(priId);
    }
}
