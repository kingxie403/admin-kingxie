package com.lte.entity;

/**
 * Created by think on 2016/11/18.
 * 权限菜单关联
 */
public class SysPriRefMenu {
    private Integer priId;//权限ID
    private Integer menuId;//菜单ID

    public Integer getPriId() {
        return priId;
    }

    public void setPriId(Integer priId) {
        this.priId = priId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return "SysPriRefMenu{" +
                "priId=" + priId +
                ", menuId=" + menuId +
                '}';
    }
}
