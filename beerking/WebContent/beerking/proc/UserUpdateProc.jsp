<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="uMgr" class = "beerking.UserDataMgr"/>
<jsp:useBean id="uBean" class = "beerking.UserDataBean"/>
<jsp:setProperty property="*" name="uBean"/>
<%
	boolean result = uMgr.updateUser(uBean);
    String msg = "회원수정 실패";
    if(result){
      msg = "회원수정 성공";
    }
%>
<script>
  alert("<%= msg %>");
  location.href = "../mypage/MyPage.jsp";
</script>