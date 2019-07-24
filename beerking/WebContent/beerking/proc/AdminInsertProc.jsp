<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class = "beerking.AdminMgr"/>
<%	
		request.setCharacterEncoding("EUC-KR");
		String msg = "오류발생";
		
		boolean result = false ;
		result = mgr.insertBeer(request);
		if(result) msg = "등록했다!";
%>
<script>
	alert("<%= msg %>");
	location.href = "../admin/AdminList.jsp";
</script>