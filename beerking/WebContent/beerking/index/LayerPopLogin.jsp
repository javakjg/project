<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<%
	String URL = request.getRequestURL().toString();
%>
<link rel="stylesheet" type="text/css" href="../css/LayerPopLogin.css">
<head>
<style>
	#userjoinTab input{
		width:300px;
		margin-bottom:3px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
    $("#alert-success").hide();
    $("#alert-danger").hide();
    $("input").keyup(function(){
        var pwd1=$("#pwd").val();
        var pwd2=$("#pwd2").val();
        if(pwd1 != "" || pwd2 != ""){
            if(pwd1 == pwd2){
                $("#alert-success").show();
                $("#alert-danger").hide();
                $("#UserjoinSubmit").removeAttr("disabled");
            }else{
                $("#alert-success").hide();
                $("#alert-danger").show();
                $("#UserjoinSubmit").attr("disabled", "disabled");
            }    
        }
    });
});
$(function(){
	 $("#emailO").hide();
	 var idcheck =  $("#idcheck2").val();
	 var idcheck2 = "no";
	 $("#pwd").attr("disabled", "disabled");
	 $("#pwd2").attr("disabled", "disabled");
	if(idcheck != idcheck2){
		$("#emailX").hide();
		$("#idcheck2").hide();
		$("#emailO").show();
		$("#pwd").removeAttr("disabled");
		$("#pwd2").removeAttr("disabled");
	}else{
		$("#emailO").hide();
		$("#emailX").show();
	}
});

function cheakMail(email){
	url = "../proc/emailcheckProc.jsp?email="+email;
	window.name = "MailCheackProc";
	window.open(url, "post","width=500, height=350, resizable = no, scrollbars = no");
}
</script>
</head>
<body>
	<div class="modal_Login">
		<div class="modal_Login_content">
			<img src="../css/Beerking-logo.png" width="300" height = "150">
			<h1 class="title" style ="margin-bottom: 30px;">로그인</h1>
			<form id="loginForm" action="../proc/UserLoginProc.jsp" method="POST" >
				<table align="center">
					<tr>
						<td>
							<input name="email" placeholder="이메일" required="required">
						</td>
					</tr>
					<tr>
						<td>
							<input  type="password" name="pwd" placeholder="비밀번호" required="required">
						</td>
					</tr>
					
					<tr>
						<td>
							<input type="submit" id="loginSubmit" value="로그인">
						</td>
					</tr>
						<input type="hidden" name="URL" value="<%=URL%>">
				</table>
				
				<table align="center" >
						<hr>
						<td>
							<input type="button" class="joinButton" value="회원가입" style="font-size:15px">
						</td>
						<td>
							<input type="button" class="emailSearchButton" value="아이디 찾기" style="font-size:15px">
						</td>
						<td>
							<input type="button" class="pwdSearchButton" value="비밀번호 찾기" style="font-size:15px">
						</td>
					</table>
			</form>
		</div>
	</div>
	<div class="modal_Join">
		<div class="modal_Join_content">
			<img src="../css/Beerking-logo.png" width="300" height = "150">
			<h1 class="title" style ="margin-bottom: 30px;">회원가입</h1>
			<form name="joinProcFrm" id="joinProcFrm" action="../proc/UserJoinProc.jsp" method="POST">
				<table align="center" id="userjoinTab" style="width: 520px;margin-left: 20px;">
					<tr>
						<td style="width:400px;text-align:center;"><input type="email" name="email" id="email1" placeholder="이메일" required="required">
						</td>				
						<td align="">
							<span id="emailO" style="width:120;"><font color="green" size="4">O</font></span>
							<span id="emailX" style="width:120;">
							<button style="border-radius: 6px;height: 40px; width:70px; background-color: #efefef; margin-left: -70;
    						border: 1px solid #dedede;color: #3a3a3a;" onclick="cheakMail(this.form.email.value)">중복체크</button>&nbsp;&nbsp;<font color="red" size="4">X</font> </span>
							<input type="hidden" name="idcheck2" id="idcheck2" value="no">
						</td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input type="password" name="pwd" id="pwd"placeholder="비밀번호" required="required"></td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input type="password" name="pwd2" id="pwd2"placeholder="비밀번호 확인" required="required"></td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;">
							<div class="alert alert-success" id="alert-success"  style="width:400px;background-color:forestgreen;margin:auto;border-radius: 6px;">비밀번호가 일치합니다.</div>
							<div class="alert alert-danger" id="alert-danger" style="width:400px;background-color:red;margin:auto;border-radius: 6px;">비밀번호가 일치하지 않습니다.</div>
						</td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input name="name" placeholder="이름" required="required"></td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input name="nickname" placeholder="별명" required="required"></td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input name="address" placeholder="주소" required="required"></td>
					</tr>
					<tr>
						<td style="width:400px;text-align:center;"><input name="tel" placeholder="전화번호" required="required"></td>
					</tr>
						<td style="width:450px; text-align:center;">
							<input type="submit" id="UserjoinSubmit" value="회원가입" style="width:280px;height:50px;">
						</td>
						<input type="hidden" name="URL" value="<%=URL%>">
				</table>
			</form>
		</div>
	</div><div class="modal_EmailSearch">
		<div class="modal_EmailSearch_content">
			<img src="../css/Beerking-logo.png" width="300" height = "150">
			<h1 class="title" style ="margin-bottom: 30px;">아이디 찾기</h1>
			<form id="emailForm" action="../proc/UserPwdSearchProc.jsp" method="POST">
				<table align="center">
					<tr>
						<td><input name="name" placeholder="이름" required="required"></td>
					</tr>
					<tr>
						<td><input name="tel" placeholder="전화번호" required="required"></td>
					</tr>
						<td>
							<input type="submit" id="UserEmailSearchSubmit" value="아이디 찾기">
						</td>
						<input type="hidden" name="URL" value="<%=URL%>">
				</table>
			</form>
		</div>
	</div>
	</div><div class="modal_PwdSearch">
		<div class="modal_PwdSearch_content">
			<img src="../css/Beerking-logo.png" width="300" height = "150">
			<h1 class="title" style ="margin-bottom: 30px;">비밀번호 찾기</h1>
			<form id="pwdForm" action="../proc/UserPwdSearchProc.jsp" method="POST">
				<table align="center">
					<tr>
						<td><input name="email" placeholder="이메일" required="required"></td>
					</tr>
					<tr>
						<td><input name="name" placeholder="이름" required="required"></td>
					</tr>
						<td>
							<input type="submit" id="UserPwdSearchSubmit" value="비밀번호 찾기">
						</td>
						<input type="hidden" name="URL" value="<%=URL%>">
				</table>
			</form>
		</div>
	</div>
</body>



