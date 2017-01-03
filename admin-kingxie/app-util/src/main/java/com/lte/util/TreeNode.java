package com.lte.util;

import java.io.Serializable;

/**
 * Created by think on 2016/11/14.
 */
public class TreeNode implements Serializable {
    private long id; //ID
    private String name;//节点名字
    private long pid; //节点的父ID
    private String url; //节点打开的地址
    private boolean checked;
    private String target; //节点在某个frame或者Iframe打开

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getPid() {
        return pid;
    }

    public void setPid(long pid) {
        this.pid = pid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    @Override
    public String toString() {
        return "TreeNode{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", pid='" + pid + '\'' +
                ", url='" + url + '\'' +
                ", target='" + target + '\'' +
                '}';
    }
}
