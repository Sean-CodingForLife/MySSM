package com.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.po.User;

public interface UserDao {

	public Integer queryUsersCount();
	public Integer addUser(   User user);
	public Integer deleteUser(User user);
	public Integer queryUsersCountByName(  @Param("keyword") String keyword);
	public Integer queryUsersCountByStatus(@Param("keyword") String keyword);
	
	public List<User> queryUsers(                                          @Param("start") Integer start, @Param("end") Integer end);
	public List<User> queryUsersByName(  @Param("keyword") String keyword, @Param("start") Integer start, @Param("end") Integer end);
	public List<User> queryUsersByStatus(@Param("keyword") String keyword, @Param("start") Integer start, @Param("end") Integer end);
	
	public User       queryUserByAccount(String              keyword);
}
