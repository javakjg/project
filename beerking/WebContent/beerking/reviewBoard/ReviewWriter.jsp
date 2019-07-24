<!-- ReviewWriter.jsp -->
<%@page import="beerking.ReviewBoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="beerking.BeerBean"%>
<%@page import="beerking.UserDataBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%	request.setCharacterEncoding("EUC-KR");%>
<%
	String flag ="insert";
	String keyWord = "";
	int listnum = 0;
	if(request.getParameter("keyWord")!=null &&
		!request.getParameter("keyWord").equals("null")){
		keyWord = request.getParameter("keyWord");
	}
	if(request.getParameter("num")!=null &&
			!request.getParameter("num").equals("null")){
		listnum = Integer.parseInt(request.getParameter("num"));
	}
	if(listnum !=0){
		flag = "update";
	}
	String middle = request.getParameter("middlename");
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = rMgr.getUser2(email);
	int costumer = uBean.getUsernum();
	Vector<BeerBean> blist = rMgr.getWriterBeardata(middle,keyWord);
%> 
<jsp:include page="../index/Navleft.jsp"></jsp:include>
<script type="text/javascript">
	//�˻�
	function searchWriter(){
		var con6 = document.getElementById("keyWord");
		if(con6.value==""){
			alert("�˻�� �Է����� ������ �˻��� �����ʽ��ϴ�.");
			con6.focus();
			return;
		}
		var con7 = document.getElementById("writerSearchFrm");
		con7.submit();
	}
	//���߼Һз�����
	function seletname(b, m, se, sk){
		var con1 = document.getElementById("Typebig");
		con1.value = b;
		var con2 = document.getElementById("Typemiddle");
		var con3 = document.getElementById("Typesmall");
		con2.value = m;
		var e = se+sk;
		con3.value = e;
		var con4 = document.getElementById("smallbName");
		con4.value = se;
	}
	
	function Procsubmit(){
		oEditors.getById["textAreaContent"].exec("UPDATE_CONTENTS_FIELD", [ ]);
		var che = document.getElementById("BigwriterFrm");
		if(che.Typebig.value =="��з�"){
			alert("ī�װ��� ������������� �ۼ����� �ʽ��ϴ�.");
			return;
		}else{
			try {
				che.submit();
		    } catch(e) {}
		}
	}
</script>
<div style="width:100%;">
<div style="width:75%; display:inline-block; margin-top:5%">
<div id="writerSearchFrmDIV">
	<form id="writerSearchFrm" method="post">
		<table style="width:800px;margin-left:auto;margin-right:auto;">
			<tr>
				<td style="float:left;"><input name="keyWord" id="keyWord" placeholder="�����̸��� �˻����ּ���  ex)ī��" style="width:600px;"></td>
				<td style="float:left;"><input type="button" value="�˻�" onclick="javascript:searchWriter();" style="width:50px;">
					<input type="hidden" name="middlename"></td>
			</tr>
			<%for(int i=0;i<blist.size();i++){
					BeerBean bbean = blist.get(i); 
					String big = bbean.getTypebig();
					String typemiddle = bbean.getTypesmall();
					String typesmall = bbean.getBeerEname()+"/"+bbean.getBeerKname();
					String functionType =bbean.getTypebig()+"\'"+","+"\'"+bbean.getTypesmall()+"\'"+","+"\'"+bbean.getBeerEname()+"\'"+","+"\'"+bbean.getBeerKname();
					%>
			<tr style="height:15px;">
				<td style="margin:auto;">
				<%if(flag.equals("update")){
					ReviewBoardBean rrbean = rMgr.getWriter(listnum);
					BeerBean bbbean = rMgr.getBeerdata(rrbean.getBeernum());
					big = bbbean.getTypebig();
					typemiddle = bbbean.getTypesmall();
					typesmall = bbbean.getBeerEname()+"/"+bbbean.getBeerKname();
					functionType =bbbean.getTypebig()+"\'"+","+"\'"+bbbean.getTypesmall()+"\'"+","+"\'"+bbbean.getBeerEname()+"\'"+","+"\'"+bbbean.getBeerKname();
				} %>
				<%=big %> >> <%=typemiddle %> >><a href="javascript:seletname('<%=functionType %>')"><%=typesmall %></a>
				</td>
			</tr>
			<%}//for %>
		</table>
	</form>
</div>
<div id="ReviewWriterFrm" style="width:80%;">
<form  name="BigwriterFrm" id="BigwriterFrm" action="../proc/ReviewWriterProc.jsp">
	<table style="width:850px;">
		<tr>
			<th style="float:left;">
				���� : <%if(flag.equals("update")){ReviewBoardBean rrbean = rMgr.getWriter(listnum);%><input name="title" style="width:650px;" value="<%=rrbean.getReviewtitle()%>"><%}else{ %><input name="title" style="width:650px;"><%} %>
				<!-- <input name="title" style="width:766px; height:412px;"  id="textAreaContent">   -->
			</th>
		</tr>
		<tr>
			<%if(flag.equals("update")){
				ReviewBoardBean rrbean = rMgr.getWriter(listnum);
				BeerBean bbbean = rMgr.getBeerdata(rrbean.getBeernum());
				%>
				<td>
				<input value="<%=bbbean.getTypebig() %>" id="Typebig" name="Typebig" style="width:120px;" readonly> >> 
				<input value="<%=bbbean.getTypesmall() %>" id="Typemiddle" name="Typemiddle" style="width:120px;" readonly> >>
				<input value="<%=bbbean.getBeerEname()+"/"+bbbean.getBeerKname() %>" id="Typesmall" name="Typesmall" style="width:120px;" readonly>
				</td>
			<%}else{ %>
				<td>
				<input value="��з�" id="Typebig" name="Typebig" style="width:120px;" readonly> >> 
				<input value="�ߺз�" id="Typemiddle" name="Typemiddle" style="width:120px;" readonly> >>
				<input value="�����̸�" id="Typesmall" name="Typesmall" style="width:120px;" readonly>
				</td>
			<%} %>
		</tr>
			<tr>
				<td align="center">
					<textarea style="width:750px; height:400px;"   rows="10" cols="80" id="textAreaContent" name="content"><%if(flag.equals("update")){ ReviewBoardBean rrbean = rMgr.getWriter(listnum); %><%=rrbean.getReviewcomment()%><%} %></textarea>
				</td>
			<tr>
		<tr>
			<td align="right" style="float:left;"><%if(flag.equals("update")){ %><a href="javascript:Procsubmit()">[�����Ϸ�]</a><%}else{ %><a href="javascript:Procsubmit()">[�ۼ��Ϸ�]</a><%} %> / <a href="ReviewMgr.jsp">[�������]</a>
			</td>
		</tr>
	</table>
	<%if(flag.equals("update")){
				ReviewBoardBean rrbean = rMgr.getWriter(listnum);
				BeerBean bbbean = rMgr.getBeerdata(rrbean.getBeernum());
	%><input type="hidden" id="smallbName" name="smallbName" value="<%=bbbean.getBeerEname()%>">
	<%}else{ %>
	<input type="hidden" id="smallbName" name="smallbName" value="aaa"><%} %>
	<input type="hidden" id="flag" name="flag" value="<%=flag%>">
	<%if(flag.equals("update")){ReviewBoardBean rrbean = rMgr.getWriter(listnum); %>
	<input type="hidden" name="reviewnum" id="reviewnum" value="<%=rrbean.getReviewnum()%>"><%} %>
</form>
</div>
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
	    sSkinURI: " <%=request.getContextPath()%>/se2/SmartEditor2Skin.html ", // �������� HTML
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
