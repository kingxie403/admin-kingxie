package com.lte.dao;

import com.lte.entity.SysUserGroup;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Repository("sysUserGroupDao")
public interface SysUserGroupDao {
    boolean saveUserGroup(SysUserGroup sysUserGroup);
    boolean deleteUserGroup(SysUserGroup sysUserGroup);
    boolean updateUserGroup(SysUserGroup sysUserGroup);
    List<SysUserGroup> queryAll();
    SysUserGroup queryById(Integer groupId);
}
