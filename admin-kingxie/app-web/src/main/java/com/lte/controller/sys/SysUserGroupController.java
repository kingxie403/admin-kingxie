package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysUserGroup;
import com.lte.service.SysUserGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/11/22.
 */
@Controller
@RequestMapping("/")
public class SysUserGroupController extends BaseController{
    @Autowired
    private SysUserGroupService sysUserGroupService;
    private List<SysUserGroup> groupList;
    private List<SysUserGroup> returnList;

    @RequestMapping(value = "user/group/manager",method = RequestMethod.GET)
    public ModelAndView manager(){
        return new ModelAndView("admin/user/group/manager");
    }


    @ResponseBody
    @RequestMapping(value = "user/group/save",method = RequestMethod.POST)
    public String save(@RequestBody SysUserGroup sysUserGroup){
        Map<String,String> map = new HashMap<>();
        try {
            if(sysUserGroup.getGroupId() == null){
                sysUserGroup.setParentId(0);
                sysUserGroupService.saveUserGroup(sysUserGroup);
            }else{
                sysUserGroup.setParentId(sysUserGroup.getGroupId());
                sysUserGroupService.saveUserGroup(sysUserGroup);
            }
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }

    }


    @ResponseBody
    @RequestMapping(value = "user/group/list",method = RequestMethod.POST)
    public String list(){
        groupList=sysUserGroupService.queryAll();
        returnList = new ArrayList<>();
        try {
            for (SysUserGroup sysUserGroup : groupList) {
                Integer id = sysUserGroup.getGroupId();
                if (sysUserGroup.getParentId() == 0 || sysUserGroup.getParentId()==null) {
                    returnList.add(sysUserGroup);
                    build(sysUserGroup);
                }
            }
            return responseArraySuccess(returnList);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    private void build(SysUserGroup sysUserGroup){
        List<SysUserGroup> children = getChildren(sysUserGroup);
        if (!children.isEmpty()) {
            for (SysUserGroup child : children) {
                Integer id = child.getGroupId();
                returnList.add(sysUserGroupService.queryById(id));
                build(child);
            }
        }
    }

    private List<SysUserGroup> getChildren(SysUserGroup sysUserGroup){
        List<SysUserGroup> children  = new ArrayList<SysUserGroup>();
        Integer groupId = sysUserGroup.getGroupId();
        for (SysUserGroup child: groupList) {
            if(groupId==child.getParentId()){
                children.add(child);
            }
        }
        return children;
    }
}
