package com.controller;

import java.util.List;

import com.po.Job;
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
@RequestMapping("/job")
public class JobController extends BaseController {

	private final static String jobPageUrl = "admin/job/job";

	@Autowired
	JobService jobService;

	@GetMapping("/home")
	public String toJobPage() {
		return JobController.jobPageUrl;
	}

	@GetMapping("/jobs")
	@ResponseBody
	public String queryJobs(@RequestParam String keyword, @RequestParam Integer startPage,
			@RequestParam Integer offset) {

		return jobService.queryJobs(keyword, startPage, offset).toJson();
	}

	@PostMapping("/job")
	@ResponseBody
	public String addJob(@RequestBody Job job) {

		return jobService.addJob(job).toJson();
	}

	@PutMapping("/job")
	@ResponseBody
	public String updateJob(@RequestBody Job job) {
		return jobService.updateJob(job).toJson();
	}

	@DeleteMapping("/jobs")
	@ResponseBody
	public String deleteJob(@RequestBody List<Job> jobs) {
		return jobService.deleteJobs(jobs).toJson();
	}

}
