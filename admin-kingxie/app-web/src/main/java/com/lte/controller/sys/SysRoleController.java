package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysRole;
import com.lte.service.SysRoleService;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by think on 2016/11/11.
 */
@Controller
@RequestMapping("/role")
public class SysRoleController extends BaseController{
    @Autowired
    SysRoleService sysRoleService;

    @RequestMapping(value = "/manager")
    public ModelAndView manager(){
        ModelAndView modelAndView = new ModelAndView("admin/role/manager");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(String roleName,String roleCode) throws UnsupportedEncodingException {
//        String str = URLDecoder.decode(URLDecoder.decode(roleName,"UTF-8"),"UTF-8");
        SysRole sysRole = new SysRole();
        sysRole.setRoleName(roleName);
        sysRole.setRoleCode(roleCode);
        sysRoleService.saveRole(sysRole);
        Map<String,String> map = new HashMap<>();
        map.put("msg","success");
        return responseSuccess(map);
    }

    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public String list(String roleName,Integer pageNo,Integer pageSize){
        PageResult<SysRole> result = null;
        try {
            result = sysRoleService.queryByPage(roleName,pageNo,pageSize);
            return responseSuccess(result);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/get/{roleId}",method = RequestMethod.GET)
    public String get(@PathVariable("roleId") Integer roleId){
        SysRole sysRole = sysRoleService.queryById(roleId);
        return responseSuccess(sysRole);
    }

    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String update(Integer roleId,String roleName,String roleCode){
        SysRole sysRole = new SysRole();
        sysRole.setRoleId(roleId);
        sysRole.setRoleName(roleName);
        sysRole.setRoleCode(roleCode);
        sysRoleService.updateRole(sysRole);
        Map<String,String>map = new HashMap<>();
        map.put("msg","sucs");
        return responseSuccess(map);
    }

}
