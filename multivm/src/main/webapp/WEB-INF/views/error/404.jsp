<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>404</title>
</head>
<body>
<div id="wrap">
    <!-- header -->
    <div class="gnb">
        <ul>
            <li><h1 class="ubcn-logo"><img src="${root}/resources/images/ubcn.png" alt="bingo multi 관리자"></h1></li>
        </ul>
        <ul>
            <li class="subtit"></li>
            <li>
                <div class="user-name"><span>${sessionScope.loginUser.name}</span>님 환영합니다.</div>
                <div class="ubcn-logout"><a href="${root}/logout">로그아웃</a></div>
            </li>
        </ul>
    </div>

    <!-- body -->
    <section id="body_wrap">
        <header id="body_header"  class="item_none">
            404 error
        </header>

        <section id="body_contents">
            <div class="error404">
                <ul class="error_cont">
                    <li><img src="${root}/resources/images/404.png"></li>
                    <li>페이지를 찾을 수 없습니다.<br>
                        페이지가 존재하지 않거나, 사용할 수 없는 페이지입니다.</li>
                    <li><a href="${root}/index" class="button3">메인으로</a></li>
                </ul>
            </div>
        </section>
    </section>
</div>

</body>
</html>