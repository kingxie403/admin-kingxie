package com.lte.controller.sys;

import com.lte.entity.SysUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by think on 2016/11/8.
 */
@Controller
@RequestMapping("/")
public class HomeController {

    @RequestMapping(value = "home",method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request){
        HttpSession session = request.getSession();
        SysUser sysUser = (SysUser) session.getAttribute("user");
        ModelAndView modelAndView = new ModelAndView("home");
        modelAndView.addObject("user",sysUser);
        return modelAndView;
    }
}
