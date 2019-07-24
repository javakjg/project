<%@page import="beerking.BeerMgr"%>
<%@page import="beerking.BeerBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ include file="../index/Navleft.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/BeerList.css?ver=1">
<jsp:useBean id="beerMgr" class = "beerking.BeerMgr" />
<%
	request.setCharacterEncoding("EUC-KR");

	
	String beerName = request.getParameter("beerName");
	String rank = "false";
	if(request.getParameter("rank")!=null)
	{
		rank = request.getParameter("rank"); 
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
		<div class = "search">
		<h1><font color ="white">맥주 검색</font></h1></br>
			<form name = "searchFrm" method ="post" action="BeerSearch.jsp">	
				<input size="20" name = "beerName" placeholder = "맥주이름" value = "" style="background:">
				<input type ="button" value = "찾기" onClick = "javascript:check()" style="background: #202024; color: rgba(255,255,255,1); border : 0; width:100">
			</form>
			</div>
			</br>
			<div width="1200" align="left">
			<input type ="button" value = "랭킹보기" onclick="location.href='BeerList.jsp?rank=true'" style="background: #202024; color: rgba(255,255,255,1); width:100; margin-left:60">
			</div>
			</br>
			</br>

			
	<div id="main"  background-color ="black">
		<%if(rank.equals("false")) {%>
		<div class="inner"> 
			<div id="parent" class="thumbnails">
		<% 
			Vector<BeerBean> vlist = beerMgr.beerRead(beerName);
			int vlistsize = vlist.size();
			if(vlistsize < 4){
				for(int k = 0; k < vlistsize; k++){
					BeerBean bean = vlist.get(k);
		%>
				<div class="box">
				<%for(int z=0;z<10;z++){%>
						<%if(beerNew[z]==bean.getBeernum()){%>
							<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
						<%}%>
						<%}%>
						<button class="beerButton" onclick="javascript:onclickButton(<%=k%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>"  width="200" height="200"></button><br>
							<div class="inner" style="color:white">			
								<%=bean.getBeerEname()%><br>
								<%=bean.getBeerKname()%>			
							</div>
					</div>
		<%}//--for%>
	<%}else{//--if%>
		
		<% 
			for(int i = 0; i < vlist.size()/4; i++){
		%>
		
		<% 
			for(int a = (i*4); a < (i+1)*4; a++){
				BeerBean bean = vlist.get(a);
		%>	
					<div class="box">
					<%for(int x=0;x<10;x++){%>
						<%if(beerNew[x]==bean.getBeernum()){%>
							<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
						<%}%>
						<%}%>
						<button class="beerButton" onclick="javascript:onclickButton(<%=a%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>"  width="200" height="200"></button><br>
							<div class="inner" style="color:white">			
								<%=bean.getBeerEname()%><br>
								<%=bean.getBeerKname()%>			
							</div>
					</div>
			<%}//---for %>
		<%}//---for %>
			<%if(vlist.size()%4!=0) %>
			<%
					for(int j = 4*(vlist.size()/4); j < vlist.size(); j++){
						BeerBean bean = vlist.get(j);
			%>
					<div class="box">
					<%for(int c=0;c<10;c++){%>
						<%if(beerNew[c]==bean.getBeernum()){%>
							<img src = "../css/new.png"  width="75" height="75" style="position:absolute; opacity: 1.9;">
						<%}%>
						<%}%>
						<button class="beerButton" onclick="javascript:onclickButton(<%=j%>)"><img class="image fit" src = "../beerimg/<%=bean.getFilename()%>"  width="200" height="200"></button><br>
							<div class="inner" style="color:white">			
								<%=bean.getBeerEname()%><br>
								<%=bean.getBeerKname()%>			
							</div>
					</div>
				<%} %>
			<%}%>
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
