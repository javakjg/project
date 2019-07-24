<%@page import="beerking.ReviewBoardBean"%>
<%@page import="beerking.BeerBean"%>
<%@page import="beerking.MonthBeerBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="MainMgr" class="beerking.AdminMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
	BeerBean bean = MainMgr.getMbeer();
	MonthBeerBean bean2 = MainMgr.getMdata(bean.getBeernum());
	ReviewBoardBean bean3 = MainMgr.getMreview();
	String state = MainMgr.getMreviewState();
%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>BeerKing</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="../css/assets/css/main.css" />
	</head>
	<body>
			<section id="banner" class="bg-img" data-bg="banner.jpg">
				<div class="inner">
					<header>
						<h1><img src = "../css/Beerking-logo.png" width="750" height="450"></h1>
					</header>
				</div>
				<a href="#one" class="more">Learn More</a>
			</section>

		<!-- One -->
			<section id="one" class="wrapper post bg-img" data-bg="banner2.jpg">
				<div class="inner">
					<%if(!bean2.getAdminComment().equals("초기값")){ %>
					<article class="box">
						<header>
							<h2>이번 달 최고의 맥주</h2>
							<h2><%=bean.getBeerEname() %></h2>
							<p><img src="../beerimg/<%=bean.getFilename()%>"></p>
							<p>등록 날짜 : <%=bean2.getUdate() %></p>
						</header>
						<div class="content">
							<p>관리자 코멘트 : <%=bean2.getAdminComment() %>
							<p>분류 : <%=bean.getTypebig() %> >> <%=bean.getTypesmall()%> </p>
							<p>도수 : <%=bean.getAlchol() %> </p>
						</div>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">더 보기</a>
						</footer>
					</article>
					<%}else{ %>
					<article class="box">
						<header>
							<h2>이번 달 최고의 맥주</h2>
							<h2>등록 된 맥주가 없습니다.</h2>
						</header>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">더 보기</a>
						</footer>
					</article>
					<%} %>
				</div>
				<a href="#two" class="more">Learn More</a>
			</section>

		<!-- Two -->
			<section id="two" class="wrapper post bg-img" data-bg="banner5.jpg">
				<div class="inner">
					<%if(!state.equals("초기값")){ %>
					<article class="box">
						<header>
							<h2>이번 달 최고의 리뷰</h2>
							<h2><%=bean3.getReviewtitle() %></h2>
							<p>작성 날짜 : <%=bean3.getReviewdate() %></p>
						</header>
						<div class="content">
							<p><%=bean3.getReviewcomment() %></p>
						</div>
						<footer>
							<a href="../reviewBoard/ReviewMgr.jsp?num=<%=bean3.getReviewnum()%>" class="button alt">더 보기</a>
						</footer>
					</article>
					<%}else{ %>
					<article class="box">
						<header>
							<h2>이번 달 최고의 리뷰</h2>
							<h2>등록 된 리뷰가 없습니다.</h2>
						</header>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">더 보기</a>
						</footer>
					</article>
					<%} %>
				</div>
				<a href="#three" class="more">Learn More</a>
			</section>

		<!-- Three -->
			<section id="three" class="wrapper post bg-img" data-bg="banner4.jpg">
				<div class="inner">
					<article class="box">
						<header>
							<h2>맥주 정보 보기</h2>
						</header>
						<div class="content">
							<p>BeerKing 이 자랑하는 맥주에 대한 정보를 볼 수 있습니다.</p>
						</div>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">더 보기</a>
						</footer>
					</article>
				</div>
				<a href="#four" class="more">Learn More</a>
			</section>

		<!-- Four -->
			<section id="four" class="wrapper post bg-img" data-bg="banner3.jpg">
				<div class="inner">
					<article class="box">
						<header>
							<h2>리뷰 게시글</h2>
						</header>
						<div class="content">
							<p>다양한 사람들이 남긴 리뷰글을 만나보세요</p>
						</div>
						<footer>
							<a href="../reviewBoard/ReviewMgr.jsp" class="button alt">더 보기</a>
						</footer>
					</article>
				</div>
			</section>

		<!-- Footer -->
		<!-- Scripts -->
			<script src="../css/assets/js/jquery.min.js"></script>
			<script src="../css/assets/js/jquery.scrolly.min.js"></script>
			<script src="../css/assets/js/jquery.scrollex.min.js"></script>
			<script src="../css/assets/js/skel.min.js"></script>
			<script src="../css/assets/js/util.js"></script>
			<script src="../css/assets/js/main.js"></script>
	</body>
</html>
