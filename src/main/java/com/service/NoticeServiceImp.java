package com.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.dao.AdminUserDao;
import com.dao.AdminUser_Notice_RelateDao;
import com.dao.NoticeDao;
import com.dao.ToolDao;
import com.message.Message;
import com.myTool.MyMapTool;
import com.po.AdminUser;
import com.po.AdminUser_Notice_Relate;
import com.po.Notice;
import com.reponseData.ResponseData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("NoticeService")
@Transactional
public class NoticeServiceImp implements NoticeService {

    @Autowired
    NoticeDao noticeDao;

    @Autowired
    AdminUserDao adminUserDao;

    @Autowired
    ToolDao toolDao;

    @Autowired
    AdminUser_Notice_RelateDao adminUser_Notice_RelateDao;

    @Override
    public ResponseData queryNotices(String keyword, String type, Integer startPage, Integer offset) {

        Integer count = 0;
        Integer start = (startPage - 1) * offset;
        Integer end = offset;

        List<Map<String, Object>> noticeWithNameList = null;
        List<Notice> notices = null;
        AdminUser adminUser = null;
        Map<String, Object> map;

        switch (type) {
            case "":
                count = noticeDao.queryNoticesCount();
                if (count != 0) {
                    notices = noticeDao.queryNotices(start, end);
                    noticeWithNameList = new ArrayList<Map<String, Object>>();
                    for (Notice notice : notices) {
                        map = MyMapTool.getMap(notice);
                        adminUser = adminUser_Notice_RelateDao.queryAdminUserByNotice(notice);
                        map.put("name", adminUser.getName());
                        noticeWithNameList.add(map);
                    }
                }
                break;
            case "title":
                count = noticeDao.queryNoticesCountByTitle(keyword);
                if (count != 0) {
                    notices = noticeDao.queryNoticesByTitle(keyword, start, end);
                    noticeWithNameList = new ArrayList<Map<String, Object>>();
                    for (Notice notice : notices) {
                        map = MyMapTool.getMap(notice);
                        adminUser = adminUser_Notice_RelateDao.queryAdminUserByNotice(notice);
                        map.put("name", adminUser.getName());
                        noticeWithNameList.add(map);
                    }
                }
                break;
            default:
                switch (type) {
                    case "name":
                        adminUser = adminUserDao.queryAdminUserByName(keyword);
                        if (adminUser != null) {
                            noticeWithNameList = new ArrayList<Map<String, Object>>();
                            List<AdminUser_Notice_Relate> adminUser_Notice_Relates = adminUser_Notice_RelateDao
                                    .queryAdminUser_Notice_RelatesByAdminUser(adminUser, start, end);

                            for (AdminUser_Notice_Relate adminUser_Notice_Relate : adminUser_Notice_Relates) {
                                Notice notice = noticeDao.queryNoticeByNo(adminUser_Notice_Relate.getNotice_no());
                                map = MyMapTool.getMap(notice);
                                map.put("name", keyword);
                                noticeWithNameList.add(map);
                            }
                        }
                        break;
                }
                break;
        }

        return new ResponseData(count, noticeWithNameList, (noticeWithNameList != null));
    }

    @Override
    public Message addNotice(Notice notice, String adminUserAccount) {

        if (noticeDao.addNotice(notice) != 0) {

            AdminUser_Notice_Relate adminUser_Notice_Relate = new AdminUser_Notice_Relate();

            AdminUser adminUser = adminUserDao.queryAdminUserByAccount(adminUserAccount);

            adminUser_Notice_Relate.setAdminUser_no(adminUser.getNo());

            adminUser_Notice_Relate.setNotice(toolDao.queryLastNo());

            if (adminUser_Notice_RelateDao.addAdminUser_Notice_Relate(adminUser_Notice_Relate) != 0) {
                return Message.success;
            } else {
                return Message.fail;
            }
        } else {
            return Message.fail;
        }

    }

    @Override
    public Message deleteNotices(List<Notice> notices) {
        for (Notice notice : notices) {

            if ((adminUser_Notice_RelateDao.deleteAdminUser_Notice_RelateByNotice(notice) == 0)
                    || (noticeDao.deleteNotice(notice) == 0)) {
                return Message.fail;
            }
        }
        return Message.success;
    }

    @Override
    public Message updateNotice(Notice notice, String adminUserAccount) {
        AdminUser adminUser = adminUser_Notice_RelateDao.queryAdminUserByNotice(notice);
        if (adminUser.getAccount().equals(adminUserAccount)) {
            noticeDao.updateNotice(notice);
            return Message.success;
        }
        return Message.fail;
    }

}