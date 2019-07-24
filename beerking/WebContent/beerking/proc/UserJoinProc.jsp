<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="uMgr" class = "beerking.UserDataMgr"/>
<jsp:useBean id="bean" class = "beerking.UserDataBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
    boolean result = uMgr.insertUser(bean);
    String msg = "회원가입 실패";
	String URL = request.getParameter("URL");
    if(result){
      msg = "회원가입 성공";
      uMgr.insertUserTrand();
    }
%>
<script>
  alert("<%= msg %>");
  location.href = "<%=URL%>";
</script>