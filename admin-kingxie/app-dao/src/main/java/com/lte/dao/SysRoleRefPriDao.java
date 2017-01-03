package com.lte.dao;

import com.lte.entity.SysRoleRefPri;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by think on 2016/11/22.
 */
@Repository("sysRoleRefPriDao")
public interface SysRoleRefPriDao {
    boolean insertSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean deleteSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean updateSysRoleRefPri(SysRoleRefPri sysRoleRefPri);
    boolean deleteAllByRole(Integer roleId);
    List<SysRoleRefPri> queryByRoleId(Integer roleId);
}
