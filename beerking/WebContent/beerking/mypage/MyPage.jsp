<%@page import="beerking.TrandBean"%>
<%@page import="beerking.ReplyBean"%>
<%@page import="beerking.ReviewBoardBean"%>
<%@page import="beerking.BeerBean"%>
<%@page import="beerking.UserDataBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<jsp:useBean id="MyPageMgr" class = "beerking.MyPageMgr"/>
<jsp:useBean id="tMgr" class="beerking.TrandMgr"/>
<%	
	String email = (String)session.getAttribute("emailKey");
	UserDataBean uBean = uMgr.selectUser(email);
	request.setCharacterEncoding("EUC-KR");
	Vector<BeerBean> vlist = MyPageMgr.getbeer(uBean.getUsernum());
	Vector<ReviewBoardBean> vlist1 = MyPageMgr.getReviewlike(uBean.getUsernum());
	Vector<ReplyBean> vlist2 = MyPageMgr.getMyReply(uBean.getUsernum());
	int likecount = 0;
	int repcount = 0;
	double revGrade = 0;
	int totalRecord = 0;//총게시물 수
	int numPerPage = 5;//페이지당 레코드 수 5, 10, 15, 30
	int pagePerBlock = 15;//블럭당 페이지 수
	int totalPage = 0;//총 페이지 수 = (올림, 절상)총 게시물 수/페이지당 레코드 수
	int totalBlock = 0;// 총 블럭 수 = (올림) 총 페이지수 / 블럭당 페이지 수	
	int nowPage = 1; //현재 페이지
	int nowBlock = 1; // 현재 블럭
	
	//page에 보여질 게시물 개수
		/*if(request.getParameter("numPerPage")!=null&&!request.getParameter("numPerPage").equals("null"))
		{
			numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
		}*/
		
		int start = 0;//tblBoard select 시작번호
		int end = numPerPage; //10개
		
		totalRecord = MyPageMgr.getTotalCount(uBean.getUsernum());

		 //nowPage를 요청한 경우, 
	    if(request.getParameter("nowPage")!=null)
	    {
	    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
	    }
	    start = (nowPage*numPerPage)-numPerPage;
	    
	    //전체 페이지 수
	    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);//double실수 계산 후 int로 정수변환 [1.0]블럭을 [1] 블럭으로
	    
	    //전체 블럭 수
	    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	    
	    //현재 블럭 값
	    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	    
	    int moreBeer = 3;
	    
	    if(request.getParameter("moreBeer") != null){
	    	moreBeer += Integer.parseInt(request.getParameter("moreBeer"));
	    }
	    
		int moreReview = 3;
	    
	    if(request.getParameter("moreReview") != null){
	    	moreReview += Integer.parseInt(request.getParameter("moreReview"));
	    }
	
%>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

function pageing(page)
{
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}
function block(block)
{
	document.readFrm.nowPage.value=<%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();
}

function list()
{
	document.listFrm.action = "MyPage.jsp";
	document.listFrm.submit();
}
function numPerFn(numPerPage)
{
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit();
}
function read(num)
{
	document.readFrm.num.value = num;	
	document.readFrm.action = "read.jsp";
	document.readFrm.submit();
}
$(document).ready(function(){
    $("#fold1>a").click(function(){
        var submenu = $(this).next("ul");
        var closemenu2 = $("#middle2");
        var closemenu3 = $("#middle3");
        var closemenu4 = $("#middle4");
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
            closemenu2.slideUp();
            closemenu3.slideUp();
            closemenu4.slideUp();
        }
    });
    $("#fold2>a").click(function(){
        var submenu = $(this).next("ul");
        var closemenu1 = $("#middle1");
        var closemenu3 = $("#middle3");
        var closemenu4 = $("#middle4");
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
            closemenu1.slideUp();
            closemenu3.slideUp();
            closemenu4.slideUp();
        }
    });
    $("#fold3>a").click(function(){
        var submenu = $(this).next("ul");
        var closemenu1 = $("#middle1");
        var closemenu2 = $("#middle2");
        var closemenu4 = $("#middle4");
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
            closemenu1.slideUp();
            closemenu2.slideUp();
            closemenu4.slideUp();
        }
    });
    $("#fold4>a").click(function(){
        var submenu = $(this).next("ul");
        var closemenu1 = $("#middle1");
        var closemenu2 = $("#middle2");
        var closemenu3 = $("#middle3");
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
            closemenu1.slideUp();
            closemenu2.slideUp();
            closemenu3.slideUp();
        }
    });
});
</script>
	<link rel="stylesheet" href="../css/MyPage-skel-noscript.css" />
	<link rel="stylesheet" href="../css/MyPage-style.css" />
	<link rel="stylesheet" href="../css/MyPage-style-desktop.css" />
<style> 
ul[id^="middle"]{
	display: none;
}
ul,li{
	list-style:none;
}
</style>
</head>
<body bgcolor="#202020">
<div id="content-box">
<! -------------------------------------------------------------로고--------------------------------------------------------------------------------- !>
<div id="header-wrapper">
	<div class="container">
		<div id="header">
			<div id="logo">
				<h1 style="text-align:center;"><a href="../beerdb/BeerList.jsp"><img src="../css/Beerking-logo.png" width="500" height = "250"></a></h1>	
			</div>
		</div>
	</div>
</div>	
<%if(email!=null) {%>
<! -------------------------------------------------------------내 정보 시작--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold1">
			<a href="#"><h2 align="center"><font size="6">내 정보</font></h2></br></a>
			<ul id="middle1">
				<li>
					<form id="regFrm" method="post" action="../proc/UserUpdateProc.jsp">
							<font size="5" bold>아이디</font><br><p><input name="email" style="width:350px; height:50px;" value="<%=uBean.getEmail()%>" disabled="disabled"></p></br></br>
							<font size="5" bold>비밀번호</font><br><p><input type="password" style="width:350px; height:50px;" name="pwd" value="<%=uBean.getPwd()%>"></p></br></br>
							<font size="5" bold>이름</font><br><p><input name="name" style="width:350px; height:50px;" value="<%=uBean.getName()%>" disabled="disabled"></p></br></br>
							<font size="5" bold>닉네임</font><br><p><input name="nickname" style="width:350px; height:50px;" value="<%=uBean.getNickname()%>"></p></br></br>
							<font size="5" bold>주소</font><br><p><input name="address" style="width:350px; height:50px;" value="<%=uBean.getAddress()%>"></p></br></br>
							<font size="5" bold>전화번호</font><br><p><input name="tel" style="width:350px; height:50px;" value="<%=uBean.getTel()%>"></p>
							<input type="hidden" name="usernum" value="<%=uBean.getUsernum()%>">
							<p><input type="submit" class="button-style1" value="수정완료"></p>
					</form>
				</li>
			</ul>
		</li>
	</ul>
</div>		
</section>
					</div>					
				</div>
			</div>
<! -------------------------------------------------------------내 정보 끝--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------즐겨찾기 시작--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="">
						<!--  section id="pbox2"-->
<div id="foldDiv">
	<ul>	
		<li id="fold2">				
			<img  src = "../css/heart.png" width = "50" height = "50" style ="margin-left: -200; margin-bottom: -35;"><a href="#"><h2 align="center"><font size="6">즐겨찾기</font></h2></br></a>
			<ul id="middle2" <%if(moreBeer!=3||moreReview!=3){%>style="display: block; width: 650px;"<%}%>>

					<div style="width:700px;">
						
						<div style="width:650px; float:left;margin:auto">
							<h2 align="center"><font size="5" color ="pink">내가 좋아요 한 맥주</font></h2></br>
						</div>

							<%if(vlist.isEmpty()){%>

							<%}else{
								for(int i=0; i<vlist.size()&&i<moreBeer; i++){
									BeerBean bBean = vlist.get(i);
							%>
							<div style ="width:200px; float:left; margin:15;">
								<table  style="width:200px; height:200px; align:center;">
								<tr>
									<td><a href="../beerdb/BeerSearch.jsp?beerName=<%=bBean.getBeerEname() %>"><img src="../beerimg/<%=bBean.getFilename()%>" ></a>
									<%=bBean.getBeerEname() %></td>						
								</tr>
								</table>
							</div>
							<%}//--for
							}//--for and else%>
						</div>						
							<input type="button" value="더 보기" OnClick="location.href ='MyPage.jsp?moreBeer=<%=moreBeer%>'" class="button-style">	
	
					<div style="width:700px;">
						<div style="width:650px; float:left;margin:auto">
							<h2 align="center"><font size="5" color ="pink">내가 좋아요 한 리뷰</font></h2></br>
						</div>
							<%if(vlist.isEmpty()){%>
							
							<%}else{
								for(int i=0; i<vlist1.size()&&i<moreReview; i++){
									ReviewBoardBean rBean = vlist1.get(i);
							%>
							<div style ="width:200px; float:left; margin:15;">
								<table  style="width:200px; height:200px; align:center;">
								<tr>
									<td>
									<a href="../reviewBoard/ReviewMgr.jsp?num=<%=rBean.getReviewnum()%>"><img src="../beerimg/<%=rBean.getFilename()%>"></a>
									
									</td>
								</tr>
								<tr align="center">
									<td>
									<%=rBean.getReviewtitle() %>
									</td>
								</tr>
								</table>
								</div>
							<%}//--for
							}//--for and else%>
							
							
							
							<input type="button" value="더 보기" OnClick="location.href ='MyPage.jsp?moreReview=<%=moreReview%>'" class="button-style">
						
					</div>		
			</ul>
		</li>
	</ul>
</div>	

					
	<!--/section-->
					</div>
				</div>
			</div>
<! -------------------------------------------------------------즐겨찾기 끝--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------내가 쓴 리뷰 시작------------------------------------------------------------------------------------ !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold3">
			<a href="#"><h2 align="center"><font size="6">나의 리뷰 및 댓글</font></h2></br></a>
			<ul id="middle3" <%if(request.getParameter("nowPage")!=null){%>style="display: block;"<%}%>>
				<li>
					<div align="center"><br/>
					<h2>내가 쓴 리뷰</h2><br/>
						<table width="700">
							<tr>
							</tr>
						</table>
						<table>
							<tr>
								<td align="center" colspan="2">
									<table cellspacing="0">
									<tr align="center" bgcolor="#D0D0D0">
										<td width="250">제 목</td>
										<td width="150">날 짜</td>
										<td width="100">좋아요</td>
										<td width="100">평점</td>
									</tr>
									<% 
										Vector<ReviewBoardBean> vlist3 = MyPageMgr.getMyReview(uBean.getUsernum(), start, end);
										int listSize = vlist3.size();
										if(vlist3.isEmpty())
										{
									%>
										<tr align="center"><td colspan="4">등록하신 리뷰가 없습니다.</td></tr>
									<%}else{%>
									<%
										for(int i=0; i<numPerPage; i++)
										{
											if(i==listSize) break;
											ReviewBoardBean rBean = vlist3.get(i);
									%>
											<tr align="center">
												<td><%if(rBean.getReviewstate()==0){%><a href="../reviewBoard/ReviewMgr.jsp?num=<%=rBean.getReviewnum()%>"><%}else{%>(삭제됨)<%} %><%= rBean.getReviewtitle() %></a></td>
												<td><%= rBean.getReviewdate() %></td>
												<td><%= likecount = MyPageMgr.getlike(rBean.getReviewnum())%>
												<td><%= revGrade = MyPageMgr.getrevGrade(rBean.getReviewnum()) %>
											</tr>
										<%}//--for %>
									<%}//--else %>
									</table>
								</td>
							</tr>
							<tr>
								<td align="center"><%
										//페이징에 표시 될 시작변수 및 마지막 변수
										int pageStart = (nowBlock-1)*pagePerBlock+1;
										int pageEnd = ((pageStart+pagePerBlock)<totalPage)?(pageStart+pagePerBlock):totalPage+1;
									 %>
									 <%if(totalPage!=0){%>
									<!-- 이전블럭 -->
									<%if(nowBlock>1){%>
										<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
									<%}%>&nbsp;
									<!-- 페이징 -->
									<%for(;pageStart<pageEnd; pageStart++){%>
										<a href="javascript:pageing('<%=pageStart%>')">
										<%if(nowPage==pageStart){%>
											<font color="red"><%}%>
											[<%=pageStart %>]</a>
										<%if(nowPage==pageStart){%></font><%}%>
									<%}//--for %>&nbsp;
									<!-- 다음블럭 -->
									<%if(totalBlock>nowBlock){%>
										<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
									<%}%>
									<%}//--if%></td>
							</tr>
							<tr>
								<td colspan="2"><br/><br/></td>
							</tr>
						</table>
					<hr width="350"/>
					</div>
					<div align="center"><br/>
					<h2>내가 쓴 댓글</h2><br/>
					<table>
						<tr>
							<td align="center" colspan="2">
								<table cellspacing="0">
								<%if(vlist2.isEmpty()){%>
									<tr align="center"><td align="center">등록하신 댓글이 없습니다.</td></tr>
								<%}else{%>
								<% 
									for(int i=0; i<vlist2.size(); i++){
										ReplyBean bean2 = vlist2.get(i);
								%>
								<tr align="center" bgcolor="#D0D0D0">
									<td width="550"> 글 제목 : <a href="../reviewBoard/ReviewMgr.jsp?num=<%=bean2.getReviewnum()%>"><%=bean2.getReviewtitle() %></a></td>
									<td></td>
								</tr>
								<tr>
								</tr>
								<tr align="center" bgcolor="#D0D0D0">
									<td width="550"> 댓글 내용</td>
									<td width="100"> 좋아요</td>
								</tr>			
								<tr align="left">
									<td align="center"><%=bean2.getReplycomment() %></td>
									<td align="center"><%=repcount = MyPageMgr.getReLike(bean2.getReplynum()) %></td>
								</tr>
								<%}//--for
								}//--else%>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="2"><br/><br/></td>
						</tr>
					</table>
						<hr width="350"/>
						<form name="listFrm" method="post">
							<input type="hidden" name="reload" value="true">
							<input type="hidden" name="nowPage" value="1">
						</form>
						
						<form name="readFrm">
							<input type="hidden" name="num">
							<input type="hidden" name="nowPage" value="">
							<input type="hidden" name="numPerPage" value="">
						</form>
					</div>
				</li>
			</ul>
		</li>
	</ul>
</div>	
</section>
				</div>
			</div>
</div>
<! -------------------------------------------------------------내가 쓴 리뷰 끝------------------------------------------------------------------------------------ !>
<! -------------------------------------------------------------통계 시작------------------------------------------------------------------------------------ !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="">
						<!--  section id="pbox2"-->
<div id="foldDiv">
	<ul>	
		<li id="fold4">				
			<a href="#"><h2 align="center"><font size="6">맥주 검색 통계</font></h2></br></a>
			<ul id="middle4" style="width: 650px;">
				<%TrandBean tBean = tMgr.selectTrand(uBean.getUsernum());%>
					<div id="chart_div" style="width:600px; height: 400px;"></div>
					<div id="chart_div2" style="width:600px; height: 400px;"></div>
					<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
					<script>
					google.charts.load('current', {'packages':['corechart']});
					google.charts.setOnLoadCallback(drawVisualization);
					function drawVisualization() { 
						var data = google.visualization.arrayToDataTable([
								['맥주 종류', 'Pale Ale', 'Porter', 'Stout', 'Altbier', 'Kolsch', 'Steinbier', 
									'Dampfbier', 'Weissbier', 'Kellerbier', 'Roggenbier', 'Belgian Ale', 'Flanders Red Ale'],
								['에일',  <%=tBean.getPaleAle()%>, <%=tBean.getPorter()%>, <%=tBean.getStout()%>, <%=tBean.getAltbier() %>, <%=tBean.getKolsch()%>, <%=tBean.getSteinbier()%>, 
								<%=tBean.getDampfbier()%>, <%=tBean.getWeissbier()%>, <%=tBean.getKellerbier()%>, <%=tBean.getRoggenbier()%>, <%=tBean.getBelgianAle()%>, <%=tBean.getFlandersRedAle()%>]
							]);
						var options = {
								title : '',
								seriesType: 'bars',
								bar: {groupWidth: '80%'},
								width: 600,
				                height: 400		                
							};
						var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
						chart.draw(data, options);
					}
					
					</script>
					<script>
					google.charts.load('current', {'packages':['corechart']});
					google.charts.setOnLoadCallback(drawVisualization2);
					function drawVisualization2() {
						var data2 = google.visualization.arrayToDataTable([
							['맥주 종류', 'Pale Lager', 'Helles', 'Dark Lager', 'Pilsener', 'Dunkel', 'Schwarzbier', 
								'Export', 'Steam Beer', 'Bock', 'Rauchbier', 'Vienna Lager', 'Marzen'],
							['라거',  <%=tBean.getPaleLager()%>, <%=tBean.getHelles()%>, <%=tBean.getDarkLager()%>, <%=tBean.getPilsener()%>, <%=tBean.getDunkel()%>, <%=tBean.getSchwarzbier()%>, 
							<%=tBean.getExport()%>, <%=tBean.getSteamBeer()%>, <%=tBean.getBock()%>, <%=tBean.getRauchbier()%>, <%=tBean.getViennaLager()%>, <%=tBean.getMarzen()%>]		
						]);
						var options2 = {
								title : '',
								seriesType: 'bars',
								bar: {groupWidth: '80%'},
								width: 600,
				                height: 400
							};
						var chart2 = new google.visualization.ComboChart(document.getElementById('chart_div2'));
						chart2.draw(data2, options2);
					}
					</script>
			</ul>
		</li>
	</ul>
</div>	

					
	<!--/section-->
					</div>
				</div>
			</div>
<! -------------------------------------------------------------통계 끝------------------------------------------------------------------------------------ !>
<! -------------------------------------------------------------관리자 페이지 시작------------------------------------------------------------------------------------ !>

<%
	if(uBean.getUsergrant() == 2){
%>
	<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
	<h2 align="center"><a href="../admin/AdminList.jsp"><font size="6" color="red">관리자</a></font></h2>
	</section>
				</div>
			</div>
</div>
<%
	}
%>
<%}else{%>
	<h1 align="center"><font size="7" color="white">로그인을 해주세요.</font></h1><br><br><br><br><br><br>
<%} %>
<! -------------------------------------------------------------관리자 페이지 끝------------------------------------------------------------------------------------ !>
</div><!-- contentbox -->
</body>
</html>