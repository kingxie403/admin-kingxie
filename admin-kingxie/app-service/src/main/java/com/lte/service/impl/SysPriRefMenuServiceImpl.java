package com.lte.service.impl;

import com.lte.dao.SysPriRefMenuDao;
import com.lte.entity.SysPriRefMenu;
import com.lte.service.SysPriRefMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/18.
 */
@Service("sysPriRefMenuService")
public class SysPriRefMenuServiceImpl implements SysPriRefMenuService {
    @Autowired
    private SysPriRefMenuDao sysPriRefMenuDao;
    @Override
    public boolean insertSysPriRefMenu(SysPriRefMenu sysPriRefMenu) {
        return sysPriRefMenuDao.insertSysPriRefMenu(sysPriRefMenu);
    }

    @Override
    public boolean deleteSysPriRefMenu(SysPriRefMenu sysPriRefMenu) {
        return sysPriRefMenuDao.deleteSysPriRefMenu(sysPriRefMenu);
    }

    @Override
    public boolean updateSysPriRefMenu(SysPriRefMenu sysPriRefMenu) {
        return sysPriRefMenuDao.updateSysPriRefMenu(sysPriRefMenu);
    }

    @Override
    public boolean deleteAllByPriId(Integer priId) {
        return sysPriRefMenuDao.deleteAllByPriId(priId);
    }

    @Override
    public List<SysPriRefMenu> queryByPriId(Integer priId) {
        return sysPriRefMenuDao.queryByPriId(priId);
    }
}
