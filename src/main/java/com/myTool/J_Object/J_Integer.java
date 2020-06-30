package com.myTool.J_Object;

import com.myTool.JsonableAdapter;

public class J_Integer extends JsonableAdapter {

    private Integer integer;

    public J_Integer(Integer integer) {
        this.integer = integer;
    }

    @Override
    public String toJson(String key, Boolean flag) {
        if (flag) {

            if (key == null || key.equals("")) {
                return (String.valueOf(this.integer));
            } else {
                return ("\"" + key + "\" : " + String.valueOf(this.integer));
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\" : " + String.valueOf(this.integer)));
        }
    }

}