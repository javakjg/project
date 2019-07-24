<!-- ReviewDeleteProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<%
	int reviewnum = Integer.parseInt(request.getParameter("num"));
	rMgr.WriterDelete(reviewnum);
%> 
<script type="text/javascript">
	alert("글을 삭제하였습니다.");
	location.href = "../reviewBoard/ReviewMgr.jsp";
</script>