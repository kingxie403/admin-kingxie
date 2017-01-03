package com.lte.dao;

import com.lte.entity.SysUserGroupRefRole;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/23.
 */
@Repository("sysUserGroupRefRoleDao")
public interface SysUserGroupRefRoleDao {
    boolean insertSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean deleteSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean updateSysUserGroupRefRole(SysUserGroupRefRole sysUserGroupRefRole);
    boolean deleteAllByUserGroupId(Integer userGroupId);
    List<SysUserGroupRefRole> queryByUserGroupId(Integer userGroupId);
}
