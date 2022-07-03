<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYSITE: 갤러리</title>

<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/css/gallery.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>

</head>


<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<!-- //header -->
		<!-- //nav -->

		<c:import url="/WEB-INF/views/includes/aside/gallery.jsp"></c:import>
		<!-- //aside -->


		<div id="content">

			<div id="content-head">
				<h3>갤러리</h3>
				<div id="location">
					<ul>
						<li>홈</li>
						<li>갤러리</li>
						<li class="last">갤러리</li>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<!-- //content-head -->


			<div id="gallery">
				<div id="list">
			
					<c:if test="${!empty authUser}">
						<button id="btnImgUpload">이미지올리기</button>
						<div class="clear"></div>
					</c:if>
			
					<ul id="viewArea">
						
						<!-- 이미지반복영역 -->
						<c:forEach items="${galleryList}" var="galleryVo" varStatus="status">
							<li id="imageNo${galleryVo.no}">
								<div class="view">
									<img class="imgItem" src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}" 
										 data-no="${galleryVo.no}" 
										 data-src="${pageContext.request.contextPath}/upload/${galleryVo.saveName}"
										 data-content="${galleryVo.content}">
									<div class="imgWriter">작성자: <strong>${galleryVo.userName}</strong></div>
								</div>
							</li>
						</c:forEach>
						<!-- 이미지반복영역 -->
						
						
					</ul>
				</div>
				<!-- //list -->
			</div>
			<!-- //board -->
		</div>
		<!-- //content  -->
		<div class="clear"></div>

		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

	
		
	<!-- 이미지등록 팝업(모달)창 -->
	<div class="modal fade" id="addModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">이미지등록</h4>
				</div>
				
				<form method="post" action="${pageContext.request.contextPath}/gallery/upload" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="form-group">
							<label class="form-text">글작성</label>
							<input id="addModalContent" type="text" name="content" value="" >
						</div>
						<div class="form-group">
							<label class="form-text">이미지선택</label>
							<input id="file" type="file" name="file" value="" >
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn" id="btnUpload">등록</button>
					</div>
				</form>
				
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	


	<!-- 이미지보기 팝업(모달)창 -->
	<div class="modal fade" id="viewModal">
		<div class="modal-dialog" >
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">이미지보기</h4>
				</div>
				<div class="modal-body">
					
					<div id="viewModelImg" class="formgroup">
						<!-- <img id="viewModelImg" src ="">  --><!-- ajax로 처리 : 이미지출력 위치-->
					</div>
					
					<div class="formgroup">
						<p id="viewModelContent"></p>
					</div>
					
				</div>
				<!-- <form method="post" action=""> -->
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<c:if test="${!empty authUser}">
						<button type="button" class="btn btn-danger" id="btnDel">삭제</button>
						<input type="hidden" name="no" value="">
					</c:if>
				</div>
				<!-- </form> -->
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->	


</body>

<script type="text/javascript">

/* 이미지 올리기 */
$("#btnImgUpload").on("click", function(){
	console.log("이미지올리기 버튼 클릭")
	
	$("#addModal").modal("show")
})


/* 모달창-등록버튼 */
$("#btnUpload").on("click", function(){
	console.log("모달창 - 이미지 등록 버튼 클릭")
	
	var content = $("#addModal [name='content']").val()
	var orgName = $("#addModal [name='file']").val()
	
	if(orgName == "" || orgName == null){
		console.log("선택된 파일 없음")
		alert("파일을 선택해주세요")
		return false
	}
	return true
})


/* 이미지 보기 */
$("#viewArea").on("click", ".imgItem", function(){
	console.log("이미지 클릭")
	
	var $this = $(this)
	var no = $this.data("no")
	var src = $this.data("src")
	var content = $this.data("content")
	
	console.log(no)
	console.log(src)
	
	var str ='<img src="'+src+'">'
	
	$("#viewModelImg").html(str)
	$("#viewModelContent").html(content)
	$("[button='button']").val("")
	$("[name='no']").val(no)
	
	$("#viewModal").modal("show")
})


/* 모달창 삭제 버튼을 눌렀을 때 */
$("#btnDel").on("click", function(){
	console.log("이미지 삭제 버튼 클릭")
	
	var no = $("[name='no']").val()
	console.log(no)

	$.ajax({
		url : "${pageContext.request.contextPath}/gallery/delete",		
		type : "post",
		contentType : "application/json",
		data : JSON.stringify(no),
		dataType : "json",
		
		success : function(result){
			console.log(result)
			
			if(result == "success"){
				console.log("#imageNo"+no)
				$("#imageNo"+no).remove()
			}
			
			$("#viewModal").modal("hide")
			
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			
		} 
	})
})

</script>




</html>

