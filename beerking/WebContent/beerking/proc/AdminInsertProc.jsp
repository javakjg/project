<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class = "beerking.AdminMgr"/>
<%	
		request.setCharacterEncoding("EUC-KR");
		String msg = "�����߻�";
		
		boolean result = false ;
		result = mgr.insertBeer(request);
		if(result) msg = "����ߴ�!";
%>
<script>
	alert("<%= msg %>");
	location.href = "../admin/AdminList.jsp";
</script>