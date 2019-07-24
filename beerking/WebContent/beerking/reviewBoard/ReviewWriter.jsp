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
	//검색
	function searchWriter(){
		var con6 = document.getElementById("keyWord");
		if(con6.value==""){
			alert("검색어를 입력하지 않으면 검색이 되지않습니다.");
			con6.focus();
			return;
		}
		var con7 = document.getElementById("writerSearchFrm");
		con7.submit();
	}
	//대중소분류선택
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
		if(che.Typebig.value =="대분류"){
			alert("카테고리를 등록하지않으면 작성되지 않습니다.");
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
				<td style="float:left;"><input name="keyWord" id="keyWord" placeholder="맥주이름을 검색해주세요  ex)카스" style="width:600px;"></td>
				<td style="float:left;"><input type="button" value="검색" onclick="javascript:searchWriter();" style="width:50px;">
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
				제목 : <%if(flag.equals("update")){ReviewBoardBean rrbean = rMgr.getWriter(listnum);%><input name="title" style="width:650px;" value="<%=rrbean.getReviewtitle()%>"><%}else{ %><input name="title" style="width:650px;"><%} %>
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
				<input value="대분류" id="Typebig" name="Typebig" style="width:120px;" readonly> >> 
				<input value="중분류" id="Typemiddle" name="Typemiddle" style="width:120px;" readonly> >>
				<input value="맥주이름" id="Typesmall" name="Typesmall" style="width:120px;" readonly>
				</td>
			<%} %>
		</tr>
			<tr>
				<td align="center">
					<textarea style="width:750px; height:400px;"   rows="10" cols="80" id="textAreaContent" name="content"><%if(flag.equals("update")){ ReviewBoardBean rrbean = rMgr.getWriter(listnum); %><%=rrbean.getReviewcomment()%><%} %></textarea>
				</td>
			<tr>
		<tr>
			<td align="right" style="float:left;"><%if(flag.equals("update")){ %><a href="javascript:Procsubmit()">[수정완료]</a><%}else{ %><a href="javascript:Procsubmit()">[작성완료]</a><%} %> / <a href="ReviewMgr.jsp">[목록으로]</a>
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
	var oEditors = []; //전역변수
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors, //전역변수명
	    elPlaceHolder: "textAreaContent", //에디터가 그려질 textarea id값
	    sSkinURI: " <%=request.getContextPath()%>/se2/SmartEditor2Skin.html ", // 에디터의 HTML
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
