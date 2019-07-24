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
	int costumer = 0;//로그인이 안되었을때를 가정
	int middlenum = 0; // 중분류 조건
	int CHmiddle = 1; // 대분류 조건
	int num = 0;//hotissue조건
	int likescore = 1;//초기 리뷰좋아요 체크
	int scorecheck = 1;//초기평점 체크
	int rplove =1;//댓글 좋아요 조건
	int grant = 0;//관리자모드
	int replynum = 0;//초기 좋아요
	
	//세션에서 email을 받아 유저 세팅
	String email = (String)session.getAttribute("emailKey");
	  UserDataBean uBean = rMgr.getUser2(email);
	 if(uBean.getUsernum()!=0){
	 	costumer = uBean.getUsernum();
	 	grant = uBean.getUsergrant();
	  }
	//num값받기
	if(request.getParameter("num")!=null&&
	!request.getParameter("num").equals("null")){
		num = Integer.parseInt(request.getParameter("num"));
	}
	//replynum값 받기
	if(request.getParameter("replynum")!=null&&
	!request.getParameter("replynum").equals("null")){
		replynum = Integer.parseInt(request.getParameter("replynum"));
	}
	//middlenum값 받기
	if(request.getParameter("middlenum")!=null&&
			!request.getParameter("middlenum").equals("null")){
			middlenum = Integer.parseInt(request.getParameter("middlenum"));
		}
	//rplove값 받기
	if(request.getParameter("rplove")!=null&&
			!request.getParameter("rplove").equals("null")){
			rplove = Integer.parseInt(request.getParameter("rplove"));
			}
	//likescore값 받기
	if(request.getParameter("likescore")!=null&&
			!request.getParameter("likescore").equals("null")){
		likescore = Integer.parseInt(request.getParameter("likescore"));
	}
	//scorecheck값 받기
	if(request.getParameter("scorecheck")!=null&&
			!request.getParameter("scorecheck").equals("null")){
		scorecheck = Integer.parseInt(request.getParameter("scorecheck"));
	}
	//chmiiddle값 받기
	if(request.getParameter("CHmiddle")!=null&&
			!request.getParameter("CHmiddle").equals("null")){
		CHmiddle = Integer.parseInt(request.getParameter("CHmiddle"));
	}
	int totalRecord = 0; 		//총 게시물 수
	int numPerPage = 10; 	//페이지당 레코드 수 10
	int pagePerBlock = 15; //블럭당 페이지 수 
	int totalPage = 0; 		//총 페이지 수 = (올림)총게시물수/페이지당 레코드수
	int totalBlock = 0; 		//총 블럭 수= (올림)총 페이지수/블럭당 페이지수 (78/15=>5.6=>6)
	int nowPage = 1; 		//현재 페이지
	int nowBlock = 1; 		//현재 블럭
	
	//numPrepage의 값 받기 <추후 추가예정>
	 if(request.getParameter("numPerPage")!=null&&
	 !request.getParameter("numPerPage").equals("null")){
	    	numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
	    }
	
	int start = 0; 	//start값을 넘겨줘서 List를 출력한다. 
	int end = numPerPage; //10개
	
	// 검색에 필요한 값
	String keyWord = "";
	
	//검색 일때
	if(request.getParameter("keyWord")!=null &&
			!request.getParameter("keyWord").equals("null")){
		keyWord = request.getParameter("keyWord");
		totalRecord = rMgr.getTotalCount(keyWord);
	}else{
		totalRecord = rMgr.getTotalCountType(CHmiddle,middlenum);
	}
	
	//검색 후에 다시 검색 안된 페이지를 요청하기
	if(request.getParameter("reload")!=null&&
	request.getParameter("reload").equals("true")){
		keyWord = "";
	}
	
	
	//nowPage를 요청한 경우.(만약 요청하지 않으면 default값인 1이다.)
	    if(request.getParameter("nowPage")!=null&&
	    		!request.getParameter("nowPage").equals("null")){
	    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    }
	    start = (nowPage*numPerPage)-numPerPage;
    
    //전체 페이지 수
   totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    //전체 블럭 수
   totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
    //현재 블럭
   nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
   //조건 체크
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
	
	//검색
	function search(){
		if(document.FrmkeyField.keyWord.value==""){
			alert("검색어를 입력하지 않으면 검색이 되지않습니다.");
			doucument.FrmkeyField.keyWord.focus();
			return;
		}
		document.FrmkeyField.submit();
	}

	//대분류 선택
	function middlech(i) {
		document.readFrm.CHmiddle.value=i;
		document.readFrm.submit();
	}
	//페이징
	function pageing(page) {
		document.readFrm.nowPage.value=page;
		document.readFrm.submit();
	}
	//블럭
	function block(block) {
		document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	//중분류 클릭시 중분류 data name submit할 form에 저장(추후검색에 사용)
	function middletype(num){
		var txt = "middle"+num
		document.readFrm.middlenum.value=num;
		document.getElementById(txt).middlenum.value=num;
		document.getElementById(txt).keyWord.value="null";
		document.FrmkeyField.keyWord.value="null";
		document.getElementById(txt).submit();
	}
	//readFrm submit용(list에 사용)
	function read(num){
		document.readFrm.num.value=num;
		document.readFrm.submit();
	}
	//처음 목록으로
	function list(){
		document.listFrm.action = "ReviewMgr.jsp";
		document.listFrm.submit();
	}
	//좋아요와 취소(조건을 걸어두었음.)
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
	//평점(조건을 걸어두었음.)
	function scoreee(){
		if(document.scoreFrm.score.value >5){
			alert("5이하의 점수를 입력하세요.");
			return;
		}
		if(document.scoreFrm.score.value<1){
			alert("1이상의 점수를 입력하세요.");
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
	//평점취소	
	function scorecancell(){
		document.scoreFrm.scorecheck.value=2;
		document.scoreFrm.action = "../proc/scoreProc.jsp";
		document.scoreFrm.submit();
		}
	//reply 삽입
	function rpInsert(){
		document.replycommentcheck.action="../proc/replyProc.jsp";
		document.replycommentcheck.submit();
	}
	//reply삭제
	function rpdelete(i){
		document.replycommentcheck.flag.value="delete";
		document.replycommentcheck.replynum.value=i;
		document.replycommentcheck.action="../proc/replyProc.jsp";
		document.replycommentcheck.submit();
	}
	//reply보이게하기
	function rpshoww(){
		var con = document.getElementById("replyDiv");
		if(con.style.display=='none'){
			con.style.display = 'block';
		}else{
			con.style.display = 'none';
		}
	}
	
	//rereply 삽입
	function rprpInsert(i){
		var e ="rereplycommentcheck"+i
		var con = document.getElementById(e);
		con.action="../proc/rereplyProc.jsp";
		con.submit();
	}
	//rereply 삭제
	function reredelete(i,j){ 
		var e = "rereplycommentcheck"+j
		var con = document.getElementById(e);
		con.flag.value="delete";
		con.rereplynum.value=i;
		con.action="../proc/rereplyProc.jsp";
		con.submit();
	}
	//대댓글 클릭 이벤트
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
<!-- 인클루드 할곳 -->
<jsp:include page="../index/Navleft.jsp"/>
<!-- 대/중 분류 -->
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
						for(int i=0;i<mlist.length;i++){//중 분류
					%> 
					<li><form method="post" id="middle<%=i%>" name="middle<%=i%>"> <a href="javascript:middletype('<%=i%>')"><%if(middlenum==i){%><font color="red"><%}%><%=mlist[i] %></font></a>
					<input type="hidden" name="middletype" value="<%=mlist[i]%>">
					<input type="hidden" name="num" value="<%=num%>">
					<input type="hidden" name="nowPage" value="<%=nowPage %>">
					<input type="hidden" name="keyWord" value="<%=keyWord %>">
					<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
					<input type="hidden" name="CHmiddle" value="<%=CHmiddle%>">
					<input type="hidden" name="middlenum" value="<%=middlenum %>">
					</form><!-- middle[i] form 끝 --></li>
					<%}//중 분류 for %>
				</ul>
			</div><!-- logoDiv -->
		</div>
	</div>
<!-- 대/중 분류 끝 -->
<!-- 검색 form 시작 -->
	<div id="search" class="container2">
		<form name="FrmkeyField" method="post" action="ReviewMgr.jsp">
			<ul id="searchLi">
				<li>
					<input name="keyWord" placeholder="검색"><input type="button" value="검색" onclick="javascript:search()">
					<input type="hidden" name="nowPage" value="1">
					<input type="hidden" name="CHmiddle" value="<%=CHmiddle%>">
					<input type="hidden" name="middlenum" value="<%=middlenum %>">
					<input type="hidden" name="num" value="<%=num%>">
				</li>	
			</ul>
		</form>
	</div><!-- searchFrm/ Div -->
<!-- 검색 form 끝 -->
<!-- hot issue 및 게시판 board 출력 -->
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
				if(num==0){//핫이슈 조건문 (게시판의 메인)
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
					maintitle = "제목";
				%>
				<%} %>
				<div style="background-color: #DDDDDD;">
				<ul style="border-top:groove;border-width: 1px;">
					<li><h1><%=maintitle %> : <%=reviewtitle %></h1></li>
				</ul><!-- span으로  -->
					<span style="display:inline-block;width:480px;text-align:left;"><h2>닉 네임 : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=userlist.getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')"><%=userlist.getNickname() %></a></h2></span>
					<span style="display:inline-block;width:480px;text-align:right"> 등록날짜 : <%= reviewdate +" / "+ reviewtime%></span>
					<span style="display:inline-block;border-bottom:groove;border-width: 1px; width:100%;"><br></span><br>
				</div>
				<!-- 좋아요 폼 -->
				<div id="scoreFrmDiv" style="display:inline-block;width:950px;text-align:right; height:120px;">
				<form name="scoreFrm" style="display:inline-block;width:950px;text-align:right;">
					<%if(costumer==0){%>
						좋아요및 평점주기는 <a href="javascript:onclickLoginButton()">로그인</a>후에 가능합니다.
					<%}else{%>
					<%if(likescore==1&&costumer != rvUsernum){ %>
					<input type="image" src = "../css/noheart.png" onclick="javascript:like()" style="width: 40px; height: 40px; padding: 0px; vertical-align: middle;  border:0; outline:0; background-color:#FFF;">
					<%}else if(likescore==2&&costumer != rvUsernum){ %>
					<input type="image" src = "../css/heart.png" onclick="javascript:like()" style="width: 40px; height: 40px; padding: 0px; vertical-align: middle;  border:0; outline:0; background-color:#FFF;"><%} %>
					<font style="font-size: 20px; vertical-align: middle;"></font><%if(scorecheck==1&&costumer != rvUsernum) {%>
					<font style="font-size: 20px; vertical-align: middle;">평점 :</font> <input type="number" name="score" min="1" max="5" value="0" style="width: 50px; height: 40px; padding: 0px; font-size: 1em; vertical-align: middle;">
					<input type="button" value="평점주기" onclick="javascript:scoreee()" style="width: 100px; height: 40px; padding: 0px; font-size: 20px; vertical-align: middle;">
					<%}else if(scorecheck==2&&costumer != rvUsernum){ %><input type="button" value="평점취소" onclick="javascript:scorecancell()" style="width: 100px; height: 40px; padding: 0px; font-size: 20px; vertical-align: middle;"><%} %>
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
			<!-- 좋아요 폼 끝 -->
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
			<span style="display:inline-block;width:300px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;"><a href="javascript:rpshoww();">댓글보기</a><font color="red">(<%=rpTotal %>)</font></span>
			<span style="display:inline-block;width:600px;text-align:right;margin:5px;padding: 5px;vertical-align: middle;">
			총 좋아요 : <%=rMgr.getReviewLikecount(reviewnum) %>개 / 평균 평점 : <%if(rMgr.ReviewAverageRation(reviewnum)==0) {%>0<%} %><fmt:formatNumber value="<%=rMgr.ReviewAverageRation(reviewnum) %>" pattern=".00"/> 점</span>
<!-- 댓글부분 시작 -->
			<form method="post" name="replycommentcheck" style="display:inline-block;width:950px;">
			<span style="display:inline-block;width:900px;text-align:left;margin:5px;padding: 5px;"><h3><%if(costumer==0){%>로그인 후에 이용할수 있습니다.<%}else{ out.print("닉 네임: "+uBean.getNickname()); }%></h3></h1></span>
				<span style="display:inline-block;width:900px;text-align:left;margin:5px;padding: 5px;">
					<textarea name="replycomment" cols="72" rows="2" maxlength="1000" style="height: 50px;vertical-align: middle;resize:none;"></textarea>
					<input type="button" value="입력완료" onclick="javascript:rpInsert()" style="width:80px;height: 50px;vertical-align: middle;border-radius:0;border:0;">
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
	<!-- 댓글좋아요 -->
	<span style="display:inline-block;width:200px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;">
	닉 네임 : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=rpUser.getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')">
			<%=rpUser.getNickname() %></a>>></span>
	<!-- <input type="button" value="대댓글 (<%//=rprpTotal %>)" onclick="javascript:rpshowww('<%//=i%>')"> -->
	<span style="display:inline-block;width:300px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;"><%=replycomment %></span>
	 <span style="display:inline-block;width:300px;text-align:right;margin:5px;padding: 5px;vertical-align: middle;">
	 <button onclick="javascript:rpshowww('<%=i%>');" style="width:70px;height:30px;background-color:#FFF;">답글(<%=rprpTotal %>)</button>
	 <%if(costumer==0){%>
	<%}else{%>
	<%if(rplove==1&&costumer != rpusernum){ %><input type="image" src = "../css/noheart.png" onclick="javascript:relike('<%=i%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;">
	<%}else if(rplove==2&&costumer != rpusernum){ %><input type="image" src = "../css/heart.png" onclick="javascript:relike('<%=i%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;"><%} if(costumer == rpusernum||grant==2){%><input type="image" src = "../css/deleteButton.png" onclick="javascript:rpdelete('<%=replynum%>')" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#EEEEEE;"><%} %>
	<%}%>총 좋아요 : <%=rplikecount %>개</span>
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
		<!-- 대댓글 부분시작 -->
		<div id="rereply<%=i %>" style="display:none; border-top:groove; border-bottom:groove;width:100%;float:left;background-color: #DDDDDD;">
		<%if(costumer!=0||grant==2){ %>
			<span style="display:inline-block;width:800px;text-align:left;margin:5px;padding: 5px;vertical-align: middle;">
			닉 네임: <%=uBean.getNickname()%></span>
			<form method="post" name="rereplycommentcheck" id="rereplycommentcheck<%=i%>" style="display:inline-block;width:800px;text-align:right;">
			<span style="display:inline-block;width:800px;text-align:left;margin:5px;padding: 5px;">
				<textarea name="rereplaycomment" cols="72" rows="2" maxlength="1000" style="width:600px;height: 50px;vertical-align: middle;resize:none;"></textarea>
				<input type="button" value="입력완료" onclick="javascript:rprpInsert('<%=i%>')" style="height: 50px;vertical-align: middle;">
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
			<%}//if 대댓글if%>
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
			닉네임 : <a href="javascript:window.open('reviewUserdata.jsp?usernum=<%=rMgr.getUser(rereplyusernum).getUsernum() %>'
			,'profile','width=700,height=550,status=no,toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no')">
			<%=rereuser %></a> >> <%=rereplycomment %> 
			</span>
			<span style="display:inline-block;width:390px;text-align:right;margin:5px;padding: 5px;">
			작성일 : <%=rereplydata %> <%if(costumer==rereplyusernum||grant==2){ %><input type="image" src = "../css/deleteButton.png" onclick="javascript:reredelete('<%=rereplynum%>','<%=i%>');" style="width: 20px; height: 20px; padding: 0px; border:0; outline:0; vertical-align: middle;background-color:#DDDDDD;"><%} %>
			</span>
			<%}//대댓글 for
			}//대댓글if %>
				</div><!-- 대댓글Div -->
			</div><!-- divmannn -->
		<%}//for 댓글
		}//if 댓글%>	
	<!-- 대댓글 부분 끝 -->
<!-- 댓글 부분 끝 -->
</div><!-- 댓글Div -->
</div>
<!-- 게시판 출력 끝 -->
<!-- 게시판 List 시작 -->
<div id="page2" class="container2">
	<div id="content2" style="border-top: 3px solid rgba(0,0,0,.1);">
		<div class="title2">
				<br/><br/>
				<div style="border-bottom: 3px solid rgba(0,0,0,.1);">
				<h2>리뷰 게시글 목록</h2>
				<br/><br/>
				</div>
			<ul class="style3">
			<%
				String mddlelist = mlist[middlenum]; 
				Vector<ReviewBoardBean> vlist = rMgr.getBoardList(keyWord, start, end,mddlelist);
				int listSize1 = totalRecord-start;
				if(vlist.isEmpty()) {%>
				<li class="first2">
					<h3>등록 된 게시물이 없습니다</h3>
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
					<span style="float:right;width:280px;text-align: right;"><font size="2">작성자 : <%=udBean.getNickname() %>&nbsp&nbsp 날짜 : <%=rbBean.getReviewdate() %>
					<%if(costumer==rbBean.getUsernum()||grant==2){%><a href="javascript:updatereview('<%=listnum%>')">수정</a>/<a href="javascript:deletereview('<%=listnum%>')">삭제</a><%} %></font>
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
<!-- 게시판 List 끝 -->
<!-- page처리 시작 -->
<div>
	<span style="float:left;width:500px;text-align:center;">
	<%
		//페이징에 표시될 시작변수 및 마지막 변수
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		int pageEnd = ((pageStart+pagePerBlock)<totalPage)?(pageStart+pagePerBlock):totalPage+1;
		%>
		<%if(totalPage!=0){%>
			<!-- 이전 블럭 -->
			<%if(nowBlock>1) { %>
				<a href="javascript:block('<%=nowBlock-1%>')">&#60;&#60;</a>
			<%} %>&nbsp;
			<!-- 페이징     -->
			<%for(; pageStart<pageEnd; pageStart++) {%>
				<font size="5px"><a href="javascript:pageing('<%=pageStart %>')">
				<%if(nowPage==pageStart) {%>
				<font color="red">[<%=pageStart %>]</font>
				<%}else{%>
				[<%=pageStart %>]</a></font>
				<%}//else %>
			<%}//---for %>&nbsp;
			<!-- 다음 블럭 -->
			<%if(totalBlock>nowBlock) { %>
				<a href="javascript:block('<%=nowBlock+1%>')">>></a>
			<%} %>
		<%} //---if%>
		</span>
		
		<span style="float:left;width:500px;text-align:right;">
		<%if(costumer!=0){ %><a href="javascript:writer();">[글쓰기]</a><%} %>
		<a href="javascript:list()">[목록]</a>
		</span>
</div>
<!-- page 끝 -->
</div><!-- wrapperDiv -->
<!-- 게시판 글쓰기용 form -->
<form method="post" name="writerFrm">
	<input type="hidden" name="middlename" value="<%=mlist[middlenum] %>">
	<input type="hidden" name="num" value="0">
	<input type="hidden" name="flag" value="insert">
</form>
<!-- 게시판 글쓰기용 form 끝 -->
<!-- 게시판 읽기용 -->
<form method="post" name="readFrm">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="nowPage" value="<%=nowPage %>">
	<input type="hidden" name="keyWord" value="<%=keyWord %>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
	<input type="hidden" name="CHmiddle" value="<%=CHmiddle %>">
	<input type="hidden" name="middlenum" value="<%=middlenum %>">
</form>
<!-- 처음으로 페이지 -->
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>
<!-- 읽기용 끝 -->
</body>
</html>