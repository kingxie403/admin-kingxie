package com.lte.service.impl;

import com.github.pagehelper.PageHelper;
import com.lte.dao.SysDicTypeDao;
import com.lte.entity.SysDicType;
import com.lte.service.SysDicTypeService;
import com.lte.util.BeanUtil;
import com.lte.util.PageResult;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/15.
 */
@Service("sysDicTypeService")
public class SysDicTypeServiceImpl implements SysDicTypeService {
    @Autowired
    private SysDicTypeDao sysDicTypeDao;

    @Override
    public boolean saveDicType(SysDicType SysDicType) {
        return sysDicTypeDao.saveDicType(SysDicType);
    }

    @Override
    public boolean deleteDicType(SysDicType SysDicType) {
        return sysDicTypeDao.deleteDicType(SysDicType);
    }

    @Override
    public boolean updateDicType(SysDicType SysDicType) {
        return sysDicTypeDao.updateDicType(SysDicType);
    }

    @Override
    public List<SysDicType> queryAll() {
        return sysDicTypeDao.queryAll();
    }

    @Override
    public List<SysDicType> queryByName(@Param("dicTypeName") String dicTypeName) {
        return sysDicTypeDao.queryByName(dicTypeName);
    }

    @Override
    public PageResult<SysDicType> queryByPage(String dicTypeName, Integer pageNo, Integer pageSize) {
        pageNo= pageNo==null?1:pageNo;
        pageSize=pageSize==null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);
        return BeanUtil.toPageResult(sysDicTypeDao.queryByName(dicTypeName));
    }

    @Override
    public SysDicType queryById(Integer dicTypeId) {
        return sysDicTypeDao.queryById(dicTypeId);
    }
}
