package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysUserGroup;
import com.lte.entity.SysUserGroupRefUser;
import com.lte.service.SysUserGroupRefUserService;
import com.lte.service.SysUserGroupService;
import com.lte.util.TreeNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/11/22.
 */
@Controller
@RequestMapping("/")
public class SysUserGroupRefUserController extends BaseController {
    @Autowired
    private SysUserGroupRefUserService sysUserGroupRefUserService;
    @Autowired
    private SysUserGroupService sysUserGroupService;

    @ResponseBody
    @RequestMapping(value = "user/groups/save",method = RequestMethod.POST)
    public String save(String userGroups,Integer userId){
        try {
            String[] groupArr = userGroups.split(",");
            sysUserGroupRefUserService.deleteAllByUserId(userId);
            for (int i = 0; i < groupArr.length; i++) {
                if(!groupArr[i].equals(" ")){
                    SysUserGroupRefUser sysUserGroupRefUser = new SysUserGroupRefUser();
                    sysUserGroupRefUser.setUserGroupId(Integer.valueOf(groupArr[i]));
                    sysUserGroupRefUser.setUserId(userId);
                    sysUserGroupRefUserService.insertSysUserGroupRefUser(sysUserGroupRefUser);
                }
            }
            Map<String,String> map = new HashMap<>();
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "user/groups/{userId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer userId){
        List<SysUserGroupRefUser> list =  sysUserGroupRefUserService.queryByUserId(userId);
        List<SysUserGroup> groupsAll =  sysUserGroupService.queryAll();
        List<Integer> groupId = new ArrayList<>();
        List<TreeNode> nodeList = new ArrayList<>();
        for (SysUserGroupRefUser sysUserGroupRefUser:list) {
            groupId.add(sysUserGroupRefUser.getUserGroupId());
        }
        for (SysUserGroup sysUserGroup :groupsAll) {
            TreeNode treeNode = null;
            if(groupId.contains(sysUserGroup.getGroupId())){
                treeNode = new TreeNode();
                treeNode.setChecked(true);
                treeNode.setName(sysUserGroupService.queryById((int)sysUserGroup.getGroupId()).getGroupName());
                treeNode.setPid(sysUserGroup.getParentId());
                treeNode.setId(sysUserGroup.getGroupId());
            }else{
                treeNode = new TreeNode();
                treeNode.setName(sysUserGroupService.queryById((int)sysUserGroup.getGroupId()).getGroupName());
                treeNode.setPid(sysUserGroup.getParentId());
                treeNode.setId(sysUserGroup.getGroupId());
            }
            nodeList.add(treeNode);
        }
        return responseArraySuccess(nodeList);
    }

}
