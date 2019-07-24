<!-- Navleft.jsp -->
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file="LayerPopLogin.jsp" %>
<%	
	request.setCharacterEncoding("EUC-KR");
	String[] middle = {
			"Pale Ale",
			"Porter",
			"Stout",
			"Altbier",
			"Kolsch",
			"Steinbier",
			"Dampfbier",
			"Weissbier",
			"Kellerbier",
			"Roggenbier",
			"Belgian Ale",
			"Flanders Red Ale"};
	String[] middle2 ={
			"Pale Lager",
			"Helles",
			"Dark Lager",
			"Pilsener",
			"Dunkel",
			"Schwarzbier",
			"Export",
			"Steam Beer",
			"Bock",
			"Rauchbier",
			"Vienna Lager",
			"Marzen"
	};
%>
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="../css/NavLeft-default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/NavLeft-fonts.css" rel="stylesheet" type="text/css" media="all" />
<style> 
	#middle{
		display: none;
	}
	#fold1:hover,#fold2:hover,#board:hover{
		background-color: #3f3f3f;
	}
</style>

<%@ include file="top.jsp" %> 
	<iframe name="trandIframe" src="../index/Trand.jsp" style="visibility:hidden;display:none"></iframe>
<div id="page" class="container">
<!--------------------------------------------------------좌측 고정페이지가 끝------------------------------------------------------------------------>
	<div id="header">
		<div id="logo">
			<a href="../index/IndexPage.jsp"><img src="../css/Beerking-logo.png" width="300" height = "150"></a>
		</div>
		<div id="menu">
		<font style="font-family:fantasy;font-weight:500;" size="8" color="#FFFF00">Beer</font>
		<div id="foldDiv">
			<div>
			<ul>
				<li id="fold1" style="">
					<a href="#" accesskey="1" title=""><font>에일</font></a>
					<ul id="middle">
						<%for(int i=0;i<middle.length;i++){%>
							<li style="background: #202020; color: rgba(255,255,255,1);"><a href="javascript:golist('<%=middle[i]%>')" accesskey="2" title=""><%=middle[i] %></a></li>
						<%}//if%>
					</ul>
				</li>
			</ul>
			</div>
		</div>
		<div id="foldDiv">
		<div>
			<ul>
				<li id="fold2" style="">
					<a href="#" accesskey="1" title=""><font>라거</font></a>
					<ul id="middle">
						<%for(int i=0;i<middle2.length;i++){%>
							<li style="background: #202020; color: rgba(255,255,255,1);"><a href="javascript:golist('<%=middle2[i]%>')" accesskey="2" title=""><%=middle2[i] %></a></li>
						<%}//if%>
					</ul>
				</li>
			</ul>
			</div>
		</div>
		<div id="foldDiv">
		<div>
			<b><font style="font-family:fantasy;font-weight:500;" size="8" color="#FFFF00">Board</font></b>
			<ul>
				<li id="Board">
					<a href="../reviewBoard/ReviewMgr.jsp">리뷰</a>
				</li>
				<li id="Board">
					<a href="../requestBoard/RequestList.jsp">요청</a>
				</li>
			</ul>
			</div>
		</div>
		<%if(email != null){%>
		<%
			int trandKey[] = tMgr.selectMostTrand(uBean.getUsernum());
			String trandBeer[] = new String [3];		
		%>
		<div id="recommend">
			<b><font style="font-family:fantasy;font-weight:500;" size="8" color="#FF0000">Choice</font></b>
			<ul>
				<li>
					<%if(trandKey[0]<12){%>
					<%trandBeer[0] = tMgr.selectTrandBeer(middle[trandKey[0]]);%>
					<%}else{%>
					<%trandBeer[0] = tMgr.selectTrandBeer(middle2[trandKey[0]-12]);%>
					<%}String trandFileName1 = tMgr.selectTrandBeerFile(trandBeer[0]);%>
					<div>
					<img src = "../css/recommend.png"  width="75" height="75" style="position:absolute; left:200;">
					<a href="../beerdb/BeerSearch.jsp?beerName=<%=trandBeer[0]%>"><img src = "../beerimg/<%=trandFileName1%>"  width="200" height="200"></a>	
					</div>			
				</li>
				<li>
					<%if(trandKey[1]<12){%>
					<%trandBeer[1] = tMgr.selectTrandBeer(middle[trandKey[1]]);%>
					<%}else{%>
					<%trandBeer[1] = tMgr.selectTrandBeer(middle2[trandKey[1]-12]);%>
					<%}String trandFileName2 = tMgr.selectTrandBeerFile(trandBeer[1]);%>
					<div>
					<img src = "../css/recommend.png"  width="75" height="75" style="position:absolute; left:200;">
					<a href="../beerdb/BeerSearch.jsp?beerName=<%=trandBeer[1]%>"><img src = "../beerimg/<%=trandFileName2%>"  width="200" height="200"></a>
					</div>
				</li>
				<li>
					<%if(trandKey[2]<12){%>
					<%trandBeer[2] = tMgr.selectTrandBeer(middle[trandKey[2]]);%>
					<%}else{%>
					<%trandBeer[2] = tMgr.selectTrandBeer(middle2[trandKey[2]-12]);%>
					<%}String trandFileName3 = tMgr.selectTrandBeerFile(trandBeer[2]);%>
					<div>
					<img src = "../css/recommend.png"  width="75" height="75" style="position:absolute; left:200;">
					<a href="../beerdb/BeerSearch.jsp?beerName=<%=trandBeer[2]%>"><img src = "../beerimg/<%=trandFileName3%>"  width="200" height="200"></a>
					</div>
				</li>
			</ul>
			</div>
		<%}%>
		</div>
	</div>

<script type="text/javascript" src="../js/LayerPopLogin.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    $("#fold1>a").click(function(){
	        var submenu = $(this).next("ul");
	        if( submenu.is(":visible") ){
	            submenu.slideUp();
	        }else{
	            submenu.slideDown();
	        }
	    });
	    $("#fold2>a").click(function(){
	        var submenu = $(this).next("ul");
	        if( submenu.is(":visible") ){
	            submenu.slideUp();
	        }else{
	            submenu.slideDown();
	        }
	    });
	});
	function golist(beername) {
 		window.parent.trandIframe.document.trandForm.smalltype.value = beername;
 		window.parent.trandIframe.document.trandForm.usernum.value = <%=uBean.getUsernum()%>;
 		window.parent.trandIframe.document.trandForm.submit();
		location.href = "../beerdb/BeerList.jsp?typesmall="+beername;
	}
	
	function check(){
		if(document.searchFrm.beerName.value ==""){
			alert("입력해라");
			return;
		}
		document.searchFrm.submit();
	}
</script>
<!-- 메인화면 -->
<div id="mainIndex" style="padding-bottom: 470px";>
