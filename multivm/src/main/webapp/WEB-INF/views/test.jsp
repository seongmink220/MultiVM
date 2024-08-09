<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-07
  Time: 오전 9:51
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <title>로그인페이지(Test)</title>
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

</head>

<body>
<nav class="navbar navbar-expand-md bg-gray navbar-gray fixed-top shadow-lg">
    <a class="navbar-brand" href="${root}">home</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navMenu">
        <span class="navbar-toggler-icon"></span>
    </button>
    <p> ${sessionScope.loginUser.name}</p>
    <div class="collapse navbar-collapse" id="navMenu">

        <ul class="navbar-nav ml-auto">
            <c:if test="${sessionScope.User==null}">
                <li class="nav-item">
                    <a href="${root}" class="nav-link">로그인</a>
                </li>
            </c:if>

            <%--<li class="nav-item">
                <a href="${root}/join" class="nav-link">회원가입</a>
            </li>--%>
            <%--<li class="nav-item">
                <a href="${root}/modify_user" class="nav-link">정보수정</a>
            </li>--%>
            <li class="nav-item">
                <a href="${root}/logout" class="nav-link">로그아웃</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container" style="margin-top:100px">
    <div class="row">
        <div class="container-fluid bg-light ">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-2 pt-3">
                    <div class="form-group ">
                        <select id="inputState " class="form-control">
                            <option selected>Brand</option>
                            <option>BMW</option>
                            <option>Audi</option>
                            <option>Maruti</option>
                            <option>Tesla</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-2 pt-3">
                    <div class="form-group">
                        <select id="inputState2" class="form-control">
                            <option selected>Model</option>
                            <option>BMW</option>
                            <option>Audi</option>
                            <option>Maruti</option>
                            <option>Tesla</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-2 pt-3">
                    <div class="form-group">
                        <select id="inputState3" class="form-control">
                            <option selected>Budget</option>
                            <option>BMW</option>
                            <option>Audi</option>
                            <option>Maruti</option>
                            <option>Tesla</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-2 pt-3">
                    <div class="form-group">
                        <select id="inputState" class="form-control">
                            <option selected>Type</option>
                            <option>BMW</option>
                            <option>Audi</option>
                            <option>Maruti</option>
                            <option>Tesla</option>
                        </select>
                    </div>
                </div>
                <c:if test="${auth !=0}">
                    <c:forEach var="getGroupList" items="${getGroupList}">
                        <option value="${getGroupList.groupSeq}" <c:if test="${getGroupList.groupSeq==groupSeq}">selected</c:if>>
                                ${getGroupList.groupName}
                        </option>
                    </c:forEach>
                </c:if>
                <div class="col-md-2">
                    <button type="button" class="btn btn-primary btn-block">Search</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

