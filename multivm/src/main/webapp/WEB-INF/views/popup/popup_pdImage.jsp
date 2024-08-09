<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-08
  Time: 오후 3:21
  마스터상품정보.
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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/magnific-popup.css">
    <title>상품이미지 일괄등록</title>
    <script src="${root}/resources/ckeditor/config.js"></script>
</head>
<style>

</style>
<script type="text/javascript">

    $(document).ready(function (){

    });

</script>
<body>
<div id="wrap">
    <section id="body_wrap">
        <header id="body_header">
            상품이미지 일괄 등록
        </header>
    </section>

    <div id="modal_pop">

        <div class="pop_box excelModal" style="display: none;">
            <div class="pop_title">
                <h2>상품이미지 일괄 등록</h2>
                <span><a href="javascript:void(0)"onclick="closdModal()"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
            </div>
            <div class="pop_contbox">
                <div class="filebox bs3-primary">
                    <input class="upload-name" value="선택된 파일 없음" disabled="disabled">
                    <label for="file_excel" >파일선택</label>
                    <input type="file" id="input_file" name="input_file" accept=".xlsx,.xls" multiple="multiple" />
                </div>
                <script>
                    $(document).ready(function(){
                        var fileTarget = $('.filebox .upload-hidden');

                        fileTarget.on('change', function(){
                            if(window.FileReader){
                                var filename = $(this)[0].files[0].name;
                                var filetype = filename.slice(filename.indexOf(".") + 1).toLowerCase();
                                if(filetype!='xlsx'&&filetype!='xls'){
                                    alert('xlsx, xls 파일이 아닙니다.');
                                    return false;
                                }
                            } else {
                                var filename = $(this).val().split('/').pop().split('\\').pop();
                            }


                            $(this).siblings('.upload-name').val(filename);
                        });
                    });
                </script>
                <div class="pop_button">
                    <a href="javascript:void(0)" class="button2 btn_cancel"onclick="close();">취소</a>
                    <a href="javascript:void(0)" class="button2 btn_ok"onclick="save();">등록</a>
                </div>
            </div>
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
