package com.myTool;

import javax.servlet.http.Cookie;

public class MyCookieTool {
    
    public static Cookie createCookie(String key, String value) {
    	Cookie cookie = new Cookie(key, value);
		return cookie;
    }
    
    public static String getCookiesValueByName(String name, Cookie[] cookies) {
        if (cookies == null) {
            return "";
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                return cookie.getValue();
            }
        } return "";
    }
}
