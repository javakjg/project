<!-- rereplyProc.jsp -->
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%	request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%  
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = rMgr.getUser2(email);
	int rereplynum = Integer.parseInt(request.getParameter("rereplynum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	String keyWord = request.getParameter("keyWord");
	int numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	int CHmiddle = Integer.parseInt(request.getParameter("CHmiddle"));
	int middlenum = Integer.parseInt(request.getParameter("middlenum"));
	String comment = request.getParameter("rereplaycomment");
	int usernum = uBean.getUsernum();
	int scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	int replaynum = Integer.parseInt(request.getParameter("replynum"));
	//usernum = 1; // �۵�Ȯ���� ���ؼ� �����ص� usernum ���߿� �ּ�ó���ϸ� ��.
	String msg = "���� �ۼ��� �����ϼ̽��ϴ�.";
	if(request.getParameter("flag").equals("insert")){
		rMgr.insertRereply(comment, usernum, replaynum);
		msg = "���� �ۼ��� �����ϼ̽��ϴ�.";
	}else if(request.getParameter("flag").equals("delete")){
		rMgr.deleteRereply(replaynum, usernum,rereplynum);
		msg = "������ �����ϼ̽��ϴ�.";
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