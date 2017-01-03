package com.lte.service.impl;

import com.github.pagehelper.PageHelper;
import com.lte.dao.SysUserDao;
import com.lte.entity.SysRole;
import com.lte.entity.SysUser;
import com.lte.service.SysUserService;
import com.lte.util.BeanUtil;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by think on 2016/11/2.
 */
@Service("sysUserService")
public class SysUserServiceImpl implements SysUserService {
    @Autowired
    private SysUserDao sysUserDao;

    @Override
    public boolean saveUser(SysUser sysUser) {
        return sysUserDao.saveUser(sysUser);
    }

    @Override
    public boolean deleteUser(Integer userId) {
        return sysUserDao.deleteUser(userId);
    }

    @Override
    public boolean updateUser(SysUser sysUser) {
        return sysUserDao.updateUser(sysUser);
    }

    @Override
    public boolean existUser(SysUser sysUser) {
        return sysUserDao.existUser(sysUser);
    }

    @Override
    public List<SysUser> findLikeUserName(String userName) {
        return sysUserDao.findLikeUserName(userName);
    }

    @Override
    public SysUser findByUserName(String userName) {
        return sysUserDao.findByUserName(userName);
    }

    @Override
    public PageResult<SysUser> queryByPage(String userName, Integer pageNo, Integer pageSize) {
        pageNo = pageNo==null?1:pageNo;
        pageSize = pageSize ==null?10:pageSize;
        PageHelper.startPage(pageNo,pageSize);//startPage是告诉拦截器说我要开始分页了。分页参数是这两个。
        return BeanUtil.toPageResult(findLikeUserName(userName));
    }

    @Override
    public SysUser findById(Integer userId) {
        return sysUserDao.findById(userId);
    }

    @Override
    public List<SysRole> findRoleByUser(Integer userId) {
        return sysUserDao.findRoleByUser(userId);
    }
}
