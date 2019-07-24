<%@page import="beerking.BeerMgr"%>
<%@page import="beerking.BeerBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ include file="../index/Navleft.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/BeerList.css?ver=1">
<jsp:useBean id="beerMgr" class = "beerking.BeerMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
	String typesmall = request.getParameter("typesmall");
	if(request.getParameter("typesmall")==null)
	{
		typesmall = "Pale Ale";
	}
	String rank = "false";
	if(request.getParameter("rank")!=null)
	{
		rank = request.getParameter("rank"); 
	}

	
	int next = 8 ;
	int a = 0 ;
	if(request.getParameter("next") != null){
		if(Integer.parseInt(request.getParameter("next")) > 0){
			a = Integer.parseInt(request.getParameter("next"));
		}
		next += a ;
	}
	int beerNew[] = beerMgr.getBeerNew();
%>
<html>
<head>
<script>
window.onpageshow = function(event) {
	   if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	       location.reload();
	   }

	};
 	function add(a) {
 		document.buttonFrm.next.value = <%= next %>;
 		document.buttonFrm.submit();
	}
 	/* function favAdd(number,usernum){
 		window.open("../proc/FavProc.jsp?fav="+"true&number="+number+"&usernum="+usernum, "a", "width=1, height=1, left="+screen.width+","+" top="+screen.height);
 		document.getElementById("favAdd"+number).src='../css/heart.png'; 
 		document.getElementById("favAdd"+number).onclick = function(){favDel(number,usernum);};
 		document.getElementById("favAdd"+number).id = "favDel"+number;		
 	} */
 	function favAdd(number,usernum){
 		window.parent.favIframe.document.favForm.fav.value = "true";
 		window.parent.favIframe.document.favForm.number.value = number;
 		window.parent.favIframe.document.favForm.usernum.value = usernum;
 		window.parent.favIframe.document.favForm.submit();
 		document.getElementById("favAdd"+number).src='../css/heart.png'; 
 		document.getElementById("favAdd"+number).onclick = function(){favDel(number,usernum);};
 		document.getElementById("favAdd"+number).id = "favDel"+number;		
 	}
	/* function favDel(number,usernum){
		window.open("../proc/FavProc.jsp?fav="+"false&number="+number+"&usernum="+usernum, "a", "width=1, height=1, left="+screen.width+","+" top="+screen.height);
		document.getElementById("favDel"+number).src='../css/noheart.png'; 
	 	document.getElementById("favDel"+number).onclick = function(){favAdd(number,usernum);};
		document.getElementById("favDel"+number).id = "favAdd"+number;
 	} */
	function favDel(number,usernum){
 		window.parent.favIframe.document.favForm.fav.value = "false";
 		window.parent.favIframe.document.favForm.number.value = number;
 		window.parent.favIframe.document.favForm.usernum.value = usernum;
 		window.parent.favIframe.document.favForm.submit();		
 		document.getElementById("favDel"+number).src='../css/noheart.png'; 
	 	document.getElementById("favDel"+number).onclick = function(){favAdd(number,usernum);};
		document.getElementById("favDel"+number).id = "favAdd"+number;
 	}
	function ScoreAdd(score,number,usernum){
		window.parent.scoreIframe.document.scoreForm.score.value = score;
 		window.parent.scoreIframe.document.scoreForm.number.value = number;
 		window.parent.scoreIframe.document.scoreForm.usernum.value = usernum;
 		window.parent.scoreIframe.document.scoreForm.submit();	
		if(score==1){
			document.getElementById("ScoreButtonA"+number).src='../css/starOn.png'; 
			document.getElementById("ScoreButtonB"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonC"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonD"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonE"+number).src='../css/starOff.png';
		}else if(score==2){
			document.getElementById("ScoreButtonA"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonB"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonC"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonD"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonE"+number).src='../css/starOff.png';
		}else if(score==3){
			document.getElementById("ScoreButtonA"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonB"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonC"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonD"+number).src='../css/starOff.png';
			document.getElementById("ScoreButtonE"+number).src='../css/starOff.png';
		}else if(score==4){
			document.getElementById("ScoreButtonA"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonB"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonC"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonD"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonE"+number).src='../css/starOff.png';
		}else if(score==5){
			document.getElementById("ScoreButtonA"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonB"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonC"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonD"+number).src='../css/starOn.png';
			document.getElementById("ScoreButtonE"+number).src='../css/starOn.png';
		}
 	}


</script>
<title>맥주정보 게시판</title>
<style type="text/css">
 a:link { color: red; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}
 a:active {color: red; text-decoration: none;}
</style>
</head>
<body>
	<iframe name="favIframe" src="Fav.jsp" style="visibility:hidden;display:none"></iframe>
	<iframe name="scoreIframe" src="Score.jsp" style="visibility:hidden;display:none"></iframe>
	<div id="main" background-color ="black">
	<div class="inner"> 
	<%if(rank.equals("false")) {%>
			<%
				String info = beerMgr.getBeerText(typesmall);
			%>
			<div class = "small">
				<h1><font color="white"></h1>
				<div class = "info">
				</br>
				<font style="font-size:40px;"><b><%=typesmall%></b></font><p>
				<b><%=info %></b></font>
				</div>
			</div>
			</br></br>
			<div width="1200" align="left">
			<input type ="button" value = "랭킹보기" onclick="location.href='BeerList.jsp?rank=true'" style="background: #202024; color: rgba(255,255,255,1); width:100; margin-left:120">
			</div>
			<div>
			<form name = "searchFrm" method ="post" action="BeerSearch.jsp">	
				
				<input size="20" name = "beerName" placeholder = "맥주이름" value = "" style="background:">
				<input type ="button" value = "찾기" onClick = "javascript:check()" style="background: #202024; color: rgba(255,255,255,1); width:100">

			</form>
			</div>
			

 



			
			
			<div id="parent" class="thumbnails">
				<%
					Vector<BeerBean> vlist = beerMgr.getBeerLimit(typesmall, next);
					int vlistsize =  vlist.size()/4;
					if(vlist.size()/4==0){
					for(int o = 0;o<vlist.size();o++){
						BeerBean bean = vlist.get(o);		
				%>
					<div class="box">
						<%for(int z=0;z<10;z++){%>
						<%if(beerNew[z]==bean.getBeernum()){%>
							<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
						<%}%>
						<%}%>
						<button class="beerButton" onclick="javascript:onclickButton(<%=o%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>" width="200" height="200"></button><br>
						<div class="inner" style="color:white">
						<%=bean.getBeerEname()%><br>
						<%=bean.getBeerKname()%>
						</div>
					</div>	
					<%}//-for %>
				<%}//if %>
				<%
					for(int i = 0; i < vlist.size()/4; i++){
				%>
				<%
				if(i != vlistsize-1){
				%>
					<%
						for(int j = 0; j < 4; j++){	
							BeerBean bean = vlist.get(j+(i*4));		
					%>
				<div class="box">
					<%for(int x=0;x<10;x++){%>
					<%if(beerNew[x]==bean.getBeernum()){%>
						<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
					<%}%>
					<%}%>
					<button class="beerButton" onclick="javascript:onclickButton(<%=j+(i*4)%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>"  width="200" height="200"></button><br>
					<div class="inner" style="color:white">			
					<%=bean.getBeerEname()%><br>
					<%=bean.getBeerKname()%>			
					</div>
				</div>	
				<%}//-for %>
				<%}else{//-if%>
					<%
						for(int k = 0; k < 4+(vlist.size()%4); k++){	
							BeerBean bean = vlist.get(k+(i*4));		
							if(k ==  4){
								%><tr><%
							}
					%>
				<div class="box">
					<%for(int c=0;c<10;c++){%>
					<%if(beerNew[c]==bean.getBeernum()){%>
						<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
					<%}%>
					<%}%>
					<button class="beerButton" onclick="javascript:onclickButton(<%=k+(i*4)%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>"  width="200" height="200"></button><br>
					<div class="inner" style="color:white">
					<%=bean.getBeerEname()%><br>
					<%=bean.getBeerKname()%>			
					</div>
				</div>	
				<%}//-for %>
				<%}//-else%>
				<%}%>
			</div>
	<Form name = "buttonFrm" action = "BeerList.jsp">
		<p align="center">	
			<input type="button" value="더 보기"  onclick="javascript:add('<%= next %>')">
			<input type = "hidden" name = "next" value="<%= next %>" >
			<input type = "hidden" name = "typesmall" value="<%= typesmall %>" >
		</p>
	</Form>
	</div>
	</div>
	<%
		for(int l = 0; l < vlist.size(); l++){
			BeerBean bean = vlist.get(l);
			boolean flag = beerMgr.getFavoriteBeer(uBean.getUsernum(), bean.getBeernum());
			int score = beerMgr.getScoreBeer(uBean.getUsernum(), bean.getBeernum());
	%>
	<div class="modal_beerDB" id="Div_Modal<%=l%>">
	
		<div class="modal_beerDB_content">
			<h1>
				<center  style="color:white">맥주정보</center>
			</h1>
			<%
					if(email != null){
						if(flag == true){
				%>

						<input type="image"  style="WIDTH: 80px; HEIGHT: 80px; background-color:#202024;  border:0; outline:0;" src = "../css/heart.png" id="favDel<%=bean.getBeernum()%>" onclick="javascript:favDel(<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
				<%
						}else{
				%>
						<input type="image" style="WIDTH: 80px; HEIGHT: 80px; background-color:#202024; border:0; outline:0;" src="../css/noheart.png" id="favAdd<%=bean.getBeernum()%>" onclick="javascript:favAdd(<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)" >
						<%}//--if %>
			<%}%>
			<table align="left" width="700px"  style="color:white">
				<tr>
					<td rowspan="4" align="center"><img id="image" width="250" height="250" src="../beerimg/<%=bean.getFilename()%>"></td>
					<td><b>분류 :</b> <%=bean.getTypebig()%>  /  <%=bean.getTypesmall()%></td>
				</tr>
				<tr>
					<td><b>도수 :</b> <%=bean.getAlchol()%>% ABV</td>
				</tr>
				<tr>
					<td><b>회사 :</b> <%=bean.getCompany()%></td>
				</tr>
				<tr>
					<td><b>국가 :</b> <%=bean.getCountry()%></td>
				</tr>				
				<tr>
					<td align="center"><b><%=bean.getBeerEname()%><%="</br>"%><%=bean.getBeerKname()%></td></b>
					<td align="right">
						<%
						if(email != null){
						%>
							<table>
								<tr>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=1){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonA<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(1,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=2){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonB<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(2,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=3){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonC<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(3,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=4){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonD<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(4,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=5){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonE<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(5,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
								</tr>
							</table>
						<%}else{ %>
							<b>즐겨찾기</b> 및 <b>평점</b>은 <a href="javascript:onclickLoginButton(<%=l%>)">로그인</a>을 해주세요
						<%}//--if %>
					</td>
				</tr>
			</table>			
		</div>
	</div>
	<%}%>
	<%}else if(rank.equals("true")) {%>
			
			<div class = "small">
				<h1><font color="white"></h1>
				<div class = "info">
				</br>
				<font style="font-size:40px;"><b>랭킹</b></font><p>
				<b>가장 평점이 높은 맥주 입니다.</b></font>
				</div>
			</div>

	<div id="parent" class="thumbnails">
				<%
					Vector<BeerBean> vlist = beerMgr.getBeerRank();
					String AVG[] = beerMgr.getRankAVG();
					for(int o = 0;o<vlist.size();o++){
						BeerBean bean = vlist.get(o);		
						
				%>
					<div class="box">
						<img src="../css/rank<%=o+1%>.png" style="width:50; height:50; float:left;">
						<div style="float:right; margin-right:10;">
						<img src = "../css/starOn.png" width="25" height="25">
						<font style="font-size:25; color:white;"><%=AVG[o]%></font>
						</div>
						<button class="beerButton" onclick="javascript:onclickButton(<%=o%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>" width="200" height="200"></button><br>
						<div class="inner" style="color:white;">
						<%=bean.getBeerEname()%><br>
						<%=bean.getBeerKname()%>
						</div>
					</div>	
					<%}//-for %>
		
			</div>
	</div>
	</div>
	<%
		for(int l = 0; l < vlist.size(); l++){
			BeerBean bean = vlist.get(l);
			boolean flag = beerMgr.getFavoriteBeer(uBean.getUsernum(), bean.getBeernum());
			int score = beerMgr.getScoreBeer(uBean.getUsernum(), bean.getBeernum());
	%>
	<div class="modal_beerDB" id="Div_Modal<%=l%>">
	
		<div class="modal_beerDB_content">
			<h1>
				<center  style="color:white">맥주정보</center>
			</h1>
			<%
					if(email != null){
						if(flag == true){
				%>

						<input type="image"  style="WIDTH: 80px; HEIGHT: 80px; background-color:#202024;  border:0; outline:0;" src = "../css/heart.png" id="favDel<%=bean.getBeernum()%>" onclick="javascript:favDel(<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
				<%
						}else{
				%>
						<input type="image" style="WIDTH: 80px; HEIGHT: 80px; background-color:#202024; border:0; outline:0;" src="../css/noheart.png" id="favAdd<%=bean.getBeernum()%>" onclick="javascript:favAdd(<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)" >
						<%}//--if %>
			<%}%>
			<table align="left" width="700px"  style="color:white">
				<tr>
					<td rowspan="4" align="center"><img id="image" width="250" height="250" src="../beerimg/<%=bean.getFilename()%>"></td>
					<td><b>분류 :</b> <%=bean.getTypebig()%>  /  <%=bean.getTypesmall()%></td>
				</tr>
				<tr>
					<td><b>도수 :</b> <%=bean.getAlchol()%>% ABV</td>
				</tr>
				<tr>
					<td><b>회사 :</b> <%=bean.getCompany()%></td>
				</tr>
				<tr>
					<td><b>국가 :</b> <%=bean.getCountry()%></td>
				</tr>				
				<tr>
					<td align="center"><b><%=bean.getBeerEname()%><%="</br>"%><%=bean.getBeerKname()%></td></b>
					<td align="right">
						<%
						if(email != null){
						%>
							<table>
								<tr>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=1){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonA<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(1,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=2){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonB<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(2,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=3){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonC<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(3,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=4){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonD<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(4,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
									<td>
										<input type="image" style="WIDTH: 40px; HEIGHT: 40px; background-color:#202024;  border:0; outline:0;" src = <%if(score>=5){%>"../css/starOn.png"<%}else{%>"../css/starOff.png"<%}%> id="ScoreButtonE<%=bean.getBeernum()%>" onclick="javascript:ScoreAdd(5,<%=bean.getBeernum()%>,<%=uBean.getUsernum()%>)">
									</td>
								</tr>
							</table>
						<%}else{ %>
							<b>즐겨찾기</b> 및 <b>평점</b>은 <a href="javascript:onclickLoginButton(<%=l%>)">로그인</a>을 해주세요
						<%}//--if %>
					</td>
				</tr>
			</table>			
		</div>
	</div>
	<%}%>
	<%}%>
	</div>
	</div>
</body>
<script type="text/javascript" src="../js/BeerList.js"></script>
</html>