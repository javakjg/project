<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	session.invalidate();
	String URL = request.getParameter("URL");
%>
<script>
   location.href = "<%=URL%>";
</script>