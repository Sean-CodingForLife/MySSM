package com.myTool;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MyTokenTool {

    public static boolean checkToken(String type, HttpServletRequest request) {

        if (request == null) {
            throw new NullPointerException("Request is null");
        }

        HttpSession session = request.getSession();
        String nekot = MyCookieTool.getCookiesValueByName("token", request.getCookies());
        String token = null;

        switch(type) {
            case "user" :
                token = (String) session.getAttribute("token");
            break;
            case "admin" :
                token = (String) session.getAttribute("token_admin");
            break;
            default : 
                return false;
        }
        return nekot.equals(token);
    }

    public static void addToken(String type, HttpServletRequest request, HttpServletResponse response) {

        Random random = new Random();
        Date date = new Date();
        Long token = date.getTime() + random.nextInt(256);
        HttpSession session = request.getSession();
        String sToken = token.toString();

        switch (type) {
            case "user":
                session.setAttribute("token", sToken);
                break;
            case "admin":
                session.setAttribute("token_admin", sToken);
                break;
        }Cookie cookie = new Cookie("token", sToken);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}