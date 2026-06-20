package com.myTool;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MyTokenTool {

    private static final String TOKEN_COOKIE = "myssm_token";
    private static final String TOKEN_SESSION = "sessionToken";

    public static boolean checkToken(HttpServletRequest request) {

        if (request == null) {
            throw new NullPointerException("Request is null");
        }

        HttpSession session = request.getSession();
        String nekot = MyCookieTool.getCookiesValueByName(TOKEN_COOKIE, request.getCookies());
        String token = (String) session.getAttribute(TOKEN_SESSION);
        return nekot != null && nekot.equals(token);
    }

    public static boolean hasRole(String role, HttpServletRequest request) {
        return checkToken(request) && role.equals(request.getSession().getAttribute("loginRole"));
    }

    public static void addToken(HttpServletRequest request, HttpServletResponse response) {

        Random random = new Random();
        Date date = new Date();
        Long token = date.getTime() + random.nextInt(256);
        HttpSession session = request.getSession();
        String sToken = token.toString();

        session.setAttribute(TOKEN_SESSION, sToken);
        Cookie cookie = new Cookie(TOKEN_COOKIE, sToken);
        cookie.setPath(request.getContextPath() + "/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    public static void removeToken(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        session.removeAttribute(TOKEN_SESSION);

        Cookie cookie = new Cookie(TOKEN_COOKIE, "");
        cookie.setPath(request.getContextPath() + "/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}
