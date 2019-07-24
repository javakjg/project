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
					<%if(!bean2.getAdminComment().equals("�ʱⰪ")){ %>
					<article class="box">
						<header>
							<h2>�̹� �� �ְ��� ����</h2>
							<h2><%=bean.getBeerEname() %></h2>
							<p><img src="../beerimg/<%=bean.getFilename()%>"></p>
							<p>��� ��¥ : <%=bean2.getUdate() %></p>
						</header>
						<div class="content">
							<p>������ �ڸ�Ʈ : <%=bean2.getAdminComment() %>
							<p>�з� : <%=bean.getTypebig() %> >> <%=bean.getTypesmall()%> </p>
							<p>���� : <%=bean.getAlchol() %> </p>
						</div>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">�� ����</a>
						</footer>
					</article>
					<%}else{ %>
					<article class="box">
						<header>
							<h2>�̹� �� �ְ��� ����</h2>
							<h2>��� �� ���ְ� �����ϴ�.</h2>
						</header>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">�� ����</a>
						</footer>
					</article>
					<%} %>
				</div>
				<a href="#two" class="more">Learn More</a>
			</section>

		<!-- Two -->
			<section id="two" class="wrapper post bg-img" data-bg="banner5.jpg">
				<div class="inner">
					<%if(!state.equals("�ʱⰪ")){ %>
					<article class="box">
						<header>
							<h2>�̹� �� �ְ��� ����</h2>
							<h2><%=bean3.getReviewtitle() %></h2>
							<p>�ۼ� ��¥ : <%=bean3.getReviewdate() %></p>
						</header>
						<div class="content">
							<p><%=bean3.getReviewcomment() %></p>
						</div>
						<footer>
							<a href="../reviewBoard/ReviewMgr.jsp?num=<%=bean3.getReviewnum()%>" class="button alt">�� ����</a>
						</footer>
					</article>
					<%}else{ %>
					<article class="box">
						<header>
							<h2>�̹� �� �ְ��� ����</h2>
							<h2>��� �� ���䰡 �����ϴ�.</h2>
						</header>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">�� ����</a>
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
							<h2>���� ���� ����</h2>
						</header>
						<div class="content">
							<p>BeerKing �� �ڶ��ϴ� ���ֿ� ���� ������ �� �� �ֽ��ϴ�.</p>
						</div>
						<footer>
							<a href="../beerdb/BeerList.jsp" class="button alt">�� ����</a>
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
							<h2>���� �Խñ�</h2>
						</header>
						<div class="content">
							<p>�پ��� ������� ���� ������� ����������</p>
						</div>
						<footer>
							<a href="../reviewBoard/ReviewMgr.jsp" class="button alt">�� ����</a>
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
