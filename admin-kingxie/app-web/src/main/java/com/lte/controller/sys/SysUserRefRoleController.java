package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysRole;
import com.lte.entity.SysUserRefRole;
import com.lte.service.SysRoleService;
import com.lte.service.SysUserRefRoleService;
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
 * Created by think on 2016/11/12.
 */
@Controller
@RequestMapping("/")
public class SysUserRefRoleController extends BaseController {
    @Autowired
    private SysUserRefRoleService sysUserRefRoleService;
    @Autowired
    private SysRoleService sysRoleService;

    @ResponseBody
    @RequestMapping(value = "/user/roles/{userId}",method =RequestMethod.POST)
    public String queryRole(@PathVariable Integer userId){
        List<SysUserRefRole> sysUserRefRoleList = sysUserRefRoleService.queryByUserId(userId);
        List<SysRole> sysRoleList = sysRoleService.queryAll();
        List<Long> useRoleId = new ArrayList<>();
        List<TreeNode> roleList = new ArrayList<>();
        for (SysUserRefRole sysUserRefRole:sysUserRefRoleList) {
            useRoleId.add(sysUserRefRole.getRoleId());
        }
        for (SysRole sysRole:sysRoleList ) {
            TreeNode treeNode = null;
            if (useRoleId.contains(sysRole.getRoleId())){
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
            roleList.add(treeNode);
        }

        return responseArraySuccess(roleList);
    }

    @ResponseBody
    @RequestMapping(value = "/user/roles/save",method = RequestMethod.POST)
    public String saveRoles(String roles,Integer userId){
        String[] roleArr = roles.split(",");
        try {
            sysUserRefRoleService.deleteAllByUserId(userId);
            for (int i = 0; i < roleArr.length; i++) {
                if(!roleArr[i].equals("") && roleArr[i]!=null){
                    SysUserRefRole sysUserRefRole = new SysUserRefRole();
                    sysUserRefRole.setUserId(userId);
                    sysUserRefRole.setRoleId(Long.parseLong(roleArr[i]));
                    sysUserRefRoleService.saveSysUserRefRole(sysUserRefRole);
                }
            }
            Map<String,String> map = new HashMap<>();
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }

    }

}
