package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysRole;
import com.lte.entity.SysUserGroupRefRole;
import com.lte.service.SysRoleService;
import com.lte.service.SysUserGroupRefRoleService;
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
 * Created by think on 2016/11/23.
 */
@Controller
@RequestMapping("/")
public class SysUserGroupRefRoleController extends BaseController {
    @Autowired
    private SysUserGroupRefRoleService sysUserGroupRefRoleService;
    @Autowired
    private SysRoleService sysRoleService;

    @ResponseBody
    @RequestMapping(value = "userGroup/roles/save",method = RequestMethod.POST)
    public String save(String roles,Integer userGroupId){
        try {
            String[] roleArr = roles.split(",");
            sysUserGroupRefRoleService.deleteAllByUserGroupId(userGroupId);
            for (int i = 0; i < roleArr.length; i++) {
                if(!roleArr[i].equals("") || roleArr[i]!=null){
                    SysUserGroupRefRole sysUserGroupRefRole = new SysUserGroupRefRole();
                    sysUserGroupRefRole.setRoleId(Integer.valueOf(roleArr[i]));
                    sysUserGroupRefRole.setUserGroupId(userGroupId);
                    sysUserGroupRefRoleService.insertSysUserGroupRefRole(sysUserGroupRefRole);
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
    @RequestMapping(value = "userGroup/roles/{userGroupId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer userGroupId){
        List<SysUserGroupRefRole> list =  sysUserGroupRefRoleService.queryByUserGroupId(userGroupId);
        List<SysRole> rolesAll =  sysRoleService.queryAll();
        List<Integer> roleId = new ArrayList<Integer>();
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        for (SysUserGroupRefRole sysUserGroupRefRole:list) {
            roleId.add(sysUserGroupRefRole.getRoleId());
        }
        for (SysRole sysRole :rolesAll) {
            TreeNode treeNode = null;
            if (roleId.contains((int)sysRole.getRoleId())){
                treeNode = new TreeNode();
                treeNode.setChecked(true);
                treeNode.setName(sysRoleService.queryById((int) sysRole.getRoleId()).getRoleName());
                treeNode.setPid(0);
                treeNode.setId(sysRole.getRoleId());
            }else{
                treeNode = new TreeNode();
                treeNode.setName(sysRoleService.queryById((int) sysRole.getRoleId()).getRoleName());
                treeNode.setPid(0);
                treeNode.setId(sysRole.getRoleId());
            }
            nodeList.add(treeNode);
        }
        return responseArraySuccess(nodeList);
    }


}
