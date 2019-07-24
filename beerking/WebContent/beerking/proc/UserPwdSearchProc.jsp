<%@page import="beerking.Gmail_Mail"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	
	Gmail_Mail mail = new Gmail_Mail();

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String msg = "일치하는 정보가 없습니다.";
	String URL = request.getParameter("URL");

	String result = uMgr.pwdSearch(email, name);
	if (result != "null") {
		msg = "email 주소로 메일을 발송했습니다.";
		out.print(result);
		mail.send("비밀번호", result, email);
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=URL%>";
</script>