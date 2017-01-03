package com.lte.service.impl;

import com.lte.dao.SysRoleRefPriDao;
import com.lte.entity.SysRoleRefPri;
import com.lte.service.SysRoleRefPriService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Service("sysRoleRefPriService")
public class SysRoleRefPriServiceImpl implements SysRoleRefPriService {
    @Autowired
    private SysRoleRefPriDao sysRoleRefPriDao;

    @Override
    public boolean insertSysRoleRefPri(SysRoleRefPri sysRoleRefPri) {
        return sysRoleRefPriDao.insertSysRoleRefPri(sysRoleRefPri);
    }

    @Override
    public boolean deleteSysRoleRefPri(SysRoleRefPri sysRoleRefPri) {
        return sysRoleRefPriDao.deleteSysRoleRefPri(sysRoleRefPri);
    }

    @Override
    public boolean updateSysRoleRefPri(SysRoleRefPri sysRoleRefPri) {
        return sysRoleRefPriDao.updateSysRoleRefPri(sysRoleRefPri);
    }

    @Override
    public boolean deleteAllByRole(Integer roleId) {
        return sysRoleRefPriDao.deleteAllByRole(roleId);
    }

    @Override
    public List<SysRoleRefPri> queryByRoleId(Integer roleId) {
        return sysRoleRefPriDao.queryByRoleId(roleId);
    }
}
