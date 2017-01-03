package com.lte.dao;

import com.lte.entity.SysRole;
import com.lte.entity.SysUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/2.
 */
@Repository("sysUserDao")
public interface SysUserDao {
    boolean saveUser(SysUser sysUser);
    boolean deleteUser(Integer userId);
    boolean updateUser(SysUser sysUser);
    boolean existUser(SysUser sysUser);
    List<SysUser> findLikeUserName(@Param("userName") String userName);
    SysUser findByUserName(String userName);
    SysUser findById(Integer userId);

    List<SysRole> findRoleByUser(Integer userId);
}
