package com.myTool;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class MyClassTypeTool {

    public static boolean isInteger(Object object) {
        return object instanceof Integer;
    }

    public static boolean isString(Object object) {
        return object instanceof String;
    }

    public static boolean isBoolean(Object object) {
        return object instanceof Boolean;
    }

    public static boolean isDate(Object object) {
        return object instanceof Date;
    }

    public static boolean isList(Object object) {
        return object instanceof List<?>;
    }

    public static boolean isMap(Object object) {
        return object instanceof Map<?, ?>;
    }


}