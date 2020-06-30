package com.myTool;

import java.util.ArrayList;
import java.util.List;

public class MyCastTool {

    public static List<Object> Object2ObjectList(Object object) {
        if (object instanceof List<?>) {
            List<Object> list = new ArrayList<Object>();
            for (Object _object : (List<?>) object) {
                list.add(_object);
            } return list;
        } return null;
    }

    public static <T> List<Object> TList2ObjectList(List<T> _list) {

        if (_list != null) {

            List<Object> list = new ArrayList<Object>();

            for (T t : _list) {
                list.add((Object) t);
            } return list;
        } return null;
    }
}