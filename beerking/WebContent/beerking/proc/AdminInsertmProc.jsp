<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="beerking.AdminMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	int beernum = Integer.parseInt(request.getParameter("beernum"));
	String adminbeercomment = request.getParameter("adminbeercomment");
	if(beernum == 0){
		mgr.resetMonthBeer();
	}else{
		mgr.insertMonthBeer(beernum, adminbeercomment);
	}
	String msg="맥주 등록 완료!";
%>
<script>
	alert("<%=msg%>");
	location.href = "../admin/AdminList.jsp";
</script>