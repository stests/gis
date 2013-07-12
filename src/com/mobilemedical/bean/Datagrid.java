package com.mobilemedical.bean;

import java.util.List;

/**
 * User: zhujun
 * Date: 13-7-10
 * Time: 下午2:40
 */
public class Datagrid {

    private int total;
    private List rows;
    private List footer;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

    public List getFooter() {
        return footer;
    }

    public void setFooter(List footer) {
        this.footer = footer;
    }
}
