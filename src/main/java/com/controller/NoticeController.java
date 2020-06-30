package com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import com.po.Notice;
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
	public String addNotice(@RequestBody Notice notice, HttpSession session) {

		String adminUserAccount = (String) session.getAttribute("adminUserAccount");

		return noticeService.addNotice(notice, adminUserAccount).toJson();
	}

	@GetMapping("/notices")
	@ResponseBody
	public String queryNotice(@RequestParam String keyword, @RequestParam String type, @RequestParam Integer startPage,
			Integer offset) {
		return noticeService.queryNotices(keyword, type, startPage, offset).toJson();
	}

	@DeleteMapping("/notices")
	@ResponseBody
	public String deleteNotice(@RequestBody List<Notice> notices) {
		return noticeService.deleteNotices(notices).toJson();

	}

	@PutMapping("/notice")
	@ResponseBody
	public String updateNotice(@RequestBody Notice notice, HttpSession session) {
		String adminUserAccount = (String) session.getAttribute("adminUserAccount");

		return noticeService.updateNotice(notice, adminUserAccount).toJson();
	}

}
