package com.lte.controller.sys;

import com.lte.controller.base.BaseController;
import com.lte.entity.SysDicItem;
import com.lte.service.SysDicItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by think on 2016/11/16.
 */
@Controller
@RequestMapping("/dicItem")
public class SysDicItemController extends BaseController {
    @Autowired
    private SysDicItemService sysDicItemService;

    @ResponseBody
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    public String save(@RequestBody List<SysDicItem> list){
        Map<String,String> map = new HashMap<>();

        if(list != null && list.size() >0){
            Integer typeId = list.get(0).getTypeId();
            if(sysDicItemService.queryByTypeId(typeId).size() > 0){
                sysDicItemService.deleteByTypeId(typeId);
                for (SysDicItem sysDicItem:list) {
                    sysDicItemService.saveDicItem(sysDicItem);
                }
                map.put("msg","sucs");
            }else{
                for (SysDicItem sysDicItem:list) {
                    sysDicItemService.saveDicItem(sysDicItem);
                }
                map.put("msg","sucs");
            }
        }else{
            map.put("msg","fail");
        }
        return responseSuccess(map);
    }

    @ResponseBody
    @RequestMapping(value = "/list/{typeId}",method = RequestMethod.POST)
    public String list(@PathVariable Integer typeId){
        try {
             List<SysDicItem> list = sysDicItemService.queryByTypeId(typeId);
            return responseArraySuccess(list);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }


    @ResponseBody
    @RequestMapping(value = "/list/",method = RequestMethod.GET)
    public String get(String dicTypeCode){
        try {
            List<SysDicItem> list = sysDicItemService.queryByTypeCode(dicTypeCode);
            return responseArraySuccess(list);
        } catch (Exception e) {
            return responseFail(e.getMessage());
        }
    }
}
