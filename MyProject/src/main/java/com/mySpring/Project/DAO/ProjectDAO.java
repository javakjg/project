package com.mySpring.Project.DAO;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.mySpring.Project.DTO.ProjectBean;

public interface ProjectDAO {
	public ArrayList<ProjectBean> ProjectDAO(@Param("start")int start, @Param("end")int end);
	public void insert(@Param("name")String name, @Param("pwd")String pwd, @Param("content")String content) throws Exception;
	public void delete(@Param ("Bookid") int Bookid);
	public ArrayList<ProjectBean> pClick(@Param ("pNum")int pNum, @Param("e1")int end);
	public int totalRecord();
}
