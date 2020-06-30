package com.myTool;

public class MyJsonTool {
    public static String getJson(Object object) {
        JsonHandle jsonHandle = new JsonHandle(object);
        return jsonHandle.getJson("", true);
    }
}