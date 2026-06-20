package com.po;

import java.util.Date;

public class LoginLog {
    private Integer id;
    private String account;
    private String status;
    private String ip;
    private String message;
    private Date created_date;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getAccount() { return account; }
    public void setAccount(String account) { this.account = account; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getIp() { return ip; }
    public void setIp(String ip) { this.ip = ip; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Date getCreated_date() { return created_date; }
    public void setCreated_date(Date created_date) { this.created_date = created_date; }
}
