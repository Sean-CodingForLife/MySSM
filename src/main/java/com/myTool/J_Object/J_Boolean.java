package com.myTool.J_Object;

import com.myTool.JsonableAdapter;

public class J_Boolean extends JsonableAdapter {

    private Boolean bool;

    public J_Boolean (Boolean bool) {
        this.bool = bool;
    }

    @Override
    public String toJson(String key, Boolean flag) {
        if (flag) {
            if (key == null || key.equals("")) {
                return (String.valueOf(bool));
            } else {
                return ("\"" + key + "\" : " + String.valueOf(bool));
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\" : " + String.valueOf(bool)));
        }
    }
    
}