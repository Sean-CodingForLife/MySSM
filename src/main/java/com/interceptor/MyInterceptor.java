package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myTool.MyTokenTool;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MyInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());

        if (isPublicPath(path)) {
            return true;
        }

        if (isAdminPath(path)) {
            return allowOrRedirect(MyTokenTool.checkToken("admin", request), request, response);
        }

        if (path.equals("/manager")) {
            boolean loggedIn = MyTokenTool.checkToken("admin", request) || MyTokenTool.checkToken("user", request);
            return allowOrRedirect(loggedIn, request, response);
        }

        return true;
    }

    private boolean isPublicPath(String path) {
        return path.equals("/")
                || path.equals("/index.jsp")
                || path.startsWith("/login")
                || path.startsWith("/register")
                || path.startsWith("/js/")
                || path.startsWith("/css/");
    }

    private boolean isAdminPath(String path) {
        return path.startsWith("/user/")
                || path.startsWith("/department/")
                || path.startsWith("/job/")
                || path.startsWith("/document/")
                || path.startsWith("/employee/")
                || path.startsWith("/notice/");
    }

    private boolean allowOrRedirect(boolean allowed, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        if (allowed) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + "/login/admin");
        return false;
    }
    
}
