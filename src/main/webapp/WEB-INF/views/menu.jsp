<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="./index"><img src="assets/apple-icon-152x152.png" alt="logo" /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu<i class="fas fa-bars ms-1"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link" href="./board">게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="./gallery">gallery</a></li>
                        <li class="nav-item"><a class="nav-link" href="./file">파일</a></li>
                        <li class="nav-item"><a class="nav-link" href="./mail">메일</a></li>
                        <li class="nav-item"><a class="nav-link" href="./notice">공지</a></li><c:choose><c:when test="${sessionScope.mid ne null }">
                        <li class="nav-item"><a class="nav-link" href="./myInfo@${sessionScope.mid }">${sessionScope.mname }님</a></li>
                        <li class="nav-item"><a class="nav-link" href="./logout">로그아웃</a></li></c:when><c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="./login">로그인</a></li></c:otherwise></c:choose>
                    </ul>
                </div>
            </div>
        </nav>