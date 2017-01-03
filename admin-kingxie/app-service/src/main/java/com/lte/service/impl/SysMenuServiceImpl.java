package com.lte.service.impl;

import com.lte.dao.SysMenuDao;
import com.lte.entity.SysMenu;
import com.lte.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
@Service("sysMenuService")
public class SysMenuServiceImpl implements SysMenuService {
    @Autowired
    SysMenuDao sysMenuDao;

    @Override
    public boolean saveMenu(SysMenu sysmenu) {
        return sysMenuDao.saveMenu(sysmenu);
    }

    @Override
    public boolean deleteMenu(SysMenu sysmenu) {
        return sysMenuDao.deleteMenu(sysmenu);
    }

    @Override
    public boolean updateMenu(SysMenu sysmenu) {
        return sysMenuDao.updateMenu(sysmenu);
    }

    @Override
    public List<SysMenu> queryAll() {
        return sysMenuDao.queryAll();
    }

    @Override
    public SysMenu queryById(Integer menuId) {
        return sysMenuDao.queryById(menuId);
    }

    @Override
    public List<SysMenu> queryForUser(String userName) {
        return sysMenuDao.queryForUser(userName);
    }

    @Override
    public List<SysMenu> queryForGroup(String userName) {
        return sysMenuDao.queryForGroup(userName);
    }
}
