package com.myTool.J_Object;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.myTool.JsonHandle;
import com.myTool.JsonableAdapter;

public class J_POJO extends JsonableAdapter {

    private Object pojo;

    public J_POJO(Object pojo) {
        this.pojo = pojo;
    }

    @Override
    public String toJson(String key, Boolean flag) {

        Class<?> clazz = pojo.getClass();

        String json = "";

        if (pojo != null) {

            if (flag == false) {
                json += "{";
            }
            if (key.equals("") == false) {
                json += "\"" + key + "\" :";
            }
            json += "{";

            Field[] fields = clazz.getDeclaredFields();

            for (Integer i = 0; i < fields.length; i++) {

                Field field = fields[i];

                String fieldName = field.getName();
                String upperChar = fieldName.substring(0, 1).toUpperCase();
                String anotherStr = fieldName.substring(1);
                String methodName = "get" + upperChar + anotherStr;

                Method method = null;
                Object result = null;
                try {
                    method = clazz.getMethod(methodName);
                    result = method.invoke(pojo);
                } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
                        | InvocationTargetException e) {
                    e.printStackTrace();
                }

                if (result != null) {
                    JsonHandle jsonHandle = new JsonHandle(result);
                    json += jsonHandle.getJson(fieldName, true);
                } else {
                    json += "\"" + fieldName + "\" : " + "null";
                }
                if (i != (fields.length - 1)) {
                    json += ", ";
                } else {
                    json += "}";
                }
            }
            if (flag == false) {
                json += "}";
            }
        } else {
            if (flag) {
                if (key.equals("")) {
                    return "null";
                } else {
                    return ("\"" + key + "\"" + " : null");
                }
            } else {
                return String.format("{%s}", ("\"" + key + "\"" + " : null"));
            }
        }

        return json;
    }

}