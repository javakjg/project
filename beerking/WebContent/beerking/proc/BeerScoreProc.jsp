<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="beerMgr" class="beerking.BeerMgr"/>
<%  
	int beerscore = Integer.parseInt(request.getParameter("score"));
	int beernum = Integer.parseInt(request.getParameter("number"));
	int usernum = Integer.parseInt(request.getParameter("usernum"));
	
	if(beerMgr.getGradeBeer(usernum, beernum)){
		beerMgr.updateScoreBeer(beerscore, usernum, beernum);
	}else{
		beerMgr.addScoreBeer(beerscore, usernum, beernum);
	}
	
%>
<script>
	location.href="../beerdb/Score.jsp"
	/* self.close(); */
</script>