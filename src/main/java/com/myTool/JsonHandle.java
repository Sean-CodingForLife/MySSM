package com.myTool;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.myTool.J_Object.J_Boolean;
import com.myTool.J_Object.J_Date;
import com.myTool.J_Object.J_Integer;
import com.myTool.J_Object.J_List;
import com.myTool.J_Object.J_Map;
import com.myTool.J_Object.J_Null;
import com.myTool.J_Object.J_POJO;
import com.myTool.J_Object.J_String;

public class JsonHandle {

    private Jsonable jsonable;

    public JsonHandle(Object object) {

        if (object != null) {
            if (MyClassTypeTool.isInteger(object)) {
                jsonable = new J_Integer((Integer) object);
            } else if (MyClassTypeTool.isString(object)) {
                jsonable = new J_String((String) object);
            } else if (MyClassTypeTool.isBoolean(object)) {
                jsonable = new J_Boolean((Boolean) object);
            } else if (MyClassTypeTool.isDate(object)) {
                jsonable = new J_Date((Date) object);
            } else if (MyClassTypeTool.isList(object)) {
                jsonable = new J_List((List<?>) object);
            } else if (MyClassTypeTool.isMap(object)) {
                jsonable = new J_Map((Map<?, ?>) object);
            } else {
                jsonable = new J_POJO(object);
            }
        } else {
            jsonable = new J_Null(object);
        }

    }

    public String getJson() {
        return this.jsonable.toJson("", true);
    }

    public String getJson(String key, Boolean flag) {
        return this.jsonable.toJson(key, flag);
    }

}