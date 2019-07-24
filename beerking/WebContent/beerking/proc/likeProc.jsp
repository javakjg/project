<!-- likeProc.jsp -->
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%	request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%   
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
	int costumer = uBean.getUsernum();//임시 유저 지정(세션에서 받아오는 역할)
	int scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	int rplove = Integer.parseInt(request.getParameter("rplove"));
	
	String msg = "좋아요가 실패했습니다.";
	if(likescore == 1){
		rMgr.insertLike(reviewnum, costumer);
		msg = "좋아요 하셨습니다.";
		likescore =2;
	}else if(likescore == 2){
		rMgr.deleteLike(reviewnum, costumer);
		msg = "좋아요 취소하셨습니다.";
		likescore = 1;
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
	document.comeback.action = "../reviewBoard/ReviewMgr.jsp";
	document.comeback.submit();
</script>

