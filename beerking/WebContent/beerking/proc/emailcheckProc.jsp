<!-- emailcheckProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR" %>
<%	request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="uMgr" class="beerking.UserDataMgr"/>
<%
	String email = "";
	if(request.getParameter("email") !="null"||!request.getParameter("email").equals("")){
		email = request.getParameter("email");
	}
	int cheeeee = 0;
	String msg = "�������� ������� �Ѿ���̽��ϴ�.";
	if(email.equals("")){
		msg = "email �� ��ĭ���� �ѱ�� �����ϴ�.";
		cheeeee = 1;
	}else if(uMgr.emailCheck(email)==true){
		msg = email+" �� �ߺ��� ���̵��Դϴ�.";
		cheeeee = 1;
	}else if(uMgr.emailCheck(email)==false){
		msg = email+" �� ����Ҽ� �ִ� ���̵��Դϴ�.";
	}
%>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	function checkmails(email){
		$("#idcheck2",opener.document).val("Yes");
		$("#email1",opener.document).val(email);
		if(opener !=null){
			 var idcheck =  $("#idcheck2",opener.document).val();
			 var idcheck2 = "no";
			 $("#pwd").attr("disabled", "disabled");
			 $("#pwd2").attr("disabled", "disabled");
			if(idcheck != idcheck2){
				$("#emailX",opener.document).hide();
				$("#idcheck2",opener.document).hide();
				$("#emailO",opener.document).show();
				$("#pwd",opener.document).removeAttr("disabled");
				$("#pwd2",opener.document).removeAttr("disabled");
			}else{
				$("#emailO",opener.document).hide();
				$("#emailX",opener.document).show();
			}
			self.close();
		}
	}
</script>
<body>
	<div style="text-align:center;width:480px;height:150px;margin-top:50px;">
			<%=msg %>
	</div>
	<form id="emails" style="text-align:center;width:480px;height:100px;">
		<input type="button" id="cancel" value="���" onclick="window.close()" style="width:100px;height:30px">
		<%if(cheeeee==0){ %><input type="button" id="submitemail" value="����ϱ�" onclick="checkmails('<%=email%>')" style="width:100px;height:30px"><%} %>
	</form>
</body>