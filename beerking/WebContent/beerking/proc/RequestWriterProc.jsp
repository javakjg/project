<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="requsetMgr" class="beerking.RequestBoardMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<% 
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = requsetMgr.getUser2(email);
	int costumer = uBean.getUsernum();
	String comment = request.getParameter("content");
	String title = request.getParameter("title");
	String flag = request.getParameter("flag");
	String msg = "글쓰기를 실패하였습니다.";
	if(flag.equals("insert")){
		requsetMgr.insertWriter(title, comment, costumer);
		msg = "글쓰기를 완료하였습니다.";
	}else if(flag.equals("update")){
		int requestnum = Integer.parseInt(request.getParameter("requestnum"));
		requsetMgr.updateWriter(title,comment, costumer, requestnum);
		msg = "글쓰기를 수정하였습니다.";
	}
	 
%>
<script type="text/javascript">
	alert("글쓰기를 완료하였습니다.");
</script>
<%
	response.sendRedirect("../requestBoard/RequestList.jsp");
%>
