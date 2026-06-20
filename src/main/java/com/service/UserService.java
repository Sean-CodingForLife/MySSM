package com.service;

import java.util.List;

import com.message.Message;
import com.po.User;
import com.responseData.ResponseData;

public interface UserService {
	public ResponseData queryUsers(String keyword, String type, Integer startPage, Integer offset);

	public Message addUser(User user);

	public Message deleteUsers(List<User> users);

	public boolean accountExists(String account);

	public User login(User user);

	public Message register(User user);
}
