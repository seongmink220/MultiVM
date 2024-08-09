<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-08
  Time: 오후 3:21
  전체 상품정보.
--%>
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

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.1.3/cropper.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/magnific-popup.css">
    <link type="text/css" href="https://fengyuanchen.github.io/cropperjs/css/cropper.css" rel="stylesheet">
    <title>상품이미지 검색</title>
    <script src="${root}/resources/ckeditor/ckeditor.js"></script>
    <script src="${root}/resources/ckeditor/config.js"></script>
</head>
<style>
    div.gallery {
        margin: 5px;
        border: 1px solid #ccc;
        float: left;
        width: 180px;
    }

    div.gallery:hover {
        border: 1px solid #777;
    }

    div.gallery img {
        width: 100%;
        height: auto;
    }

    div.desc {
        padding: 15px;
        text-align: center;
    }
</style>
<script type="text/javascript">

    $(document).ready(function (){
        $('#imageList>div').hide();
        $('#imageList>div').slice(0,3).show();

        console.log(${data});
    });

</script>
<body>
<div id="wrap">
    <section id="body_wrap">
        <header id="body_header">
            이미지 검색 :
        </header>
    </section>
    <div id ="imageList">
        <div class="gallery">
            <a target="_blank" href="img_5terre.jpg">
                <img src="https://www.w3schools.com/css/img_5terre.jpg" alt="Cinque Terre" width="600" height="400">
            </a>
            <div class="desc">Add a description of the image here</div>
        </div>

        <div class="gallery">
            <a target="_blank" href="img_forest.jpg">
                <img src="https://www.w3schools.com/css/img_forest.jpg" alt="Forest" width="600" height="400">
            </a>
            <div class="desc">Add a description of the image here</div>
        </div>

        <div class="gallery">
            <a target="_blank" href="img_lights.jpg">
                <img src="https://www.w3schools.com/css/img_lights.jpg" alt="Northern Lights" width="600" height="400">
            </a>
            <div class="desc">Add a description of the image here</div>
        </div>

        <div class="gallery">
            <a target="_blank" href="img_mountains.jpg">
                <img src="https://www.w3schools.com/css/img_mountains.jpg" alt="Mountains" width="600" height="400">
            </a>
            <div class="desc">Add a description of the image here</div>
        </div>
        <button onclick="more();">more</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    /*$('#group-select').select2({
        placeholder: "조직을 선택해주세요"
    });*/
    var cnt = 3;
    function more(){
        $('#imageList>div').slice(cnt,cnt+3).show();
        cnt+=3;
    }


</script>

</body>
</html>
