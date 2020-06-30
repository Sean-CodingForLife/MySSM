package com.service;

import java.util.List;

import com.dao.UserDao;
import com.message.Message;
import com.po.User;
import com.reponseData.ResponseData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

@Service("UserService")
@Transactional
public class UserServiceImp implements UserService {

	@Autowired
	UserDao userDao;

	@Override
	public Message login(User user) {

		User _user = userDao.queryUserByAccount(user.getAccount());

		if (_user != null) {
			if (_user.getPassword().equals(user.getPassword())) {
				return Message.loginSuccess;
			} else
				return Message.loginFail_Password;
		} else
			return Message.loginFail_Account;

	}

	@Override
	public Message register(User user) {
		if (userDao.queryUserByAccount(user.getAccount()) != null) {
			userDao.addUser(user);
			return Message.registerSuccess;
		}
		return Message.registerFail;
	}

	@Override
	public ResponseData queryUsers(@RequestParam String keyword, @RequestParam String type,
			@RequestParam Integer startPage, @RequestParam Integer offset) {

		Integer count = 0;
		Integer start = (startPage - 1) * offset;
		Integer end = offset;

		List<User> userList = null;

		switch (keyword) {
			case "":
				count = userDao.queryUsersCount();
				if (count != 0) {
					userList = userDao.queryUsers(start, end);
				}
				break;
			default:
				switch (type) {
					case "name":
						count = userDao.queryUsersCountByName(keyword);
						if (count != 0) {
							userList = userDao.queryUsersByName(keyword, start, end);
						}
						break;
					case "status":
						count = userDao.queryUsersCountByStatus(keyword);
						if (count != 0) {
							userList = userDao.queryUsersByStatus(keyword, start, end);
						}
						break;
				}
				break;
		}
		return new ResponseData(count, userList, (userList != null));
	}

	@Override
	public Message deleteUsers(List<User> users) {
		for (User user : users) {
			if (userDao.deleteUser(user) == 0) {
				return Message.fail;
			}

		}
		return Message.success;
	}

}
