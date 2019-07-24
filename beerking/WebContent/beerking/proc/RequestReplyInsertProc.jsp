<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.RequestBoardMgr"/>
<% 
	request.setCharacterEncoding("EUC-KR");
	String requestReplyComment = request.getParameter("requestReplyComment");
	int requestBoardNum = Integer.parseInt(request.getParameter("requestBoardNum"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	rMgr.insertRequestReply(requestReplyComment, requestBoardNum);
%> 
<script>
	location.href="../requestBoard/RequestList.jsp?requestBoardNum="+<%=requestBoardNum%>+"&nowPage="+<%=nowPage%>+"&numPerPage="+<%=numPerPage%>;
</script>