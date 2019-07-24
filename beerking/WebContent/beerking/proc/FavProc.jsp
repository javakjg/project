<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="beerMgr" class="beerking.BeerMgr"/>
<%  
	int beernum = Integer.parseInt(request.getParameter("number"));
	int usernum = Integer.parseInt(request.getParameter("usernum"));
	String fav = request.getParameter("fav");
	
	if(fav.equals("false")){
		beerMgr.deleteFavoriteBeer(usernum, beernum);
	}else if(fav.equals("true")){
		beerMgr.addFavoriteBeer(usernum, beernum);
	}
%>
<script>
	location.href="../beerdb/Fav.jsp"
	/* self.close(); */
</script>