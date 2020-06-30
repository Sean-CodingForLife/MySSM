package com.service;

import java.util.List;

import com.message.Message;
import com.po.Job;
import com.reponseData.ResponseData;

public interface JobService {
    public ResponseData queryJobs(String keyword, Integer startPage, Integer offset);
    public Message updateJob(Job job);
    public Message addJob(Job job);
    public Message deleteJobs(List<Job> jobs);
}