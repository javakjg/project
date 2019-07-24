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
		alert("���� ���� �Ǵ� ������ �Էµ��� �ʾҽ��ϴ�.");
		document.frm.contents.focus();
		return;
	}
	document.frm.submit();
}

function checkInputs2() {
	if(document.frm2.reviewnum.value==""){
		alert("���伱�� �Ǵ� ���䳻���� �Էµ��� �ʾҽ��ϴ�.");
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
<! -------------------------------------------------------------�ΰ�--------------------------------------------------------------------------------- !>
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
<! -------------------------------------------------------------DB�߰� ����--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold1">
			<a href="#"><h2 align="center"><font size="6">DB �߰�</font></h2></br></a>
			<ul id="middle1">
				<li>
					<form method="post" action="../proc/AdminInsertProc.jsp" enctype="multipart/form-data">
							<font size="5" bold>���ֿ����̸�</font><br><p><input type="text" name="beerEname" style="width:350px; height:50px;" value=" "></p></br></br>
							<font size="5" bold>�����ѱ��̸�</font><br><p><input type="text" style="width:350px; height:50px;" name="beerKname" value=" "></p></br></br>
							<font size="5" bold>�� �з� :   </font><select name="typebig" onchange = "beerchange(this)">
													  	<option>�з� ����</option>
  													  	<option value="Ale">Ale</option>
  													  	<option value="Lager">Lager</option>
													  </select></br></br>
							<font size="5" bold>�� �з� :   </font><select name="typesmall" id = "change">
													 <option>���� ����</option>
											  		</select></br></br>
							<font size="5" bold>���� ex) 4.5</font><input type="text" style="width:350px; height:50px;" name = "alchol"></br></br>
							<font size="5" bold>ȸ��</font><input type="text" style="width:350px; height:50px;" name = "company"></br></br>
							<font size="5" bold>����</font><input type="text" style="width:350px; height:50px;" name = "country"></br></br>
							<font size="5" bold>���� ����</font><input type="file" name = "filename"></br></br>
							<p><input type="submit" class="button-style1" value="���">
							<input type="reset" class="button-style1" value="����"></p>
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
<! -------------------------------------------------------------DB�߰� ��--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------�ְ���� ����--------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold2">
			<a href="#"><h3 align="center"><font size="6">�̹��� �ְ��Ǹ���</font></h3></br></br></br></a>
			<ul id="middle2">
				<li>
					<div class="8u">
						<section id="fbox1">
							<h2 align="center"><font size="5">���� ���ƿ� �� ����</font></h2>
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
									<font size="5" bold>���� �����̸�</br><%=bean.getBeerEname() %></font></br></br>
									<font size="5" bold>���� �ѱ��̸�</br><%=bean.getBeerKname() %></font></br></br></br></br></br>
							<%}//--for
							}//--for and else%>
									<p><input type="radio" name="beernum" size="9" maxlength="20" value="0">�ʱ�ȭ</p>
									<p><font size="5" bold>������ �ڸ�Ʈ</font><textarea name="adminbeercomment" style="resize: none;" cols="25" rows="15"></textarea></p></br></br>
									<p><input type="button" value="�ۿø���" onclick="checkInputs()"></p></br>
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
<! -------------------------------------------------------------�ְ���� ��--------------------------------------------------------------------------------- !>
<! -------------------------------------------------------------�ְ��� ����-------------------------------------------------------------------------------- !>
<div id="wrapper">
			<div class="container" id="page-wrapper" align="center">
				<div class="6u">
						<section id="pbox2">
<div id="foldDiv">
	<ul>
		<li id="fold2">
			<a href="#"><h3 align="center"><font size="6">�̹��� �ְ��Ǹ���</font></h3></br></br></br></a>
			<ul id="middle2">
				<li>
					<div class="8u">
						<section id="fbox1">
							<h2 align="center"><font size="5">���� ���ƿ� �� ����</font></h2>
							<form name="frm2" method="post" action="../proc/AdminInsertProc2.jsp">
							<ul class="style99">
								<%
									Vector<ReviewBoardBean> vlist11 = mgr.getMaxlikeReview();
									for(int i =0; i<vlist11.size(); i++){
									ReviewBoardBean bean = vlist11.get(i);
								%>
								<li>
									<p><input type="radio" name="reviewnum" size="9" maxlength="20" value="<%=bean.getReviewnum() %>"></p>
									<p><%if(!bean.getFilename().equals("÷�������� �����ϴ�.")){%><img src="../userimg/<%=bean.getFilename() %>"><%}else{%>÷�������� �����ϴ�.<%}%></p>
									<font size="5" bold>���� ���� : <%=bean.getReviewtitle() %></font>
								<%}//-for %>
									</br></br>
									<p><input type="radio" name="reviewnum" size="9" maxlength="20" value="0">�ʱ�ȭ</p>
									<p><input type="button" value="�ۿø���" onclick="checkInputs2()"></br>

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
<! -------------------------------------------------------------�ְ��� ����-------------------------------------------------------------------------------- !>
<%}else{%>
	<h1 align="center"><font size="7" color="white">�����ڸ� �� �� �ִ� ������ �Դϴ�.</font></h1><br><br><br><br><br><br>
<%}%>
</div><!-- contentbox -->
</body>
</html>