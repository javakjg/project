<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="uMgr" class = "beerking.UserDataMgr"/>
<jsp:useBean id="uBean" class = "beerking.UserDataBean"/>
<jsp:setProperty property="*" name="uBean"/>
<%
	boolean result = uMgr.updateUser(uBean);
    String msg = "ȸ������ ����";
    if(result){
      msg = "ȸ������ ����";
    }
%>
<script>
  alert("<%= msg %>");
  location.href = "../mypage/MyPage.jsp";
</script>