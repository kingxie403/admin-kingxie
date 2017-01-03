package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysPrivilege;
import com.lte.entity.SysRoleRefPri;
import com.lte.service.SysPrivilegeService;
import com.lte.service.SysRoleRefPriService;
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
public class SysRoleRefPriController extends BaseController {
    @Autowired
    private SysRoleRefPriService sysRoleRefPriService;
    @Autowired
    private SysPrivilegeService sysPrivilegeService;

    /**
     * 查询某个角色拥有的所有权限
     * @param roleId 角色ID
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "role/pris/{roleId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer roleId){
        List<SysRoleRefPri> sysRoleRefPriList = sysRoleRefPriService.queryByRoleId(roleId);
        List<SysPrivilege> sysPrivilegeList = sysPrivilegeService.queryAll();
        List<Integer> usePrivilegeId = new ArrayList<>();
        List<TreeNode> roleList = new ArrayList<>();
        for (SysRoleRefPri sysRoleRefPri:sysRoleRefPriList) {
            usePrivilegeId.add(sysRoleRefPri.getPriId());
        }
        for (SysPrivilege sysPrivilege:sysPrivilegeList ) {
            TreeNode treeNode = null;
            if (usePrivilegeId.contains(sysPrivilege.getPriId())){
                treeNode = new TreeNode();
                treeNode.setChecked(true);
                treeNode.setName(sysPrivilegeService.queryById((int) sysPrivilege.getPriId()).getPriName());
                treeNode.setPid(0);
                treeNode.setId(sysPrivilege.getPriId());
            }else{
                treeNode = new TreeNode();
                treeNode.setName(sysPrivilegeService.queryById((int) sysPrivilege.getPriId()).getPriName());
                treeNode.setPid(0);
                treeNode.setId(sysPrivilege.getPriId());
            }
            roleList.add(treeNode);
        }

        return responseArraySuccess(roleList);
    }


    /**
     * 保存角色权限关系
     * @param pris 权限的ID集合
     * @param roleId 角色ID
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "role/pris/save",method = RequestMethod.POST)
    public String save(String pris,Integer roleId){
        try {
            String[] priArr = pris.split(",");
            sysRoleRefPriService.deleteAllByRole(roleId);
            for (int i = 0; i < priArr.length; i++) {
                if(!priArr[i].equals("") || priArr[i]!=null){
                    SysRoleRefPri sysRoleRefPri = new SysRoleRefPri();
                    sysRoleRefPri.setRoleId(roleId);
                    sysRoleRefPri.setPriId(Integer.valueOf(priArr[i]));
                    sysRoleRefPriService.insertSysRoleRefPri(sysRoleRefPri);
                }
            }
            Map<String,String> map = new HashMap<>();
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }

    }
}
