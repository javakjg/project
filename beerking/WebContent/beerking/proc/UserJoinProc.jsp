<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="uMgr" class = "beerking.UserDataMgr"/>
<jsp:useBean id="bean" class = "beerking.UserDataBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
    boolean result = uMgr.insertUser(bean);
    String msg = "ȸ������ ����";
	String URL = request.getParameter("URL");
    if(result){
      msg = "ȸ������ ����";
      uMgr.insertUserTrand();
    }
%>
<script>
  alert("<%= msg %>");
  location.href = "<%=URL%>";
</script>