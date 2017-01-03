package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysDicType;
import com.lte.service.SysDicTypeService;
import com.lte.util.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by think on 2016/11/15.
 */
@Controller
@RequestMapping("/dicType")
public class SysDicTypeController extends BaseController {
    @Autowired
    private SysDicTypeService sysDicTypeService;


    @RequestMapping(value = "/manager",method = RequestMethod.GET)
    public ModelAndView manager(){
        return new ModelAndView("admin/dictionary/manager");
    }

    @ResponseBody
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    public String list(String dicTypeName,Integer pageNo,Integer pageSize){
        try {
            PageResult<SysDicType> result = sysDicTypeService.queryByPage(dicTypeName,pageNo,pageSize);
            return responseSuccess(result);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }

    }
    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(@RequestBody SysDicType sysDicType){
        Map<String,String> map = new HashMap<>();
        try {
            sysDicTypeService.saveDicType(sysDicType);
            map.put("msg","sucs");
            return responseSuccess(map);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/get/{dicTypeId}",method = RequestMethod.POST)
    public String get(@PathVariable Integer dicTypeId){
        SysDicType sysDicType =  sysDicTypeService.queryById(dicTypeId);
        return responseSuccess(sysDicType);
    }

    @ResponseBody
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String update(@RequestBody SysDicType sysDicType){
        Map<String,String> map = new HashMap<>();
        try {
            sysDicTypeService.updateDicType(sysDicType);
            map.put("msg","sucs");
            return responseSuccess(sysDicType);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }


    }

}
