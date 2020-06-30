package com.message;

import com.myTool.Jsonable;

public enum Message implements Jsonable {

	loginSuccess("登录成功", true),
	loginFail_Password("登录失败，密码错误", false),
	loginFail_Account("登录失败，账号错误", false),
	registerSuccess("注册成功", true),
	registerFail("注册失败", false),
	fail("失败", false),
	success("成功", true);
	
		
	private String  message;
	private boolean flag;

	private Message(String message, boolean flag) {
		 this.setMessage(message);
		 this.setFlag(flag);
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
		return "{\"message\" : " + "\"" + this.message + "\", " +
				"\"flag\"   : " + Boolean.toString(this.flag) + "}";
		
	}

	@Override
	public String toJson(String key, Boolean flag) {
		if (flag) {
			if (key == null || key.equals("")) {
				return "{\"message\" : " + "\"" + this.message + "\", " + "\"flag\"   : " 
				+ Boolean.toString(this.flag) + "}";
			} else {
				return key + " : {\"message\" : " + "\"" + this.message + "\", " + "\"flag\"   : " 
				+ Boolean.toString(this.flag) + "}";
			}
		} else {
			return String.format("{%s}", (key + " : {\"message\" : " + "\"" + this.message + "\", " + "\"flag\"   : "
					+ Boolean.toString(this.flag) + "}"));
		}
	}
}
