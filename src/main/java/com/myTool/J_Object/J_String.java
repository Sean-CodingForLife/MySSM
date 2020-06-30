package com.myTool.J_Object;

import com.myTool.JsonableAdapter;

public class J_String extends JsonableAdapter {

    private String string;

    public J_String(String string) {
        this.string = string;
    }
    
    @Override
    public String toJson(String key, Boolean flag) {
        if (flag) {
            if (key == null || key.equals("")) {
                return ("\"" + string + "\"");
            } else {
                return ("\"" + key + "\" : " + "\"" + string + "\"");
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\" : " + "\"" + string + "\""));
        }
    }
    
}