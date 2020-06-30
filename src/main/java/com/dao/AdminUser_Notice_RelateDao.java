package com.dao;

import java.util.List;

import com.po.AdminUser;
import com.po.AdminUser_Notice_Relate;
import com.po.Notice;

import org.apache.ibatis.annotations.Param;


public interface AdminUser_Notice_RelateDao {

    public List<AdminUser_Notice_Relate> queryAdminUser_Notice_RelatesByAdminUser(@Param("adminUser") AdminUser adminUser, @Param("start") Integer start, @Param("end") Integer end);

    public AdminUser queryAdminUserByNotice(Notice notice);

    public Integer deleteAdminUser_Notice_RelateByNotice(Notice notice);

    public Integer addAdminUser_Notice_Relate(AdminUser_Notice_Relate adminUser_Notice_Relate);
}