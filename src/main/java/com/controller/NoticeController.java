package com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import com.message.Message;
import com.po.Notice;
import com.responseData.ResponseData;
import com.service.NoticeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseController {

	private final static String noticePageUrl = "admin/notice/notice";

	@Autowired
	NoticeService noticeService;

	@GetMapping("/home")
	public String toNoticePage() {
		return NoticeController.noticePageUrl;
	}

	@PostMapping("/notice")
	@ResponseBody
	public Message addNotice(@RequestBody Notice notice, HttpSession session) {

		String adminUserAccount = (String) session.getAttribute("adminUserAccount");

		return noticeService.addNotice(notice, adminUserAccount);
	}

	@GetMapping("/notices")
	@ResponseBody
	public ResponseData queryNotice(@RequestParam String keyword, @RequestParam String type, @RequestParam Integer startPage,
			@RequestParam Integer offset) {
		return noticeService.queryNotices(keyword, type, startPage, offset);
	}

	@DeleteMapping("/notices")
	@ResponseBody
	public Message deleteNotice(@RequestBody List<Notice> notices) {
		return noticeService.deleteNotices(notices);

	}

	@PutMapping("/notice")
	@ResponseBody
	public Message updateNotice(@RequestBody Notice notice, HttpSession session) {
		String adminUserAccount = (String) session.getAttribute("adminUserAccount");

		return noticeService.updateNotice(notice, adminUserAccount);
	}

}
