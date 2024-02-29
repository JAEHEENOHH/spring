<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>공지사항</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="shortcut icon" type="image/x-icon" href="assets/favicon.ico" />
<link rel="apple-touch-icon" sizes="57x57" href="assets/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="assets/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="assets/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="assets/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="assets/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="assets/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="assets/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="assets/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="assets/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192" href="assets/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="assets/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="assets/favicon-16x16.png">
<link rel="manifest" href="assets/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link href="css/board.css?ver=0.01" rel="stylesheet" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- summer note -->
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<script src="/js/summernote/summernote-bs4.min.js"></script>
<link href="/css/summernote/summernote-lite.css" rel="stylesheet">
<link href="/css/summernote/summernote-bs4.min.css" rel="stylesheet">

<script type="text/javascript">
//전자정부 페이징 이동하는 스크립트
function linkPage(pageNo){
	location.href = "./notice?pageNo="+pageNo;
}	
</script>
</head>
<body id="page-top">
	<!-- Navigation-->
	<%@ include file="menu.jsp" %>

	<!-- 게시판 -->
	<section class="page-section" id="services">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">공지사항</h2>
			</div>
			<div class="row text-center">
							
				<c:choose>
					<c:when test="${fn:length(list) gt 0}">
						<table class="table table-hover">
							<thead>
								<tr class="row">
									<th class="col-2">번호</th>
									<th class="col-6">제목</th>
									<th class="col-2">날짜</th>
									<th class="col-2">읽음</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list }" var="row">
								<tr class="row">
									<td class="col-2">${row.nno }</td>
									<td class="title col-6" onclick="location.href='./noticeDetail?no=${row.nno }'">
									<c:if test="${row.ndel eq 1}"><img alt="new" src="./img/new.png"></c:if>
									${row.ntitle }
									</td>
									<td class="col-2">${row.ndate }</td>
									<td class="col-2">${row.nread }</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- 페이징 -->
				<div class="m-2 text-secondary" >
					<ui:pagination paginationInfo="${paginationInfo}" type="text" jsFunction="linkPage"/>
				</div>
					</c:when>
					<c:otherwise>
						<h1>출력할 데이터가 없습니다.</h1>
					</c:otherwise>
				</c:choose>
				
				
				
				<!-- 글쓰기 버튼 -->
				<c:if test="${sessionScope.mid ne null }">
					<button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#write">글쓰기</button>
				</c:if>
			</div>
		</div>
	</section>
	
	<!-- 글쓰기 모달 만들기 -->
	<div class="modal" id="write">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">글쓰기 창 입니다</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="mt-2">
						<form action="./write" method="post" onsubmit="return writeCheck()" name="frm">
							<input type="text" id="title" name="title" class="form-control mb-2" required="required" placeholder="제목을 입력하세요">
							<textarea id="summernote" name="content" class="form-control mb-2 vh-500" required="required"></textarea>
							<button type="submit" class="btn btn-info mt-2">글쓰기</button>
						</form>
					</div>
				</div>
				<div class="modal-footer">
					2024-02-19 웹표준 기술 / RESTAPI / RESTFULL
				</div>
			</div>
		</div>
	</div>
	
	<!-- 톺아보기 모달 -->
	<div class="modal" id="detail">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle">톺아보기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="mt-2" id="modalContent">
						제목<br>
						본문내용
					</div>
				</div>
				<div class="modal-footer">
					톺아보기 모달 닫기
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#summernote').summernote({
			lang: 'ko-KR', // default: 'en-US'
			height: 600,
			fontNames : ['D2Coding', 'Arial Black', 'Comic Sans MS', 'Courier New'],
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    /* ['font', ['strikethrough', 'superscript', 'subscript']], */
			    ['fontname', ['fontname','fontsize', 'color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    /* ['height', ['height']] */
			    ['table', ['table','link', 'picture', 'video']],
			    ['view', ['fullscreen', 'codeview', 'help']]
			  ]
		});
	});
	</script>
</body>
</html>