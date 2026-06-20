package com.controller;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.CannotCreateTransactionException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

@ControllerAdvice(annotations = Controller.class)
public class ApiExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(ApiExceptionHandler.class);

    @Autowired
    private MessageSource messageSource;

    @ExceptionHandler(Exception.class)
    public Object handleException(Exception exception, HttpServletRequest request) {
        logger.error("Request failed: {} {}", request.getMethod(), request.getRequestURI(), exception);

        if (!isApiRequest(request)) {
            return new ModelAndView("Error");
        }

        String code = isDatabaseException(exception) ? "error.database" : "error.server";
        String fallback = isDatabaseException(exception)
                ? "Database connection failed. Please check the datasource settings."
                : "Server error. Please check the console log.";

        Map<String, Object> body = new LinkedHashMap<String, Object>();
        body.put("flag", false);
        body.put("code", code);
        body.put("message", getMessage(code, fallback, request));

        return new ResponseEntity<Map<String, Object>>(body, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private boolean isApiRequest(HttpServletRequest request) {
        String contextPath = request.getContextPath();
        String path = request.getRequestURI().substring(contextPath.length());
        return path.startsWith("/api/");
    }

    private boolean isDatabaseException(Throwable throwable) {
        Throwable current = throwable;
        while (current != null) {
            if (current instanceof SQLException
                    || current instanceof DataAccessException
                    || current instanceof CannotCreateTransactionException) {
                return true;
            }
            current = current.getCause();
        }
        return false;
    }

    private String getMessage(String code, String fallback, HttpServletRequest request) {
        Locale locale = RequestContextUtils.getLocale(request);
        return messageSource.getMessage(code, null, fallback, locale);
    }
}
