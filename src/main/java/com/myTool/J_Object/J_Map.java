package com.myTool.J_Object;

import java.util.Iterator;
import java.util.Map;

import com.myTool.JsonHandle;
import com.myTool.JsonableAdapter;

public class J_Map extends JsonableAdapter {

    private Map<?, ?> map;

    public J_Map(Map<?, ?> map) {
        this.map = map;
    }

    @Override
    public String toJson(String key, Boolean flag) {

        if (map == null) {
            throw new NullPointerException();
        }

        Iterator<?> iterator = map.keySet().iterator();

        boolean tmp = iterator.hasNext();

        String json = "";

        if (tmp) {

            if (flag == false) {
                json += "{";
            }
            if (key.equals("") == false) {
                json += "\"" + key + "\" : ";
            }
            json += "{";
            while (tmp) {
                String name = (String) iterator.next();

                Object object = map.get(name);

                json += "\"" + name + "\" : ";

                if (object != null) {
                    JsonHandle jsonHandle = new JsonHandle(object);

                    json += jsonHandle.getJson();

                } else {
                    json += "null";
                }
                tmp = iterator.hasNext();
                if (tmp == false) {
                    json += "}";
                } else {
                    json += ", ";
                }
            }
            if (flag == false) {
                json += "}";
            }
        } else {
            if (flag) {
                if (key == null || key.equals("") == false) {
                    return "{}";
                } else {
                    return key + " : {}";
                }
            } else {
                return "{\"" + key + "\" : {}}";
            }
        }
        return json;
    }
}