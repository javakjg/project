<!-- replyProc.jsp -->
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%	request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%  
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = rMgr.getUser2(email);
	int replynum = Integer.parseInt(request.getParameter("replynum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String keyWord = request.getParameter("keyWord");
	int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	int CHmiddle = Integer.parseInt(request.getParameter("CHmiddle"));
	int middlenum = Integer.parseInt(request.getParameter("middlenum"));
	String comment = request.getParameter("replycomment");
	int usernum = uBean.getUsernum();
	int scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	int reviewnum = Integer.parseInt(request.getParameter("reviewnum"));
	int rplove = Integer.parseInt(request.getParameter("rplove"));
	//usernum = 1; // 작동확인을 위해서 설정해둔 usernum 나중에 주석처리하면 됨.
	String msg = "댓글 작성에 실패하셨습니다.";
	if(request.getParameter("flag").equals("insert")){
		rMgr.insertReply(comment, usernum, reviewnum);
		msg = "댓글 작성에 성공하셨습니다.";
	}else if(request.getParameter("flag").equals("delete")){
		rMgr.deleteReply(reviewnum, usernum,replynum);
		msg = "댓글을 삭제하셨습니다.";
	}
%>
<form name="comeback" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage %>">
	<input type="hidden" name="keyWord" value="<%=keyWord %>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
	<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
	<input type="hidden" name="middlenum" value="<%=middlenum %>">
</form>

<script type="text/javascript">
	alert("<%=msg%>");
	document.comeback.action = "../reviewBoard/ReviewMgr.jsp";
	document.comeback.submit();
</script>