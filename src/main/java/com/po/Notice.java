package com.po;

import java.util.Date;

public class Notice {
    private Integer no;
    private String title;
    private String content;
    private Date   created_date;

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return this.content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreated_date() {
        return created_date;
    }

    public void setCreated_date(Date date) {
        this.created_date = date;
    }
        
}