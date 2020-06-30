package com.myTool.J_Object;

import java.util.List;

import com.myTool.JsonHandle;
import com.myTool.JsonableAdapter;

public class J_List extends JsonableAdapter {

    private List<?> list;

    public J_List(List<?> list) {
        this.list = list;
    }

    @Override
    public String toJson(String key, Boolean flag) {

        String json = "";

        if (list != null && list.size() != 0) {

            if (flag == false) {
                json = "{";
            }
            if (key.equals("") == false) {
                json += "\"" + key + "\" : ";
            }
            json += "[";

            for (Integer i = 0; i < list.size(); i++) {

                Object object = list.get(i);

                if (object != null) {

                    JsonHandle jsonHandle = new JsonHandle(object);

                    json += jsonHandle.getJson();

                } else {
                    json += "null";
                }

                if (i == (list.size() - 1)) {
                    json += "]";
                } else {
                    json += ", ";
                }

            }
            if (flag == false) {
                json += "}";
            }
            return json;
        } else {
            if (flag) {
                if (key == null || key.equals("") == false) {
                    return "[]";
                } else {
                    return "\"" + key + "\" : []";
                }
            } else {
                return "{\"" + key + "\" : []}";
            }
        }
    }

}