<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.RequestBoardMgr"/>
<% 
	request.setCharacterEncoding("EUC-KR");
	int requestBoardNum = Integer.parseInt(request.getParameter("requestBoardNum"));
	int requestReplyNum = Integer.parseInt(request.getParameter("requestReplyNum"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	rMgr.deleteRequestReply(requestReplyNum);
%> 
<script>
	location.href="../requestBoard/RequestList.jsp?requestBoardNum="+<%=requestBoardNum%>+"&nowPage="+<%=nowPage%>+"&numPerPage="+<%=numPerPage%>;
</script>