package com.dao;

import java.util.List;

import com.po.Job;

import org.apache.ibatis.annotations.Param;

public interface JobDao {

    public List<Job> queryAllJob();

    public Job queryJobByName(@Param("keyword") String keyword);

    public List<Job> queryJobs(@Param("start") Integer start, @Param("end") Integer end);
    public List<Job> queryJobsByName(@Param("keyword") String keyword, @Param("start") Integer start, @Param("end") Integer end);

    public Integer queryJobsCountByName(@Param("keyword") String keyword);
    public Integer updateJob(Job job);
    public Integer deleteJob(Job job);
    public Integer addJob(Job job);
    public Integer queryJobsCount();
}