package com.service;

import com.message.Message;
import com.po.AdminUser;

public interface AdminUserService {
	public Message login(AdminUser adminUser);
}
