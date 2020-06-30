package com.myTool.J_Object;

import com.myTool.JsonableAdapter;

public class J_Enum extends JsonableAdapter {

    public Enum<?> e;

    public J_Enum(Enum<?> e) {
        this.e = e;
    }

    @Override
    public String toJson (String key, Boolean flag) {

        if (flag) {
            if (key == null || key == "") {
                return "\"" + e.name() + "\"";
            } else {
                return ("\"" + key + "\" : " + "\"" + e.name() + "\"");
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\" : " + "\"" + e.name() + "\""));
        }
    }

}