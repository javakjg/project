<!-- ReviewWriterProc.jsp -->
<%@page import="beerking.BeerBean"%>
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<% 
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = rMgr.getUser2(email);
	int costumer = uBean.getUsernum();
	String Typesmall = request.getParameter("smallbName");
	BeerBean bean =  rMgr.SmallbeerDataGet(Typesmall);
	int beernum = bean.getBeernum();
	String comment = request.getParameter("content");
	String title = request.getParameter("title");
	String flag = request.getParameter("flag");
	String msg = "글쓰기를 실패하였습니다.";
	int insertNum = 0;
	if(flag.equals("insert")){
		rMgr.insertWriter(title, comment, costumer, beernum);
		msg = "글쓰기를 완료하였습니다.";
		insertNum=rMgr.getInsertReview(costumer);
	}else if(flag.equals("update")){
		int reviewnum = Integer.parseInt(request.getParameter("reviewnum"));
		rMgr.updateWriter(title,comment, costumer, beernum,reviewnum);
		msg = "글쓰기를 수정하였습니다.";
		insertNum=reviewnum;
	}	 
%>
<form name="big" method="post">
	<input type="hidden" name="num" value="<%=insertNum%>">
</form>
<script type="text/javascript">
	alert("<%=msg%>");
	document.big.action="../reviewBoard/ReviewMgr.jsp";
	document.big.submit();
</script>
<%
	/* response.sendRedirect("../reviewBoard/ReviewMgr.jsp"); */
%>
