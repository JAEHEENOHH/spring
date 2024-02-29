<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>톺아보기</title>
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
<link href="css/board.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
function deletePost(){
	Swal.fire({
		  title: "글을 삭제하시겠습니까?",
		  //text: "post를 삭제합니다.",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonText: "Yes",
		  cancelButtonText: "No",
		}).then(result => {
		  if (result.isConfirmed) {
			//java에게 삭제하라고 명령내리겠습니다.
			//가상 form = post
			let vform = $('<form></form>');
			vform.attr('name', 'vform');
			vform.attr('method', 'post');
			vform.attr('action', './postDel');
			vform.append($('<input/>', {type:'hidden', name:'no', value:${detail.board_no } }));
			vform.appendTo('body');
			vform.submit();
			//Swal.fire("삭제했습니다.","", "success");
		  }//end if
		});//end deletePost()
}
function commentInert(){
	let comment = $("#comment").val();
	if(comment.length < 10){
		Swal.fire("댓글의 길이가 짧습니다","댓글은 10글자 이상이어야 합니다.", "warning");
		return false;
	}
}

function like1(cno){
	Swal.fire("좋아요를 누릅니다","", "success");
	setTimeout(function(){		
		location.href="./likeUp?no=${detail.board_no}&cno="+cno;
	}, 3000);
}
function like(cno) {
    Swal.fire({
        title: "좋아요를 누르시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "확인",
        cancelButtonText: "취소",
    }).then((result) => {
        if (result.isConfirmed) {
            // 확인 버튼을 클릭한 경우에만 페이지 이동
            location.href = "./likeUp?no=${detail.board_no}&cno=" + cno;
        }
    });
}


//jquery start
$(function(){
	//댓글쓰기 몇 글자 썼는지 확인하는 코드 2024-02-20 psd
	$("#comment").keyup(function(){
		let text = $(this).val();
		if(text.length > 500){
			Swal.fire("댓글의 길이가 깁니다","댓글은 500자 까지 가능합니다.", "warning");
			$(this).val(text.substr(0, 500));	
		}
		$("#comment-input").text("댓글쓰기 " + text.length +  "/500");
	});
});

//댓글 삭제 버튼
function deleteComment(no){
	//Swal.fire("댓글을 삭제합니다.", no+"번글을 삭제합니다", "warning");
	if(confirm("댓글을 삭제하시겠습니까?")){		
		location.href="./deleteComment?no=${detail.board_no}&cno="+no;
	}
}
</script>
</head>
<body id="page-top">
	<!-- Navigation-->
	<%@ include file="menu.jsp" %>

	<!-- detail -->
	<section class="page-section" id="detail">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">톺아보기</h2>
			</div>
			<div class="card mb-4" style="min-height: 500px;">
				<div class="card-body">
					<div class="h2">${detail.board_title }</div>
					<div class="row p-2 bg-secondary">
						<div class="col align-middle text-start">
						${detail.mname }
						<c:if test="${detail.mid eq sessionScope.mid}">
							<img alt="edit" src="./img/edit.png">
							<img alt="delete" src="./img/delete.png" title="글삭제" onclick="deletePost(${detail.board_no })">
						</c:if>
						</div>
						<div class="col align-middle text-end">${detail.board_date }</div>
					</div>
					<div class="mt-4 h-auto">${detail.board_content }</div>
				</div>
			</div>
		<button class="btn btn-warning" onclick="history.back()">게시판으로</button>
		<button class="btn btn-warning" onclick="history.go(-1)">게시판으로</button>
		
		<hr>
		<!-- 댓글 입력창 = 스크립트로 빈칸검사하기 -->
		<div class="">
			<form action="./commentWrite" method="post" onsubmit="return commentInert()">
			<div class="row">
				<div class="input-group mb-3">
					<textarea class="form-control" id="comment" name="comment" aria-describedby="comment-input"></textarea>
  					<button class="btn btn-secondary" type="submit" id="comment-input">댓글쓰기 0/500</button>
				</div>
			</div>
			<input type="hidden" name="no" value="${detail.board_no }">				
			</form>
		</div>
		
		<!-- 댓글 출력창 -->
		<div class=" mt-2">		
			<c:forEach items="${commentsList }" var="c">
			<div class="my-4 shadow md-5 bg-body rounded">
				<div class="bg-warning text-dark row p-2">
					<div class="col-7">
					${c.mname }
					<c:if test="${c.mid eq sessionScope.mid}">
						<img alt="edit" src="img/edit.png">
						<img alt="delete" src="img/delete.png" title="댓글삭제" onclick="deleteComment(${c.no })">
					</c:if>
					</div>
					<div class="col-2"><img alt="ip" src="img/ip.png"> ${c.cip }</div>
					<div class="col-2"><img alt="time" src="img/time.png"> ${c.cdate }</div>
					<div class="col-1">
					<img alt="like" src="img/like.png" onclick="like(${c.no})"> 
					${c.clike }
					</div>
				</div>
				<div class="mx-5 mt-1" style="min-height: 80px">${c.comment }</div>
			</div>
			</c:forEach>
			
		</div>
		<!-- 댓글 끝 -->
		</div>
	</section>
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
