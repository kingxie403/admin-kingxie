package com.lte.controller.sys;

import com.alibaba.fastjson.JSON;
import com.lte.entity.SysUser;
import com.lte.service.SysUserService;
import com.lte.util.MD5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by think on 2016/11/2.
 */
@Controller
@RequestMapping("/")
public class RegisterController {
    private  Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SysUserService sysUserService;

    @RequestMapping(value = "register",method = RequestMethod.GET)
    public String register(){
        return "register";
    }

    @ResponseBody
    @RequestMapping(value = "register/save",method = RequestMethod.POST)
    public String save(@RequestBody SysUser sysUser){
        Map map = new HashMap();
        if(sysUser != null){
            String md5 = MD5.md5(sysUser.getPassword());
            sysUser.setPassword(md5);
            sysUser.setCreateDate(new Date());
            sysUser.setUpdateDate(new Date());
            sysUserService.saveUser(sysUser);
            logger.debug("------注册成功-----");
        }
        map.put("scs","scs");
        return JSON.toJSONString(map);
    }


}
