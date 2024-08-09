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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />

    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.1.3/cropper.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/magnific-popup.css">
    <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">-->
    <link type="text/css" href="https://fengyuanchen.github.io/cropperjs/css/cropper.css" rel="stylesheet">

    <%--<link type="text/css" href="https://fengyuanchen.github.io/cropperjs/css/cropper.css" rel="stylesheet">
    <script src="https://fengyuanchen.github.io/cropperjs/js/cropper.js"></script>--%>

    <!--여기 테스트 -->
    <%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.1.3/cropper.js"></script>
    <%--<script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.min.js"></script>--%>
    <title>상품 마스터 정보</title>
    <script src="${root}/resources/ckeditor/ckeditor.js"></script>
    <script src="${root}/resources/ckeditor/config.js"></script>
</head>
<style>
    .test11 {
        position: fixed;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        z-index: 999999999;
    }
    .pop_box2 {
        position: fixed;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 672px;
        border-radius: 12px;
        background: #fff;
        z-index: 100000;
        font-size: 14px;
    }
    .cropper-bg {
        width: 630px!important;
        height: 400px!important;
    }
    .btn_cancel2{ background: #88909e;}
    #shadow_bg2 { position:fixed; left:0; top:0; width:100%; height:100%; background: rgba(0,0,0,0.7); z-index:999999990; }

    #shadow_bg {
        z-index: 9998 !important;
    }
    #modal_pop {
        z-index: 9999 !important;
    }
    div#cke_1_contents {
        height: 100px !important;
    }
    .slot_list>div.product>ul>li:nth-child(4)>div {
        width: 100%;
    }
    .product_photo>img{
        max-width: 100%!important;
    }

    #drop-region {
        /*background-color: #fff;
        border-radius:20px;
        box-shadow:0 0 35px rgba(0,0,0,0.05);
        width:400px;
        padding:60px 40px;
        text-align: center;*/
        cursor:pointer;
        transition:.3s;
    }
    #drop-region:hover {
        box-shadow:0 0 30px rgba(0,0,0,0.1);
    }

</style>
<script type="text/javascript">

    $(document).ready(function (){
        $('#mn_mg_list').addClass("current");
        $('#lnb_product').addClass("on");
        $('#mn_mg_m_list').addClass("current");
        $('#lnb_m_product').addClass("on");
        $('#lnb_m_product').next('ul').css('display','block');
        $('#lnb_product').children('ul').show();
        $('.subtit').text("상품 마스터 정보")
        //$(".depth-1").not('#lnb_product').removeClass("on");
        //$(".depth-1").not('#lnb_product').children('ul').hide();

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        /*if(${sessionScope.loginUser.auth==0}){
            $(".sub_tit").hide();
            $(".slot_list").hide();
            $(".admin_cont").show();
        }*/

        ck3 = CKEDITOR.replace("product_info",{
            filebrowserUploadUrl: '/customer/ckeditor/file-upload.do',
            toolbarCanCollapse : true,
            toolbarStartupExpanded : false,
            toolbarGroups : [
                { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
                { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
                { name: 'tools', groups: [ 'tools' ] },
                { name: 'clipboard', groups: [ 'undo', 'clipboard' ] },
                { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
                { name: 'forms', groups: [ 'forms' ] },
                { name: 'links', groups: [ 'links' ] },
                { name: 'insert', groups: [ 'insert' ] },
                '/',
                { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
                { name: 'styles', groups: [ 'styles' ] },
                { name: 'colors', groups: [ 'colors' ] },
                { name: 'others', groups: [ 'others' ] },
                { name: 'about', groups: [ 'about' ] }
            ],
            removeButtons : 'Source,Save,NewPage,ExportPdf,Preview,Print,Templates,PasteFromWord,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,RemoveFormat,CopyFormatting,BidiLtr,BidiRtl,Language,Anchor,HorizontalRule,Iframe,PageBreak,Smiley,PasteText,Copy,ShowBlocks,About,Unlink,CreateDiv,Blockquote,Subscript,Superscript,Paste,Cut,Format,Styles,Maximize,Strike,Outdent,Indent',
            height : '200px'




        });
    });

    /*$('.btn_imgchange').click(function() {
        //$('#theFileInput').click();
        $("#myImageModal").show();
    });*/


</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            상품 마스터 정보
        </header>


        <div id="shadow_bg" style="display: none;"></div>
        <div id="shadow_bg2" style="display: none;"></div>
        <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
        <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">

        <div id="modal_pop">

            <div class="pop_box excelModal" style="display: none;">
                <div class="pop_title">
                    <h2>엑셀 업로드/다운</h2>
                    <span><a href="javascript:void(0)"onclick="closdModal()"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <div class="filebox bs3-primary">
                        <input class="upload-name" value="선택된 파일 없음" disabled="disabled">
                        <label for="file_excel" >파일선택</label>
                        <input type="file" name ="file_excel" id="file_excel" accept=".xlsx, .xls" onchange="readExcel();" class="upload-hidden">
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
                    <div class="form_down"><a href="${root}/resources/form/test.xlsx" download="엑셀양식">양식 다운로드<img src="${root}/resources/images/ic_down.png"></a></div>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel"onclick="closdModal();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok"onclick="sendExcel();">업로드하기</a>
                    </div>
                </div>
            </div>

            <div class="pop_box excelDLModal" style="display: none;">
                <div class="pop_title">
                    <h2>상품마스터정보 다운로드</h2>
                    <span><a href="javascript:void(0)" onclick="closdModal();"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <div class="pop_txt">
                        상품정보를<br>
                        유비씨엔소속-시스템조직에<br>
                        다운로드 하겠습니까?
                    </div>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel"onclick="$('#shadow_bg').stop().fadeOut();$('.excelDLModal').stop().fadeOut();">아니오</a>
                        <a href="javascript:void(0)" class="button2 btn_ok" onclick="alert('현재 서비스 예정중입니다.');$('#shadow_bg').stop().fadeOut();$('.excelDLModal').stop().fadeOut();">예</a>
                    </div>
                </div>
            </div>


            <div class="pop_box dataModal" style="display: none;">
                <div class="pop_title">
                    <h2>상품정보</h2>
                    <span><a href="javascript:void(0);" onclick="closdModal();"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form">
                        <fieldset>
                            <legend>상품정보내역</legend>
                            <ul class="tabs">
                                <li class="tab-1" >활성화</li>
                                <li class="tab-2" >비활성화</li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="productName" class="form_title_b">상품명 <span>*</span></label>
                                    <div class="input01">
                                        <label for="isGlass">파손여부</label>
                                        <input type="checkbox" id="isGlass" name="isGlass" value="T">
                                    </div>
                                    <input type="text" id="productName" placeholder="최대 20자입니다" maxlength="20">
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-code" class="form_title">상품코드 <span></span></label>
                                    <input type="text" id="product-code" oninput="this.value = this.value.replace(/[^A-Za-z0-9]/g, '').replace(/(\..*)\./g, '$1');" placeholder="미입력시 자동채번" maxlength="20">
                                </li>
                                <li>
                                    <label for="product-size" class="form_title">적재수량</label>
                                    <input type="text" id="product-size" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="0" maxlength="10">
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-price" class="form_title">가격 <span>*</span></label>
                                    <input type="text" id="product-price" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="입력해주세요" maxlength="10">
                                </li>
                                <li>
                                <li>
                                    <label for="product-sale" class="form_title tooltip">할인 <span id="sale-message" style="font-size: small; cursor:help;font-weight: bold;">
                                    </span></label>
                                    <input type="text" id="product-sale" placeholder="입력해주세요" disabled="disabled">
                                </li>
                            </ul>
                            <ul class="form_group form_textarea">
                                <ul class="form_group form_textarea">
                                    <li>
                                        <label for="product_info" class="form_title">상품설명</label>
                                        <textarea cols="50" rows="3" id="product_info" placeholder="입력해주세요"></textarea>
                                        <%-- <div id="text_count">(0 / 100)</div>--%>
                                        <input type="hidden" id="company_Seq" value="">
                                        <input type="hidden" id="product-orig" value="">
                                        <input type="hidden" id="product-seq">
                                        <input type="hidden" id="product-use">
                                        <input type="hidden" id="product-isGlass">
                                        <input type="hidden" id="product-empty">

                                        <script>


                                            $(document).ready(function() {
                                                $('#product_info').on('keyup', function() {
                                                    $('#text_count').html("("+$(this).val().length+" / 100)");

                                                    if($(this).val().length > 100) {
                                                        $(this).val($(this).val().substring(0, 100));
                                                        $('#text_count').html("(100 / 100)");
                                                    }
                                                });

                                                $(".tabs>li").click(function () {
                                                    $(this).toggleClass('current');

                                                    if ($(this).siblings().hasClass('current')) {
                                                        $(this).siblings().removeClass('current');
                                                    }else $(this).siblings().addClass('current')

                                                    if ($(".tab-2").hasClass('current')) {
                                                        if ($("#product-seq").val() != 0) {
                                                            $("#product-use").val('N');
                                                            $("#modal_form").find("input").attr("disabled", true);
                                                            $("#modal_form").find("textarea").attr("disabled", true);
                                                        }
                                                        $("#product-use").val('N');
                                                    } else {
                                                        if ($("#product-seq").val() != 0) {
                                                            $("#modal_form").find("input").attr("disabled", false);
                                                            $("#modal_form").find("textarea").attr("disabled", false);
                                                            $("#product-sale").attr("disabled", true);
                                                            $("#product-use").val('Y');
                                                        }
                                                        $("#product-use").val('Y');
                                                    }
                                                });


                                            });

                                        </script>
                                    </li>
                                </ul>
                                <ul class="form_group">
                                    <li>
                                        <label for="product_photo" class="form_title">상품이미지 <%--<span style="font-size: 12px; color: #2e9ad0;text-decoration-line: underline;" onclick="imageSearchPopup();">이미지검색</span>--%></label>
                                        <%--<div class="product_photo"><img id="product_photo" src="${root}/resources/images/product/default.png"></div>--%>
                                        <div class="product_photo" id="drop-region" onclick="showImageModal();"><img id="product_photo" src="http://devmultivm.ubcn.co.kr/image/product/default.png"></div>
                                        <a class="button btn_imgchange" onclick="showImageModal();">이미지 변경</a>
                                        <input type="file" accept=".jpeg,.jpg,.png,.gif" name="product_image" id="product_image" onClick="showImageModal()" style="display:none"/>
                                    </li>
                                </ul>
                            </ul>
                        </fieldset>
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok" onclick="addData();">적용하기</a>
                    </div>
                </div>
            </div>
        </div>

        <!--자르기 모달 테스트  -->
        <div id="modal_pop test11" class="test11" style="display: none;">
            <div class="pop_box2">
                <div class="pop_title">
                    <h2>이미지 변경</h2>
                    <span><a href="javascript:closebg2();"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <img style="width: 271px; height: 271px;" class="js-avatar-preview" src="">
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel2" onclick="closebg2();">취소</a>
                        <button class="btn button2 btn_ok js-save-cropped-avatar">적용</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar">
            <ul>
                <li class="mar02">
                    <label for="company-select">소속</label>
                    <select name="company" id="company-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="">선택해주세요</option>
                                <c:forEach var="companyList" items="${companyList}">
                                    <option value="${companyList.seq}">${companyList.name}</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option value="${sessionScope.loginUser.companySeq}" selected>${sessionScope.loginUser.companyName}</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="mar02">
                    <label for="group-select">조직</label>
                    <select name="organization" id="group-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="">소속을 선택해주세요</option>
                                <c:forEach var="orgList" items="${orgList}">
                                    <option value="${orgList.seq}">${orgList.name}</option>
                                </c:forEach>
                            </c:when>
                            <c:when test="${sessionScope.loginUser.auth==3}">
                                <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="orgList" items="${orgList}" varStatus="status">
                                    <c:if test="${status.index eq 0}">
                                        <option value="${orgList.seq}" selected>${orgList.name}</option>
                                    </c:if>
                                    <c:if test="${status.index ne 0}">
                                        <option value="${orgList.seq}">${orgList.name}</option>
                                    </c:if>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="input-size01">
                    <label for="product-name">상품명/상품코드</label>
                    <input type="text" id="product-name" placeholder="검색어를 입력해주세요" maxlength="20" onkeydown="if(event.keyCode == 13) searchProduct();">

                </li>
                <li class="label_none2"><label for=""></label><a href="javascript:void(0)" class="button3 button_position2" onclick="searchProduct();">조회</a></li>
            </ul>
        </div>
        <c:choose>
            <c:when test="${sessionScope.loginUser.auth==0}">
                <section id="body_contents" class="">
                    <div class="table_outline">
                        <ul class="admin_cont">
                            <li><img src="${root}/resources/images/ic_blank.png"></li>
                            <li>소속/조직을 선택해주세요.</li>
                        </ul>
                        <div class="sub_tit" style="display: none;">
                            <ul>
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth<4}">
                                        <li class="data_btn">
                                            <a href="javascript:void(0)" class="button btn_add" onclick="addDataModal();">Add DATA</a>
                                            <a href="javascript:void(0)" class="button btn_delete2" onclick="deleteData();">Delete DATA</a>
                                            <span>검색 결과 : <span class="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</span>&nbsp;
                                            <c:if test="${sessionScope.loginUser.auth==0}"><span id="admin_space">company_seq=<c:out value="${sessionScope.loginUser.companySeq}"></c:out>&nbsp;/&nbsp;organization_seq=<c:out value="${sessionScope.loginUser.organizationSeq}"></c:out></span> </c:if>
                                        </li>
                                        <li>
                                                <%--<a href="${root}/resources/form/test.xlsx" download>폼 다운로드</a>
                                                <a class="button btn_excel" onclick="document.getElementById('file_excel').click();">엑셀 업로드</a>
                                                <input type="file" name="file_excel" id="file_excel" onchange="readExcel();" style="display:none"/>--%>
                                                <a href="javascript:void(0)" class="button" onclick="pdInfoExcelDownload();"><img src="${root}/resources/images/ic_down.png">상품정보 다운로드</a>
                                                <a href="javascript:void(0)" class="button" onclick="excelModal();"><img src="${root}/resources/images/ic_excel.png">엑셀 일괄업로드</a>
                                                <a href="javascript:void(0)" class="button" onclick="imageAllInsertPopup();"><img src="${root}/resources/images/ic_copy.png">이미지 일괄업로드</a>
                                            <%--<a href="javascript:void(0)" class="button" onclick="dwJsonModal();"><img src="${root}/resources/images/ic_down.png">다운로드</a>--%>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><span>검색 결과 : <span class="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</span>&nbsp;
                                                <%--<div class="datetime">${datetime} 기준</div>--%>
                                            </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                        <div class="slot_list" style="display: none;">
                            <ul class="blank_cont" style="display: none;">
                                <li><img src="${root}/resources/images/ic_blank.png"></li>
                                <li>등록된 상품이 없습니다.</li>
                                <li>상품을 추가하려면<br>아래 추가하기 버튼을 눌러주세요.</li>
                                <li><a href="javascript:void(0)" class="button3" onclick="addDataModal();">추가하기</a></li>
                            </ul>
                            <div class="product">
                            </div>
                        </div>
                    </div>
                </section>
            </c:when>
            <c:otherwise>
                <section id="body_contents" class="">
                    <div class="table_outline">
                        <div class="sub_tit" >
                            <ul>
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth<4}">
                                        <li class="data_btn">
                                            <a href="javascript:void(0)" class="button btn_add" onclick="addDataModal();">Add DATA</a>
                                            <a href="javascript:void(0)" class="button btn_delete2" onclick="deleteData();">Delete DATA</a>
                                            <span>검색 결과 : <span class="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</span>&nbsp;
                                            <c:if test="${sessionScope.loginUser.auth==0}"><span id="admin_space">company_seq=<c:out value="${sessionScope.loginUser.companySeq}"></c:out>&nbsp;/&nbsp;organization_seq=<c:out value="${sessionScope.loginUser.organizationSeq}"></c:out></span> </c:if>
                                        </li>
                                        <li>
                                                <%--<a href="${root}/resources/form/test.xlsx" download>폼 다운로드</a>
                                                <a class="button btn_excel" onclick="document.getElementById('file_excel').click();">엑셀 업로드</a>
                                                <input type="file" name="file_excel" id="file_excel" onchange="readExcel();" style="display:none"/>--%>
                                            <a href="javascript:void(0)" class="button" onclick="pdInfoExcelDownload();"><img src="${root}/resources/images/ic_down.png">상품정보 다운로드</a>
                                            <a href="javascript:void(0)" class="button" onclick="excelModal();"><img src="${root}/resources/images/ic_excel.png">엑셀 일괄업로드</a>
                                            <a href="javascript:void(0)" class="button" onclick="imageAllInsertPopup();"><img src="${root}/resources/images/ic_copy.png">이미지 일괄업로드</a>
                                            <%--<a href="javascript:void(0)" class="button" onclick="dwJsonModal();"><img src="${root}/resources/images/ic_down.png">다운로드</a>--%>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                           <%-- <li><h2>마스터 상품현황</h2></li>--%>
                                            <li>
                                                <div style="float: left;">검색 결과 : <span class="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</div>&nbsp;
                                                <%--<div style="float: right;" class="datetime">${datetime} 기준</div>--%>
                                            </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                        <div class="slot_list">
                            <ul class="blank_cont" <c:if test="${!empty productList}">style="display: none;"</c:if>>
                                <li><img src="${root}/resources/images/ic_blank.png"></li>
                                <li>등록된 상품이 없습니다.</li>
                                <li>상품을 추가하려면<br>아래 추가하기 버튼을 눌러주세요.</li>
                                <li><a href="javascript:void(0)" class="button3" onclick="addDataModal();">추가하기</a></li>
                            </ul>
                            <div class="product"<c:if test="${empty productList}">style="display: none;"</c:if>>
                                <c:forEach var="productList" items="${productList}">
                                    <ul id="${productList.productSeq}" <c:if test="${fn:contains(productList.productCode,'F')}">style="background-color:#feffe766;"</c:if>>
                                        <li><c:choose>
                                            <c:when test="${empty productList.productImage}">
                                                <img src="http://devmultivm.ubcn.co.kr/image/product/default.png">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${productList.productImage}">
                                            </c:otherwise>
                                        </c:choose></li>
                                        <li>${productList.productName}<br/><strong>${productList.productPrice} 원</strong></li>
                                        <li>
                                            <ul>
                                                <li>적재수량</li>
                                                <li>${productList.productCount}</li>
                                            </ul>
                                        </li>
                                        <li>
                                            <div><a href="javascript:editDataModal(${productList.productSeq});">수정</a></div>
                                            <%--<div><a href="javascript:clearData(${productList.productSeq});">Clear</a></div>--%>
                                        </li>
                                        <div class="ez-checkbox c_position"><input type="checkbox" class="ez-hide"></div>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </section>


            </c:otherwise>
        </c:choose>

        <!-- 이미지 모달 추가 -->


        <%--<div class="modal_pop1">
            <a href="${root}/imageModal" class="iframe-link"><%=request.getRealPath("/") %></a>
        </div>--%>


    </section>
</div>
<script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/magnific-popup@1.1.0/dist/jquery.magnific-popup.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    $('#company-select').select2();
    $('#group-select').select2({
        placeholder: "조직을 선택해주세요"
    });

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    var cropper;
    var cropperModalId = '.test11';
    var $jsPhotoUploadInput = $('#product_image');

    $('#company-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            location.reload();
            return false;
        }
        //alert($(this).val());
        $.ajax({
            url:'${root}/product/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+$(this).val(),
            datatype: 'JSON',
            success:function(response){
                var html ="";
                for(var i=0; i<response.length; i++){
                    html +="<option value='"+response[i].seq+"'>"+response[i].name+"</option>";
                }
                $('#group-select').empty();
                $("#group-select").append(html);
                //$('#group-select').children().remove();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    function searchProduct(){

        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var productName = $("#product-name").val();
        //alert("companySeq:"+companySeq+" organizationSeq:"+organizationSeq)
        if(companySeq==''){
            alert("소속을 선택하세요.");
            return false;
        }
        if(organizationSeq==''){
            alert("조직을 선택하세요.");
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/selectProductList.do',
            type : 'POST',
            data: {organizationSeq : organizationSeq,
                productName : productName,
                productCode : productName },
            datatype: 'JSON',
            success:function(response){
                $(".admin_cont").hide();
                $(".sub_tit").show();
                $(".slot_list").show();
                if(response.length <1){
                    $('.totCnt').text('0');
                    <c:if test="${sessionScope.loginUser.auth==0}">
                    $("#admin_space").text("organization_seq="+organizationSeq);
                    </c:if>
                    $(".blank_cont").show();
                    $(".product").hide();
                }
                else{
                    $(".blank_cont").hide();
                    $(".product").show();
                    var html ="";

                    for(var i=0; i<response.length; i++){
                        html +='<ul id="' + response[i].productSeq + '"';
                        if(response[i].productCode.includes("F")){
                            html +='style="background-color:#feffe766;"';
                        }
                        html +='><li>';
                        if(response[i].productImage == null){
                            html +='<img src="http://devmultivm.ubcn.co.kr/image/product/default.png">';
                        }else html +='<img src="' + response[i].productImage + '">';
                        html +='</li><li>' + response[i].productName + '<br/><strong>' + response[i].productPrice + '&nbsp;원</strong></li><li><ul><li>적재수량</li><li>' +response[i].productCount+'</li></ul></li><li>';
                        html +='<div><a href="javascript:editDataModal('+response[i].productSeq+');">수정</a></div>';
                        //html +='<div><a href="javascript:clearData('+response[i].productSeq+');">Clear</a></div>';
                        html +='</li><div class="ez-checkbox c_position"><input type="checkbox" class="ez-hide" value="' + response[i].productSeq + '"></div></ul>';
                    }
                    //$('.product').children().remove();
                    $(".product").html(html);
                    $('.totCnt').text(response.length);
                    $('input').ezMark();
                }
                console.log(response);
                $("#company_seq").val(companySeq);
                $("#orig_seq").val(organizationSeq);

                <c:if test="${sessionScope.loginUser.auth==0}">
                $("#admin_space").text("company_seq="+companySeq+" / organization_seq="+organizationSeq);
                </c:if>
                /*$('.product').children().remove();
                $(".product").html(html);
                $('input').ezMark();*/

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function addDataModal(){
        $('#drop-region').css("box-shadow","");
        if(${sessionScope.loginUser.auth>3}){
            alert('해당 관리자는 상품등록 할 수 있는 권한이 없습니다');
            return false;
        }
        $('#modal_pop').stop().fadeIn();
        $('.dataModal').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        $("#product-seq").val(0);
        //$("#product-size").val(0);
        $("#product-sale").val(0);
        $("#sale-message").text('');
        //$("#product-size").attr("disabled", true);
        $("#productName").attr("disabled", false);
        $("#product-code").attr("disabled", false);
        $("#product-price").attr("disabled", false);
        CKEDITOR.instances.product_info.setData('');
        $("#product_image").val('');
        $("#product-use").val('Y');
        $("#product-isGlass").val('F');
        $('.input01').find('.ez-checkbox').removeClass('ez-checked');
        $("#product_photo").attr("src",'http://devmultivm.ubcn.co.kr/image/product/default.png');
        $(".tab-1").addClass("current");
        $(".tab-2").removeClass("current");
        $("#sale-message").children().remove();
    }

    function editDataModal(productSeq){
        $("#product_image").val('');
        $('#drop-region').css("box-shadow","");
        $('#modal_pop').stop().fadeIn();
        $('.dataModal').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/product/ajax/selectProduct.do?productSeq='+productSeq,
            type : 'GET',
            datatype: 'JSON',
            success:function(response){
                if(response.useYN=='Y'){
                    /*$(".tabs").children("li:eq(0)").attr("class","tabcurrent");
                    $(".tabs").children("li:eq(1)").attr("class","");*/
                    $(".tab-1").addClass("current");
                    $(".tab-2").removeClass("current");
                    $("#modal_form").find("input").attr("disabled", false);
                    $("#modal_form").find("textarea").attr("disabled", false);
                    $("#product-sale").attr("disabled", true);
                }else{
                    /*$(".tabs").children("li:eq(0)").attr("class","");
                    $(".tabs").children("li:eq(1)").attr("class","current");*/
                    $(".tab-1").removeClass("current");
                    $(".tab-2").addClass("current");
                    $("#modal_form").find("input").attr("disabled", true);
                    $("#modal_form").find("textarea").attr("disabled", true);
                }
                $("#productName").val(response.productName);
                $("#product-code").val(response.productCode);
                $("#product-code").attr("disabled", true);
                $("#product-size").val(response.productCount);
                $("#product-price").val(response.productPrice);
                $("#product-sale").val(response.discount);
                //$("#sale-message").text(response.eventContent);
                $("#sale-message").text('');
                $("#sale-message").children().remove();
                if(response.eventContent!=''){
                    $("#sale-message").html(response.eventContent+'<div class="tooltip-content">'+response.eventTitle+'</div>');
                }
                //$("#product_info").val(response.productDetail);
                CKEDITOR.instances.product_info.setData(response.productDetail);
                /*$("#product-company").val(response.companySeq);
                $("#product-orig").val(response.organizationSeq);*/
                $("#product-empty").val(response.productImage);
                $("#product-seq").val(response.productSeq);
                $("#product_photo").attr("src",response.productImage);
                $("#product-use").val(response.useYN);
                if(response.isGlass =='T'){
                    $('.input01').find('.ez-checkbox').addClass('ez-checked');
                }
                else $('.input01').find('.ez-checkbox').removeClass('ez-checked');
                $("#product-isGlass").val(response.isGlass);
            },
            error: function (xhr, status, error) {console.log(error);}
        });

    }

    function addData(){
        if(${sessionScope.loginUser.auth>3}){
            alert('해당 관리자는 수정할 수 있는 권한이 없습니다');
            return false;
        }
        var form = new FormData();
        var productName = $("#productName").val()
        var productCode = $("#product-code").val();
        var productCount = $("#product-size").val();
        var productPrice = $("#product-price").val();
        //220318. html저장 -> 에디터적용
        //var productDetail = $("#product-info").val();
        var productDetail = CKEDITOR.instances.product_info.getData();
        var companySeq = $("#company_seq").val();
        var organizationSeq = $("#orig_seq").val();
        var productImage = $("#product_photo").attr("src");
        //productImage = productImage.split('/').reverse()[0]; //기존 이미지명 추출
        var productSeq = $("#product-seq").val();
        var useYN = $("#product-use").val();
        var productImage_up =$("#product_image")[0].files[0];
        //2022-03-30. 파손여부 추가

        if(productCode!=productCode.toUpperCase()){
            alert('상품코드는 대문자만 가능합니다.');
            return false;
        }

        if($('#isGlass').parent('.ez-checkbox').hasClass('ez-checked')){
            $("#product-isGlass").val('T');
        } else $("#product-isGlass").val('F');

        /*if($('.input01').find('.ez-checkbox').hasClass('ez-checked')){
            $("#product-isGlass").val('T');
        } else $("#product-isGlass").val('F');*/
        var isGlass = $("#product-isGlass").val();

        form.append( "productName", productName );
        form.append( "productCode", productCode.trim() );
        form.append( "productCount", productCount );
        form.append( "productPrice", productPrice );
        form.append( "productDetail", productDetail );
        form.append( "companySeq", companySeq );
        form.append( "organizationSeq", organizationSeq );
        form.append( "productImage_up", $("#product_image")[0].files[0] ); //신규 이미지 파일
        form.append( "productSeq", productSeq );
        form.append( "useYN", useYN );
        form.append( "productImage_bf",$("#product-empty").val());
        form.append( "isGlass", isGlass );

        if(productImage_up==null){
            //파일 없을때 productImage에 넣음(추가시엔 default.png,수정시엔 가져온src)
            form.append( "productImage",productImage);
        }
        var params = $("#modal_form").serialize();
        //alert("df "+$("#product_image")[0].files[0]);
        if(productName==''||productPrice==''||productPrice==''){
            alert("값을 입력하세요.");
            return false;
        }
        if(productDetail==''){
            productDetail=' ';
        }
        var data = {productSeq : productSeq,
            companySeq : companySeq,
            organizationSeq : organizationSeq,
            productCode : productCode,
            productName : productName,
            productCount : productCount,
            productPrice : productPrice,
            productDetail : productDetail,
            productImage : productImage,
            useYN : useYN,
            isGlass : isGlass};

        if(productSeq!=0){
            editData(form);
        }
        else{
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/product/ajax/insertProduct.do',
                data: form,
                type : 'POST',
                enctype: 'multipart/form-data',
                processData: false,
                contentType: false,
                success:function(response){
                    alert(response);
                    if(response.includes('중복')){
                        $("input[id=product-code]").focus();
                    }else{
                        searchProduct();
                        closdModal();
                    }
                    //$(".product").load(location.href + ".product");
                    //$('.input01').children('.ez-checkbox').eq(0).attr("class","");
                },
                error: function (xhr, status, error) {
                    console.log(error);
                }, complete: function () {FunLoadingBarEnd();}
            });
        }
    }
    function clearData(productSeq){
        if(${sessionScope.loginUser.auth>3}){
            alert('해당 관리자는 수정할 수 있는 권한이 없습니다');
            return false;
        }
        var form = new FormData();
        form.append("productSeq",productSeq);
        form.append("isClear",1);
        //editData({productSeq : productSeq,isClear : "1"});
        editData(form);
    }
    function editData(data){
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/product/ajax/updateProduct.do',
            type : 'POST',
            data: data,
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success:function(response){
                alert(response);
                searchProduct();
                closdModal();
                //$('.input01').children('.ez-checkbox').eq(0).detach();

            },
            error: function (xhr, status, error) {console.log(error);},
            complete: function () {FunLoadingBarEnd();}
        });
    }

    function deleteData(){
        if(${sessionScope.loginUser.auth>3}){
            alert('해당 관리자는 삭제할 수 있는 권한이 없습니다');
            return false;
        }
        var sizeCheck = $('.product input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 데이터를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('ul').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/product/ajax/deleteSelectedProduct.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    searchProduct();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }

    function useN(){
        if($(".tabs").children("li:eq(1)").attr("class")=="current"){
            $('#modal_form').each(function() {
                $("input").attr("disabled",true);
                //this.disable();
            });
        }
    }

    function showImageModal(){
        document.getElementById('product_image').click();
    }

    $('#product-code').change(function(){
        var upper = $(this).val().toUpperCase();
        if($(this).val()!=upper){
            alert('상품코드는 대문자로만 입력 가능합니다.');
            //$('#product-code').val($(this).val().toUpperCase());
            $('#product-code').focus();
            return false;
        }
    });

    //여기서부터

    /*$('.btn_imgchange').click(function() {
        $('#product_image').click();
        //$("#myModal").show();
    });*/

    $(function() {
        $('.iframe-link').magnificPopup({
            markup:'<div id="wrap">'+
                '<div class="mfp-iframe-scaler">'+
                '<div class="mfp-close"></div>'+
                '<iframe class="mfp-iframe" frameborder="0" allowfullscreen></iframe>'+
                '</div>',
            type:'iframe'
        });
    });

    function imageSearchPopup(){
        //var detail = CKEDITOR.instances.detail.getData();
        var title = "???d";
        var form = document.createElement('form');

        var w = $('#width').val() + 'px';
        var h = parseInt($('#height').val())+40;
        h = h+'px';
        var popup1 = window.open('',title,'width=500px,height=600px,resizable=no,location=no,menubar=yes,top='+150+',left='+((document.body.offsetWidth / 2)+window.screenLeft-100 )+'');
        form.setAttribute('method', 'POST');
        form.setAttribute('action', '${root}/popup/imageSearch');
        form.setAttribute('target', title);

        /*var hiddenField = document.createElement('input');
        hiddenField.setAttribute('type', 'hidden');
        hiddenField.setAttribute('name', 'detail');
        hiddenField.setAttribute('value', detail);
        form.appendChild(hiddenField);*/
        document.body.appendChild(form);
        form.submit();
    }

    $jsPhotoUploadInput.on('change', function reviewImage(ev) {
        var files = this.files;
        if (files.length > 0) {
            var photo = files[0];

            var reader = new FileReader();
            reader.onload = function(event) {
                var image = $('.js-avatar-preview')[0];
                image.src = event.target.result;

                //수정 - 자르기화면 없앰
                $('#product_photo').attr('src', reader.result).height(90);
            };
            reader.readAsDataURL(photo);

            resize();


        }
    });

    function dwJsonModal(){
        $('#modal_pop').stop().fadeIn();
        $('#modal_pop').children('.pop_box').hide();
        $('.excelDLModal').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        //1. input초기화
        //2. 파일 없을때 에러메시지
    }
    var ajaxExcelData;
    function excelModal(){
        $('#modal_pop').stop().fadeIn();
        $('#modal_pop').children('.pop_box').hide();
        $('.excelModal').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('.upload-name').val('선택된 파일 없음');
        $('#file_excel').val("");
    }
    //엑셀
    function readExcel(){
        console.log('readExcel: '+ajaxExcelData);
        var companySeq = $("#company_seq").val();
        var organizationSeq = $("#orig_seq").val();
        var input = event.target;
        var reader = new FileReader();

        reader.onload = function (){
            var data = reader.result;
            var workBook = XLSX.read(data, { type: 'binary' });
            workBook.SheetNames.forEach(function (sheetName) {
                console.log('SheetName: ' + sheetName);
                var rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName],{header:['no', 'productCode', 'productName','productPrice','productDetail','productCount','isGlass','imgCode'],range:1});
                rows.push({"companySeq":companySeq,"organizationSeq":organizationSeq,"productName":"ubcn11111"});
                console.log(JSON.stringify(rows));
                ajaxExcelData=JSON.stringify(rows);
                //ajax list<product>
            })
        };
        reader.readAsBinaryString(input.files[0]);
        console.log('readExcel2: '+ajaxExcelData);
    }
    function sendExcel(){
        if(ajaxExcelData==null||ajaxExcelData==''||$('#file_excel').val()==null){
            alert('파일을 선택하세요.'); return false;
        }
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/product/ajax/insertDBfromExcel.do',
            type : 'POST',
            contentType:'application/json; charset=UTF-8',
            data: ajaxExcelData,//JSON.stringify(rows),
            success:function(response){
                alert(response.message);
                if(response.status =='success'){
                    searchProduct();
                    closdModal();
                }
                ajaxExcelData ='';
                $('#file_excel').val('');
                $('.upload-name').val('선택된 파일 없음');
            },
            error: function (xhr, status, error) {
                console.log(error);
                ajaxExcelData ='';
                $('#file_excel').val('');
                $('.upload-name').val('선택된 파일 없음');
            },
            complete: function () {
                FunLoadingBarEnd();
            }
        });
    }

    //이걸로 다 변경
    function closdModal(){
        $('#modal_pop').stop().fadeOut();
        $('#modal_pop').children('.pop_box').stop().fadeOut();
        $('#shadow_bg').stop().fadeOut();
    }

    //이미지 일괄업로드
    function imageAllInsertPopup(){
        var w = '772px';
        var h = '650px';
        var popup1 = window.open('/popup/imageAllInsert/'+$("#orig_seq").val(),'이미지일괄업로드','resizable=no,location=no,menubar=yes,top='+(100 + 1*50)+',left='+((document.body.offsetWidth / 2)+window.screenLeft-(1*100) )+', width='+w+',height='+h);

    }


    // 2023-01-27. 이미지 변경 > 드래그앤드롭 추가 yshwang
        var dropRegion = document.getElementById("drop-region"),//div
            imagePreviewRegion = document.getElementById("product_photo"), //img
            imageUploadInput = document.getElementById("product_image"); //input file

        function preventDefault(e) {
            console.log(e+"아왜안돼");
            //css
            //if(e.originalEvemt instanceof dragenter||e.originalEvemt instanceof dragover){
            $('#drop-region').css("box-shadow","0 0 30px rgb(92 172 255 / 91%");
            //}
            e.preventDefault();
            e.stopPropagation();
        }

        dropRegion.addEventListener('dragenter', preventDefault, false)
        dropRegion.addEventListener('dragleave', preventDefault, false)
        dropRegion.addEventListener('dragover', preventDefault, false)
        //dropRegion.addEventListener('drop', preventDefault, false)
        dropRegion.addEventListener('drop', handleDrop, false);

        function handleDrop(e) {
            e.preventDefault();
            $('#drop-region').css("box-shadow","");
            var dt = e.dataTransfer,
                files = dt.files;

            if (files.length) {
                if (handleFiles(files)) {
                    var photo = files[0];
                    var reader = new FileReader();
                    reader.onload = function (event) {
                        var image = $('.js-avatar-preview')[0];
                        image.src = event.target.result;
                        console.log(files[0]);
                        //console.log(reader.)
                        //console.log(reader.str)
                        $('#product_photo').attr('src', reader.result).height(90); //리뷰
                        const dataTransfer = new DataTransfer();
                        dataTransfer.items.add(photo);
                        $("#product_image")[0].files = dataTransfer.files;
                        resize();
                    };
                    reader.readAsDataURL(photo);


                }

            } else {
                /*var html = dt.getData('text/html'),
                    match = html && /\bsrc="?([^"\s]+)"?\s*!/.exec(html),
                    url = match && match[1];

                if (url) {
                    uploadImageFromURL(url);
                    return;
                }*/

            }
        }


        dropRegion.addEventListener('drop', handleDrop, false);


        function handleFiles(files) {
            console.log('handleFiles 들어옴 '+files[0]);
            if (files.length >= 2) {
                alert('파일은 한개만 선택해주세요.');
                return false;
            }
            var validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            var maxSizeInBytes = 10e6; // 10MB
            if (validTypes.indexOf(files[0].type) === -1) {
                alert("이미지 파일을 선택해주세요.(.jpeg, .gif, .png");
                return false;
            }
            if (files[0].size > maxSizeInBytes) {
                alert("파일의 크기는 최대 10MB까지 가능합니다.");
                return false;
            }
            return true;
            /*for (var i = 0, len = files.length; i < len; i++) {
                if (validateImage(files[i]))
                    previewAnduploadImage(files[i]);
            }*/
        }

        // 2023.01.30 엑셀 상품정보 다운로드 추가 yshwang
        function pdInfoExcelDownload(){
            var companySeq = $("#company_seq").val();
            var organizationSeq = $("#orig_seq").val();

            if(companySeq==''||organizationSeq==''){alert("소속과 조직을 선택해주세요");return false;}
            FunLoadingBarStart();
            $.ajax({
                url:'/product/ajax/saveExcelProductInfoData.do',
                type : 'POST',
                data:{ companySeq : companySeq,
                    organizationSeq : organizationSeq},
                datatype: 'JSON',
                xhrFields:{
                    responseType: 'blob'
                },
                success:function(response){
                    //console.log(response);
                    var blob = response;
                    var downloadUrl = URL.createObjectURL(blob);
                    var a = document.createElement("a");
                    a.href = downloadUrl;
                    a.download = "멀티자판기_상품마스터정보.xlsx";
                    document.body.appendChild(a);
                    a.click();

                },
                error: function (xhr, status, error) {
                    console.log(error);
                }, complete: function () {FunLoadingBarEnd();}
            });
        }

    // 2023-01-31. 이미지 용량 압축(rexize) 추가 yshwang
    const MAX_WIDTH = 350;
    const MAX_HEIGHT = 350;
    const MIME_TYPE = "image/jpeg";
    const QUALITY = 1.0;

    function resize(){
        console.log("resize시작");
        const file = $("#product_image")[0].files[0];

        console.log(file);
        if(file.size < 1048576){return false;}

        const blobURL = URL.createObjectURL(file);
        const img = new Image();
        img.src = blobURL;
        img.onerror = function () {
            URL.revokeObjectURL(this.src);
            // Handle the failure properly
            console.log("Cannot load image");
        };
        img.onload = function () {
            URL.revokeObjectURL(this.src);
            const [newWidth, newHeight] = calculateSize(img, MAX_WIDTH, MAX_HEIGHT);
            const canvas = document.createElement("canvas");
            canvas.width = newWidth;
            canvas.height = newHeight;
            const ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0, newWidth, newHeight);
            canvas.toBlob(
                (blob) => {
                    // Handle the compressed image. es. upload or save in local state
                    //displayInfo('Original file', file);
                    //displayInfo('Compressed file', blob);
                    var dataTransfer = new DataTransfer();
                    var blobToFile = new File([blob],file.name,{ lastModified: new Date().getTime(), type: blob.type });
                    dataTransfer.items.add(blobToFile);
                    $("#product_image")[0].files = dataTransfer.files;
                },
                MIME_TYPE,
                QUALITY
            );
            console.log("resize 결과: "+$("#product_image")[0].files);
            console.log($("#product_image")[0].files);
            //document.getElementById("root").append(canvas);

        };
    }
    //////


    function calculateSize(img, maxWidth, maxHeight) {
        let width = img.width;
        let height = img.height;

        // calculate the width and height, constraining the proportions
        if (width > height) {
            if (width > maxWidth) {
                height = Math.round((height * maxWidth) / width);
                width = maxWidth;
            }
        } else {
            if (height > maxHeight) {
                width = Math.round((width * maxHeight) / height);
                height = maxHeight;
            }
        }
        return [width, height];
    }


    function readableBytes(bytes) {
        const i = Math.floor(Math.log(bytes) / Math.log(1024)),
            sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

        return (bytes / Math.pow(1024, i)).toFixed(2) + ' ' + sizes[i];
    }




</script>

</body>
</html>
