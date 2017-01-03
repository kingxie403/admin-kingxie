package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysMenu;
import com.lte.entity.SysUser;
import com.lte.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by think on 2016/11/24.
 * 获取用户所拥有的菜单
 */
@Controller
@RequestMapping("/")
public class UserForMenuController extends BaseController{
    @Autowired
    private SysMenuService sysMenuService;

    @ResponseBody
    @RequestMapping(value = "user/menu/all",method = RequestMethod.POST)
    public String queryMenuForUser(HttpServletRequest httpServletRequest){
        try {
            HttpSession session = httpServletRequest.getSession();
            SysUser user = (SysUser) session.getAttribute("user");
            String userName = user.getUserName();
            List<SysMenu> roleMenu=  sysMenuService.queryForUser(userName);
            List<SysMenu> groupMenu = sysMenuService.queryForGroup(userName);
            Set<SysMenu> allMenu = new HashSet<SysMenu>();
            allMenu.addAll(roleMenu);
            allMenu.addAll(groupMenu);
            return responseArraySuccess(allMenu);
        } catch (Exception e) {
            return  responseFail(e.getMessage());
        }
    }
}
