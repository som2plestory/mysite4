<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 방명록 삭제</title>

<!-- CSS -->
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->

		<div id="container" class="clearfix">
			
			<c:import url="/WEB-INF/views/includes/aside/guestbook.jsp"></c:import>
			<!-- //aside -->

			<div id="content">
			
				<div id="content-head">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->
				
				<input type="hidden" name="no" value="${no}">
				<div id="guestbook">
				<%-- 
					<form action="${pageContext.request.contextPath}/guestbook/delete" method="post">
					<input type="hidden" name="no" value="${guestbookVo.no}">
						<table id="guestInfo">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 70%;">
								<col style="width: 20%;">
							</colgroup>
							<tbody>
								<tr>
									<td>${guestbookVo.no}</td>
									<td>${guestbookVo.name}</td>
									<td class="text-center">${guestbookVo.regDate}</td>
								</tr>
								<tr>
									<td colspan=3 class="guestDeleteContent">
										${guestbookVo.content}
									</td>
								</tr>
							</tbody>
						</table>
						
						<table id="guestDelete">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 40%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
							</colgroup>
							<tbody>
								<tr>
									<td class="text-center"><label for="input-upassword">비밀번호</label></td>
									<td class="text-center">
										<input type="password" id="input-upassword" name="password" value="" placeholder="삭제하려면 비밀번호를 입력하세요.">
									</td>
									<td class="text-center"><button type="submit">삭제</button></td>
									<td class="text-center"><a href="./addList">[목록으로 돌아가기]</a></td>
								</tr>
							</tbody>
						</table>
					</form>
					 --%>
				</div>
				<!-- //guestbook -->
				<div id="deleteFail" style="color:#FF0000;" class="float-l">
					<c:if test="${guestbookDelete == 'Fail'}">방명록 삭제 실패: 비밀번호가 틀립니다.</c:if>
				</div>
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->
		
		<!-- footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

</body>

<script type="text/javascript">


/* 준비가 끝나면 - "" 쓰지 않는 것 유의 */
$(document).ready(function(){
	/* 방명록 정보 요청 + 그리기 */
	//guestbookInfo()!!!!!!!!! 
	guestbookInfo()
})



/* 삭제할 방명록 정보 요청 */
function guestbookInfo(){
	
	//데이터
	var no = $("[name = 'no']").val()

	//ajax!!!
	$.ajax({
		
		url : "${pageContext.request.contextPath}/api/guestbook/deleteInfo?no="+no,		
		type : "post",
		
		//파라미터 정리
		data : no,
		
		dataType : "json",
		success : function(guestbook){
			
			//화면에 그리기
			//render()!!!!!!!!!
			render(guestbook, "on")
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			
		}
	})	
}



/* 삭제할 방명록 정보 그리기 */
function render(guestbookVo, opt){
	console.log("render()")
	
	var str = ''
	str += '<table id="guestInfo">'
	str += '	<colgroup>'
	str += '		<col style="width: 10%;">'
	str += '		<col style="width: 70%;">'
	str += '		<col style="width: 20%;">'
	str += '	</colgroup>'
	str += '	<tbody>'
	str += '		<tr>'
	str += '			<td>'+guestbookVo.no+'</td>'
	str += '			<td>'+guestbookVo.name+'</td>'
	str += '			<td class="text-center">'+guestbookVo.regDate+'</td>'
	str += '		</tr>'
	str += '		<tr>'
	str += '			<td colspan=3 class="guestDeleteContent">'+guestbookVo.content+'</td>'
	str += '		</tr>'
	str += '	</tbody>'
	str += '</table>'
	str += '<table id="guestDelete">'
	str += '	<colgroup>'
	str += '		<col style="width: 10%;">'
	str += '		<col style="width: 40%;">'
	str += '		<col style="width: 25%;">'
	str += '		<col style="width: 25%;">'
	str += '	</colgroup>'
	str += '	<tbody>'
	str += '		<tr>'
	str += '			<td class="text-center"><label for="input-upassword">비밀번호</label></td>'
	str += '			<td class="text-center">'
	str += '				<input type="password" id="input-upassword" name="password" value="" placeholder="삭제하려면 비밀번호를 입력하세요.">'
	str += '			</td>'
	str += '			<td class="text-center"><button type="submit">삭제</button></td>'
	str += '			<td class="text-center"><a href="${pageContext.request.contextPath}/guestbook/addList">[목록으로 돌아가기]</a></td>'
	str += '		</tr>'
	str += '	</tbody>'
	str += '</table>'
	
	
	if(opt == "on"){
		$("#guestbook").html(str)
		
	}else{
		console.log("opt오류")
		
	}
}


</script>

</html>