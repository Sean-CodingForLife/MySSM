package com.po;

public class SysConfig {
    private Integer id;
    private String config_key;
    private String config_value;
    private String description;
    private String status;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getConfig_key() { return config_key; }
    public void setConfig_key(String config_key) { this.config_key = config_key; }
    public String getConfig_value() { return config_value; }
    public void setConfig_value(String config_value) { this.config_value = config_value; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
