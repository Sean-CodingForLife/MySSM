package com.myTool;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MyTokenTool {

    private static final String USER_TYPE = "user";
    private static final String ADMIN_TYPE = "admin";
    private static final String USER_TOKEN_COOKIE = "user_token";
    private static final String ADMIN_TOKEN_COOKIE = "admin_token";
    private static final String USER_TOKEN_SESSION = "userToken";
    private static final String ADMIN_TOKEN_SESSION = "adminToken";

    public static boolean checkToken(String type, HttpServletRequest request) {

        if (request == null) {
            throw new NullPointerException("Request is null");
        }

        HttpSession session = request.getSession();
        String nekot = MyCookieTool.getCookiesValueByName(getCookieName(type), request.getCookies());
        String token = null;

        switch(type) {
            case USER_TYPE :
                token = (String) session.getAttribute(USER_TOKEN_SESSION);
            break;
            case ADMIN_TYPE :
                token = (String) session.getAttribute(ADMIN_TOKEN_SESSION);
            break;
            default : 
                return false;
        }
        return nekot != null && nekot.equals(token);
    }

    public static void addToken(String type, HttpServletRequest request, HttpServletResponse response) {

        Random random = new Random();
        Date date = new Date();
        Long token = date.getTime() + random.nextInt(256);
        HttpSession session = request.getSession();
        String sToken = token.toString();

        switch (type) {
            case USER_TYPE:
                session.setAttribute(USER_TOKEN_SESSION, sToken);
                break;
            case ADMIN_TYPE:
                session.setAttribute(ADMIN_TOKEN_SESSION, sToken);
                break;
            default:
                return;
        }
        Cookie cookie = new Cookie(getCookieName(type), sToken);
        cookie.setPath(request.getContextPath() + "/");
        response.addCookie(cookie);
    }

    public static void removeToken(String type, HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        if (USER_TYPE.equals(type)) {
            session.removeAttribute(USER_TOKEN_SESSION);
            session.removeAttribute("userAccount");
        } else if (ADMIN_TYPE.equals(type)) {
            session.removeAttribute(ADMIN_TOKEN_SESSION);
            session.removeAttribute("adminUserAccount");
        } else {
            return;
        }

        Cookie cookie = new Cookie(getCookieName(type), "");
        cookie.setPath(request.getContextPath() + "/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }

    private static String getCookieName(String type) {
        if (ADMIN_TYPE.equals(type)) {
            return ADMIN_TOKEN_COOKIE;
        }
        return USER_TOKEN_COOKIE;
    }
}
