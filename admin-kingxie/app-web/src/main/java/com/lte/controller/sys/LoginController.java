package com.lte.controller.sys;

import com.alibaba.fastjson.JSON;
import com.lte.entity.SysUser;
import com.lte.service.SysUserService;
import com.lte.util.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by think on 2016/11/2.
 */
@Controller
@RequestMapping("/")
public class LoginController {
    @Autowired
    private SysUserService sysUserService;

    @ResponseBody
    @RequestMapping(value = "login",method = RequestMethod.POST)
    public String login(@RequestBody SysUser sysUser, HttpServletRequest request){
        sysUser.setPassword(MD5.md5(sysUser.getPassword()));
        Map map = new HashMap();
        if(sysUserService.existUser(sysUser)){
            SysUser user = sysUserService.findByUserName(sysUser.getUserName());
            HttpSession session = request.getSession();
            session.setAttribute("user",user);
            map.put("msg","success");
            return JSON.toJSONString(map);
        }
        map.put("msg","error");
        return JSON.toJSONString(map);
    }
}
