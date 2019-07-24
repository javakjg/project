<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.Vector"%>
<%@page import="beerking.FreeReplyBean"%>
<%@page import="beerking.RequestBoardBean"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="requestMgr" class="beerking.RequestBoardMgr"/>
<jsp:useBean id="rBean" class="beerking.RequestBoardBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%@ include file="../index/Navleft.jsp" %>
<%
	int totalRecord = 0;//�� �Խù���
	int numPerPage = 10;//�������� ���ڵ�� 5,10,15,30
	int pagePerBlock = 5;//���� ��������
	int totalPage = 0;//���������� = (�ø�)�ѰԽù��� / �������� ���ڵ��
	int totalBlock = 0;//�Ѻ��� = (�ø�)���������� / ���� �������� 
	int nowPage = 1;//���� ������
	int nowBlock = 1;//���� ��
	int requestBoardNum = 0;
	
	//page�� ������ �Խù� ���� ��
	if(request.getParameter("numPerPage")!=null&&!request.getParameter("numPerPage").equals("null")){
	    	numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	    }
	if(request.getParameter("requestBoardNum")!=null&&!request.getParameter("requestBoardNum").equals("null")){
    	requestBoardNum = Integer.parseInt(request.getParameter("requestBoardNum"));
    	rBean = requestMgr.readRequestBoar(requestBoardNum);
    }
	
	int start =0;//tblBoard�� select ���۹�ȣ
	int end = numPerPage;//10��
	
	totalRecord = requestMgr.getRequestBoardCount();
	
	//nowPage�� ��û�� ���, ���� ��û���� ������ default ���� 1 �̴�.
    if(request.getParameter("nowPage")!=null){
    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    start = (nowPage*numPerPage)-numPerPage;
    
    //��ü ������ ��
    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    //��ü �� ��
    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);    
    //���� �� ��
    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/RequestList.css?ver=1">
	<title>��û�Խ���</title>
<script>
function pageing(page,requestBoardNum){
	document.readFrm.requestBoardNum.value = requestBoardNum;
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();		
}
function block(block,requestBoardNum){
	document.readFrm.requestBoardNum.value = requestBoardNum;
	document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();	
}
function list(requestBoardNum){
	document.listFrm.action = "RequestList.jsp?requestBoardNum="+requestBoardNum;
	document.listFrm.submit();
}
function read(requestBoardNum){
	document.readFrm.requestBoardNum.value = requestBoardNum;
	document.readFrm.action = "RequestList.jsp";
	document.readFrm.submit();
}
function insertReply(requestBoardNum){
	document.replyInsertFrm.requestBoardNum.value = requestBoardNum;
	document.replyInsertFrm.action = "../proc/RequestReplyInsertProc.jsp";
	document.replyInsertFrm.submit();
}
function deleteReply(requestReplyNum,requestBoardNum){
	document.replyInsertFrm.requestReplyNum.value = requestReplyNum;
	document.replyInsertFrm.requestBoardNum.value = requestBoardNum;
	document.replyInsertFrm.action = "../proc/RequestReplyDeleteProc.jsp";
	document.replyInsertFrm.submit();
}
function writeRequest(){
	location.href = "RequestWriter.jsp";
}
function updateRequest(requestBoardNum){
	document.writerFrm.num.value=requestBoardNum;
	document.writerFrm.action="RequestWriter.jsp";
	document.writerFrm.submit();
}
function deleteRequest(requestBoardNum){
	document.readFrm.requestBoardNum.value = requestBoardNum;
	document.readFrm.action = "../proc/RequestDeleteProc.jsp";
	document.readFrm.submit();
}
function deleteRequest2(requestBoardNum){
	document.readFrm.requestBoardNum.value = requestBoardNum;
	document.readFrm.action = "../proc/RequestDeleteProc2.jsp";
	document.readFrm.submit();
}
</Script>
</head>
	<body>
		<div>
			<b><font size="8" color="#FFF" face="����">��û �Խ���</font></b>
			<table id="Table-Layout">
			<%
				if(requestBoardNum != 0) {
					Vector<FreeReplyBean> rvlist =requestMgr.getRequestReplyList(requestBoardNum);
			%>
				<form name="replyInsertFrm">
				<tr>
					<td>
						<table class="RequestRead">
							<tr>
								<td>
									<font size="5" color="#000">����: <%=rBean.getRequestboardtitle() %></font>	
								</td>
								<td align="right" valign="bottom">
									<font size="3" color="#000"><%=rBean.getRequestboarddate()%></font>
								</td>
							</tr>
							<tr>
								<td colspan="2"><hr></td>
							</tr>
							<tr>
								<td colspan="2">
									<font size="5" color="#000">�ۼ���: <%=uMgr.getNickname(rBean.getUsernum())%></font>
									<hr>
									<%=rBean.getRequestboardcomment() %>
								</td>
							</tr>
							<tr>
								<td>
									<%if(rBean.getUsernum() == uBean.getUsernum()) {%>
										<a href="javascript:updateRequest(<%=requestBoardNum%>)">[����]</a>
										<a href="javascript:deleteRequest(<%=requestBoardNum%>)">[����]</a>
									<%}else if(uMgr.getGrant(uBean.getUsernum())==2&&rBean.getStatus()==0){%>
										<a href="javascript:deleteRequest(<%=requestBoardNum%>)">[����ε�]</a>
									<%}else if(uMgr.getGrant(uBean.getUsernum())==2&&rBean.getStatus()==1){%>
										<a href="javascript:deleteRequest2(<%=requestBoardNum%>)">[��������]</a>
									<%} %>
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr>
					<td>	
						<table class="RequestReply">
							<tr>
								<td>���</td>
							</tr>
							<%if(rvlist.size()==0){ %>
							<tr>
								<td>
									<font size="3" color="#000">��ϵ� ����� �����ϴ�.</font><hr>
								</td>
							</tr>
							<%}%>
							<%
								for(int j=0;j<rvlist.size();j++){
									FreeReplyBean fBean = rvlist.get(j);
									String rComment = fBean.getRequestreplycomment();
									String rNickName = uMgr.getNickname(fBean.getUsernum());
									int requestreplynum = fBean.getRequestreplynum();
							%>
							<tr>
								<td>
									<font size="3" color="#000"><%=rNickName%>:<%=rComment%><%if(uMgr.getGrant(uBean.getUsernum())==2){%>
									<input type="button" value="����" onclick="javascript:deleteReply(<%=requestreplynum%>,<%=requestBoardNum%>)" style="background: #202024; color: rgba(255,255,255,1); width:100;">
									<%}%></font><hr>
								</td>
							</tr>
							<%}%>
							<%if(uMgr.getGrant(uBean.getUsernum())==2){ %>
							<tr>
								<td valign="bottom">
									<input type="text" name="requestReplyComment">
									<input type="button" value="���" onclick="javascript:insertReply(<%=requestBoardNum%>)" style="background: #202024; color: rgba(255,255,255,1); width:100;">
								</td>
							</tr>
							<%}%>
						</table>
					</td>
				</tr>
					<input type="hidden" name="requestReplyNum" value="0">
					<input type="hidden" name="requestBoardNum" value="0">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
				</form>
				<%}%>
				<tr>
					<td>
						<table class="RequestList">
						<tbody>
							<tr>
								<th>No</th>
								<th>����</th>
								<th>�ۼ���</th>
								<th>�ۼ���</th>	
							</tr>		
						<%
							Vector<RequestBoardBean> vlist = requestMgr.getRequestBoardList(start, end);
							int listSize = vlist.size();//������ ȭ�鿡 ������ �Խù� ��ȣ
							if(vlist.isEmpty()){
								out.println("��ϵ� �Խù��� �����ϴ�.");
							}else{
						%>
						<%
							for(int i=0;i<10;i++){
								if(i==listSize) break;
								RequestBoardBean bean = vlist.get(i);
								int requestboardnum = bean.getRequestboardnum();
								int usernum = bean.getUsernum();
								int freeReplyCount = requestMgr.getRequestReplyCount(requestboardnum);
							    String requestboardtitle = bean.getRequestboardtitle();
							    String requestboardcomment = bean.getRequestboardcomment();  
							    String requestboarddate = bean.getRequestboarddate();   
							    String requestboardtime = bean.getRequestboardtime();     
							    int filenum = bean.getFilenum();
							    int status = bean.getStatus();
							    String nickname = uMgr.getNickname(usernum);
						%>
						<%if(status == 0){%>
							<tr class="<%if(i%2==0){%>RequestObj1<%}else{%>RequestObj2<%}%>" height="50" onclick="javascript:read(<%=requestboardnum%>)">
								<td><%=requestboardnum%></td>
								<td>
								<c:set var="TextValue" value="<%=requestboardtitle%>"/>
								<c:choose>
							        <c:when test="${fn:length(TextValue) gt 31}">
							        <c:out value="${fn:substring(TextValue, 0, 30)}...">
							        </c:out></c:when>
							        <c:otherwise>
							        <c:out value="${TextValue}">
							        </c:out></c:otherwise>
								</c:choose>	
								<%if(freeReplyCount!=0){%>(<%=freeReplyCount%>)<%}%></td>
								<td><%=nickname%></td>
								<td><%=requestboarddate%></td>
							</tr>
						<%}else{%>
							<tr class="<%if(i%2==0){%>RequestObj1<%}else{%>RequestObj2<%}%>" height="50" onclick=<%if(uMgr.getGrant(uBean.getUsernum())==2){%>"javascript:read(<%=requestboardnum%>)"<%}%>>
								<td><%=requestboardnum%></td>
								<td>������ �Խñ� �Դϴ�.</td>
								<td><%=nickname%></td>
								<td><%=requestboarddate%></td>
							</tr>
						<%}//--if%>
							<%}//--for%>
						</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<%}%>
						<table class="PagingList">
							<tr>
								<td class="Paging">
									<%
										//����¡�� ǥ�õ� ���ۺ��� �� ������ ����
										int pageStart = (nowBlock-1)*pagePerBlock+1;
										int pageEnd = ((pageStart+pagePerBlock)<totalPage)?(pageStart+pagePerBlock):totalPage+1;
									%>
									<%if(totalPage!=0){%>
									<!-- ������ -->
									<%if(nowBlock>1){%>
										<a href="javascript:block('<%=nowBlock-1%>','<%=requestBoardNum%>')">prev...</a>
									<%}//---if%>&nbsp;
									<!-- ����¡ -->
									<%for(;pageStart<pageEnd;pageStart++){%>
									<a href="javascript:pageing('<%=pageStart%>','<%=requestBoardNum%>')">
									<%if(nowPage==pageStart){%><font color="red"><%}%>
									[<%=pageStart%>]</a>
									<%if(nowPage==pageStart){%></font><%}%>
									<%}//---for%>&nbsp;			
									<!-- ������ -->
									<%if(totalBlock>nowBlock){%>
										<a href="javascript:block('<%=nowBlock+1%>','<%=requestBoardNum%>')">...next</a>
									<%}//---if%>
									<%}//---if%>
								</td>
							</tr>
							<tr>
								<td class="Option">
									<%if(uBean.getUsernum()!=0) {%>
										<a href="javascript:writeRequest()">[�۾���]</a>
									<%}%>
									<a href="javascript:list('<%=requestBoardNum%>')">[ó������]</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	<form name="listFrm" method="post">
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="readFrm">
		<input type="hidden" name="requestBoardNum" value="0">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	</form>
	</div>
	<!-- �۾��� �� -->
	<form method="post" name="writerFrm">
		<input type="hidden" name="num" value="0">
		<input type="hidden" name="flag" value="insert">
	</form>
	</body>
</html>