package com.dao;

import java.util.List;

import com.po.Notice;

import org.apache.ibatis.annotations.Param;

public interface NoticeDao {

    public List<Notice> queryNotices(@Param("start") Integer start, @Param("end") Integer end);

    public Integer queryNoticesCount();

    public List<Notice> queryNoticesByTitle(@Param("keyword") String keyword, @Param("start") Integer start,
            @Param("end") Integer end);

    public Integer queryNoticesCountByTitle(@Param("keyword") String keyword);

    public Notice queryNoticeByNo(@Param("keyword") Integer keyword);

    public Integer addNotice(Notice notice);

    public Integer deleteNotice(Notice notice);

    public Integer updateNotice(Notice notice);

}