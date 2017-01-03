package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysMenu;
import com.lte.service.SysMenuService;
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
 * Created by think on 2016/11/18.
 */
@Controller
@RequestMapping("/menu")
public class SysMenuController extends BaseController {
    @Autowired
    private SysMenuService sysMenuService;
    private List<SysMenu> menuList;
    private List<SysMenu> returnList;
    @RequestMapping(value = "/manager",method = RequestMethod.GET)
    public ModelAndView manager(){
        return new ModelAndView("admin/menu/manager");
    }

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(@RequestBody SysMenu sysMenu){
        Map<String,String> map = new HashMap<>();
        try {
            if(sysMenu.getMenuId() == null){
                sysMenu.setMenuParent(0);
                sysMenuService.saveMenu(sysMenu);
            }else{
                sysMenu.setMenuParent(sysMenu.getMenuId());
                sysMenuService.saveMenu(sysMenu);
            }
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }

    }

    @ResponseBody
    @RequestMapping(value = "/update/icon",method = RequestMethod.POST)
    public String updateIcon(Integer menuId,String iconName){
        Map<String,String> map = new HashMap<>();
        try {
            SysMenu sysMenu =  sysMenuService.queryById(menuId);
            sysMenu.setMenuIcon(iconName);
            sysMenuService.updateMenu(sysMenu);
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }
    }


    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public String list(){
        menuList=sysMenuService.queryAll();
        returnList = new ArrayList<>();
        try {
            for (SysMenu sysMenu : menuList) {
                Integer id = sysMenu.getMenuId();
                if (sysMenu.getMenuParent() == 0) {
                    returnList.add(sysMenu);
                    build(sysMenu);
                }
            }
            return responseArraySuccess(returnList);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    private void build(SysMenu sysMenu){
        List<SysMenu> children = getChildren(sysMenu);
        if (!children.isEmpty()) {
            for (SysMenu child : children) {
                Integer id = child.getMenuId();
                returnList.add(sysMenuService.queryById(id));
                build(child);
            }
        }
    }

    private List<SysMenu> getChildren(SysMenu sysMenu){
        List<SysMenu> children  = new ArrayList<SysMenu>();
        Integer menuId = sysMenu.getMenuId();
        for (SysMenu child: menuList) {
            if(menuId==child.getMenuParent()){
                children.add(child);
            }
        }
        return children;
    }

}
