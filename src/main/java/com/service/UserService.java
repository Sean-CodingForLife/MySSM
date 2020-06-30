package com.service;

import java.util.List;

import com.message.Message;
import com.po.User;
import com.reponseData.ResponseData;

public interface UserService {
	public ResponseData queryUsers(String keyword, String type, Integer startPage, Integer offset);

	public Message deleteUsers(List<User> users);

	public Message login(User user);

	public Message register(User user);
}
