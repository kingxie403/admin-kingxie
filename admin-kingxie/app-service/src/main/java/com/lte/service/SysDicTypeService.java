package com.lte.service;

import com.lte.entity.SysDicType;
import com.lte.util.PageResult;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by think on 2016/11/15.
 */
public interface SysDicTypeService {
    boolean saveDicType(SysDicType SysDicType);
    boolean deleteDicType(SysDicType SysDicType);
    boolean updateDicType(SysDicType SysDicType);
    List<SysDicType> queryAll();
    List<SysDicType> queryByName(@Param("dicTypeName") String dicTypeName);
    PageResult<SysDicType> queryByPage(String dicTypeName, Integer pageNo, Integer pageSize);
    SysDicType queryById(Integer dicTypeId);
}
