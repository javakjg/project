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
	String msg = "�۾��⸦ �����Ͽ����ϴ�.";
	if(flag.equals("insert")){
		requsetMgr.insertWriter(title, comment, costumer);
		msg = "�۾��⸦ �Ϸ��Ͽ����ϴ�.";
	}else if(flag.equals("update")){
		int requestnum = Integer.parseInt(request.getParameter("requestnum"));
		requsetMgr.updateWriter(title,comment, costumer, requestnum);
		msg = "�۾��⸦ �����Ͽ����ϴ�.";
	}
	 
%>
<script type="text/javascript">
	alert("�۾��⸦ �Ϸ��Ͽ����ϴ�.");
</script>
<%
	response.sendRedirect("../requestBoard/RequestList.jsp");
%>
