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

        if (path.equals("/admin/dashboard")) {
            return allowOrRedirect(MyTokenTool.checkToken("admin", request), request, response, "/admin/login");
        }

        if (path.equals("/user/dashboard")) {
            return allowOrRedirect(MyTokenTool.checkToken("user", request), request, response, "/user/login");
        }

        if (isAdminPath(path)) {
            return allowOrRedirect(MyTokenTool.checkToken("admin", request), request, response, "/admin/login");
        }

        return true;
    }

    private boolean isPublicPath(String path) {
        return path.equals("/")
                || path.equals("/index.jsp")
                || path.equals("/admin/login")
                || path.equals("/user/login")
                || path.equals("/user/register")
                || path.equals("/api/admin/session")
                || path.equals("/api/user/session")
                || path.equals("/api/public/users")
                || path.startsWith("/js/")
                || path.startsWith("/css/");
    }

    private boolean isAdminPath(String path) {
        return path.startsWith("/admin/")
                || path.startsWith("/api/admin/");
    }

    private boolean allowOrRedirect(boolean allowed, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        return allowOrRedirect(allowed, request, response, "/user/login");
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
