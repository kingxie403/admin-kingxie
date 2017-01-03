package com.lte.controller.util;

import com.lte.entity.SysUser;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by think on 2016/12/19.
 */
public class UserUtil {
    public static SysUser getUserFromSession(HttpServletRequest request){
        SysUser sysUser = (SysUser) request.getSession().getAttribute("user");
        return sysUser;
    }
}
