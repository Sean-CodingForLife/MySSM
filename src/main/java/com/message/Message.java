package com.message;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.myTool.Jsonable;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum Message implements Jsonable {

    loginSuccess("Login succeeded.", true),
    loginFail_Password("Login failed: incorrect password.", false),
    loginFail_Account("Login failed: account not found.", false),
    registerSuccess("Registration succeeded.", true),
    registerFail("Registration failed.", false),
    fail("Operation failed.", false),
    success("Operation succeeded.", true);

    private String message;
    private boolean flag;

    Message(String message, boolean flag) {
        this.message = message;
        this.flag = flag;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean getFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    @Override
    public String toJson() {
        return "{\"message\" : " + "\"" + this.message + "\", "
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
}
