<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String msg = "��ġ�ϴ� ������ �����ϴ�.";
	String URL = request.getParameter("URL");

	String result = uMgr.emailSearch(name, tel);
	if (result != "null") {
		msg = result;
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=URL%>";
</script>