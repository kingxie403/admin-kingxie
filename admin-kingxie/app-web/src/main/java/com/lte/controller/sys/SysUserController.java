package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysUser;
import com.lte.service.SysUserService;
import com.lte.util.MD5;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * Created by think on 2016/11/2.
 */
@Controller
@RequestMapping("/")
public class SysUserController extends BaseController{
    @Autowired
    private SysUserService sysUserService;

    @RequestMapping(value = "user/manager",method = RequestMethod.GET)
    public String userManager(){
        return "admin/user/manager";
    }

    @RequestMapping(value = "user/home",method = RequestMethod.GET)
    public String userHome(){
        return "/admin/user/home";
    }

    @ResponseBody
    @RequestMapping(value = "/user/list",method = RequestMethod.POST)
    public String queryForName(String userName,Integer pageNo,Integer pageSize){
        logger.info("分页查询用户信息列表请求入参：pageNumber{},pageSize{}", pageNo,pageSize);
        try {
            PageResult<SysUser> pageResult = sysUserService.queryByPage(userName, pageNo,pageSize);
            return responseSuccess(pageResult);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }
    @ResponseBody
    @RequestMapping(value = "user/{userId}",method = RequestMethod.POST)
    public String findById(@PathVariable Integer userId){
        return responseSuccess(sysUserService.findById(userId));
    }

    @ResponseBody
    @RequestMapping(value = "user/update",method = RequestMethod.POST)
    public String update(@RequestBody SysUser sysUser){
        sysUser.setPassword(MD5.md5(sysUser.getPassword()));
        return responseSuccess(sysUserService.updateUser(sysUser));
    }

    @ResponseBody
    @RequestMapping(value = "user/delete/{userId}",method = RequestMethod.POST)
    public String delete(@PathVariable Integer userId){
        return responseSuccess(sysUserService.deleteUser(userId));
    }

}
