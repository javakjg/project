<!-- ReviewDeleteProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="requsetMgr" class="beerking.RequestBoardMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<%
	int requestBoardNum = Integer.parseInt(request.getParameter("requestBoardNum"));
	requsetMgr.WriterDelete(requestBoardNum);
%> 
<script type="text/javascript">
	alert("글을 삭제하였습니다.");
	location.href = "../requestBoard/RequestList.jsp";
</script>