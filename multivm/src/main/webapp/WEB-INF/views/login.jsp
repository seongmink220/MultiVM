<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <link rel="stylesheet" href="${root}/resources/css/resset.css">
    <link rel="stylesheet" href="${root}/resources/css/layout.css">
    <link rel="stylesheet" href="${root}/resources/css/contents.css">
    <link rel="stylesheet" href="${root}/resources/css/basic.css">
    <script src="${root}/resources/js/jquery-3.6.0.min.js"></script>
    <title>MVP</title>
</head>
<body class="login-bg" >
<div id="wrap">
    <section id="login_container">
        <div class="login_box">
            <div><img src="${root}/resources/images/login_greeting.png" alt="bingo smart vending machine 관리시스템에 오신 것을 환영합니다"></div>
            <div class="login_area">
                <div class="login_logo"><img src="${root}/resources/images/login_logo.png" alt="bingo multi 관리시스템">
                </div>
                <div class="login_input">
                        <ul>
                            <li><input type="text" class="log_id" id="id" placeholder="아이디를 입력하세요."></li>
                            <li><input type="password" class="log_pw" id="password" placeholder="비밀번호를 입력하세요." onkeydown="if(event.keyCode == 13) loginCheck();"></li>
                        </ul>
                        <div class="login_btn_area">
                            <a href="javascript:loginCheck();" class="btn_login" >로그인</a>
                        </div>
                        <ul class="button_link">
                            <li><a href="http://www.ubcn.co.kr/customer/qna" target="_blank">아이디/비밀번호를 잃어버리 셨나요?&nbsp;&nbsp;<span>문의하기</span></a></li>
                            <li><a href="https://vmms.ubcn.co.kr" target="_blank"><span>VMMS 바로가기</span></a></li>
                        </ul>
                </div>
                <div class="login_footer">
                    서울특별시 금천구 가산디지털1로 212, 910호 (가산동, 코오롱애스턴)<br/> TEL.1544-5737 FAX.02-6458-2001
                </div>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript">

    function loginCheck(){
        var id = $('#id').val();
        var password = $('#password').val();

        if (id.length == 0) {
            alert("아이디를 입력하세요");
            return false;
        }

        if(password.length ==0){
            alert("비밀번호를 입력하세요");
            return false;
        }
        $.ajax({
            url:'${root}/login',
            type : 'POST',
            data:{ id : id,
                password : password},
            datatype: 'JSON',
            success:function(response){
                if(response.message.includes("success")) location.replace('index');
                else{
                    alert(response.message); return false;
                }
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }


</script>
</body>
</html>