<!-- scoreProc.jsp -->
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%	request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%   
	int score = 0;
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = rMgr.getUser2(email);
	int reviewnum = Integer.parseInt(request.getParameter("reviewnum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String keyWord = request.getParameter("keyWord");
	int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	int CHmiddle = Integer.parseInt(request.getParameter("CHmiddle"));
	int middlenum = Integer.parseInt(request.getParameter("middlenum"));
	int likescore = Integer.parseInt(request.getParameter("likescore"));
	if(request.getParameter("score")!=null&&
			!request.getParameter("score").equals("null")){
		score = Integer.parseInt(request.getParameter("score"));
	}
	int costumer = uBean.getUsernum();
	int scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	int rplove = Integer.parseInt(request.getParameter("rplove"));
	String msg = "평점부여가 실패했습니다.";
	if(scorecheck == 1){
		rMgr.insertReviewgrade(score, reviewnum, costumer);
		msg = "평점을 부여하였습니다.";
		scorecheck = 2;
	}else if(scorecheck == 2){
		rMgr.deleteReviewgrade(reviewnum, costumer);
		msg = "평점을 삭제하였습니다.";
		scorecheck = 1;
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
