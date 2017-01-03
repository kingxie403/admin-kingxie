package com.lte.service;

import com.lte.entity.SysPriRefMenu;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
public interface SysPriRefMenuService {
    boolean insertSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean deleteSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean updateSysPriRefMenu(SysPriRefMenu sysPriRefMenu);
    boolean deleteAllByPriId(Integer priId);
    List<SysPriRefMenu> queryByPriId(Integer priId);
}
