<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<div>
	<input type="radio" name="chk_info" value="HTML">성공 <input
		type="radio" name="chk_info" value="CSS" checked="checked">실패
</div>
<div align="center">
	<br> <b><font size="5" color="gray">방명록</font></b> <br>
</div>
<div id="wrap" align="center">
	<div id="writeGuestForm">
		<form name="guestbookInfo" method="post" action="insert">
			<table width="700">
				<tr>
					<td>이름 :</td>
					<td><input type="text" name="name" value="aaa"></td>
					<td>비밀번호 :</td>
					<td><input type="password" name="pwd" value="1234"></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4"><textarea rows="7" cols="80" name="content"></textarea>
					</td>
				</tr>
			</table>
			<br>
			<button onclick="to_ajax();">등록</button>
		</form>
	</div>
	</br> </br> </br> </br>
	<!-- 글 등록 부분 끝-->
	<!-- 글 목록 부분 시작 -->
	<div id="listGuestForm">
		<form method="post" name="">

			<!-- 방명록 내용 부분 -->
			<div id="comment">
				<table width="500" border="1">
					<tr>
						<td>이름</td>
						<td>내용</td>
						<td>수정삭제</td>
					</tr>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.name}</td>
							<td>${dto.content}</td>
							<td>><a href="delete?Bookid=${dto.bookid }">삭제</a>
						</tr>
					</c:forEach>
				</table>
			</div>

			<!-- 페이지 부분 -->
			<div id="pageForm"></div>
		</form>
	</div>
	<!-- 글 목록 부분 끝 -->

</div>