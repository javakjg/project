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
	int totalRecord = 0;//총 게시물수
	int numPerPage = 10;//페이지당 레코드수 5,10,15,30
	int pagePerBlock = 5;//블럭당 페이지수
	int totalPage = 0;//총페이지수 = (올림)총게시물수 / 페이지당 레코드수
	int totalBlock = 0;//총블럭수 = (올림)총페이지수 / 블럭당 페이지수 
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭
	int requestBoardNum = 0;
	
	//page에 보여질 게시물 갯수 값
	if(request.getParameter("numPerPage")!=null&&!request.getParameter("numPerPage").equals("null")){
	    	numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	    }
	if(request.getParameter("requestBoardNum")!=null&&!request.getParameter("requestBoardNum").equals("null")){
    	requestBoardNum = Integer.parseInt(request.getParameter("requestBoardNum"));
    	rBean = requestMgr.readRequestBoar(requestBoardNum);
    }
	
	int start =0;//tblBoard에 select 시작번호
	int end = numPerPage;//10개
	
	totalRecord = requestMgr.getRequestBoardCount();
	
	//nowPage를 요청한 경우, 만약 요청하지 않으면 default 값인 1 이다.
    if(request.getParameter("nowPage")!=null){
    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    start = (nowPage*numPerPage)-numPerPage;
    
    //전체 페이지 수
    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    //전체 블럭 수
    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);    
    //현재 블럭 값
    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/RequestList.css?ver=1">
	<title>요청게시판</title>
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
			<b><font size="8" color="#FFF" face="굴림">요청 게시판</font></b>
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
									<font size="5" color="#000">제목: <%=rBean.getRequestboardtitle() %></font>	
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
									<font size="5" color="#000">작성자: <%=uMgr.getNickname(rBean.getUsernum())%></font>
									<hr>
									<%=rBean.getRequestboardcomment() %>
								</td>
							</tr>
							<tr>
								<td>
									<%if(rBean.getUsernum() == uBean.getUsernum()) {%>
										<a href="javascript:updateRequest(<%=requestBoardNum%>)">[수정]</a>
										<a href="javascript:deleteRequest(<%=requestBoardNum%>)">[삭제]</a>
									<%}else if(uMgr.getGrant(uBean.getUsernum())==2&&rBean.getStatus()==0){%>
										<a href="javascript:deleteRequest(<%=requestBoardNum%>)">[블라인드]</a>
									<%}else if(uMgr.getGrant(uBean.getUsernum())==2&&rBean.getStatus()==1){%>
										<a href="javascript:deleteRequest2(<%=requestBoardNum%>)">[삭제복구]</a>
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
								<td>댓글</td>
							</tr>
							<%if(rvlist.size()==0){ %>
							<tr>
								<td>
									<font size="3" color="#000">등록된 댓글이 없습니다.</font><hr>
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
									<input type="button" value="삭제" onclick="javascript:deleteReply(<%=requestreplynum%>,<%=requestBoardNum%>)" style="background: #202024; color: rgba(255,255,255,1); width:100;">
									<%}%></font><hr>
								</td>
							</tr>
							<%}%>
							<%if(uMgr.getGrant(uBean.getUsernum())==2){ %>
							<tr>
								<td valign="bottom">
									<input type="text" name="requestReplyComment">
									<input type="button" value="등록" onclick="javascript:insertReply(<%=requestBoardNum%>)" style="background: #202024; color: rgba(255,255,255,1); width:100;">
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
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>	
							</tr>		
						<%
							Vector<RequestBoardBean> vlist = requestMgr.getRequestBoardList(start, end);
							int listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
							if(vlist.isEmpty()){
								out.println("등록된 게시물이 없습니다.");
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
								<td>삭제된 게시글 입니다.</td>
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
										//페이징에 표시될 시작변수 및 마지막 변수
										int pageStart = (nowBlock-1)*pagePerBlock+1;
										int pageEnd = ((pageStart+pagePerBlock)<totalPage)?(pageStart+pagePerBlock):totalPage+1;
									%>
									<%if(totalPage!=0){%>
									<!-- 이전블럭 -->
									<%if(nowBlock>1){%>
										<a href="javascript:block('<%=nowBlock-1%>','<%=requestBoardNum%>')">prev...</a>
									<%}//---if%>&nbsp;
									<!-- 페이징 -->
									<%for(;pageStart<pageEnd;pageStart++){%>
									<a href="javascript:pageing('<%=pageStart%>','<%=requestBoardNum%>')">
									<%if(nowPage==pageStart){%><font color="red"><%}%>
									[<%=pageStart%>]</a>
									<%if(nowPage==pageStart){%></font><%}%>
									<%}//---for%>&nbsp;			
									<!-- 다음블럭 -->
									<%if(totalBlock>nowBlock){%>
										<a href="javascript:block('<%=nowBlock+1%>','<%=requestBoardNum%>')">...next</a>
									<%}//---if%>
									<%}//---if%>
								</td>
							</tr>
							<tr>
								<td class="Option">
									<%if(uBean.getUsernum()!=0) {%>
										<a href="javascript:writeRequest()">[글쓰기]</a>
									<%}%>
									<a href="javascript:list('<%=requestBoardNum%>')">[처음으로]</a>
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
	<!-- 글쓰기 폼 -->
	<form method="post" name="writerFrm">
		<input type="hidden" name="num" value="0">
		<input type="hidden" name="flag" value="insert">
	</form>
	</body>
</html>