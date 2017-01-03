package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysMenu;
import com.lte.entity.SysPriRefMenu;
import com.lte.service.SysMenuService;
import com.lte.service.SysPriRefMenuService;
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
 * Created by think on 2016/11/18.
 */
@Controller
@RequestMapping("/")
public class SysPriRefMenuController extends BaseController {
    @Autowired
    private SysPriRefMenuService sysPriRefMenuService;
    @Autowired
    private SysMenuService sysMenuService;

    @ResponseBody
    @RequestMapping(value = "/pri/menus/{priId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer priId){
        List<SysPriRefMenu> list =  sysPriRefMenuService.queryByPriId(priId);
        List<SysMenu> menuAll =  sysMenuService.queryAll();
        List<Integer> menuId = new ArrayList<>();
        List<TreeNode> nodeList = new ArrayList<>();
        for (SysPriRefMenu sysPriRefMenu:list) {
            menuId.add(sysPriRefMenu.getMenuId());
        }
        for (SysMenu sysMenu :menuAll) {
            TreeNode treeNode = null;
            if(menuId.contains(sysMenu.getMenuId())){
                treeNode = new TreeNode();
                treeNode.setChecked(true);
                treeNode.setName(sysMenuService.queryById((int)sysMenu.getMenuId()).getMenuName());
                treeNode.setPid(sysMenu.getMenuParent());
                treeNode.setId(sysMenu.getMenuId());
            }else{
                treeNode = new TreeNode();
                treeNode.setName(sysMenuService.queryById((int)sysMenu.getMenuId()).getMenuName());
                treeNode.setPid(sysMenu.getMenuParent());
                treeNode.setId(sysMenu.getMenuId());
            }
            nodeList.add(treeNode);
        }
           return responseArraySuccess(nodeList);
    }

    @ResponseBody
    @RequestMapping(value = "/pri/menus/save",method = RequestMethod.POST)
    public String save(String menus,Integer priId){
        try {
            String[] menuArr = menus.split(",");
            sysPriRefMenuService.deleteAllByPriId(priId);
            for (int i = 0; i < menuArr.length; i++) {
                 if(!menuArr[i].equals("") || menuArr[i]!=null){
                     SysPriRefMenu sysPriRefMenu = new SysPriRefMenu();
                     sysPriRefMenu.setMenuId(Integer.valueOf(menuArr[i]));
                     sysPriRefMenu.setPriId(priId);
                     sysPriRefMenuService.insertSysPriRefMenu(sysPriRefMenu);
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
