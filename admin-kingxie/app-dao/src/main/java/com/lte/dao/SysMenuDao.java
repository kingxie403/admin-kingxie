package com.lte.dao;

import com.lte.entity.SysMenu;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
@Repository("sysMenuDao")
public interface SysMenuDao {
    boolean saveMenu(SysMenu sysmenu);
    boolean deleteMenu(SysMenu sysmenu);
    boolean updateMenu(SysMenu sysmenu);
    List<SysMenu> queryAll();
    SysMenu queryById(Integer menuId);

    List<SysMenu> queryForUser(String userName);
    List<SysMenu> queryForGroup(String userName);
}
