package com.service;

import com.dao.AdminUserDao;
import com.message.Message;
import com.po.AdminUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("AdminUserService")
@Transactional
public class AdminUserServiceImp implements AdminUserService {

	@Autowired
	AdminUserDao adminUserDao;

	@Override
	public Message login(AdminUser adminUser) {

		AdminUser _adminUser = adminUserDao.queryAdminUserByAccount(adminUser.getAccount());

		if (_adminUser != null) {
			if (adminUser.getPassword().equals(_adminUser.getPassword())) {
				return Message.loginSuccess;
			} else
				return Message.loginFail_Password;
		} else
			return Message.loginFail_Account;
	}
}
