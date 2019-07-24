<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="tMgr" class = "beerking.TrandMgr"/>
<%
	int usernum = Integer.parseInt(request.getParameter("usernum"));
	String typeName = request.getParameter("smalltype");
	int smalltype = 1;
	if(typeName.equals("Pale Ale")){
		smalltype = 1;
	}else if(typeName.equals("Porter")){
		smalltype = 2;
	}else if(typeName.equals("Stout")){
		smalltype = 3;
	}else if(typeName.equals("Altbier")){
		smalltype = 4;
	}else if(typeName.equals("Kolsch")){
		smalltype = 5;
	}else if(typeName.equals("Steinbier")){
		smalltype = 6;
	}else if(typeName.equals("Dampfbier")){
		smalltype = 7;
	}else if(typeName.equals("Weissbier")){
		smalltype = 8;
	}else if(typeName.equals("Kellerbier")){
		smalltype = 9;
	}else if(typeName.equals("Roggenbier")){
		smalltype = 10;
	}else if(typeName.equals("Belgian Ale")){
		smalltype = 11;
	}else if(typeName.equals("Flanders Red Ale")){
		smalltype = 12;
	}else if(typeName.equals("Pale Lager")){
		smalltype = 13;
	}else if(typeName.equals("Helles")){
		smalltype = 14;
	}else if(typeName.equals("Dark Lager")){
		smalltype = 15;
	}else if(typeName.equals("Pilsener")){
		smalltype = 16;
	}else if(typeName.equals("Dunkel")){
		smalltype = 17;
	}else if(typeName.equals("Schwarzbier")){
		smalltype = 18;
	}else if(typeName.equals("Export")){
		smalltype = 19;
	}else if(typeName.equals("Steam Beer")){
		smalltype = 20;
	}else if(typeName.equals("Bock")){
		smalltype = 21;
	}else if(typeName.equals("Rauchbier")){
		smalltype = 22;
	}else if(typeName.equals("Vienna Lager")){
		smalltype = 23;
	}else if(typeName.equals("Marzen")){
		smalltype = 24;
	}
    tMgr.updateTrand(usernum, smalltype);
%>
<script>
	location.href="../index/Trand.jsp"
</script>