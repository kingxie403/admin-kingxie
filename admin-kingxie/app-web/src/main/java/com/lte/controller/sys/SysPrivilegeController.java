package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysPrivilege;
import com.lte.service.SysPrivilegeService;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by think on 2016/11/14.
 */
@Controller
@RequestMapping("/privilege")
public class SysPrivilegeController extends BaseController {
    @Autowired
    private SysPrivilegeService sysPrivilegeService;

    @RequestMapping(value = "/manager",method = RequestMethod.GET)
    public ModelAndView manager(){
        return new ModelAndView("admin/privilege/manager");
    }

    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public String list(String privilegeName, Integer pageNo, Integer pageSize) {
        PageResult<SysPrivilege> result = null;
        try {
            result = sysPrivilegeService.queryByPage(privilegeName, pageNo, pageSize);
            return responseSuccess(result);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(@RequestBody SysPrivilege sysPrivilege){
        Map<String,String> map =  new HashMap<>();
        try {
            sysPrivilegeService.savePrivilege(sysPrivilege);
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/get/{priId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer priId) {
        try {
            SysPrivilege sysPrivilege = sysPrivilegeService.queryById(priId);
            return responseSuccess(sysPrivilege);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }


}
