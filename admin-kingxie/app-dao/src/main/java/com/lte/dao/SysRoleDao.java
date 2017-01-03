package com.lte.dao;

import com.lte.entity.SysRole;
import com.lte.util.PageResult;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/11.
 */
@Repository("sysRoleDao")
public interface SysRoleDao {
    boolean saveRole(SysRole sysRole);
    boolean deleteRole(SysRole sysRole);
    boolean updateRole(SysRole sysRole);
    List<SysRole> queryAll();
    List<SysRole> queryByName(@Param("roleName") String roleName);
    PageResult<SysRole> queryByPage(String roleName, Integer pageNo, Integer pageSize);
    SysRole queryById(Integer roleId);
}
