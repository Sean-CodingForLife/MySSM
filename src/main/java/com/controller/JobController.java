package com.controller;

import java.util.List;

import com.message.Message;
import com.po.Job;
import com.responseData.ResponseData;
import com.service.JobService;

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
public class JobController extends BaseController {

	private final static String jobPageUrl = "admin/job/job";

	@Autowired
	JobService jobService;

	@GetMapping("/admin/jobs")
	public String toJobPage() {
		return JobController.jobPageUrl;
	}

	@GetMapping("/api/admin/jobs")
	@ResponseBody
	public ResponseData queryJobs(@RequestParam(defaultValue = "") String keyword,
			@RequestParam(required = false) Integer startPage,
			@RequestParam(required = false) Integer offset) {

		return jobService.queryJobs(keyword, startPage, offset);
	}

	@PostMapping("/api/admin/jobs")
	@ResponseBody
	public Message addJob(@RequestBody Job job) {

		return jobService.addJob(job);
	}

	@PutMapping("/api/admin/jobs")
	@ResponseBody
	public Message updateJob(@RequestBody Job job) {
		return jobService.updateJob(job);
	}

	@DeleteMapping("/api/admin/jobs")
	@ResponseBody
	public Message deleteJob(@RequestBody List<Job> jobs) {
		return jobService.deleteJobs(jobs);
	}

}
