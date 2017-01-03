package com.lte.dao;

import com.lte.entity.SysUserRefRole;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/12.
 */
@Repository("sysUserRefRoleDao")
public interface SysUserRefRoleDao {
    boolean insertSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean deleteSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean updateSysUserRefRole(SysUserRefRole sysUserRefRole);
    Integer exitsSysUserRefRole(SysUserRefRole sysUserRefRole);
    boolean deleteAllByUserId(Integer userId);
    List<SysUserRefRole> queryByUserId(Integer userId);

}
