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
				���� : <%if(flag.equals("update")){RequestBoardBean rrbean = requestMgr.getWriter(listnum);%><input name="title" style="width:650px;" value="<%=rrbean.getRequestboardtitle()%>"><%}else{ %><input name="title" style="width:650px;"><%} %>
				<!-- <input name="title" style="width:766px; height:412px;"  id="textAreaContent">   -->
			</th>
		</tr>
			<tr>
				<td align="center">
					<textarea style="width:750px; height:400px;"   rows="10" cols="80" id="textAreaContent" name="content"><%if(flag.equals("update")){ RequestBoardBean rrbean = requestMgr.getWriter(listnum); %><%=rrbean.getRequestboardcomment()%><%}%></textarea>
				</td>
			<tr>
		<tr>
			<td align="right" style="float:left;"><%if(flag.equals("update")){ %><a href="javascript:Procsubmit()">[�����Ϸ�]</a><%}else{ %><a href="javascript:Procsubmit()">[�ۼ��Ϸ�]</a><%} %> / <a href="RequestList.jsp">[�������]</a>
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
	var oEditors = []; //��������
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors, //����������
	    elPlaceHolder: "textAreaContent", //�����Ͱ� �׷��� textarea id��
	    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
	    fCreator: "createSEditor2" , //se2basicCreator.js �޼ҵ��
	    htParams : { // ���� ��� ���� (true:���/ false:������� ����)
	    bUseToolbar : true, // �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����) 
	    bUseVerticalResizer : true, // ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����) 
	    bUseModeChanger : true,
	    }
	});
	
	if(<%=listnum%>!=0){
		oEditors.getById["textAreaContent"].exec("LOAD_CONTENTS_FIELD");
	}
	
	//�����塯 ��ư�� ������ �� ������ ���� �׼��� ���� �� submitContents�� ȣ��ȴٰ� �����Ѵ�.
	function submitContents() {
	    // �������� ������ textarea�� ����ȴ�.
	    oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
	    try {
	        elClickedObj.form.submit();
	    } catch(e) {}
	}
	 
	// textArea�� �̹��� ÷��
	function pasteHTML(filepath){
	    var sHTML = '<img src="<%=request.getContextPath()%>/beerking/userimg/'+filepath+'">';
	    oEditors.getById["textAreaContent"].exec("PASTE_HTML", [sHTML]);
	}

</script>
