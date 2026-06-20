package com.myTool;

import java.util.Date;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;

import com.po.Permission;

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
        if (!checkToken(request)) {
            return false;
        }
        Object roles = request.getSession().getAttribute("loginRole");
        if (roles == null || role == null) {
            return false;
        }
        for (String item : roles.toString().split(",")) {
            if (role.equals(item.trim())) {
                return true;
            }
        }
        return false;
    }

    public static boolean hasPermission(String method, String path, HttpServletRequest request) {
        if (!checkToken(request)) {
            return false;
        }
        Object permissions = request.getSession().getAttribute("loginPermissions");
        if (!(permissions instanceof List<?>)) {
            return false;
        }
        for (Object item : (List<?>) permissions) {
            if (!(item instanceof Permission)) {
                continue;
            }
            Permission permission = (Permission) item;
            if (matches(permission.getMethod(), method) && matches(permission.getPath(), path)) {
                return true;
            }
        }
        return false;
    }

    private static boolean matches(String expected, String actual) {
        return "*".equals(expected) || expected.equalsIgnoreCase(actual);
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
