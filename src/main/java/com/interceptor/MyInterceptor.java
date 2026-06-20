package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myTool.MyTokenTool;

import org.springframework.web.servlet.HandlerInterceptor;

public class MyInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());

        if (isPublicPath(path)) {
            return true;
        }

        if (path.equals("/dashboard")) {
            return allowOrRedirect(MyTokenTool.checkToken(request), request, response, "/");
        }

        if (isAdminPath(path)) {
            return allowOrRedirect(MyTokenTool.hasRole("ADMIN", request), request, response, "/");
        }

        if (isUserPath(path)) {
            return allowOrRedirect(MyTokenTool.hasRole("USER", request), request, response, "/");
        }

        return true;
    }

    private boolean isPublicPath(String path) {
        return path.equals("/")
                || path.equals("/user/register")
                || path.equals("/api/session")
                || path.equals("/api/public/users")
                || path.startsWith("/images/")
                || path.startsWith("/js/")
                || path.startsWith("/css/");
    }

    private boolean isAdminPath(String path) {
        return path.startsWith("/admin/")
                || path.startsWith("/api/admin/");
    }

    private boolean isUserPath(String path) {
        return path.startsWith("/user/")
                && !path.equals("/user/register");
    }

    private boolean allowOrRedirect(boolean allowed, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return allowOrRedirect(allowed, request, response, "/");
    }

    private boolean allowOrRedirect(boolean allowed, HttpServletRequest request, HttpServletResponse response,
            String loginPath)
            throws Exception {
        if (allowed) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + loginPath);
        return false;
    }
    
}
