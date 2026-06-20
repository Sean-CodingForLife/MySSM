package com.service;

import java.util.List;

import com.dao.UserDao;
import com.message.Message;
import com.po.User;
import com.responseData.ResponseData;
import com.security.PasswordHash;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("UserService")
@Transactional
public class UserServiceImp implements UserService {

	@Autowired
	UserDao userDao;

	@Override
	public boolean accountExists(String account) {
		return userDao.queryUserByAccount(account) != null;
	}

	@Override
	public User login(User user) {

		User _user = userDao.queryUserByAccount(user.getAccount());

		if (_user != null) {
			if (PasswordHash.matches(user.getPassword(), _user.getPassword())) {
				return _user;
			}
		}
		return null;
	}

	@Override
	public Message register(User user) {
		user.setRole("USER");
		return addUser(user);
	}

	@Override
	public Message addUser(User user) {
		if (userDao.queryUserByAccount(user.getAccount()) == null) {
			user.setRole(normalizeRole(user.getRole()));
			user.setPassword(PasswordHash.hash(user.getPassword()));
			userDao.addUser(user);
			userDao.assignUserRole(user.getId(), user.getRole());
			return Message.registerSuccess;
		}
		return Message.registerFail;
	}

	@Override
	public ResponseData queryUsers(String keyword, String type, Integer startPage, Integer offset) {

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
					case "role":
						count = userDao.queryUsersCountByRole(keyword);
						if (count != 0) {
							userList = userDao.queryUsersByRole(keyword, start, end);
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
			userDao.deleteUserRoles(user.getId());
			if (userDao.deleteUser(user) == 0) {
				return Message.fail;
			}

		}
		return Message.success;
	}

	private String normalizeRole(String role) {
		if ("ADMIN".equals(role)) {
			return "ADMIN";
		}
		return "USER";
	}

}
