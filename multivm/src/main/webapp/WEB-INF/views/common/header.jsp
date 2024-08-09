<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-10
  Time: 오후 6:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>멀티자판기</title>

    <link rel="stylesheet" href="${root}/resources/css/resset.css">
    <link rel="stylesheet" href="${root}/resources/css/layout.css">
    <link rel="stylesheet" href="${root}/resources/css/contents.css">
    <link rel="stylesheet" href="${root}/resources/css/basic.css">
    <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="${root}/resources/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="${root}/resources/js/jquery.ezmark.min.js"></script>
    <script type="text/javascript" src="${root}/resources/js/common.js"></script>
    <script type="text/javascript" src="${root}/resources/js/index.js"></script>
    <script src="${root}/resources/js/paging.js"></script>
    <script type="text/javascript" src="${root}/resources/js/util.js"></script>

</head>
<style>
  /*  .depth-2 { display: none; } !* 서브메뉴들 숨김 *!
    .selec {  }
    #lnb .depth-1 > li.arrow_none.on>a {
        background: #0075fe!important;
    }*/
  #back{
      position: absolute;
      z-index: 99998;
      background-color: #000000;
      display:none;
      left:0;
      top:0;
  }
  #loadingBar{
      position:absolute;
      left:50%;
      top: 40%;
      display:none;
      z-index:99999;
  }

</style>
<script type="text/javascript">
    window.onpageshow = function(event) {
        if (event.persisted) {
            document.location.reload();
        }
    };

    $(document).ready(function (){
        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });

    function FunLoadingBarStart() {
        var backHeight = $(document).height();               	//뒷 배경의 상하 폭
        var backWidth = window.document.body.clientWidth;		//뒷 배경의 좌우 폭
        var backGroundCover = "<div id='back'></div>";			//뒷 배경을 감쌀 커버
        var loadingBarImage = '';								//가운데 띄워 줄 이미지
        loadingBarImage += "<div id='loadingBar'><img style='width:200px;' src='${root}/resources/images/loading.gif'/></div>";
        $('body').append(backGroundCover).append(loadingBarImage);
        $('#back').css({ 'width': backWidth, 'height': backHeight, 'opacity': '0.3' });
        $('#back').show();
        $('#loadingBar').show();
    }

    function FunLoadingBarEnd() {
        $('#back, #loadingBar').hide();
        $('#back, #loadingBar').remove();}
</script>