package com.myTool.J_Object;

import com.myTool.JsonableAdapter;

public class J_Null extends JsonableAdapter {

    public J_Null(Object object) {
    }

    @Override
    public String toJson(String key, Boolean flag) {
        if (flag) {
            if (key.equals("")) {
                return "null";
            } else {
                return "\"" + key + "\"" + " : null";
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\"" + " : null"));
        }
    }

}