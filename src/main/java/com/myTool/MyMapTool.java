package com.myTool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MyMapTool {
    
    public static Map<String, Object> getMap(Object pojo) {
        MapHandle mapHandle = new MapHandle(pojo, MapHandle.MapType.LinkedHashMap);
        return mapHandle.toMap();
    }

    public static Map<String, Object> getMap(Object pojo, MapHandle.MapType mapType) {
        MapHandle mapHandle = new MapHandle(pojo, mapType);
        return mapHandle.toMap();
    }

    public static List<Map<String, Object>> getMaps(List<?> pojos) {
        List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();

        for (Object pojo : pojos) {
            maps.add(MyMapTool.getMap(pojo));
        } return maps;
    }
    
}