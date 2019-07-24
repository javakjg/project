<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="beerking.AdminMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	int reviewnum = Integer.parseInt(request.getParameter("reviewnum"));
	if(reviewnum == 0){
		mgr.resetMonthReview();
	}else{
		mgr.insertMonthReview(reviewnum);
	}
	String msg="리뷰등록 완료!";
%>
<script>
alert("<%=msg%>");
	location.href = "../admin/AdminList.jsp";
</script>