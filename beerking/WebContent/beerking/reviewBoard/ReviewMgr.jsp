<!-- ReviewTemple.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="beerking.RereplyBean"%>
<%@page import="beerking.BeerBean"%>
<%@page import="java.util.Vector"%>
<%@page import="beerking.ReplyBean"%>
<%@page import="beerking.FiletableBean"%>
<%@page import="beerking.UserDataBean"%>
<%@page import="beerking.ReviewBoardBean"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<%	request.setCharacterEncoding("EUC-KR"); %>
<% 
	int costumer = 0;//�α����� �ȵǾ������� ����
	int middlenum = 0; // �ߺз� ����
	int CHmiddle = 1; // ��з� ����
	int num = 0;//hotissue����
	int likescore = 1;//�ʱ� �������ƿ� üũ
	int scorecheck = 1;//�ʱ����� üũ
	int rplove =1;//��� ���ƿ� ����
	int grant = 0;//�����ڸ��
	int replynum = 0;//�ʱ� ���ƿ�
	
	//���ǿ��� email�� �޾� ���� ����
	String email = (String)session.getAttribute("emailKey");
	  UserDataBean uBean = rMgr.getUser2(email);
	 if(uBean.getUsernum()!=0){
	 	costumer = uBean.getUsernum();
	 	grant = uBean.getUsergrant();
	  }
	//num���ޱ�
	if(request.getParameter("num")!=null&&
	!request.getParameter("num").equals("null")){
		num = Integer.parseInt(request.getParameter("num"));
	}
	//replynum�� �ޱ�
	if(request.getParameter("replynum")!=null&&
	!request.getParameter("replynum").equals("null")){
		replynum = Integer.parseInt(request.getParameter("replynum"));
	}
	//middlenum�� �ޱ�
	if(request.getParameter("middlenum")!=null&&
			!request.getParameter("middlenum").equals("null")){
			middlenum = Integer.parseInt(request.getParameter("middlenum"));
		}
	//rplove�� �ޱ�
	if(request.getParameter("rplove")!=null&&
			!request.getParameter("rplove").equals("null")){
			rplove = Integer.parseInt(request.getParameter("rplove"));
			}
	//likescore�� �ޱ�
	if(request.getParameter("likescore")!=null&&
			!request.getParameter("likescore").equals("null")){
		likescore = Integer.parseInt(request.getParameter("likescore"));
	}
	//scorecheck�� �ޱ�
	if(request.getParameter("scorecheck")!=null&&
			!request.getParameter("scorecheck").equals("null")){
		scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	}
	//chmiiddle�� �ޱ�
	if(request.getParameter("CHmiddle")!=null&&
			!request.getParameter("CHmiddle").equals("null")){
		CHmiddle = Integer.parseInt(request.getParameter("CHmiddle"));
	}
	int totalRecord = 0; 		//�� �Խù� ��
	int numPerPage = 10; 	//�������� ���ڵ� �� 10
	int pagePerBlock = 15; //���� ������ �� 
	int totalPage = 0; 		//�� ������ �� = (�ø�)�ѰԽù���/�������� ���ڵ��
	int totalBlock = 0; 		//�� �� ��= (�ø�)�� ��������/���� �������� (78/15=>5.6=>6)
	int nowPage = 1; 		//���� ������
	int nowBlock = 1; 		//���� ��
	
	//numPrepage�� �� �ޱ� <���� �߰�����>
	 if(request.getParameter("numPerPage")!=null&&
	 !request.getParameter("numPerPage").equals("null")){
	    	numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	    }
	
	int start = 0; 	//start���� �Ѱ��༭ List�� ����Ѵ�. 
	int end = numPerPage; //10��
	
	// �˻��� �ʿ��� ��
	String keyWord = "";
	
	//�˻� �϶�
	if(request.getParameter("keyWord")!=null &&
			!request.getParameter("keyWord").equals("null")){
		keyWord = request.getParameter("keyWord");
		totalRecord = rMgr.getTotalCount(keyWord);
	}else{
		totalRecord = rMgr.getTotalCountType(CHmiddle,middlenum);
	}
	
	//�˻� �Ŀ� �ٽ� �˻� �ȵ� �������� ��û�ϱ�
	if(request.getParameter("reload")!=null&&
	request.getParameter("reload").equals("true")){
		keyWord = "";
	}
	
	
	//nowPage�� ��û�� ���.(���� ��û���� ������ default���� 1�̴�.)
	    if(request.getParameter("nowPage")!=null&&
	    		!request.getParameter("nowPage").equals("null")){
	    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    }
	    start = (nowPage*numPerPage)-numPerPage;
    
    //��ü ������ ��
   totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    //��ü �� ��
   totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
    //���� ��
   nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
   //���� üũ
	if(num !=0){
	  if(rMgr.checkLike("reviewlike", costumer,"reviewnum",num)==true){
		  likescore = 2;
	  }
	  if(rMgr.checkLike("reviewgrade", costumer,"reviewnum",num)==true){
		  scorecheck =2;
	  }
	  if(rMgr.checkLike("replylike", costumer,"replynum",replynum)==true){
			rplove =2; 
		  }
	}else{
		if(rMgr.checkLike("reviewlike", costumer,"reviewnum", rMgr.getMaxReviewNum())==true){
			  likescore = 2;
		  }
		 if(rMgr.checkLike("reviewgrade", costumer,"reviewnum", rMgr.getMaxReviewNum())==true){
			  scorecheck =2;
		  }
		 if(rMgr.checkLike("replylike", costumer,"replynum",replynum)==true){
				rplove =2; 
		}
	}
%>
<html>
<head>
<title>
	BeerKing Review
</title>
<script type="text/javascript">

	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
	  history.go(1);
	};
	
	//�˻�
	function search(){
		if(document.FrmkeyField.keyWord.value==""){
			alert("�˻�� �Է����� ������ �˻��� �����ʽ��ϴ�.");
			doucument.FrmkeyField.keyWord.focus();
			return;
		}
		document.FrmkeyField.submit();
	}

	//��з� ����
	function middlech(i) {
		document.readFrm.CHmiddle.value=i;
		document.readFrm.submit();
	}
	//����¡
	function pageing(page) {
		document.readFrm.nowPage.value=page;
		document.readFrm.submit();
	}
	//��
	function block(block) {
		document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	//�ߺз� Ŭ���� �ߺз� data name submit�� form�� ����(���İ˻��� ���)
	function middletype(num){
		var txt = "middle"+num
		document.readFrm.middlenum.value=num;
		document.getElementById(txt).middlenum.value=num;
		document.getElementById(txt).keyWord.value="null";
		document.FrmkeyField.keyWord.value="null";
		document.getElementById(txt).submit();
	}
	//readFrm submit��(list�� ���)
	function read(num){
		document.readFrm.num.value=num;
		document.readFrm.submit();
	}
	//ó�� �������
	function list(){
		document.listFrm.action = "ReviewMgr.jsp";
		document.listFrm.submit();
	}
	//���ƿ�� ���(������ �ɾ�ξ���.)
	function like(){
		if(document.scoreFrm.likescore.value==1){
			document.scoreFrm.action = "../proc/likeProc.jsp";
			document.scoreFrm.submit();
		}else{
			document.scoreFrm.likescore.value=2;
			document.scoreFrm.action = "../proc/likeProc.jsp";
			document.scoreFrm.submit();
		}
	}
	//����(������ �ɾ�ξ���.)
	function scoreee(){
		if(document.scoreFrm.score.value >5){
			alert("5������ ������ �Է��ϼ���.");
			return;
		}
		if(document.scoreFrm.score.value<1){
			alert("1�̻��� ������ �Է��ϼ���.");
			return;
		}
		if(document.scoreFrm.scorecheck.value==1){
			document.scoreFrm.action = "../proc/scoreProc.jsp";
			document.scoreFrm.submit();
		}else{
			document.scoreFrm.scorecheck.value=2;
			document.scoreFrm.action = "../proc/scoreProc.jsp";
			document.scoreFrm.submit();
		}
	}
	//�������	
	function scorecancell(){
		document.scoreFrm.scorecheck.value=2;
		document.scoreFrm.action = "../proc/scoreProc.jsp";
		document.scoreFrm.submit();
		}
	//reply ����
	function rpInsert(){
		document.replycommentcheck.action="../proc/replyProc.jsp";
		document.replycommentcheck.submit();
	}
	//reply����
	function rpdelete(i){
		document.replycommentcheck.flag.value="delete";
		document.replycommentcheck.replynum.value=i;
		document.replycommentcheck.action="../proc/replyProc.jsp";
		document.replycommentcheck.submit();
	}
	//reply���̰��ϱ�
	function rpshoww(){
		var con = document.getElementById("replyDiv");
		if(con.style.display=='none'){
			con.style.display = 'block';
		}else{
			con.style.display = 'none';
		}
	}
	
	//rereply ����
	function rprpInsert(i){
		var e ="rereplycommentcheck"+i
		var con = document.getElementById(e);
		con.action="../proc/rereplyProc.jsp";
		con.submit();
	}
	//rereply ����
	function reredelete(i,j){ 
		var e = "rereplycommentcheck"+j
		var con = document.getElementById(e);
		con.flag.value="delete";
		con.rereplynum.value=i;
		con.action="../proc/rereplyProc.jsp";
		con.submit();
	}
	//���� Ŭ�� �̺�Ʈ
	function rpshowww(i){
		var e = "rereply"+i
		var con = document.getElementById(e);
		if(con.style.display=='none'){
			con.style.display = 'block';
		}else{
			con.style.display = 'none';
		}
	}
	//reply like
	function relike(i){
		var e ="replylikeFrm"+i;
		var cone = document.getElementById(e);
		if(cone.rplove.value ==1){
			cone.action="../proc/relikeProc.jsp";
			cone.submit();
		}else{
			cone.rplove.value =2;
			cone.action="../proc/relikeProc.jsp";
			cone.submit();
		}
	}
	
	//writer
	function writer(){
		document.writerFrm.action="ReviewWriter.jsp";
		document.writerFrm.submit();
	}
	//writer update
	function updatereview(i){
		document.writerFrm.num.value=i;
		document.writerFrm.action="ReviewWriter.jsp";
		document.writerFrm.submit();
	}
	//writer delete
	function deletereview(i){
		document.writerFrm.num.value=i;
		document.writerFrm.action="../proc/ReviewDeleteProc.jsp";
		document.writerFrm.submit();
	}
	function onclickLoginButton(){
		  modalLogin.classList.toggle("show_modal_Login"); 
	}
</script>
<link href="default.css" rel="stylesheet" type="text/css" media="all"/>
<link href="fonts.css" rel="stylesheet" type="text/css" media="all"/>
</head>
<body id="reviewMgrBoard">
<!-- ��Ŭ��� �Ұ� -->
<jsp:include page="../index/Navleft.jsp"/>
<!-- ��/�� �з� -->
<% 
	String[] mlist = null;
	if(CHmiddle ==1){
		mlist = rMgr.getMiddle(1);
	}else if(CHmiddle ==2){
		mlist = rMgr.getMiddle(2);
	}
%>
<div id="wrapper2">
	<div id="menu-wrapper2">
		<div id="menu2" class="container2">
			<ul>
				<li id="ale" <%if(CHmiddle==1){ %> class="current_page_item" <%}%>><a href="javascript:middlech('1')"><font size="10em">ALE</font></a></li>
				<li id="rog" <%if(CHmiddle==2){ %> class="current_page_item" <%} %>><a href="javascript:middlech('2')"><font size="10em">LAGER</font></a></li>
			</ul>
		</div><!-- menu-wrapperDiv -->
	</div><!-- menu containerDiv-->
	<div id="header-wrapper2">
		<div id="header2" class="container2">
			<div id="logo2">
				<ul>
					<%
						for(int i=0;i<mlist.length;i++){//�� �з�
					%> 
					<li><form method="post" id="middle<%=i%>" name="middle<%=i%>"> <a href="javascript:middletype('<%=i%>')"><%if(middlenum==i){%><font color="red"><%}%><%=mlist[i] %></font></a>
					<input type="hidden" name="middletype" value="<%=mlist[i]%>">
					<input type="hidden" name="num" value="<%=num%>">
					<input type="hidden" name="nowPage" value="<%=nowPage %>">
					<input type="hidden" name="keyWord" value="<%=keyWord %>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
					<input type="hidden" name="CHmiddle" value="<%=CHmiddle%>">
					<input type="hidden" name="middlenum" value="<%=middlenum %>">
					</form><!-- middle[i] form �� --></li>
					<%}//�� �з� for %>
				</ul>
			</div><!-- logoDiv -->
		</div>
	</div>
<!-- ��/�� �з� �� -->
<!-- �˻� form ���� -->
	<div id="search" class="container2">
		<form name="FrmkeyField" method="post" action="ReviewMgr.jsp">
			<ul id="searchLi">
				<li>
					<input name="keyWord" placeholder="�˻�"><input type="button" value="�˻�" onclick="javascript:search()">
					<input type="hidden" name="nowPage" value="1">
					<input type="hidden" name="CHmiddle" value="<%=CHmiddle%>">
					<input type="hidden" name="middlenum" value="<%=middlenum %>">
					<input type="hidden" name="num" value="<%=num%>">
				</li>	
			</ul>
		</form>
	</div><!-- searchFrm/ Div -->
<!-- �˻� form �� -->
<!-- hot issue �� �Խ��� board ��� -->
	<div id="read" class="container2">
		<%
				String maintitle ="<font color=\"red\">Hot issue</font>";
				FiletableBean flist = null;
				int reviewnum = 0;
				String reviewtitle =null;
				String reviewcomment =null;
				String reviewdate =null;
				String reviewtime =null;
				int rvUsernum = 0;
				int rvBeernum = 0;
				int rvFilenum = 0;
				UserDataBean userlist = new UserDataBean();
				userlist = rMgr.getUser(rvUsernum);
				String filename =null;
				int filesize =0;
				if(num==0){//���̽� ���ǹ� (�Խ����� ����)
					int hot = rMgr.getMaxReviewNum();
					ReviewBoardBean list =rMgr.getReview(hot);
					flist = rMgr.getFiledata(hot);
					reviewnum = list.getReviewnum();
					reviewtitle = list.getReviewtitle();
					reviewcomment = list.getReviewcomment();
					reviewdate = list.getReviewdate();
					reviewtime = list.getReviewtime();
					rvUsernum = list.getUsernum();
					rvBeernum = list.getBeernum();
					rvFilenum = list.getFilenum();
					userlist = rMgr.getUser(rvUsernum);
					filename = flist.getFilename();
					filesize = flist.getFilesize();
				%>
				<!-- <td align="center" height="25">Hot issue : </td> -->
				<%}else{ %>
				<%	
					ReviewBoardBean list =rMgr.getReview(num);
					flist = rMgr.getFiledata(num);
					reviewnum = list.getReviewnum();
					reviewtitle = list.getReviewtitle();
					reviewcomment = list.getReviewcomment();
					reviewdate = list.getReviewdate();
					reviewtime = list.getReviewtime();
					rvUsernum = list.getUsernum();
					rvBeernum = list.getBeernum();
					rvFilenum = list.getFilenum();
					userlist = rMgr.getUser(rvUsernum);
					filename = flist.getFilename();
					filesize = flist.getFilesize();
					maintitle = "����";
				%>
				<%} %>
				<div style="background-color: #DDDDDD;">
				<ul style="border-top:groove;border-width: 1px;">
					<li><h1><%=maintitle %> : <%=reviewtitle %></h1></li>
				</ul><!-- span����  -->
					<span style="display:inline-block;width:480px;text-align:left;"><h2>�� ���� : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=userlist.getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')"><%=userlist.getNickname() %></a></h2></span>
					<span style="display:inline-block;width:480px;text-align:right"> ��ϳ�¥ : <%= reviewdate +" / "+ reviewtime%></span>
					<span style="display:inline-block;border-bottom:groove;border-width: 1px; width:100%;"><br></span><br>
				</div>
				<!-- ���ƿ� �� -->
				<div id="scoreFrmDiv" style="display:inline-block;width:950px;text-align:right; height:120px;">
				<form name="scoreFrm" style="display:inline-block;width:950px;text-align:right;">
					<%if(costumer==0){%>
						���ƿ�� �����ֱ�� <a href="javascript:onclickLoginButton()">�α���</a>�Ŀ� �����մϴ�.
					<%}else{%>
					<%if(likescore==1&&costumer != rvUsernum){ %>
					<input type="image" src = "../css/noheart.png" onclick="javascript:like()" style="width: 40px; height: 40px; padding: 0px; vertical-align: middle;  border:0; outline:0; background-color:#FFF;">
					<%}else if(likescore==2&&costumer != rvUsernum){ %>
					<input type="image" src = "../css/heart.png" onclick="javascript:like()" style="width: 40px; height: 40px; padding: 0px; vertical-align: middle;  border:0; outline:0; background-color:#FFF;"><%} %>
					<font style="font-size: 20px; vertical-align: middle;"></font><%if(scorecheck==1&&costumer != rvUsernum) {%>
					<font style="font-size: 20px; vertical-align: middle;">���� :</font> <input type="number" name="score" min="1" max="5" value="0" style="width: 50px; height: 40px; padding: 0px; font-size: 1em; vertical-align: middle;">
					<input type="button" value="�����ֱ�" onclick="javascript:scoreee()" style="width: 100px; height: 40px; padding: 0px; font-size: 20px; vertical-align: middle;">
					<%}else if(scorecheck==2&&costumer != rvUsernum){ %><input type="button" value="�������" onclick="javascript:scorecancell()" style="width: 100px; height: 40px; padding: 0px; font-size: 20px; vertical-align: middle;"><%} %>
						<input type="hidden" name="num" value="<%=num%>">
						<input type="hidden" name="nowPage" value="<%=nowPage %>">
						<input type="hidden" name="keyWord" value="<%=keyWord %>">
						<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
						<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
						<input type="hidden" name="middlenum" value="<%=middlenum %>">
						<input type="hidden" name="likescore" value="<%=likescore%>" >
						<input type="hidden" name="scorecheck" value="<%=scorecheck %>">
						<input type="hidden" name="reviewnum" value="<%=reviewnum%>">
						<input type="hidden" name="rplove" value="<%=rplove%>">
					</form>
			<%}//if costumer %>
			</div>
			<!-- ���ƿ� �� �� -->
			<div id="reviewcommentDiv" style="font-size: 1em;margin:20px;text-align:left;color:black;padding: 5px;">
				<%=reviewcomment %>
			</div>
			<br/>
			<br/>
			<span style="display:inline-block;border-top:groove;width:100%;border-width: 1px;"> </span>
			<%
				Vector<ReplyBean> rplist = rMgr.getReplylist(reviewnum);
				int rpTotal =0;
				if(rplist.size()!=0){
					rpTotal = rplist.size();
				}
			%>
			<span style="display:inline-block;width:300px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;"><a href="javascript:rpshoww();">��ۺ���</a><font color="red">(<%=rpTotal %>)</font></span>
			<span style="display:inline-block;width:600px;text-align:right;margin:5px;padding: 5px;vertical-align: middle;">
			�� ���ƿ� : <%=rMgr.getReviewLikecount(reviewnum) %>�� / ��� ���� : <%if(rMgr.ReviewAverageRation(reviewnum)==0) {%>0<%} %><fmt:formatNumber value="<%=rMgr.ReviewAverageRation(reviewnum) %>" pattern=".00"/> ��</span>
<!-- ��ۺκ� ���� -->
			<form method="post" name="replycommentcheck" style="display:inline-block;width:950px;">
			<span style="display:inline-block;width:900px;text-align:left;margin:5px;padding: 5px;"><h3><%if(costumer==0){%>�α��� �Ŀ� �̿��Ҽ� �ֽ��ϴ�.<%}else{ out.print("�� ����: "+uBean.getNickname()); }%></h3></h1></span>
				<span style="display:inline-block;width:900px;text-align:left;margin:5px;padding: 5px;">
					<textarea name="replycomment" cols="72" rows="2" maxlength="1000" style="height: 50px;vertical-align: middle;resize:none;"></textarea>
					<input type="button" value="�Է¿Ϸ�" onclick="javascript:rpInsert()" style="width:80px;height: 50px;vertical-align: middle;border-radius:0;border:0;">
					<input type="hidden" name="num" value="<%=num%>">
					<input type="hidden" name="nowPage" value="<%=nowPage %>">
					<input type="hidden" name="keyWord" value="<%=keyWord %>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
					<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
					<input type="hidden" name="middlenum" value="<%=middlenum %>">
					<input type="hidden" name="reviewnum" value="<%=reviewnum%>">
					<input type="hidden" name="usernum" value="<%=uBean.getUsernum()%>">
					<input type="hidden" name="flag" value="insert">
					<input type="hidden" name="scorecheck" value="<%=scorecheck %>">
					<input type="hidden" name="reviewnum" value="<%=reviewnum%>">
					<input type="hidden" name="rplove" value="<%=rplove%>">
					<input type="hidden" name="replynum" value="1">
				</span>
			</form>
		<br/>	
	<div id="replyDiv" style="border:groove; margin:auto; width:90%;background-color: #EEEEEE;">
	<%
		if(!rplist.isEmpty()){
			for(int i=0;i<rplist.size();i++){
				rplove = 1;
				ReplyBean rpbean = rplist.get(i);
				replynum = rpbean.getReplynum();
				String replycomment = rpbean.getReplycomment();
				String replydate = rpbean.getReplydate();
				int rpusernum = rpbean.getUsernum();
				int rpreviewnum =rpbean.getReviewnum();
				UserDataBean rpUser = new UserDataBean();
				rpUser = rMgr.getUser(rpusernum);
				int rplikecount = rMgr.getReplyLikecount(replynum);
				if(rMgr.checkLike("replylike", costumer,"replynum",replynum)==true){
					rplove =2; 
				  }
	%>
	<%
		Vector<RereplyBean> rerelist = rMgr.getRereplylist(replynum);
		int rprpTotal =0;
		if(rerelist.size()!=0){
			rprpTotal = rerelist.size();
		}
	%>
	<div id="replymaaaaan<%=i %>">
	<!-- ������ƿ� -->
	<span style="display:inline-block;width:200px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;">
	�� ���� : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=rpUser.getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')">
			<%=rpUser.getNickname() %></a>>></span>
	<!-- <input type="button" value="���� (<%//=rprpTotal %>)" onclick="javascript:rpshowww('<%//=i%>')"> -->
	<span style="display:inline-block;width:300px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;"><%=replycomment %></span>
	 <span style="display:inline-block;width:300px;text-align:right;margin:5px;padding: 5px;vertical-align: middle;">
	 <button onclick="javascript:rpshowww('<%=i%>');" style="width:70px;height:30px;background-color:#FFF;">���(<%=rprpTotal %>)</button>
	 <%if(costumer==0){%>
	<%}else{%>
	<%if(rplove==1&&costumer != rpusernum){ %><input type="image" src = "../css/noheart.png" onclick="javascript:relike('<%=i%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;">
	<%}else if(rplove==2&&costumer != rpusernum){ %><input type="image" src = "../css/heart.png" onclick="javascript:relike('<%=i%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;"><%} if(costumer == rpusernum||grant==2){%><input type="image" src = "../css/deleteButton.png" onclick="javascript:rpdelete('<%=replynum%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;"><%} %>
	<%}%>�� ���ƿ� : <%=rplikecount %>��</span>
		<form method="post" name="replylikeFrm<%=i %>" id="replylikeFrm<%=i %>">
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
			<input type="hidden" name="keyWord" value="<%=keyWord %>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
			<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
			<input type="hidden" name="middlenum" value="<%=middlenum %>">
			<input type="hidden" name="likescore" value="<%=likescore%>" >
			<input type="hidden" name="rplove" value="<%=rplove%>">
			<input type="hidden" name="scorecheck" value="<%=scorecheck %>">
			<input type="hidden" name="replynum" value="<%=replynum%>">
		</form>
		<!-- ���� �κн��� -->
		<div id="rereply<%=i %>" style="display:none; border-top:groove; border-bottom:groove;width:100%;float:left;background-color: #DDDDDD;">
		<%if(costumer!=0||grant==2){ %>
			<span style="display:inline-block;width:800px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;">
			�� ����: <%=uBean.getNickname()%></span>
			<form method="post" name="rereplycommentcheck" id="rereplycommentcheck<%=i%>" style="display:inline-block;width:800px;text-align:right;">
			<span style="display:inline-block;width:800px;text-align:left;margin:5px;padding: 5px;">
				<textarea name="rereplaycomment" cols="72" rows="2" maxlength="1000" style="width:600px;height: 50px;vertical-align: middle;resize:none;"></textarea>
				<input type="button" value="�Է¿Ϸ�" onclick="javascript:rprpInsert('<%=i%>')" style="height: 50px;vertical-align: middle;">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
				<input type="hidden" name="keyWord" value="<%=keyWord %>">
				<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
				<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
				<input type="hidden" name="middlenum" value="<%=middlenum %>">
				<input type="hidden" name="reviewnum" value="<%=reviewnum%>">
				<input type="hidden" name="usernum" value="<%=uBean.getUsernum()%>">
				<input type="hidden" name="flag" value="insert">
				<input type="hidden" name="scorecheck" value="<%=scorecheck %>">
				<input type="hidden" name="replynum" value="<%=replynum%>">	
				<input type="hidden" name="rereplynum" value="1">
			</span>
			</form>
			<%}//if ����if%>
			<%if(!rerelist.isEmpty()){
				for(int j=0;j<rerelist.size();j++){
					RereplyBean rerebean = rerelist.get(j);
					int rereplyusernum = rerebean.getUsernum();
					int rereplynum = rerebean.getRereplynum();
					String rereplycomment = rerebean.getRereplycomment();
					String rereplydata = rerebean.getRereplydata();
					String rereuser = rMgr.getUser(rereplyusernum).getNickname();
			%>
			<span style="display:inline-block;width:390px;text-align:left;margin:5px;padding: 5px;">
			�г��� : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=rMgr.getUser(rereplyusernum).getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')">
			<%=rereuser %></a> >> <%=rereplycomment %> 
			</span>
			<span style="display:inline-block;width:390px;text-align:right;margin:5px;padding: 5px;">
			�ۼ��� : <%=rereplydata %> <%if(costumer==rereplyusernum||grant==2){ %><input type="image" src = "../css/deleteButton.png" onclick="javascript:reredelete('<%=rereplynum%>','<%=i%>');" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#DDDDDD;"><%} %>
			</span>
			<%}//���� for
			}//����if %>
				</div><!-- ����Div -->
			</div><!-- divmannn -->
		<%}//for ���
		}//if ���%>	
	<!-- ���� �κ� �� -->
<!-- ��� �κ� �� -->
</div><!-- ���Div -->
</div>
<!-- �Խ��� ��� �� -->
<!-- �Խ��� List ���� -->
<div id="page2" class="container2">
	<div id="content2" style="border-top: 3px solid rgba(0,0,0,.1);">
		<div class="title2">
				<br/><br/>
				<div style="border-bottom: 3px solid rgba(0,0,0,.1);">
				<h2>���� �Խñ� ���</h2>
				<br/><br/>
				</div>
			<ul class="style3">
			<%
				String mddlelist = mlist[middlenum]; 
				Vector<ReviewBoardBean> vlist = rMgr.getBoardList(keyWord, start, end,mddlelist);
				int listSize1 = totalRecord-start;
				if(vlist.isEmpty()) {%>
				<li class="first2">
					<h3>��� �� �Խù��� �����ϴ�</h3>
				</li>
			<%	
				}else{
				for(int k=0;k<vlist.size();k++){
					if(listSize1 == k) break;
					ReviewBoardBean rbBean = vlist.get(k);
					int listnum = rbBean.getReviewnum();
					UserDataBean udBean = rMgr.getUser(rbBean.getUsernum());
					BeerBean bBean = rMgr.getBeerdata(rbBean.getBeernum());
					rMgr.getReplylist(listnum);
			%>
				<li class="first2">
					<img src="../beerimg/<%=bBean.getFilename() %>" alt="" width="140" height="140" style="margin-right:0;" class="alignleft border" />					
					<span style="disaplay: block;float:left;width:250px;height:140px;line-height: 140px;text-align: left"><font size="4px" color="pink"><b><%=bBean.getTypebig() %>>></font><font size="4px" color="orange"><%=bBean.getTypesmall() %></b></font></span>
					<span style="disaplay: block;height:140px;line-height: 140px;float:left;width:500px;text-align: left;"><font size="5px"><strong><a href="javascript:read('<%=listnum%>')" style="color:black;"> 
					<c:set var="TextValue" value="<%=rbBean.getReviewtitle() %>"/>
					<c:choose>
				        <c:when test="${fn:length(TextValue) gt 21}">
				        <c:out value="${fn:substring(TextValue, 0, 20)}...">
				        </c:out></c:when>
				        <c:otherwise>
				        <c:out value="${TextValue}">
				        </c:out></c:otherwise>
					</c:choose>	
					</strong></a></font></span>
					<span style="float:right;width:280px;text-align: right;"><font size="2">�ۼ��� : <%=udBean.getNickname() %>&nbsp&nbsp ��¥ : <%=rbBean.getReviewdate() %>
					<%if(costumer==rbBean.getUsernum()||grant==2){%><a href="javascript:updatereview('<%=listnum%>')">����</a>/<a href="javascript:deletereview('<%=listnum%>')">����</a><%} %></font>
					</span>				
				</li>
				<li style="height:20px;clear: both;margin-bottom: 0px;padding: 0px 0px 0px 0px;border-top: 1px solid #C2C2C2;">
				</li>
			<%}} %>
			</ul>
			<br>
		</div>
	</div>
</div>
<!-- �Խ��� List �� -->
<!-- pageó�� ���� -->
<div>
	<span style="float:left;width:500px;text-align:center;">
	<%
		//����¡�� ǥ�õ� ���ۺ��� �� ������ ����
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		int pageEnd = ((pageStart+pagePerBlock)<totalPage)?(pageStart+pagePerBlock):totalPage+1;
		%>
		<%if(totalPage!=0){%>
			<!-- ���� �� -->
			<%if(nowBlock>1) { %>
				<a href="javascript:block('<%=nowBlock-1%>')">&#60;&#60;</a>
			<%} %>&nbsp;
			<!-- ����¡     -->
			<%for(; pageStart<pageEnd; pageStart++) {%>
				<font size="5px"><a href="javascript:pageing('<%=pageStart %>')">
				<%if(nowPage==pageStart) {%>
				<font color="red">[<%=pageStart %>]</font>
				<%}else{%>
				[<%=pageStart %>]</a></font>
				<%}//else %>
			<%}//---for %>&nbsp;
			<!-- ���� �� -->
			<%if(totalBlock>nowBlock) { %>
				<a href="javascript:block('<%=nowBlock+1%>')">>></a>
			<%} %>
		<%} //---if%>
		</span>
		
		<span style="float:left;width:500px;text-align:right;">
		<%if(costumer!=0){ %><a href="javascript:writer();">[�۾���]</a><%} %>
		<a href="javascript:list()">[���]</a>
		</span>
</div>
<!-- page �� -->
</div><!-- wrapperDiv -->
<!-- �Խ��� �۾���� form -->
<form method="post" name="writerFrm">
	<input type="hidden" name="middlename" value="<%=mlist[middlenum] %>">
	<input type="hidden" name="num" value="0">
	<input type="hidden" name="flag" value="insert">
</form>
<!-- �Խ��� �۾���� form �� -->
<!-- �Խ��� �б�� -->
<form method="post" name="readFrm">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage %>">
	<input type="hidden" name="keyWord" value="<%=keyWord %>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
	<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
	<input type="hidden" name="middlenum" value="<%=middlenum %>">
</form>
<!-- ó������ ������ -->
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>
<!-- �б�� �� -->
</body>
</html>