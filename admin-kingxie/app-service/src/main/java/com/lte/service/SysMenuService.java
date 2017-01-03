package com.lte.service;

import com.lte.entity.SysMenu;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
public interface SysMenuService {
    boolean saveMenu(SysMenu sysmenu);
    boolean deleteMenu(SysMenu sysmenu);
    boolean updateMenu(SysMenu sysmenu);
    List<SysMenu> queryAll();
    SysMenu queryById(Integer menuId);

    List<SysMenu> queryForUser(String userName);
    List<SysMenu> queryForGroup(String userName);
}
