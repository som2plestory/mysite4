<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 회원가입</title>

<!-- css -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">

<!-- js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
	
</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->

		<div id="container" class="clearfix">
			
			<c:import url="/WEB-INF/views/includes/aside/user.jsp"></c:import>
			<!-- //aside -->

			<div id="content">
			
				<div id="content-head">
					<h3>회원가입</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>회원</li>
							<li class="last">회원가입</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->
	
				<div id="user">
					<div id="joinForm">
						<form id="join-form" action="${pageContext.request.contextPath}/user/join" method="post">
							
							<div class="form-group">
								<span class="form-text"></span> 
								<span style="color:#0000FF;">*표시된 부분은 필수입니다.</span>
								<%-- 								
								<c:choose>
									<c:when test="${userVo.password == '' || userVo.name == ''}">
										<span style="color:#FF0000;">회원가입 실패: *표시된 부분은 필수입니다.</span>
									</c:when>
									<c:otherwise>
										<span style="color:#0000FF;">*표시된 부분은 필수입니다.</span>
									</c:otherwise>
								</c:choose>
								 --%>
							</div>
							
							<!-- 아이디 -->
							<div class="form-group">
								<label class="form-text" for="input-uid">*아이디</label> 
								<input type="text" id="input-uid" name="id" placeholder="아이디를 입력하세요.">
									<!-- 
									<c:if test="${userVo.id != ''}">
										value="${userVo.id}"
									</c:if>
									 -->
								<button type="button" id="btn-idCheck">중복체크</button>
								
							</div>

							<!-- 비밀번호 -->
							<div class="form-group">
								<label class="form-text" for="input-pass">*비밀번호</label> 
								<input type="password" id="input-pass" name="password" value="" placeholder="비밀번호를 입력하세요"	>
							</div>
	
							<!-- 이름 -->
							<div class="form-group">
								<label class="form-text" for="input-name">*이름</label> 
								<input type="text" id="input-name" name="name" value="" placeholder="이름을 입력하세요">
									<%-- <c:if test="${userVo.name != ''}">value="${userVo.name}"</c:if> --%>
							</div>
	
							<!-- 성별 -->
							<div class="form-group">
								<span class="form-text">성별</span> 
								
								<label for="rdo-male">남</label> 
								<input type="radio" id="rdo-male" name="gender" value="male" 
									<c:if test="${userVo.gender == 'male'}"> checked="checked" </c:if>> 
								<label for="rdo-female">여</label> 
								<input type="radio" id="rdo-female" name="gender" value="female"  
									<c:if test="${userVo.gender == 'female'}"> checked="checked" </c:if>>
							</div>
	
							<!-- 약관동의 -->
							<div class="form-group">
								<span class="form-text">*약관동의</span> 
								<input type="checkbox" id="chk-agree" name="agree" value="true">
								<label for="chk-agree">서비스 약관에 동의합니다.</label> 
								<!-- <span style="color:#FF0000;">약관에 동의하지 않으면 가입이 불가합니다.</span> -->
							</div>
							
							<!-- 버튼영역 -->
							<div class="button-area">
								<button type="submit" id="btn-submit">회원가입</button>
							</div>
							
						</form>
					</div>
					<!-- //joinForm -->
				</div>
				<!-- //user -->
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

/* 아이디 중복 확인 */
$("#btn-idCheck").on("click", function(){
	console.log("아이디 중복 확인 버튼 클릭")
	
	//데이터
	var id = $("[name = 'id']").val()
	
	//ajax
	$.ajax({
		
		url : "${pageContext.request.contextPath }/user/idCheck",
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(id),
		dataType : "json",
		success : function(result){
			console.log(reslut)
			
			if(result == "success"){
				alert("사용 가능한 아이디입니다.")
				//$("#idCheck").html("사용 가능한 아이디입니다.")
				//$("#idCheck").css("color", "blue")
			
			}else{
				alert("사용 불가능한 아이디입니다.")
				//$("#idCheck").html("사용 불가능한 아이디입니다.")
				//$("#idCheck").css("color", "red")
			}
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			
		} 
	})
})



$("#join-form").on("submit", function(){
	console.log("회원가입 버튼 클릭")
	
	var id = $("#input-uid").val()
	var password = $("#input-pass").val()
	var name = $("#input-name").val()
	
	if(id == "" || id == null){
		alert("아이디를 입력해주세요")
		return false
	}
	
	if(password == "" || password == null){
		alert("비밀번호를 입력해주세요")
		return false
	}else if(password.length < 8){
		alert("비밀번호는 8자리 이상만 가능합니다")
		return false
	}
	
	if(name == "" || name == null){
		alert("이름을 입력해주세요")
		return false
	}
	
	//약관동의
	var agree = $("#chk-agree").is(":checked")
	if(agree == false){
		alert("약관에 동의하지 않으면 회원가입이 불가능합니다")
		return false
	}
	
	return true
})

</script>

</html>