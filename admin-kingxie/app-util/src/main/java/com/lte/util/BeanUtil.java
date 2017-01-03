package com.lte.util;

import com.github.pagehelper.Page;

import java.util.List;

/**
 * Created by think on 2016/11/9.
 */
public class BeanUtil {
    public static <T> PageResult<T> toPageResult(List<T> datas) {
        PageResult<T> result = new PageResult<T>();
        if (datas instanceof Page) {
            Page page = (Page) datas;
            result.setPageNo(page.getPageNum());
            result.setPageSize(page.getPageSize());
            result.setDataList(page.getResult());
            result.setTotal(page.getTotal());
            result.setPages(page.getPages());
        }
        else {
            result.setPageNo(1);
            result.setPageSize(datas.size());
            result.setDataList(datas);
            result.setTotal(datas.size());
        }

        return result;
    }
}
