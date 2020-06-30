package com.myTool;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeMap;

public class MapHandle implements Mapable {

    private Object pojo;
    private Map<String, Object> map;

    public static enum MapType {
        HashMap, LinkedHashMap, TreeMap
    }

    public MapHandle(Object pojo, MapType mapType) {
        this.pojo = pojo;
        switch (mapType) {
            case HashMap:
                this.map = new HashMap<String, Object>();
                break;
            case LinkedHashMap:
                this.map = new LinkedHashMap<String, Object>();
                break;
            case TreeMap:
                this.map = new TreeMap<String, Object>();
                break;
        }
    }

    @Override
    public Map<String, Object> toMap() {

        Class<?> clazz = this.pojo.getClass();

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
                this.map.put(fieldName, result);
            } else {
                this.map.put(fieldName, null);
            }
        }
        return this.map;
    }

}