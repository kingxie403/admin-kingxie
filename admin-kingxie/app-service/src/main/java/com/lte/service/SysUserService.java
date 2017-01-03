package com.lte.service;

import com.lte.entity.SysRole;
import com.lte.entity.SysUser;
import com.lte.util.PageResult;

import java.util.List;

/**
 * Created by think on 2016/11/2.
 */
public interface SysUserService {
    boolean saveUser(SysUser sysUser);
    boolean deleteUser(Integer userId);
    boolean updateUser(SysUser sysUser);
    boolean existUser(SysUser sysUser);
    List<SysUser> findLikeUserName(String userName);
    SysUser findByUserName(String userName);

    /**
     *
     * @param userName 查询条件，可为空
     * @param pageNo   查询条件，可为空，默认取1
     * @param pageSize 查询条件，可为空，默认取10
     * @return
     */
    PageResult<SysUser> queryByPage(String userName, Integer pageNo, Integer pageSize);
    SysUser findById(Integer userId);

    List<SysRole> findRoleByUser(Integer userId);


}
