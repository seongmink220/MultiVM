<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-14
  Time: 오후 3:21
  자판기 상품현황
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
    <title>자판기상품정보</title>
</head>
<style>
    .product_photo2 {
        width: 100%;
        height: 90px;
        display: inline-block;
        border: 1px solid #d8d8d8;
        border-radius: 4px;
        background: #f1f1f3;
        text-align: center;
    }
    .tb_horizen {margin-bottom: 20px;min-width: 100%;}
    img#product_photo {
        height: 90px;
    }
    .slot_list>div.product>ul>li:nth-child(4)>div {
        width: 100%;
    }

</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mg_vending-machine').addClass("current");
        $('#lnb_product').addClass("on");
        $('#mn_mg_m_vending-machine').addClass("current");
        $('#lnb_m_product').addClass("on");
        $('#lnb_m_product').next('ul').css('display','block');
        $('#lnb_product').children('ul').show();
        $('.subtit').text("자판기 상품정보");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        /*if(${sessionScope.loginUser.auth==0}){
            $(".sub_tit").hide();
            $(".slot_list").hide();
            $(".admin_cont").show();
        }*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            자판기 상품정보
        </header>
        <!-- EDIT 추가 ys -->
        <div id="shadow_bg" style="display:none; "></div>
        <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
        <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
        <input type="hidden" id="vm_seq" value="${vmList[0].seq}">
        <div id="modal_pop" style="display:none; ">


            <div class="pop_box">
                <div class="pop_title">
                    <h2>상품정보</h2>
                    <span><a href="javascript:closeModal();"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <form action="#none" id="modal_form"method="post">
                        <fieldset>
                            <legend>상품정보내역</legend>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="productName" class="form_title_b">상품명</label>
                                    <div class="input01">
                                        <label for="isGlass">파손여부</label>
                                        <input type="checkbox" id="isGlass" name="isGlass" value="T" disabled>
                                    </div>
                                    <input type="text" id="productName" disabled="disabled">
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-code" class="form_title">상품코드</label>
                                    <input type="text" id="product-code" disabled="disabled">
                                </li>
                                <li>
                                    <label for="product-size" class="form_title">적재수량</label>
                                    <input type="text" id="product-size" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="입력해주세요" maxlength="10">
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-price" class="form_title">가격</label>
                                    <input type="text" id="product-price" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="입력해주세요" maxlength="10">
                                </li>
                                <li>
                                    <label for="product-sale" class="form_title tooltip">할인 <span id="sale-message" style="font-size: small;cursor:help;font-weight: bold;">
                                    </span></label>
                                    <input type="text" id="product-sale" disabled="disabled">
                                </li>
                            </ul>
                            <ul class="form_group form_textarea">
                                <li>
                                    <label for="product-info" class="form_title">상품설명</label>
                                    <textarea cols="50" rows="4" id="product-info" disabled="disabled"></textarea>
                                </li>
                            </ul>
                            <ul class="form_group">
                                <li>
                                    <label for="product_photo" class="form_title">상품이미지</label>
                                    <div class="product_photo2"><img id="product_photo" src=""></div>
                                </li>
                            </ul>
                        </fieldset>
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok" onclick="editData(0);">적용하기</a>
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
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="orgList" items="${orgList}" varStatus="status">
                                    <c:choose>
                                        <c:when test="${selectOrgSeq eq orgList.seq}">
                                        <option value="${orgList.seq}" selected>${orgList.name}</option>
                                        </c:when>
                                        <c:otherwise>
                                        <option value="${orgList.seq}">${orgList.name}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="mar02">
                    <label for="vending-select">자판기 ID</label>
                    <select name="vm" id="vending-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                            </c:when>
                            <c:when test="${sessionScope.loginUser.auth==1||sessionScope.loginUser.auth==2||sessionScope.loginUser.auth==3}">
                                <%--<c:if test="${vmListSize>1}">
                                    <option value="">선택해주세요</option>
                                </c:if>--%>
                                <c:if test="${empty vmList}">
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.vmId}</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%--<c:if test="${vmListSize>1}">
                                <option value="">선택해주세요</option>
                                </c:if>--%>
                                <c:if test="${empty vmList}">
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.vmId}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="mar02">
                    <label for="place-select">설치위치</label>
                    <select name="place" id="place-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                            </c:when>
                            <c:when test="${sessionScope.loginUser.auth==1||sessionScope.loginUser.auth==2||sessionScope.loginUser.auth==3}">
                                <%--<c:if test="${vmListSize>1}">
                                <option value="">선택해주세요</option>
                                </c:if>--%>
                                <c:if test="${empty vmList}">
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.place}</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%--<c:if test="${vmListSize>1}">
                                <option value="">선택해주세요</option>
                                </c:if>--%>
                                <c:if test="${empty vmList}">
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.place}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
            </ul>
            <ul class="search_bar_pad2">
                <li><a href="javascript:void(0)" class="button3 button_position2" onclick="searchVM();">조회</a></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="sub_tit sub_tit2" style="display: none;">
                    <ul>
                        <%--<li><h2>슬롯 현황</h2></li>
                        <li><div class="datetime">${datetime} 기준</div></li>--%>
                            <li>
                                <span>검색 결과 : <span class="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</span>&nbsp;
                                <c:if test="${sessionScope.loginUser.auth==0}"><span id="admin_space">company_seq=<c:out value="${sessionScope.loginUser.companySeq}"></c:out>&nbsp;/&nbsp;organization_seq=<c:out value="${sessionScope.loginUser.organizationSeq}"></c:out></span></c:if>
                            </li>
                    </ul>
                </div>
                <div class="slot_list" >
                    <%--<ul class="admin_cont" <c:if test="${!empty myVMProductList||sessionScope.loginUser.auth<2}">style="display:none;"</c:if>>
                        <li><img src="${root}/resources/images/ic_blank.png"></li>
                        <li>자판기 ID 및 설치위치를 선택해주세요.</li>
                    </ul>--%>
                    <ul class="blank_cont"<c:if test="${!empty myVMProductList}">style="display:none;"</c:if>>
                        <li><img src="${root}/resources/images/ic_blank.png"></li>
                        <li>등록된 상품이 없습니다.</li>
                    </ul>
                    <div class="product" <c:if test="${empty myVMProductList}">style="display:none;"</c:if>>
                        <c:forEach var="myVMProductList" items="${myVMProductList}">
                            <ul id="${myVMProductList.productCode}"><li><img src="${myVMProductList.productImage}"></li>
                                <li>${myVMProductList.productName}<br/><strong>${myVMProductList.productPrice}&nbsp;원</strong></li><li><ul><li>적재수량</li><li>${myVMProductList.productCount}</li></ul></li><li>
                                    <div><a href="javascript:editDataModal('${myVMProductList.productCode}');">수정</a></div>
                                    <%--<div><a href="javascript:clearData('${myVMProductList.productCode}');">Clear</a></div>--%>
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>
                <div class="sub_tit">
                    <ul>
                        <li><h2>자판기 상품목록</h2></li>
                        <li>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="deleteData();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                        </li>
                    </ul>
                </div>
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="20%">
                        <col width="*">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                        <th>상품코드</th>
                        <th>상품명</th>
                        <th>가격</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                        <c:if test="${empty myVMProductList}">
                            <tr style="pointer-events: none;"><td>&ensp;&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>
                        </c:if>
                        <c:forEach var="myVMProductList" items="${myVMProductList}">
                            <tr id="${myVMProductList.productCode}">
                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                <td onclick="editDataModal('${myVMProductList.productCode}');">${myVMProductList.productCode}</td>
                                <td class="t_left" onclick="editDataModal('${myVMProductList.productCode}');">${myVMProductList.productName}</td>
                                <td class="t_right" onclick="editDataModal('${myVMProductList.productCode}');">${myVMProductList.productPrice}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="pagination" id="pagination_ys">
                </div><input type="hidden" id="nowpage" value="1">
            </div>
        </section>
    </section>
</div>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    $('#company-select').select2();
    $('#group-select').select2({
        placeholder: "조직을 선택해주세요"
    });
    $('#vending-select').select2({
        placeholder: "선택해주세요"
    });
    $('#place-select').select2({
        placeholder: "선택해주세요"
    });

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('#company-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            location.reload();
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+companySeq,
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                //html +="<option value='' selected>선택해주세요</option>";
                html2 +="<option value='' selected>선택해주세요</option>";
                html3 +="<option value='' selected>선택해주세요</option>";
                html +="<option value='0' selected>전체</option>";
                for(var i=0; i<response.origList.length; i++){
                    html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html2 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].vmId+"</option>";
                    html3 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"</option>";

                }
                $('#group-select').empty();
                $("#group-select").append(html);
                $('#vending-select').empty();
                $("#vending-select").append(html2);
                $('#place-select').empty();
                $("#place-select").append(html3);
                //$("#vending-select").children().remove();
                //$("#place-select").children().remove();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
//0,1권한만 사용
    $('#group-select').change(changeCompanySelect1=function(){

        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationText = $("#group-select option:selected").text();

        if(organizationSeq==''){
            $('#vending-select').empty();
            $("#place-select").empty();
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/getSelectorVMList.do', //자판기리스트
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq
            },
            datatype: 'JSON',
            success:function(response){
                var html =""; //자판기ID
                var html2 =""; //설치위치
                if(response.vmList.length<1){
                    /* html +="<option value=''></option>";
                     html2 +="<option value=''></option>";*/
                    //$('#vending-select').empty();
                    //$("#place-select").empty();
                    html += "<option value='' selected>자판기없음</option>";
                    html2 += "<option value='' selected></option>";
                }
                else{
                    if(response.vmList.length>1) {
                        html += "<option value='' selected>선택해주세요</option>";
                        html2 += "<option value='' selected>선택해주세요</option>";
                    }
                    for(var i=0; i<response.vmList.length; i++){

                        html +="<option value='"+response.vmList[i].seq+"' >"+response.vmList[i].vmId+"</option>";
                        html2 +="<option value='"+response.vmList[i].seq+"' >"+response.vmList[i].place+"</option>";
                    }
                }
                $('#vending-select').empty();
                $("#vending-select").append(html);
                $("#place-select").empty();
                $("#place-select").append(html2)
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    //설치위치도 같이 바껴야함
    $('#place-select').change(changeCompanySelect2=function(){
        var vmSeq = $("#place-select option:selected").val();
        $('#vending-select').val(vmSeq).attr('selected',"selected");
        var vmText = $("#vending-select option:selected").text();
        $('#select2-vending-select-container').text(vmText);

    });
    $('#vending-select').change(function(){
        var vmSeq = $("#vending-select option:selected").val();
        $('#place-select').val(vmSeq).attr('selected',"selected");
        var vmText = $("#place-select option:selected").text();
        $('#select2-place-select-container').text(vmText);
    });

    function searchVM(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#vending-select option:selected").val();


        if(companySeq==''){alert("소속을 선택해주세요");return false;}
        //if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        if(vmSeq==''||vmSeq==null){alert("자판기ID 혹은 설치위치를 선택해주세요");return false;}

        $("#company_seq").val(companySeq);
        $("#vm_seq").val(vmSeq);

        $.ajax({
            url:'${root}/product/ajax/getSelectorVMProductList.do',
            type : 'POST',
            data:{vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                //$(".admin_cont").hide();
                if(response.vmProductList.length <1){
                    $(".blank_cont").show();
                    $(".sub_tit2").hide();
                    $(".product").hide();
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
                }
                else{
                    $(".sub_tit2").show();
                    $(".blank_cont").hide();
                    $(".product").show();

                    for(var i=0; i<response.vmProductList.length; i++){
                        html +='<ul id="' + response.vmProductList[i].productCode + '"><li><img src="' + response.vmProductList[i].productImage + '"></li>';
                        html +='<li>' + response.vmProductList[i].productName + '<br/><strong>' + response.vmProductList[i].productPrice + '&nbsp;원</strong></li><li><ul><li>적재수량</li><li>' +response.vmProductList[i].productCount+'</li></ul></li><li>';
                        html +='<div><a href="javascript:editDataModal(\''+response.vmProductList[i].productCode+'\');">수정</a></div>';
                        //html +='<div><a href="javascript:clearData(\''+response[i].productCode+'\');">Clear</a></div>';
                        html +='</li></ul>';

                        html2 +='<tr id="' + response.vmProductList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html2 +='<td onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productCode + '</td>';
                        html2 +='<td class="t_left" onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productName + '</td>';
                        html2 +='<td class="t_right" onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productPrice + '</td></tr>';
                    }
                    /*for(var i=0; i<response.vmProductList.length; i++){
                        html2 +='<tr id="' + response.vmProductList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html2 +='<td onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productCode + '</td>';
                        html2 +='<td class="t_left" onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productName + '</td>';
                        html2 +='<td class="t_right" onclick="editDataModal(\''+response.vmProductList[i].productCode+'\');">' + response.vmProductList[i].productPrice + '</td></tr>';
                    }*/
                    $(".product").html(html);
                    $('.totCnt').text(response.vmProductList.length);

                }
                $('#group-select').val(response.userVM.organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(response.userVM.organizationName);
                $("#orig_seq").val(response.userVM.organizationSeq);

                <c:if test="${sessionScope.loginUser.auth==0}">
                $("#admin_space").text("company_seq="+companySeq+" / organization_seq="+response.userVM.organizationSeq+" / vm_seq="+vmSeq+" / vm_id="+$("#vending-select option:selected").text());
                </c:if>

                $('#Dash_Table_Body1').html(html2);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }


    function editDataModal(productCode){
        var companySeq = $("#company_seq").val();
        var organizationSeq = $("#orig_seq").val();
        var vmSeq = $("#vm_seq").val();

        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        // var data = { companySeq : companySeq,
        //     organizationSeq : organizationSeq,
        //     vmSeq : vmSeq,
        //     productCode : productCode};

        //alert(JSON.stringify(data));
        $.ajax({
            url:'${root}/product/ajax/selectVMProduct.do',
            type : 'POST',
            //contentType: false,
            //processData: false,
            data: { companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq,
                productCode : productCode},
            datatype: 'JSON',
            success:function(response){
                $("#productName").val(response.productName);
                $("#product-code").val(response.productCode);
                $("#product-size").val(response.productCount);
                $("#product-price").val(response.productPrice);
                $("#product-info").val(response.productDetail);
                /*$("#product-company").val(response.companySeq);
                $("#product-orig").val(response.organizationSeq);*/
                $("#product_photo").attr("src",response.productImage);
                $("#product-use").val(response.useYN);
                $("#product-sale").val(response.discount);
                $("#sale-message").text('');
                $("#sale-message").children().remove();
                if(response.eventContent!=''){
                    $("#sale-message").html(response.eventContent+'<div class="tooltip-content">'+response.eventTitle+'</div>');
                }
                if(response.isGlass =='T'){
                    $('.input01').find('.ez-checkbox').addClass('ez-checked');
                }
                else $('.input01').find('.ez-checkbox').removeClass('ez-checked');
            },
            error: function (xhr, status, error) {console.log(error);}
        });

    }
    function clearData(productCode){
        var vmSeq = $("#vm_seq").val();
        $.ajax({
            url:'${root}/product/ajax/modifyVMProduct.do',
            type : 'POST',
            data: {productCode : productCode,
                vmSeq : vmSeq,
                isClear : 1},
            success:function(response){
                alert(response);
                searchVM();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function editData(isClear){
        var productCode = $("#product-code").val();
        var productCount = $("#product-size").val();
        var productPrice = $("#product-price").val();
        var vmSeq = $("#vm_seq").val();

        var params = $("#modal_form").serialize();
        if(productCode==''||productPrice==''||productPrice==''){
            alert("값을 입력하세요.");
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/modifyVMProduct.do',
            type : 'POST',
            data: {productCode : productCode,
                productCount : productCount,
                productPrice : productPrice,
                vmSeq : vmSeq,
            isClear : isClear},
            success:function(response){
                alert(response);
                searchVM();
                $('#modal_pop').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }

    function closeModal(){
        $('#modal_pop').stop().fadeOut();
        $('#shadow_bg').stop().fadeOut();
    }




    //////////////////////////////////////
    function deleteData(){
        var companySeq = $("#company_seq").val();
        var organizationSeq = $("#orig_seq").val();
        var vmSeq = $("#vm_seq").val();

        //alert(" dgd "+companySeq+"  "+ organizationSeq +"  "+vmSeq);
        if(companySeq==''){alert("소속을 선택해주세요");return false;}
        if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        if(vmSeq==''){alert("자판기ID 혹은 단말기ID를 선택해주세요");return false;}

        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        if(sizeCheck.length == 0){
            alert("삭제할 상품을 선택하세요"); return false;
        }
        var saveList = [{companySeq:companySeq,organizationSeq:organizationSeq,vmSeq:vmSeq,deleteType:1 }];
        $.each(sizeCheck,function(idex,entry){
            saveList.push({
                id: entry.closest('tr').id
            })
        });
        //alert(" dgd "+saveList+"  "+ organizationSeq +"  "+vmSeq);
        if(!confirm("정말 삭제하시겠습니까?"))	return;
        $.ajax({
            url:'${root}/product/ajax/saveProduct.do',
            type : 'POST',
            contentType:'application/json',
            dataType: 'json',
            data:
                JSON.stringify(saveList),
            datatype: 'JSON',
            success:function(response){
                if(response.status!="success") {
                    alert(response.message)
                }else{
                    alert("삭제되었습니다.")
                }
                searchVM();
            }, error: function (xhr, status, error) {console.log(error);}
        });


    }





    //////////////////////////////////////////

    $(".allSelect1").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body1').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body1').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body1').find("input").prop('checked', allChildrenChecked).change();

    });
    window.onload = function(){
        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
    }

</script>
</body>
</html>
