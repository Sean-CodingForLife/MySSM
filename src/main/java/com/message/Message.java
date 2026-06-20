package com.message;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.myTool.Jsonable;

import org.springframework.context.MessageSource;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum Message implements Jsonable {

    loginSuccess("message.login.success", "Login succeeded.", true),
    loginFail_Password("message.login.password", "Login failed: incorrect password.", false),
    loginFail_Account("message.login.account", "Login failed: account not found.", false),
    registerSuccess("message.register.success", "Registration succeeded.", true),
    registerFail("message.register.fail", "Registration failed.", false),
    fail("message.operation.fail", "Operation failed.", false),
    success("message.operation.success", "Operation succeeded.", true);

    private String code;
    private String defaultMessage;
    private boolean flag;

    Message(String code, String defaultMessage, boolean flag) {
        this.code = code;
        this.defaultMessage = defaultMessage;
        this.flag = flag;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        if (!(RequestContextHolder.getRequestAttributes() instanceof ServletRequestAttributes)) {
            return defaultMessage;
        }

        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        WebApplicationContext context = RequestContextUtils.findWebApplicationContext(request);
        if (context == null) {
            return defaultMessage;
        }

        MessageSource messageSource = context.getBean(MessageSource.class);
        Locale locale = RequestContextUtils.getLocale(request);
        return messageSource.getMessage(code, null, defaultMessage, locale);
    }

    public void setMessage(String message) {
        this.defaultMessage = message;
    }

    public boolean getFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    @Override
    public String toJson() {
        return "{\"code\" : " + "\"" + this.code + "\", "
                + "\"message\" : " + "\"" + escapeJson(this.getMessage()) + "\", "
                + "\"flag\"   : " + Boolean.toString(this.flag) + "}";
    }

    @Override
    public String toJson(String key, Boolean flag) {
        if (flag) {
            if (key == null || key.equals("")) {
                return toJson();
            }
            return key + " : " + toJson();
        }
        return String.format("{%s}", key + " : " + toJson());
    }

    private String escapeJson(String value) {
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
