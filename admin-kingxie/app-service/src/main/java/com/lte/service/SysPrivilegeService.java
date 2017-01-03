package com.lte.service;

import com.lte.entity.SysPrivilege;
import com.lte.util.PageResult;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by think on 2016/11/14.
 */
public interface SysPrivilegeService {
    boolean savePrivilege(SysPrivilege sysPrivilege);
    boolean deleteSysPrivilege(SysPrivilege sysPrivilege);
    boolean updateSysPrivilege(SysPrivilege sysPrivilege);
    List<SysPrivilege> queryAll();
    List<SysPrivilege> queryByName(@Param("privilegeName") String privilegeName);
    PageResult<SysPrivilege> queryByPage(String privilegeName, Integer pageNo, Integer pageSize);
    SysPrivilege queryById(Integer priId);
}
