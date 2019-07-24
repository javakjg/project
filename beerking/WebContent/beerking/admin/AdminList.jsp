<%@page import="beerking.UserDataBean"%>
<%@page import="beerking.ReviewBoardBean"%>
<%@page import="beerking.BeerBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="beerking.AdminMgr"/>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%request.setCharacterEncoding("EUC-KR");
String email = (String)session.getAttribute("emailKey");
UserDataBean uBean = uMgr.selectUser(email);
%>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
function beerchange(e){
	var change_Ale = ["Pale Ale","Porter","Stout","Altbier","Altbier","Steinbier","Dampfbier","Weissbier","Kellerbier","Roggenbier","Belgian Ale","Flanders Red Ale"];
	var change_Lager = ["Pale Lager", "Helles", "Dark Lager", "Pilsener", "Dunkel", "Schwarzbier", "Export", "Steam Beer", "Bock", "Rauchbier", "Vienna Lager", "Marzen"];
	var target = document.getElementById("change");
	
	if(e.value == "Ale") var A = change_Ale;
	else if(e.value == "Lager") var A = change_Lager;
	
	target.options.length = 0;
	
	  for (x in A) {
		    var opt = document.createElement("option");
		    opt.value = A[x];
		    opt.innerHTML = A[x];
		    target.appendChild(opt);
 	 } 
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function checkInputs() {
	if(document.frm.adminbeercomment.value==""||document.frm.beernum.value==""){
		alert("맥주 선택 또는 내용이 입력되지 않았습니다.");
		document.frm.contents.focus();
		return;
	}
	document.frm.submit();
}

function checkInputs2() {
	if(document.frm2.reviewnum.value==""){
		alert("리뷰선택 또는 리뷰내용이 입력되지 않았습니다.");
		return;
	}
	document.frm2.submit();
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
<%if(uBean.getUsergrant()==2){%>
<! -------------------------------------------------------------DB추가 시작--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold1">
			<a href="#"><h2 align="center"><font size="6">DB 추가</font></h2></br></a>
			<ul id="middle1">
				<li>
					<form method="post" action="../proc/AdminInsertProc.jsp" enctype="multipart/form-data">
							<font size="5" bold>맥주영어이름</font><br><p><input type="text" name="beerEname" style="width:350px; height:50px;" value=" "></p></br></br>
							<font size="5" bold>맥주한글이름</font><br><p><input type="text" style="width:350px; height:50px;" name="beerKname" value=" "></p></br></br>
							<font size="5" bold>대 분류 :   </font><select name="typebig" onchange = "beerchange(this)">
													  	<option>분류 선택</option>
  													  	<option value="Ale">Ale</option>
  													  	<option value="Lager">Lager</option>
													  </select></br></br>
							<font size="5" bold>소 분류 :   </font><select name="typesmall" id = "change">
													 <option>종류 선택</option>
											  		</select></br></br>
							<font size="5" bold>도수 ex) 4.5</font><input type="text" style="width:350px; height:50px;" name = "alchol"></br></br>
							<font size="5" bold>회사</font><input type="text" style="width:350px; height:50px;" name = "company"></br></br>
							<font size="5" bold>나라</font><input type="text" style="width:350px; height:50px;" name = "country"></br></br>
							<font size="5" bold>맥주 사진</font><input type="file" name = "filename"></br></br>
							<p><input type="submit" class="button-style1" value="등록">
							<input type="reset" class="button-style1" value="리셋"></p>
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
<! -------------------------------------------------------------DB추가 끝--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------최고맥주 시작--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold2">
			<a href="#"><h3 align="center"><font size="6">이번달 최고의맥주</font></h3></br></br></br></a>
			<ul id="middle2">
				<li>
					<div class="8u">
						<section id="fbox1">
							<h2 align="center"><font size="5">내가 좋아요 한 맥주</font></h2>
							<form name="frm" method="post" action="../proc/AdminInsertmProc.jsp">
							<ul class="style99">
							<%	Vector<BeerBean> vlist22 = mgr.getMaxlikeBeerNum();
								if(vlist22.isEmpty()){
							%>
							<li>
								<p></p>
							</li>
							<%}else{
								for(int i =0; i<vlist22.size(); i++){
								BeerBean bean = vlist22.get(i);
							%>
								<li>
									<p><input type="radio" name="beernum" size="9" maxlength="20" value="<%=bean.getBeernum() %>"></p>
									<p><img src="../beerimg/<%=bean.getFilename()%>"></p>
									<font size="5" bold>맥주 영어이름</br><%=bean.getBeerEname() %></font></br></br>
									<font size="5" bold>맥주 한글이름</br><%=bean.getBeerKname() %></font></br></br></br></br></br>
							<%}//--for
							}//--for and else%>
									<p><input type="radio" name="beernum" size="9" maxlength="20" value="0">초기화</p>
									<p><font size="5" bold>관리자 코멘트</font><textarea name="adminbeercomment" style="resize: none;" cols="25" rows="15"></textarea></p></br></br>
									<p><input type="button" value="글올리기" onclick="checkInputs()"></p></br>
								</li>
							</ul>
							</form>
						</section>
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
<! -------------------------------------------------------------최고맥주 끝--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------최고리뷰 시작-------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold2">
			<a href="#"><h3 align="center"><font size="6">이번달 최고의리뷰</font></h3></br></br></br></a>
			<ul id="middle2">
				<li>
					<div class="8u">
						<section id="fbox1">
							<h2 align="center"><font size="5">내가 좋아요 한 리뷰</font></h2>
							<form name="frm2" method="post" action="../proc/AdminInsertProc2.jsp">
							<ul class="style99">
								<%
									Vector<ReviewBoardBean> vlist11 = mgr.getMaxlikeReview();
									for(int i =0; i<vlist11.size(); i++){
									ReviewBoardBean bean = vlist11.get(i);
								%>
								<li>
									<p><input type="radio" name="reviewnum" size="9" maxlength="20" value="<%=bean.getReviewnum() %>"></p>
									<p><%if(!bean.getFilename().equals("첨부파일이 없습니다.")){%><img src="../userimg/<%=bean.getFilename() %>"><%}else{%>첨부파일이 없습니다.<%}%></p>
									<font size="5" bold>리뷰 제목 : <%=bean.getReviewtitle() %></font>
								<%}//-for %>
									</br></br>
									<p><input type="radio" name="reviewnum" size="9" maxlength="20" value="0">초기화</p>
									<p><input type="button" value="글올리기" onclick="checkInputs2()"></br>

								</li>
							
							</ul>
							</form>
						</section>
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
<! -------------------------------------------------------------최고리뷰 시작-------------------------------------------------------------------------------- !>
<%}else{%>
	<h1 align="center"><font size="7" color="white">관리자만 볼 수 있는 페이지 입니다.</font></h1><br><br><br><br><br><br>
<%}%>
</div><!-- contentbox -->
</body>
</html>