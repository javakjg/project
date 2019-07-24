<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<script>
function to_ajax() {
	var form = $("#aaa").serialize();
	var re2 = /<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>/;
 	if($("#content").val()==""||re2.test($("#content").val())){
		alert("제대로 입력하세요.");
	}
	else{
	$.ajax({										// ajax 사용.
		url: "insert", 								//Controller 매핑 된 링크
		type: "POST", 								//주소 전달 방식
		data: form,									//넘길 데이터, 넘길타입은 contentType
		dataType: 'html',							//받을 타입
		success: function(data){
			 $("#ccc").load("GuestBook #products");	//특정 id를 찾아 그 부분만 Load하는 것. Guest북의 #ccc에서 #products를 로드함.
			 $('#content').val('');					//textbox id의 값(value)을 공백으로 설정
			 $Paging.submit();						//페이징 리스트 출력
			 PageChange(($('#nowPage').val()-1));
		},
		error: function(data){
			alert("에러");
		}//error
	});//ajax
}//else
}//to_ajax
function delAjax(bookid) {
	var id = "bookid=" + bookid;	//bookid=???로 전달하기 위한 변수 선언
	$.ajax({
		url: "delete",				
		type: "POST",
		data: id,
		success: function(data){
			 $("#ccc").load("GuestBook #products");
			 $Paging.submit();
			 PageChange(($('#nowPage').val()-1));
		},
		error: function(data){
			alert("에러");
		}
	});
}
function PageChange(pageNumber){
	var pNum = "pNum="+(pageNumber+1);
	var numPerPage = "eNum="+$('#numPerPage option:selected').val();
	var aNum = pNum+"&"+numPerPage;
	$('#nowPage').val(pageNumber+1);
	$.ajax({
		url: "GuestBook",				
		type: "GET",
		data: aNum,
		success: function(data){
			var change = $(data).find('#products');		//ajax로 가져 온 data에서 #products 부분을 찾음
			$('#products').replaceWith(change);			//product 부분을 ajax로 가져 온 데이터 값으로 변경
		},
		error: function(data){
			alert("에러");
		}
	});
}
function PageNext(nPage){
	$('#pageUL').remove();
	$Paging.after('<div id="pageUL" style="width:600px; margin:10px">');
	var numPerPage = $('#numPerPage option:selected').val();	//페이지 당 게시물 수
	var empty = 0;
	$.ajax({
		url: "total",				
		type: "GET",
		data: empty,
		dataType:"text",
		success: function(data){
		var TotalRecord = data; 								// 총 게시물 32
			var PagePerBlock = 5;//option:selected				// 블럭당 페이지 3
			var TotalPage = Math.ceil(TotalRecord/ numPerPage); // 총 페이지 
			var nam = TotalPage-(nPage+1);						// 나머지  11-3=2
			var i = (nPage+1);									// 넘어온 값
			if((nPage+2)>PagePerBlock){
				$('<a href="javascript:PageNext('+(nPage-5)+')" class="btn btn-outline-info" style="margin:2px">[Prev] </a>')
				.appendTo('#pageUL');
			}
			if(PagePerBlock<nam){								// 
				var nextTotal = i+PagePerBlock;					// .length
				for(; i<nextTotal; i++){
						$('<a href="javascript:PageChange('+i+')" id="pNum'+i+' "class="btn btn-primary" style="margin:2px"></a>') // 페이징 목록 생성
								.attr('value', i+1)
								.html((i+1)+' ')
								.appendTo('#pageUL');
						if(i==(nextTotal-1)){
							$('<a href="javascript:PageNext('+i+')" class="btn btn-outline-info" style="margin:2px">[Next]</a>')
							.appendTo('#pageUL');
						}
					}//for
				}//if
				else{
					var nextTotal = TotalPage;				// .length
					for(; i<nextTotal; i++){
							$('<a href="javascript:PageChange('+i+')" id="pNum'+i+'" class="btn btn-primary" style="margin:2px"></a>') // 페이징 목록 생성
									.attr('value', i+1)
									.html((i+1)+' ')
									.appendTo('#pageUL');
						}//for
				}
			}//success
		});//ajax
}//function pageNext
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 
<c:set var= "numPerPage" value="5"></c:set>
<c:set var= "PagePerBlock" value="3"></c:set>
<c:set var= "totalPage" value="${(totalRecode / numPerPage) + (1 -((totalRecode / numPerPage)%1))%1}"></c:set>
<c:set var= "nowBlock" value="${(totalPage / PagePerBlock) + (1 -((totalPage / PagePerBlock)%1))%1}"></c:set>

페이징 처리 준비중 <br>
게시물 총 개수 : <c:out value="${totalRecode}"></c:out>/ <br>
전체페이지 수 : <fmt:parseNumber value="${(totalRecode / numPerPage) + (1 -((totalRecode / numPerPage)%1))%1}"/><br>
전체블럭수 수 : <fmt:parseNumber value="${nowBlock }"/><br>
현재 블럭 : <fmt:parseNumber value="${(nowPage / PagePerBlock) + (1 -((nowPage / PagePerBlock)%1))%1}"/>


<input type="button" value="3" onclick="javascript:test(3);">
 --%>
<form style="width:600px; margin:10px">
<input type="radio" name="snf"/> 성공
<input type="radio" name="snf" checked="checked" /> 실패(Checked)</br>
<select id ="numPerPage" onchange="nPageList()" class="custom-select" style="width : 70px;">
<option value="3">3개
<option value="5">5개
<option value="10">10개
</option>
</select></br></br></br>
</form>
<div id="ddl">
    <b><font size="5" color="gray" style="margin:10px">방명록</font></b>
	        <form id="aaa" method="POST">
	            <table style="width:600px; margin:10px">
	            <tbody>
	                <tr>
	                    <td>이름 : </td>
	                    <td><input type="text" name="name" id="name" value="aaa" class="form-control"></td>
	                    <td>비밀번호 : </td>
	                    <td><input type="password" name="pwd" id="pwd" value="1234" class="form-control"></td>
	                </tr>
	                <tr><td colspan="4">&nbsp;</td></tr>
	                <tr>
	                    <td colspan="4">
	                        <textarea rows="7" cols="80" name="content" id="content" class="form-control"></textarea>
	                    </td>
	                </tr>
	                <tr>
	                	<td colspan="4" align="right">
	                		<input type="button" value="등록" onclick="javascript:to_ajax();" class="btn btn-outline-success" style="width:100px; margin:10px;">
	                	</td>
	                </tr>
	                </tbody>
	            </table>
	            <br>
	            <!-- <a href='javascript:to_ajax();'> 등록</a> -->
	        </form>
</div>
	    </br>
	    </br>
	   <!-- 글 등록 부분 끝-->
	    <!-- 글 목록 부분 시작 -->
	            <!-- 방명록 내용 부분 -->
<div id="ccc" name="ccc">
<table id ="products" class="table table-hover" style="width:600px; margin:10px">
						<thead>
							<tr>
								<th scope="row">이름</td>
								<th scope="row">내용</td>
								<th scope="row">수정삭제</td>
							</tr>
						</thead>
							<c:forEach items="${list}" var="dto">
							<tbody>
								<tr>
									<th scope="row">${dto.name}</td>
									<td>${dto.content}</td>
									<td><a href="javascript:delAjax(${dto.bookid })" class="btn btn-outline-primary" >삭제</a></td>
								</tr>
						</c:forEach>
</table>
</div>
<form action="" id="setting">
<div id="pageUL">

</div>
<input type="hidden" id="nowPage" value="1">
</body>
<!-- <script type="text/javascript">

var $setRows = $('#setRows');

$setRows.submit(function (e) {
	e.preventDefault();
	var rowPerPage = $('[name="rowPerPage"]').val() * 1;// 1 곱 문자->숫자형  numPerPage
	var pageTotal = Math.ceil(rowTotals/ rowPerPage); // totalPage
	var $tr = $($products).find('tbody tr'); //tr의 위치를 찾기.
	var rowTotals = $tr.length; //게시물 수

//		console.log(typeof rowPerPage);

	var zeroWarning = '0넣지마라.';
	if (!rowPerPage) {
		alert(zeroWarning);
		return;
	}


$setRows.submit();

</script> -->
<script type="text/javascript">
var $Paging = $('#setting');
$Paging.submit(function (e){
	e.preventDefault();
	var numPerPage = $('#numPerPage option:selected').val();	//페이지 당 게시물 수
	var pagePerBlock = 5;										//블럭당 페이지 수
	var empty = 0;
	$('#pageUL').remove();
	$Paging.after('<div id="pageUL" style="width:1000px; margin:10px">');
	$.ajax({
		url: "total",				
		type: "GET",
		data: empty,
		dataType:"text",
		success: function(data){
			var TotalRecord = data;
			var TotalPage = Math.ceil(TotalRecord/ numPerPage); //총페이지
			if (pagePerBlock > TotalPage) {
				pagePerBlock = TotalPage;
			}
			var i = 0;
			for (; i < pagePerBlock; i++) {
/* 				if(($('#nowPage').val()-1)==i){
				$('<a href="javascript:PageChange('+i+')" id="pNum'+i+'"><font color="red">['+(i+1)+'] </font></a>') // 페이징 목록 생성
						.attr('value', i+1)
						.appendTo('#pageUL');
				console.log("들어왔어요 한번이에요")
				}
				else{ */
					$('<a href="javascript:PageChange('+i+')" class="btn btn-primary" id="pNum'+i+'" style="margin:2px"></a>"  "') // 페이징 목록 생성
					.attr('value', i+1)
					.html((i+1)+' ')
					.appendTo('#pageUL');
				/* } */
			}//for
				if(TotalPage>pagePerBlock){//pagePerBlock이 홀수면 -1을 지워야 됨. 짝수는반대
					$('<a href="javascript:PageNext('+(i-1)+')" class="btn btn-outline-info" style="margin:2px">Next</a>')
					.appendTo('#pageUL');
				}//if
		},
		error: function(data){
			alert("에러");
		}
	});
})
$Paging.submit();
function nPageList(){
	$Paging.submit();
	PageChange("0");
}
</script>
</html>
