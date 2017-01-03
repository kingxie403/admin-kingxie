package com.lte.dao;

import com.lte.entity.SysDicItem;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/15.
 */
@Repository("sysDicItemDao")
public interface SysDicItemDao {
    boolean saveDicItem(SysDicItem SysDicItem);
    boolean deleteDicItem(SysDicItem SysDicItem);
    boolean updateDicItem(SysDicItem SysDicItem);
    List<SysDicItem> queryAll();
    SysDicItem queryById(Integer dicItemId);
    List<SysDicItem> queryByTypeId(Integer dicTypeId);
    List<SysDicItem> queryByTypeCode(String dicTypeCode);
    boolean deleteByTypeId(Integer typeId);

}
