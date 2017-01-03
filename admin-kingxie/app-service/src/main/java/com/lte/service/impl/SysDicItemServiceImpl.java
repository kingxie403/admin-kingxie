package com.lte.service.impl;

import com.lte.dao.SysDicItemDao;
import com.lte.entity.SysDicItem;
import com.lte.service.SysDicItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/16.
 */
@Service("sysDicItemService")
public class SysDicItemServiceImpl implements SysDicItemService {
    @Autowired
    private SysDicItemDao sysDicItemDao;

    @Override
    public boolean saveDicItem(SysDicItem sysDicItem) {
        return sysDicItemDao.saveDicItem(sysDicItem);
    }

    @Override
    public boolean deleteDicItem(SysDicItem sysDicItem) {
        return sysDicItemDao.deleteDicItem(sysDicItem);
    }

    @Override
    public boolean updateDicItem(SysDicItem sysDicItem) {
        return sysDicItemDao.updateDicItem(sysDicItem);
    }

    @Override
    public List<SysDicItem> queryAll() {
        return sysDicItemDao.queryAll();
    }

    @Override
    public SysDicItem queryById(Integer dicItemId) {
        return sysDicItemDao.queryById(dicItemId);
    }

    @Override
    public List<SysDicItem> queryByTypeId(Integer dicTypeId) {
        return sysDicItemDao.queryByTypeId(dicTypeId);
    }

    @Override
    public List<SysDicItem> queryByTypeCode(String dicTypeCode) {
        return sysDicItemDao.queryByTypeCode(dicTypeCode);
    }

    @Override
    public boolean deleteByTypeId(Integer typeId) {
        return sysDicItemDao.deleteByTypeId(typeId);
    }


}
