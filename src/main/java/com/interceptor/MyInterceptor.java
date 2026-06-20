package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myTool.MyTokenTool;
import com.po.OperationLog;
import com.service.SystemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class MyInterceptor implements HandlerInterceptor {

    private static final Logger LOGGER = LoggerFactory.getLogger(MyInterceptor.class);

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
            return allowOrRedirect(MyTokenTool.hasPermission(request.getMethod(), path, request), request, response, "/");
        }

        if (isUserPath(path)) {
            return allowOrRedirect(MyTokenTool.hasPermission(request.getMethod(), path, request), request, response, "/");
        }

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());
        if (!path.startsWith("/api/admin/") || "GET".equalsIgnoreCase(request.getMethod())) {
            return;
        }

        WebApplicationContext context = WebApplicationContextUtils
                .getWebApplicationContext(request.getServletContext());
        if (context == null) {
            return;
        }

        OperationLog log = new OperationLog();
        Object account = request.getSession().getAttribute("loginAccount");
        log.setAccount(account == null ? "" : account.toString());
        log.setMethod(request.getMethod());
        log.setPath(path);
        log.setStatus(ex == null ? "SUCCESS" : "FAIL");
        log.setMessage(ex == null ? "Operation completed." : ex.getMessage());
        try {
            context.getBean(SystemService.class).addOperationLog(log);
        } catch (RuntimeException e) {
            LOGGER.warn("Failed to write operation log.", e);
        }
    }

    private boolean isPublicPath(String path) {
        return path.equals("/")
                || path.equals("/user/register")
                || path.equals("/api/captcha")
                || path.equals("/api/session")
                || path.equals("/api/public/users")
                || path.startsWith("/images/")
                || path.startsWith("/webjars/")
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
