<%@page import="beerking.Gmail_Mail"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	
	Gmail_Mail mail = new Gmail_Mail();

	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String msg = "��ġ�ϴ� ������ �����ϴ�.";
	String URL = request.getParameter("URL");

	String result = uMgr.pwdSearch(email, name);
	if (result != "null") {
		msg = "email �ּҷ� ������ �߼��߽��ϴ�.";
		out.print(result);
		mail.send("��й�ȣ", result, email);
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=URL%>";
</script>