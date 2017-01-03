package com.lte.service;

import com.lte.entity.SysDicItem;

import java.util.List;

/**
 * Created by think on 2016/11/16.
 */
public interface SysDicItemService {
    boolean saveDicItem(SysDicItem sysDicItem);
    boolean deleteDicItem(SysDicItem sysDicItem);
    boolean updateDicItem(SysDicItem sysDicItem);
    List<SysDicItem> queryAll();
    SysDicItem queryById(Integer dicItemId);
    List<SysDicItem> queryByTypeId(Integer dicTypeId);
    List<SysDicItem> queryByTypeCode(String dicTypeCode);
    boolean deleteByTypeId(Integer typeId);
}
