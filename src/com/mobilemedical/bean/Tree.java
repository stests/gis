package com.mobilemedical.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-11
 * Time: 上午11:03
 */
public class Tree {

    private int id;
    private String text;
    private Object attributes;
    private List<Tree> children = new ArrayList<Tree>();
    private String checked;
    private String state;
    private String iconCls;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Object getAttributes() {
        return attributes;
    }

    public void setAttributes(Object attributes) {
        this.attributes = attributes;
    }

    public List<Tree> getChildren() {
        return children;
    }

    public void setChildren(List<Tree> children) {
        this.children = children;
    }

    public String getChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }
}
