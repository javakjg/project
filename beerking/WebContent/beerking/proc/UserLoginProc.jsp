<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%
	  request.setCharacterEncoding("EUC-KR");
	  String email = request.getParameter("email");
	  String pwd = request.getParameter("pwd");
	  String URL = request.getParameter("URL");
	  
	  boolean result = uMgr.loginUser(email,pwd);
	  if(result){
	    session.setAttribute("emailKey",email);
	  }else{
		  %><script>
				alert("�α��ο� �����Ͽ����ϴ�.");
			</script><%
	  }
%>
<script>
	location.href = "<%=URL%>";
</script>