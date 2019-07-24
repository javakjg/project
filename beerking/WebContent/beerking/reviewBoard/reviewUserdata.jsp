<%@page import="beerking.BeerBean"%>
<%@page import="beerking.ReviewBoardBean"%>
<%@page import="java.util.Vector"%>
<%@page import="beerking.UserDataBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="rMgr" class="beerking.ReviewMgr"/>
<jsp:useBean id="myMgr" class="beerking.MyPageMgr"/>
<head>
<script type="text/javascript">

</script>
</head>
<body style="background-color:#202020;">
	<%
		int usernum = 0;
		usernum = Integer.parseInt(request.getParameter("usernum"));
		Vector<BeerBean> ubeer = myMgr.getRecentBeer(usernum);
		Vector<ReviewBoardBean> uReview = myMgr.getRecentReviewlike(usernum);
		UserDataBean ubean =  rMgr.getUser(usernum);
	%>
	<div style="width:650px;height:400px;margin:auto;border:solid;background-color:#606060;">
		<div style="text-align:center;">
			<h1><font color="#20DDDD"><%=ubean.getNickname() %></font><font color="white"> 님의 프로필입니다.</font></h1>
		</div>
		<div style="width:99%;margin:0px 0px 0px 0px;border:solid;background-color:#E3E3E3;float:left;">
			<ul style="margin: 0px;	padding: 0px 0px 0px 0px;	list-style: none;">
				<li style="padding-top: 0px;border-top: none;box-shadow: none; disaplay: block;text-align: left;height:30px;">
					회원 등급: <font color="#AA20AA"><%if(ubean.getUsergrant()==2){ %>관리자<%}else{ %> 일반회원<%} %></font>
				</li>
				<li style="padding-top: 0px;border-top: none;box-shadow: none;disaplay:left;text-align: left;height:30px;">
					닉 네임: <font color="#20AAAA"><%=ubean.getNickname() %></font>
				</li>
				<li style="padding-top: 0px;border-top: none;box-shadow: none;disaplay: left;text-align: left;height:30px;">
					 이메일 : <font color="#AAAA20"><%=ubean.getEmail() %></font>
				</li>
				</ul>
		</div>
			<div style="height:250px;border:solid;background-color:#FFF;float: left; width: 49%;">
				<table align="center">
				<tr>
				<td style="margin: 0px;	padding: 0px 0px 0px 0px; list-style: none;">
					<li style="padding-top: 0px;border-top: none;box-shadow: none; disaplay: block;text-align: center;height:30px;">
						<font color="#20AAAA" size="4px"><%=ubean.getNickname() %></font>님이 가장 최근에 <br>좋아요한 맥주
					</li>
					<li style="padding-top: 0px;border-top: none;box-shadow: none; disaplay: block;text-align: center;height:150px;">
						<%if(ubeer.size()!=0){
							for(int i=0;i<1;i++){ 
							BeerBean bBean = ubeer.get(i);%>
							
							<p><a href="#" onclick="javascript:opener.location.href='../beerdb/BeerSearch.jsp?beerName=<%=bBean.getBeerEname()%>';self.close();"><img src="../beerimg/<%=bBean.getFilename()%>" width="150" height="100"></a></p>
							<p><font color="#AA20AA" size="5px"><%=bBean.getBeerEname() %></font></p>
						<%}//for %>
						<%}else{ %>
							<br/>
							<p style="width:300px;"><font color="#802020">좋아요한 맥주가 없습니다.</font></p>
						<%} %>
					</li>
				</td>
				</tr>
				</table>
			</div>
			<div style="height:250px;border:solid;background-color:#FFF;float: right; width: 49%;">
				<table align="center">
				<tr>
				<td style="margin: 0px;	padding: 0px 0px 0px 0px; list-style: none;">
					<li style="padding-top: 0px;border-top: none;box-shadow: none; disaplay: block;text-align: center;height:30px;">
						<font color="#20AAAA" size="4px"><%=ubean.getNickname() %></font>님이 가장 최근에 <br>좋아요한 리뷰게시글
					</li>
					<li style="padding-top: 0px;border-top: none;box-shadow: none; disaplay: block;text-align: center;height:150px;">
						<%if(uReview.size()!=0){
							for(int i=0;i<1;i++){ 
							ReviewBoardBean rBean = uReview.get(i);%>
							<p><a href="#" onclick="javascript:opener.location.href='../reviewBoard/ReviewMgr.jsp?num=<%=rBean.getReviewnum()%>';self.close();"><img src="../beerimg/<%=rBean.getFilename()%>" width="150" height="100"></a></p>
							<p><font color="#AA20AA" size="5px"><%=rBean.getReviewtitle() %></font></p>
						<%}//for %>
						<%}else{ %>
							<br/>
							<p style="width:300px;"><font color="#802020">좋아요한 리뷰가 없습니다.</font></p>
						<%} %>
					</li>
				</td>
				</tr>
				</table>
			</div>
	</div>