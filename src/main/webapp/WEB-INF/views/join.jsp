<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trinity Company - 회원가입</title>
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
		<link rel="icon" type="image/png" sizes="192x192"  href="assets/android-icon-192x192.png">
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
        <script type="text/javascript">
        const Toast = Swal.mixin({
        	  toast: true,
        	  position: 'center-center',
        	  showConfirmButton: false,
        	  timer: 3000,
        	  timerProgressBar: true,
        	  didOpen: (toast) => {
        	    toast.onmouseenter = Swal.stopTimer;
        	    toast.onmouseleave = Swal.resumeTimer;
        	  }
        	});
        
        $(function(){
        	//Swal.fire('title','content', 'success');
			//2024-02-29 애플리케이션 테스트 수행  psd
        	$('#idCheck').click(function (){        		
        		let id = $('#id').val();
        		//Swal.fire('ID검사','검사할 아이디 : ' + id, 'success');
        		//3글자 이상, 10글자 이하 
        		
        		//기회가 된다면 공백을 사용하지 못하게 해주세요.
        		if(id.length > 10 || id.length < 3){
        			//3글자 이하, 10글자 이상 = 비정상 -> 멈춤
        			Swal.fire('ID검사','아이디는 3 ~ 10 글자로 만들어주세요.', 'error');
        		} else {
        			//3글자 이상, 10글자 이하 = 정상 -> ajax
        			$.ajax({
        				url : './idCheck',
        				type : 'post',
        				dataType : 'text',
        				data : {id : id},
        				  success: function(data){
                              if(data == 1)
                                  Swal.fire('ID검사','이미 가입된 아이디 입니다. ', 'success');
                              else
                                  Swal.fire('ID검사', id + '는 가입할 수 있는 ID 입니다. ', 'success');			
                          },
                          error : function(error){
                              Swal.fire('ID검사', '서버와 통신 중 오류가 발생했습니다.', 'error');			
                          }
        			});
        		}
        	});
        	
        	//join을 클릭하면 이벤트 발생
        	$('#join').click(function(){
        		//Swal.fire('회원가입','회원가입 버튼을 클릭하셨습니다.', 'success');
        		//id값 가져오기
        		let id = $('#id').val();
        		let pw1 = $('#password1').val();
        		let pw2 = $('#password2').val();
        		let name = $('#name').val();
        		let email = $('#email').val();
        		
        		if(id.length < 3 || id.length > 10){
        			$('#id').focus();
        			Swal.fire('회원가입','아이디는 3~10글자 사이여야 합니다.', 'error');
        			return false;
        		}
        		if(pw1 == ''){
        			$('#pw1').focus();
        			Swal.fire('회원가입','암호를 입력하세요.', 'error');
        			return false;
        		}
        		if(pw2 == ''){
        			$('#pw2').focus();
        			Swal.fire('회원가입','암호를 다시 입력하세요.', 'error');
        			return false;
        		}
        		if(pw1.length < 3 || pw1.length > 10){
        			$('#pw1').text('');
        			$('#pw2').text('');
        			$('#pw1').focus();
        			Swal.fire('회원가입','아이디는 3~10글자 사이여야 합니다.', 'error');
        			return false;
        		} else if(pw1 != pw2){
        			$('#pw1').text('');
        			$('#pw2').text('');
        			$('#pw1').focus();
        			Swal.fire('회원가입','비밀번호가 일치하지 않습니다.', 'error');
        			return false;	
        		}
        		
        		if(name.length < 3 || name.length > 10){
        			Swal.fire('회원가입','닉네임은 3~10글자 사이여야 합니다.', 'error');
        			$('#name').focus();
        			return false;
        		}
        		
        		
        		
        		const regExp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/;
          		if(!regExp.test(email)){
          			Swal.fire('회원가입','이메일 형식이 아닙니다.', 'error');
            		return false;
          		}
          		
          		
        		//Swal.fire('회원가입','아이디 : ' + id + "<br>비밀번호 : " + pw1 + "/" + pw2, 'success');
        		//alert("줄바꿈 \n 줄바꿈");
        		//전송하기
        		let loginForm = $('<form></form>');
        		loginForm.attr('name','login');
        		loginForm.attr('method','post');
        		loginForm.attr('action','./join');
        		
        		loginForm.append(    $('<input>', {'type':'hidden', 'name':'id', 'value':id})   );
        		loginForm.append($('<input>', {type:'hidden', 'name':'pw', 'value':pw1}));
        		loginForm.append($('<input>', {type:'hidden', 'name':'name', 'value':name}));
        		loginForm.append($('<input>', {type:'hidden', 'name':'email', 'value':email}));
        		
        		loginForm.appendTo('body');
        		loginForm.submit();
        	});
        });
       
        </script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <%@ include file="menu.jsp" %>
        
        <div class="mt-10">회원가입</div>
        
        <!-- join -->
        <section class="page-section" id="mail">
            <div class="d-flex justify-content-center ">
            <div class="text-center p-5 w-50 bg-secondary">
			<div class="mb-3 row">
				<label for="id" class="col-sm-2 col-form-label">아이디</label>
				<div class="col-sm-7">
					<input type="text" id="id" class="form-control" placeholder="아이디를 입력하세요">
				</div>
				<div class="col-sm-3">
					<button type="button" id="idCheck" class="btn btn-info w-100">ID 검사</button>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password1" placeholder="암호를 입력하세요">
				</div>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password2" placeholder="암호를 입력하세요">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="name" class="col-sm-2 col-form-label">이 름</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="name" placeholder="이름을 입력하세요">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="email" class="col-sm-2 col-form-label">이메일</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="email" placeholder="이메일을 입력하세요">
				</div>
			</div>
			<div class="mb-3 row">
				<div class="col-sm-12">
					<button type="button" id="join" class="btn btn-info">회원가입</button>
				</div>
			</div>
			</div>
		</div>
        </section>
        
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>