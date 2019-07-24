<!-- top.jsp -->
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<jsp:useBean id="tMgr" class="beerking.TrandMgr"/>
<% 	request.setCharacterEncoding("EUC-KR"); %>
<%
	String URL2 = request.getRequestURL().toString();
%>
<style>
	div#top{
		width : 100%;
		height : 30px;
		background-color:#282828;
		text-align:right;
	}
	.loginButton,
	.logoutButton,
	.indexJoinButton,
	.MyPageButton {
		-moz-appearance: none;
		-webkit-appearance: none;
		-ms-appearance: none;
		appearance: none;
		-moz-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
		-webkit-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
		-ms-transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
		transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
		border-radius: 4px;
		border: 0;
		cursor: pointer;
		display: inline-block;
		font-weight: 420;
		height: 2em;
		line-height: 2em;
		padding: 0 1.5em;
		text-align: center;
		text-decoration: none;
		white-space: nowrap;
		text-transform: uppercase;
	}

	.loginButton,
	.logoutButton,
	.indexJoinButton,
	.MyPageButton {
		background-color: #5a5a5a;
		color: #ffffff !important;
	}

	.loginButton:hover,
	.logoutButton:hover,
	.indexJoinButton:hover,
	.MyPageButton:hover {
			background-color: #676767;
		}

	.loginButton:active,
	.logoutButton:active,
	.indexJoinButton:active,
	.MyPageButton:active {
			background-color: #4d4d4d;
		}

	.loginButton:active,
	.logoutButton:active,
	.indexJoinButton:active,
	.MyPageButton:active {
			background-color: transparent;
			box-shadow: inset 0 0 0 2px rgba(144, 144, 144, 0.25);
			color: #fff !important;
		}
</style>
<script>
	function logOut(){
		location.href="../proc/UserLogoutProc.jsp?URL=<%=URL2%>";
	}
</script>
<% 
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = uMgr.selectUser(email);
	
	String msg="�α����� ���ּ���.";
	String log="";
	if(email == null) log ="<button class=\"loginButton\">�α���</button>";
	else {
		msg = uBean.getNickname()+" �� ȯ���մϴ�.";
		log = "<button class=\"logoutButton\" onclick=\"javascript:logOut()\">�α׾ƿ�</button>";
	}
	String reg="";
	if(email == null) reg ="<button class=\"indexJoinButton\">ȸ������</button>";
	else reg = "<button class=\"MyPageButton\" onclick=\"location.href=\'../mypage/MyPage.jsp\'\">����������</button>";
%>
<div id="top">
	<font color="#EBFBFF"><%=msg %>  <%=log %>  <%=reg %></font>
</div>