<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 방명록</title>

<!-- CSS -->
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->
	
		<div id="container" class="clearfix">
			
			<c:import url="/WEB-INF/views/includes/aside/guestbook.jsp"></c:import>
			<!-- //aside -->

			<div id="content">
				
				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<%-- <form action="${pageContext.request.contextPath}/api/guestbook/add" method="get"> --%>
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td class="text-center"><label class="form-text" for="input-uname">이름</label></td>
									<td><input id="input-uname" type="text" name="name"></td>
									<td class="text-center"><label class="form-text" for="input-upassword">패스워드</label></td>
									<td><input id="input-upassword"type="password" name="password"></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button id="btnSubmit" type="submit">등록</button></td>
								</tr>
							</tbody>
							
						</table>
						<!-- //guestWrite -->
						
					<!-- </form> -->	
					
					<div id = "listArea">
					</div>
					
					
				</div>
				<!-- //guestbook -->
			
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
	/* 리스트 요청 + 그리기 */
	//fetchList()!!!!!!!!! 
	fetchList()
})
 
 
 
/* 저장버튼을 클릭 했을 때 */
$("#btnSubmit").on("click", function(){
	console.log("저장버튼 클릭")
	
	//데이터 수집 [속성=""]
	var name = $("[name = 'name']").val()
	var password = $("[name = 'password']").val()
	var content = $("[name = 'content']").val()
	
	//데이터 객체로 묶기
	var guestVo = {
		name: name,
		password: password,
		content: content
	}
	
	//ajax!!!
	$.ajax({
		
		/* 길어질수록 불편하니 미리 객체로 묶어오기 */
		/* url : "${pageContext.request.contextPath }/api/guestbook/add?name="+name+"&password="+password+"&content="+content,*/
		url : "${pageContext.request.contextPath }/api/guestbook/add",
		type : "post",
		//contentType : "application/json",
		
		//파라미터 정리
		data : guestVo,
		
		dataType : "json",
		success : function(gVo){
			
			/* 1개데이터 리스트 추가(그리기:render)하기 */
			render(gVo, "up");
			
			/* 입력폼 초기화 */
			$("[name = 'name']").val("");
			$("[name = 'password']").val("");
			$("[name = 'content']").val("");
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
		}
			
	})
})
 
 
 
/* 리스트 요청 */
function fetchList(){
	//ajax!!!
	$.ajax({
		
		url : "${pageContext.request.contextPath}/api/guestbook/list",		
		type : "post",
		//contentType : "application/json",
		//data : {name: ”홍길동"},
		
		dataType : "json",
		success : function(guestbookList){
				
			//화면 data + html 그린다
			for(var i=0; i<guestbookList.length; i++){
					
					//render()!!!!!!!!!
					render(guestbookList[i], "down")	//vo --> 화면에 그린다.
			}
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			
		}
	})
}



/* 리스트 그리기 1개씩 */
function render(guestbookVo, opt){
	console.log("render()")
	
	
	var str = ''
	str += '<table class="guestRead">'
	str += '    <colgroup>'
	str += '       	<col style="width: 10%;">'
	str += '        <col style="width: 40%;">'
	str += '        <col style="width: 40%;">'
	str += '        <col style="width: 10%;">'
	str += '    </colgroup>'
	str += '    <tr>'
	str += '        <td>'+guestbookVo.no+'</td>'
	str += '        <td>'+guestbookVo.name+'</td>'
	str += '        <td>'+guestbookVo.regDate+'</td>'
	str += '        <td class="text-center">'
	str += '        	<a href="${pageContext.request.contextPath}/api/guestbook/deleteForm?no='+guestbookVo.no+'">삭제</a>'
	str += '        </td>'
	/* 
	str += '        <td>'
	str += '        	<button style=" width: 100%;'
	str += '    						border: #FFFFFF;'
	str += '    						background-color: #FFFFFF;'
	str += '    						cursor: pointer;"'
	str += '    		class="btnDelete" type="submit">삭제</button></td>'
	 */
 	str += '    </tr>'
	str += '    <tr>'
	str += '        <td colspan=4 class="text-left">'+guestbookVo.content+'</td>'
	str += '    </tr>'
	str += '</table>'
	
	
	if(opt == "down"){
		$("#listArea").append(str)
		
	}else if(opt == "up"){
		$("#listArea").prepend(str)
			
	}else{
		console.log("opt오류")
		
	}
}


</script>
</html>