package com.service;

import java.util.List;

import com.message.Message;
import com.po.Notice;
import com.reponseData.ResponseData;

public interface NoticeService {
    public ResponseData queryNotices(String keyword, String type,Integer startPage, Integer offset);
    public Message addNotice(Notice notice, String adminUserAccount);
    public Message updateNotice(Notice notice, String adminUserAccount);
    public Message deleteNotices(List<Notice> notices);
}