package com.myTool.J_Object;

import java.text.SimpleDateFormat;
import java.util.Date;
import com.myTool.JsonableAdapter;

public class J_Date extends JsonableAdapter {

    private Date date;

    public J_Date(Date date) {
        this.date = date;
    }
    
    @Override
    public String toJson(String key, Boolean flag) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        if (flag) {
            if (key == null || key == "") {
                return ("\"" + format.format(date) + "\"");
            } else {
                return ("\"" + key + "\" : " + "\"" + format.format(date) + "\"");
            }
        } else {
            return String.format("{%s}", ("\"" + key + "\" : " + "\"" + format.format(date) + "\""));
        }
    }
    
}