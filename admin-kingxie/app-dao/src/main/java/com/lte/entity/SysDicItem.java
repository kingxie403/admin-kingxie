package com.lte.entity;

/**
 * Created by think on 2016/11/15.
 */
public class SysDicItem {
    //TODO 修改所有entity的ID类型为Integer
    private long id;
    private int sort;
    private int typeId;
    private String text;
    private int value;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "SysDicItem{" +
                "id=" + id +
                ", sort=" + sort +
                ", typeId=" + typeId +
                ", text='" + text + '\'' +
                ", value=" + value +
                '}';
    }
}
