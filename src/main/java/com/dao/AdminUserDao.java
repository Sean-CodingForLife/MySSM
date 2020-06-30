package com.dao;

import com.po.AdminUser;

import org.apache.ibatis.annotations.Param;

public interface AdminUserDao {

	public AdminUser queryAdminUserByNo(@Param("keyword") Integer keyowrd);

	public AdminUser queryAdminUserByAccount(String keyword);

	public AdminUser queryAdminUserByName(String keyword);
}
