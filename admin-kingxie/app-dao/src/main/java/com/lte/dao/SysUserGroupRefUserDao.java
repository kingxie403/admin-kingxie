package com.lte.dao;

import com.lte.entity.SysUserGroupRefUser;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Repository("sysUserGroupRefUserDao")
public interface SysUserGroupRefUserDao {
    boolean insertSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean deleteSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean updateSysUserGroupRefUser(SysUserGroupRefUser sysUserGroupRefUser);
    boolean deleteAllByUserId(Integer userId);
    List<SysUserGroupRefUser> queryByUserId(Integer userId);
}
