package com.reponseData;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.myTool.JsonableAdapter;
import com.myTool.MyJsonTool;

public class ResponseData extends JsonableAdapter {
    private List<?> data;
    private String head;
    private String body;
    private Map<String, Object> map;

    public ResponseData(Integer count, List<?> data, boolean successful) {
        this.data = data;
        this.map = new LinkedHashMap<String, Object>();
        map.put("count", count);
        map.put("successful", successful);

        this.head = "";
        this.body = "";
    }

    public String getHead() {
        if (this.head.equals("")) {
            return "{\"head\" : {}}";
        } else {
            return this.head;
        }
    }

    public String getBody() {
        if (this.body.equals("")) {
            return "{\"body\" : {}}";
        } else {
            return this.body;
        }
    }

    @Override
    public String toJson() {

        this.head = MyJsonTool.getJson(map);
        this.body = MyJsonTool.getJson(data);
        
        return String.format("{\"head\" : %s, \"body\" : %s}", this.head, this.body);
    }

}