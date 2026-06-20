package com.responseData;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.myTool.JsonableAdapter;
import com.myTool.MyJsonTool;

public class ResponseData extends JsonableAdapter {
    private Map<String, Object> head;
    private List<?> body;

    public ResponseData(Integer count, List<?> data, boolean successful) {
        this.body = data;
        this.head = new LinkedHashMap<String, Object>();
        head.put("count", count);
        head.put("successful", successful);
    }

    public Map<String, Object> getHead() {
        return this.head;
    }

    public List<?> getBody() {
        return this.body;
    }

    @Override
    public String toJson() {
        return String.format("{\"head\" : %s, \"body\" : %s}", MyJsonTool.getJson(this.head), MyJsonTool.getJson(this.body));
    }

}
