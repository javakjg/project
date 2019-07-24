package com.mySpring.Project.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mySpring.Project.DAO.ProjectDAO;

@Controller
public class MyProjectController {

	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value="main")
	public String main(Model model)
	{
		return "main";
	}
	
	@RequestMapping(value="/GuestBook", method = RequestMethod.GET)//a href or action�쓽 �씠由�
	public String GuestBook(HttpServletRequest req, Model model){
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);
		model.addAttribute("total", dao.totalRecord());
		int s = 0;
		int e = 3;
		if(req.getParameter("pNum")==null) {
			model.addAttribute("list",dao.ProjectDAO(s, e));//for each臾� items�쓽 ${list}
		}
		else if((Integer.parseInt(req.getParameter("pNum"))-1)==0){
			e = Integer.parseInt(req.getParameter("eNum"));
			model.addAttribute("list",dao.ProjectDAO(s, e));
		}
		else {
			e = Integer.parseInt(req.getParameter("eNum"));
			s = ((Integer.parseInt(req.getParameter("pNum"))-1)*e);
			model.addAttribute("list",dao.pClick(s, e));
		}
		return "GuestBook";
		//views/noteList.jsp �떎�뻾
	}
	
	@RequestMapping(value="/index")//a href or action�쓽 �씠由�
	public String index(Model model){
		return "index";//views/noteList.jsp �떎�뻾
	}
	
	
	@RequestMapping(value="/insert")
	public String insert(HttpServletRequest req, Model model) throws Exception {
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);
		model.addAttribute("total", dao.totalRecord());
		dao.insert(req.getParameter("name"),req.getParameter("pwd"),req.getParameter("content"));
		return "redirect:GuestBook";
		
	}
	
	@RequestMapping(value="/delete")
	public String Delete(HttpServletRequest req, Model model) throws Exception{
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);	
		dao.delete(Integer.parseInt(req.getParameter("bookid")));
		return "redirect:GuestBook";
	}
	@RequestMapping(value="/total")
	@ResponseBody
	public String total(HttpServletRequest req, Model model) throws Exception{
		ProjectDAO dao = sqlSession.getMapper(ProjectDAO.class);
		String t = String.valueOf(dao.totalRecord());
		return t;
	}
}
