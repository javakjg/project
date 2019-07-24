<%@page import="beerking.RequestBoardBean"%>
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="requestMgr" class="beerking.RequestBoardMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<%
	String flag ="insert";
	String email = (String)session.getAttribute("emailKey");
	int listnum = 0;
	if(request.getParameter("num")!=null &&
			!request.getParameter("num").equals("null")){
		listnum = Integer.parseInt(request.getParameter("num"));
	}
	if(listnum !=0){
		flag = "update";
	}
%> 
<jsp:include page="../index/Navleft.jsp"></jsp:include>
<script type="text/javascript">
function Procsubmit(){
	oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
		try {
			document.BigwriterFrm.submit();
	    } catch(e) {}
}
</script>
<div style="width:100%;">
<div id="ReviewWriterFrm" style="width:75%; display:inline-block; margin-top:5%">
<form  name="BigwriterFrm" id="BigwriterFrm" action="../proc/RequestWriterProc.jsp">
	<table style="width:850px;">
		<tr>
			<th style="float:left;">
				제목 : <%if(flag.equals("update")){RequestBoardBean rrbean = requestMgr.getWriter(listnum);%><input name="title" style="width:650px;" value="<%=rrbean.getRequestboardtitle()%>"><%}else{ %><input name="title" style="width:650px;"><%} %>
				<!-- <input name="title" style="width:766px; height:412px;"  id="textAreaContent">   -->
			</th>
		</tr>
			<tr>
				<td align="center">
					<textarea style="width:750px; height:400px;"   rows="10" cols="80" id="textAreaContent" name="content"><%if(flag.equals("update")){ RequestBoardBean rrbean = requestMgr.getWriter(listnum); %><%=rrbean.getRequestboardcomment()%><%}%></textarea>
				</td>
			<tr>
		<tr>
			<td align="right" style="float:left;"><%if(flag.equals("update")){ %><a href="javascript:Procsubmit()">[수정완료]</a><%}else{ %><a href="javascript:Procsubmit()">[작성완료]</a><%} %> / <a href="RequestList.jsp">[목록으로]</a>
			</td>
		</tr>
	</table>
	<%if(flag.equals("update")){RequestBoardBean rrbean = requestMgr.getWriter(listnum);%>
	<input type="hidden" name="requestnum" id="requestnum" value="<%=rrbean.getRequestboardnum()%>">
	<%}%>
	<input type="hidden" id="flag" name="flag" value="<%=flag%>">
</form>
</div>
</div>
</div>
<!-- Smart Editor --> 
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<!-- Smart Editor -->
<script type="text/javascript">
	var oEditors = []; //전역변수
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors, //전역변수명
	    elPlaceHolder: "textAreaContent", //에디터가 그려질 textarea id값
	    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2" , //se2basicCreator.js 메소드명
	    htParams : { // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	    bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
	    bUseVerticalResizer : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
	    bUseModeChanger : true,
	    }
	});
	
	if(<%=listnum%>!=0){
		oEditors.getById["textAreaContent"].exec("LOAD_CONTENTS_FIELD");
	}
	
	//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
	function submitContents() {
	    // 에디터의 내용이 textarea에 적용된다.
	    oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	    try {
	        elClickedObj.form.submit();
	    } catch(e) {}
	}
	 
	// textArea에 이미지 첨부
	function pasteHTML(filepath){
	    var sHTML = '<img src="<%=request.getContextPath()%>/beerking/userimg/'+filepath+'">';
	    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
	}

</script>
