<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-28
  Time: 오후 3:40
  To change this template use File | Settings | File Templates.
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
    <title>이벤트 관리</title>
</head>
<style>
    #shadow_bg {
        z-index: 9998 !important;
    }
    #modal_pop {
        z-index: 9999 !important;
    }
    div#cke_1_contents {
        height: 100px !important;
    }
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mf_event').addClass("current");
        $('#lnb_company').addClass("on");
        $('#lnb_company').children('ul').show();
        $('#mn_mf_m_event').addClass("current");
        $('#lnb_m_company').addClass("on");
        $('#lnb_m_company').next('ul').css('display','block');
        $('.subtit').text("이벤트 관리");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            이벤트 관리
        </header>

        <div id="shadow_bg" style="display: none;"></div>
        <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
        <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
        <input type="hidden" id="company_name" value="${sessionScope.loginUser.companyName}">
        <input type="hidden" id="orig_name" value="${sessionScope.loginUser.organizationName}">
        <input type="hidden" id="vm_seq" value="0">
        <div id="modal_pop">
            <div class="pop_box" style="display: none;">
                <div class="pop_title">
                    <h2>이벤트 추가</h2>
                    <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form">
                    <table class="cont_table" summary="게시물 상세보기입니다">
                        <caption class="blind">이벤트 추가</caption>
                        <tbody>
                        <tr>
                            <th>이벤트명<span style="color: #f53a3a;">*</span></th></th>
                            <th class="cont"><input type="text" id="event_title" placeholder="입력해주세요" maxlength="30"></th>
                        </tr>
                        <tr>
                            <th>이벤트 타입<span style="color: #f53a3a;">*</span></th></th>
                            <td class="cont">
                                <select name="event_type" id="event_type">
                                    <option value="">선택해주세요</option>
                                    <option value="-">-(정액할인)</option>
                                    <option value="%">%(%할인)</option>
                                </select>
                                <input type="text" id="event_data" placeholder="ex.(-)200, 3(%)" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" maxlength="6">
                            </td>
                        </tr>
                        <tr>
                            <th>이벤트 기간<span style="color: #f53a3a;">*</span></th></th>
                            <td class="cont"><input type="date" id="event_start_Time">&nbsp;~&nbsp;<input type="date" id="event_end_Time"></td>
                        </tr>
                        <tr <c:if test="${sessionScope.loginUser.auth>0}">style="display: none;"</c:if>>
                            <th>소속<span style="color: #f53a3a;">*</span></th></th>
                            <td class="cont">
                                <select name="company-select3" id="company-select3" style="width: 100%;">
                                    <option value="">선택해주세요</option>
                                    <c:forEach var="companyList" items="${companyList}">
                                        <option value="${companyList.seq}">${companyList.name}</option>
                                    </c:forEach>
                                </select>

                            </td>
                        </tr>
                        <tr>
                            <th>조직<span style="color: #f53a3a;">*</span></th></th>
                            <td class="cont">
                                <select id="multipleSelect" data-placeholder="선택해주세요" style="width: 100%;" multiple>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>이벤트 설명</th>
                            <td class="cont">
                                <textarea cols="50" rows="4" id="event_content" placeholder="내용을 입력해주세요"></textarea>
                                <div id="text_count">(0 / 100)</div>
                                <script>
                                    $(document).ready(function() {
                                        $('#product-info').on('keyup', function() {
                                            $('#text_count').html("("+$(this).val().length+" / 100)");

                                            if($(this).val().length > 100) {
                                                $(this).val($(this).val().substring(0, 100));
                                                $('#text_count').html("(100 / 100)");
                                            }
                                        });
                                    });
                                </script>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <input type="hidden" value="0" id="event_seq">
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok"onclick="addEvent();">등록하기</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="pop_box3 pop_listEvent" style="display: none;">
            <div class="pop_title">
                <h2>이벤트 상세조회</h2>
                <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_listEvent').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
            </div>
            <div class="pop_contbox scroll_contbox">
                <div class="table_responsive">
                    <table class="tb_horizen cont_table">
                        <colgroup>
                            <col width="35%">
                            <col width="65%">
                        </colgroup>
                        <tbody id="Dash_Table_Body3" style="pointer-events: none;">
                        <tr>
                            <td>이벤트ID/이벤트명</td>
                            <td id="td1_eventTitle" class="cont"></td>
                        </tr>
                        <tr>
                            <td>소속/조직</td>
                            <td id="td2_comOrg" class="cont"></td>
                        </tr>
                        <tr>
                            <td>이벤트 정보</td>
                            <td id="td3_eventType" class="cont"></td>
                        </tr>
                        <tr>
                            <td>이벤트 기간</td>
                            <td id="td4_eventDate" class="cont"></td>
                        </tr>
                        <tr>
                            <td>이벤트설명</td>
                            <td id="td5_eventContent" class="cont"></td>
                        </tr>
                        <tr>
                            <td>등록일</td>
                            <td id="td6_createDate" class="cont"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" id="td7_eventSeq" value="">
                <div class="sub_tit3">
                    <ul>
                        <li><h2>등록된 상품 목록</h2></li>
                        <li>
                            <select name="vm-select4" id="vm-select4" style="width: 35%; height: 40px; padding: 0 8px;">
                                <option value="0">전체</option>
                            </select>
                            <select name="product-select4" id="product-select4" style="width: 35%; height: 40px; padding: 0 8px;">
                                <option value="0">전체</option>
                            </select>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="deleteProductFromEvent();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                        </li>
                    </ul>
                </div>
                <div class="table_responsive">
                    <table class="tb_horizen">
                        <colgroup>
                            <col width="5%">
                            <col width="10%">
                            <col width="20%">
                            <col width="15%">
                            <col width="*">
                            <col width="10%">
                            <col width="10%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th><div class="ez-checkbox c_position2 allSelect4"><input type="checkbox" class="ez-hide"></div></th>
                            <th>자판기ID</th>
                            <th>상품명</th>
                            <th>상품코드</th>
                            <th>설치위치</th>
                            <th>판매가격</th>
                            <th>적용후가격</th>
                        </tr>
                        </thead>
                        <tbody id="Dash_Table_Body4">
                        <%--<tr>
                            <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                            <td>00001</td>
                            <td class="t_left">가산디지털역</td>
                            <td>1번 출구</td>
                            <td>가동중</td>
                        </tr>--%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar" style="display:none ;">
            <ul>
                <li>
                    <label for="office-select">소속</label>
                    <input type="text" name="favSE" list="SE" placeholder="선택 및 입력해주세요">
                    <datalist id="SE">
                        <select name="">
                            <option value="Bing" LABEL="1">1</option>
                            <option value="DuckDuckGo"> 2</option>
                            <option value="Google">3</option>
                            <option value="Yahoo!">4</option>
                        </select>
                    </datalist>
                </li>
                <li>
                    <label for="office-list">datalist TEST</label>
                    <input list="office-list" class="arrow_delete" name="office" id="office" placeholder="입력해주세요">
                    <datalist id="office-list">
                        <option value="1" label="1">
                        <option value="2" label="2">
                        <option value="3" label="3">
                        <option value="4" label="4">
                    </datalist>
                </li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="table_copy_outline">
            <div class="table_copy table_copy2 mar01">
                <div class="item table_outline_a">
                    <div class="table_selectbox3">
                        <span style="font-size: 14px;">※이벤트는 조직별로 등록합니다. 등록시 여러 조직 선택가능</span>
                        <ul>
                            <li>
                                <select name="company-select1" id="company-select1" style="width: 100%;" >
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">소속 선택</option>
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
                            <li>
                                <select name="group-select1" id="group-select1" style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">조직 선택</option>
                                        </c:when>
                                        <c:when test="${sessionScope.loginUser.auth==1}">
                                            <option value="0">조직 전체</option>
                                            <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                                            <c:forEach var="defaultOrg" items="${defaultOrg}">
                                                <option value="${defaultOrg.seq}">${defaultOrg.name}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                            <li>
                                <select name="event-select1" id="event-select1" style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="0">이벤트 선택</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0">이벤트 전체</option>
                                            <c:forEach var="eventList" items="${eventList}">
                                                <option value="${eventList.seq}">${eventList.seq}]&nbsp;${eventList.eventTitle}</option>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                            <li class="button_position3"></li>
                        </ul>
                    </div>
                    <%--<span style="">이벤트 기간 검색</span>--%>
                    <div class="table_selectbox2_3">
                        <ul>
                            <li class="input-size02"><input type="date" id="sDate">&nbsp;~&nbsp;<input type="date" id="eDate"><a href="javascript:void(0);" class="button3" onclick="searchData();">조회</a></li>
                            <li class="">
                                <a href="javascript:void(0);" class="button" onclick="addEventModal();">이벤트 신규등록</a>
                                <a href="javascript:void(0);" class="button" onclick="modifyEventModal();">수정</a>
                                <a href="javascript:void(0);" class="button" onclick="deleteEvent();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                            <table class="tb_horizen">
                                <colgroup>
                                    <col width="5%">
                                    <col width="10%">
                                    <col width="*">
                                    <col width="15%">
                                    <col width="40%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                                    <th>이벤트ID</th>
                                    <th>이벤트명</th>
                                    <th>할인내용</th>
                                    <th>이벤트 기간</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body1">
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth==0}">
                                        <tr style="pointer-events: none;"><td colspan=5>소속을 선택하세요</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${empty eventList}">
                                            <tr style="pointer-events: none;"><td colspan=5>등록된 이벤트가 존재하지 않습니다</td></tr>
                                        </c:if>
                                        <c:forEach var="eventList" items="${eventList}">
                                            <tr onclick="detailEvent(${eventList.seq})" id="${eventList.seq}">
                                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                                <td>${eventList.seq}</td>
                                                <td class="t_left">${eventList.eventTitle}</td>
                                                <td class="">-${eventList.eventContent}</td>
                                                <td class="t_left">${eventList.eventStartTime}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                <%--<tr>
                                    <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>00001</td>
                                    <td class="t_left">포카리스웨트포카리스웨트포카리스웨트</td>
                                    <td class="t_right">1,500</td>
                                    <td class="t_right">1,500</td>
                                </tr>--%>
                                </tbody>
                            </table>
                        </div>
                        <div class="pagination" id="pagination_ys">
                        </div><input type="hidden" id="nowpage" value="1">
                    </div>
                </div>
                <div class="item copy_arrow"></div>
                <div class="item table_outline_a">
                    <div class="table_selectbox3_2">
                        <ul>
                            <li>
                                <select name="group-select2" id="group-select2"style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">조직 선택</option>
                                        </c:when>
                                        <%--<c:when test="${sessionScope.loginUser.auth==1}">
                                            <c:if test="${empty orgList}">
                                            </c:if>
                                            <c:forEach var="orgList" items="${orgList}">
                                                <option value="${orgList.seq}">${orgList.name}</option>
                                            </c:forEach>
                                        </c:when>--%>
                                        <c:otherwise>
                                            <option value="${sessionScope.loginUser.organizationSeq}">${sessionScope.loginUser.organizationName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                            <li>
                                <select name="vm-select2" id="vm-select2"  style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="0">설치위치 선택</option>
                                        </c:when>
                                        <c:otherwise>
                                    <option value="0">설치위치 전체</option>
                                    <c:if test="${empty vmList}">
                                    </c:if>
                                    <c:forEach var="vmList" items="${vmList}">
                                        <option value="${vmList.seq}">${vmList.place}(${vmList.vmId})</option>
                                    </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                            <li>
                                <select name="product-select2" id="product-select2"  style="width: 100%;">
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth==0}">
                                        <option value="all">상품 선택</option>
                                    </c:when>
                                    <c:otherwise>
                                    <option value="all">상품 전체</option>
                                    <c:if test="${empty vmProductList}">
                                    </c:if>
                                    <c:forEach var="vmProductList" items="${vmProductList}">
                                        <option id="${vmProductList.vmSeq}"value="${vmProductList.productCode}">[${vmProductList.productCode}]&nbsp;${vmProductList.productName}</option>
                                    </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                </select>
                            </li>
                            <li class="button_position3"></li>
                        </ul>
                    </div>
                    <div class="table_selectbox2_4">
                        <ul>
                            <li class="button_position3"><span style="font-size: 14px;">※이벤트는 각 상품에 한개씩만 등록가능합니다.</span><a href="javascript:void(0);" class="button" onclick="insertEventToVMProduct();">선택한 상품에 이벤트 추가</a></li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                            <table class="tb_horizen">
                                <colgroup>
                                    <col width="5%">
                                    <col width="15%">
                                    <col width="20%">
                                    <col width="15%">
                                    <col width="*">
                                    <col width="10%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><div class="ez-checkbox c_position2 allSelect2"><input type="checkbox" class="ez-hide"></div></th>
                                    <th class="table_vm_th1">자판기ID</th>
                                    <th class="table_vm_th2">상품명</th>
                                    <th class="table_vm_th3">상품코드</th>
                                    <th class="table_vm_th4">판매가격</th>
                                    <th class="table_vm_th5">설치위치</th>
                                    <th class="table_vm_th6">이벤트ID</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body2">
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth==0}">
                                        <tr style="pointer-events: none;"><td colspan=7>이벤트 혹은 조직을 먼저 조회해주세요</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${empty vmProductList}">
                                            <tr style="pointer-events: none;"><td colspan=7>자판기에 상품이 존재하지 않습니다</td></tr>
                                        </c:if>
                                        <c:forEach var="vmProductList" items="${vmProductList}">
                                            <tr id="${vmProductList.vmSeq}" class="${vmProductList.productCode}">
                                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                                <td style="pointer-events: none;">${vmProductList.vmId}</td>
                                                <td style="pointer-events: none;" class="t_left">${vmProductList.productName}</td>
                                                <td style="pointer-events: none;" class="t_right">${vmProductList.productCode}</td>
                                                <td style="pointer-events: none;" class="t_right">${vmProductList.productPrice}</td>
                                                <td style="pointer-events: none;" class="t_right">${vmProductList.place}</td>
                                                <td style="pointer-events: none;" class="t_right">${vmProductList.eventContent}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                <%--<tr>
                                    <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>00001</td>
                                    <td class="t_left">포카리스웨트</td>
                                    <td class="t_right">1,500</td>
                                    <td class="t_right">1,500</td>
                                    <td class="t_right">1,500</td>
                                    <td class="t_right">TT</td>
                                </tr>--%>
                                </tbody>
                            </table>
                        </div>
                        <div class="pagination" id="pagination_ys2">
                        </div><input type="hidden" id="nowpage2" value="1">
                    </div>
                </div>
            </div>
        </section>

    </section>
</div>
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />--%>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">

    $('#company-select1').select2();
    $('#group-select1').select2();
    $('#event-select1').select2();
    $('#group-select2').select2();
    $('#vm-select2').select2();
    $('#product-select2').select2();
    $('#vm-select4').select2();
    $('#product-select4').select2();
    $('#company-select3').select2();
    $('#multipleSelect').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });


    $('#company-select1').change(changeCompanySelect=function(){
        var companySeq = $("#company-select1 option:selected").val();
        if(companySeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{companySeq : companySeq, page : 'event'},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //이벤트
                html2 +="<option value='0' selected>조직 전체</option>";
                html3 +="<option value='0' selected>이벤트 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.eventInfo.length; i++){
                    html3 +="<option value='"+response.eventInfo[i].seq+"'>["+response.eventInfo[i].seq+"]&nbsp;"+ response.eventInfo[i].eventTitle +"</option>";
                }
                $('#group-select1').empty();
                $("#group-select1").append(html2);
                $('#event-select1').empty();
                $("#event-select1").append(html3);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#group-select1').change(changeGroupSelect1=function(organizationSeq){
        var companySeq = $("#company-select1 option:selected").val();
        if(typeof(organizationSeq) === 'object') {
            organizationSeq = $("#group-select1 option:selected").val();
        }
        var organizationText = $("#group-select1 option[value='+organizationSeq+']").text();
        if(organizationSeq==''){
            alert('조직을 선택하세요');
            changeGroupSelect1();
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq, companySeq : companySeq, page : 'event'},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //이벤트
                html2 +="<option value='0' selected>조직 전체</option>";
                html3 +="<option value='0' selected>이벤트 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.eventInfo.length; i++){
                    html3 +="<option value='"+response.eventInfo[i].seq+"'>["+response.eventInfo[i].seq+"]&nbsp;"+ response.eventInfo[i].eventTitle +"</option>";
                }

                $('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                $('#group-select1').empty();
                $("#group-select1").append(html2);
                $('#group-select1').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(organizationText);
                $('#event-select1').empty();
                $("#event-select1").append(html3);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#event-select1').change(changeEventSelect1=function(){
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var eventSeq = $("#event-select1 option:selected").val();
        var eventText = $("#event-select1 option:selected").text();
        //var eventText = $("#event-select1 option:selected").text();
        if(eventSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq, companySeq : companySeq, eventSeq : eventSeq, page : 'event'},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //이벤트
                html2 +="<option value='0' selected>조직 전체</option>";
                html3 +="<option value='0' selected>이벤트 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.eventInfo.length; i++){
                    html3 +="<option value='"+response.eventInfo[i].seq+"'>["+response.eventInfo[i].seq+"]&nbsp;"+ response.eventInfo[i].eventTitle +"</option>";
                }

                $('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                $('#group-select1').empty();
                $("#group-select1").append(html2);
                $('#group-select1').val(response.eventList[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(response.eventList[0].organizationName);
                $('#event-select1').empty();
                $("#event-select1").append(html3);
                $('#event-select1').val(eventSeq).attr('selected',"selected");
                $('#select2-event-select1-container').text(eventText);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    /*$('#group-select2').change(changeGroupSelect2=function(){
        changeGroupSelect1($(this).val());
        searchData();
    });*/
    $('#vm-select2').change(changeVMSelect2=function(){
        var organizationSeq = $("#group-select2 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var vmText = $("#vm-select2 option[value='+vmSeq+']").text();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq, vmSeq : vmSeq, productCode: 'all', page : 'event2'},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //자판기
                var html4 = ""; //상품
                var html5 = ""; //상품tr

                //html2 +="<option value='0' selected>조직 전체</option>";
                html3 +="<option value='0' selected>설치위치 전체</option>";
                html4 +="<option value='all' selected>상품 전체</option>";

                for(var i=0; i<response.vmInfo.length; i++){
                    html3 +="<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+ response.vmInfo[i].vmId +")</option>";
                }
                for(var i=0; i<response.ProductInfo.length; i++){
                    html4 +="<option value='"+response.ProductInfo[i].productCode+"'>["+response.ProductInfo[i].productCode+"]&nbsp;"+ response.ProductInfo[i].productName +"</option>";
                }
                if(response.productList.length<1){
                    html5 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=6>상품이 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.productList.length; i++){
                    html5 +='<tr id="'+response.productList[i].productCode+'/'+response.productList[i].vmSeq+'/'+response.productList[i].productPrice+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html5 +='<td style="pointer-events: none;">' + response.productList[i].vmId + '</td>';
                    html5 +='<td style="pointer-events: none;" class="">' + response.productList[i].productName + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productCode + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productPrice + '</td>';
                    html5 +='<td style="pointer-events: none;" class="">' + response.productList[i].place + '</td><td style="pointer-events: none;" class="">' + response.productList[i].eventContent + '</td></tr>';
                }

                //$('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                //$('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                //$('#group-select1').empty();
                //$("#group-select1").append(html2);
                //$('#group-select1').val(organizationSeq).attr('selected',"selected");
                //$('#select2-group-select-container').text(organizationText);

                $('#product-select2').empty();
                $("#product-select2").append(html4);
                $('#Dash_Table_Body2').html(html5);
                $('input').ezMark();
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#product-select2').change(changeProductSelect2=function(){
        var organizationSeq = $("#group-select2 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var productCode = $("#product-select2 option:selected").val();

        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq, vmSeq : vmSeq, productCode: productCode, page : 'event2'},
            datatype: 'JSON',
            success:function(response){
                /*var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //자판기
                var html4 = ""; //상품*/
                var html5 = ""; //상품tr

                //html2 +="<option value='0' selected>조직 전체</option>";
                /*html3 +="<option value='0' selected>설치위치 전체</option>";
                html4 +="<option value='all' selected>상품 전체</option>";

                for(var i=0; i<response.vmInfo.length; i++){
                    html3 +="<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+ response.vmInfo[i].vmId +")</option>";
                }
                for(var i=0; i<response.ProductInfo.length; i++){
                    html4 +="<option value='"+response.ProductInfo[i].productCode+"'>["+response.ProductInfo[i].productCode+"]&nbsp;"+ response.ProductInfo[i].productName +"</option>";
                }*/
                if(response.productList.length<1){
                    html5 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=6>상품이 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.productList.length; i++){
                    html5 +='<tr id="'+response.productList[i].productCode+'/'+response.productList[i].vmSeq+'/'+response.productList[i].productPrice+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html5 +='<td style="pointer-events: none;">' + response.productList[i].vmId + '</td>';
                    html5 +='<td style="pointer-events: none;" class="">' + response.productList[i].productName + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productCode + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productPrice + '</td>';
                    html5 +='<td style="pointer-events: none;" class="">' + response.productList[i].place + '</td><td style="pointer-events: none;" class="">' + response.productList[i].eventContent + '</td></tr>';
                }

                //$('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                //$('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                //$('#group-select1').empty();
                //$("#group-select1").append(html2);
                //$('#group-select1').val(organizationSeq).attr('selected',"selected");
                //$('#select2-group-select-container').text(organizationText);

                //$('#product-select2').empty();
                //$("#product-select2").append(html4);
                $('#Dash_Table_Body2').html(html5);
                $('input').ezMark();
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#company-select3').change(changeCompanySelect3=function(){
        var companySeq = $("#company-select3 option:selected").val();
        if(companySeq==''){
            alert('소속을 선택해주세요');
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectCompany.do',
            type : 'POST',
            data:{companySeq:companySeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                //html +="<option value=''>조직 선택</option>";
                for(var i=0; i<response.origList.length; i++){
                    html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                }
                $('#multipleSelect').empty();
                $("#multipleSelect").append(html);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#vm-select4').change(changeVMSelect4=function(){
        var eventSeq = $('#td7_eventSeq').val();
        var vmSeq = $("#vm-select4 option:selected").val();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/getEventDetail.do',
            type : 'POST',
            data:{ eSeq : eventSeq, eventSeq : eventSeq, vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html2=""; // product-select4
                var html3 =""; //Dash_Table_Body4

                if(response.productList.length <1){
                    html3 +='<tr style="pointer-events: none;"><td colspan=7>둥록된 상품이 존재하지 않습니다</td></tr>';
                }
                html2 +='<option value="all">상품 전체</option>';
                for(var i=0; i<response.productList.length; i++){
                    html3 +='<tr id="'+ response.productList[i].vmSeq +'/'+ response.productList[i].productCode +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.productList[i].vmId+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productName+'</td><td class="" style="pointer-events: none;">'+response.productList[i].productCode+'</td>';
                    html3 +='<td class="t_left" style="pointer-events: none;">'+response.productList[i].place+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productPrice+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productCount+'</td></tr>';
                }
                for(var i=0; i<response.productInfo.length; i++){
                    html2 +="<option value='"+response.productInfo[i].productCode+"'>[" + response.productInfo[i].productCode + "]&nbsp;"+response.productInfo[i].productName+"</option>";
                }
                $('#Dash_Table_Body4').html(html3);
                $('#product-select4').empty();
                $("#product-select4").append(html2);
                $('input').ezMark();
                $('.allSelect4').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#product-select4').change(changeProductSelect4=function(){
        var eventSeq = $('#td7_eventSeq').val();
        var vmSeq = $("#vm-select4 option:selected").val();
        var productCode = $("#product-select4 option:selected").val();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/getEventDetail.do',
            type : 'POST',
            data:{ eSeq : eventSeq, eventSeq : eventSeq, vmSeq : vmSeq, productCode : productCode},
            datatype: 'JSON',
            success:function(response){
                var html3 =""; //Dash_Table_Body4
                if(response.productList.length <1){
                    html3 +='<tr style="pointer-events: none;"><td colspan=7>둥록된 상품이 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.productList.length; i++){
                    html3 +='<tr id="'+ response.productList[i].vmSeq +'/'+ response.productList[i].productCode +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.productList[i].vmId+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productName+'</td><td class="" style="pointer-events: none;">'+response.productList[i].productCode+'</td>';
                    html3 +='<td class="t_left" style="pointer-events: none;">'+response.productList[i].place+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productPrice+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productCount+'</td></tr>';
                }
                $('#Dash_Table_Body4').html(html3);
                $('input').ezMark();
                $('.allSelect4').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });


    $(".allSelect1").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body1').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body1').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body1').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect2").click(function(){
        $('#Dash_Table_Body2').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body2').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body2').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect3").click(function(){
        $('#Dash_Table_Body4').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body2').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body4').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect4").click(function(){
        $('#Dash_Table_Body4').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body4').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body4').find("input").prop('checked', allChildrenChecked).change();

    });
    window.onload = function(){
        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
        pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
    }

    function addEventModal(){

        $('#modal_pop').stop().fadeIn();
        $('.pop_box').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#company-select3').attr('disabled', false);
        $('#multipleSelect').attr('disabled', false);
        $('#modal_form').each(function() { this.reset();});
        $("#event_seq").val(0);
        if(${sessionScope.loginUser.auth==0}){
            $.ajax({
                url:'${root}/company/ajax/getCompanyList.do',
                type : 'GET',
                success:function(response){
                    var html ="";
                    html +="<option value='' selected>선택해주세요</option>";
                    for(var i=0; i<response.length; i++){
                        html +="<option value='"+response[i].seq+"'>"+response[i].name+"</option>";
                    }
                    $('#company-select3').empty();
                    $("#company-select3").append(html);
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append('<option value="">선택해주세요</option>');
                },
                error: function (xhr, status, error) {console.log(error);}
            });
        }else{
            $.ajax({
                url:'${root}/company/ajax/getOrgList.do',
                type : 'GET',
                success:function(response){
                    var html ="";
                    for(var i=0; i<response.length; i++){
                        html +="<option value='"+response[i].organizationSeq+"'>"+response[i].organizationName+"</option>";
                    }
                    $('#company-select3').empty();
                    $("#company-select3").append('<option value="' + $('#company_seq').val() + '" seleted>' + $('#company_name').val() + '</option>');
                    $('#select2-company-select3-container').text($('#company_name').val());
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append(html);
                    if(${sessionScope.loginUser.auth>1}) {
                        //$('#multipleSelect').val($('#orig_seq').val()).attr('selected',"selected");
                        $('#multipleSelect').val($('#orig_seq').val()).change();
                    }
                },
                error: function (xhr, status, error) {console.log(error);}
            });

        }
        $('.pop_title h2').text('이벤트 신규등록');
    }
    function addEvent(){////
        var form = new FormData();
        var companySeq = $("#company-select3 option:selected").val();
        var companyName = $("#company-select3 option:selected").text();
        var organizationSeq = $("#multipleSelect").val();
        var eventTitle = $("#event_title").val();
        var eventType = $("#event_type option:selected").val();
        var eventData = $("#event_data").val();
        var eventStartTime = $("#event_start_Time").val();
        var eventEndTime = $("#event_end_Time").val();
        var eventContent = $("#event_se_Time").val();
        var eventSeq = $("#event_seq").val();

        if(eventTitle==''||companySeq==''||organizationSeq.length===0||eventType==''||eventData==''||eventStartTime==''||eventEndTime==''){
            alert("필수값을 모두 채워주세요.");
            return false;
        }
        if(eventType=='%' && !(eventData >0 && eventData <=100)){
            alert("할인율은 0부터 100까지 입력 가능합니다.");
            $("#event_data").focus();
            return false;
        }
        if(eventType=='-' && eventData<0){
            alert("할인금액은 정수만 입력 가능합니다.(마이너스 금액은 생략 바랍니다.)");
            $("#event_data").focus();
            return false;
        }

        form.append("companySeq", companySeq);
        form.append("array_organizationSeq", organizationSeq);
        form.append( "eventTitle", eventTitle );
        form.append( "eventType", eventType );
        form.append( "eventData", eventData );
        form.append( "eventStartTime", eventStartTime.replace(/\-/g, '') );
        form.append( "eventEndTime", eventEndTime );
        form.append( "seq", eventSeq );
        form.append( "eventContent", eventContent );

        FunLoadingBarStart();
        $.ajax({
            url:'${root}/company/ajax/insertEvent.do',
            type : 'POST',
            data: form,
            processData: false,
            contentType: false,
            success:function(response){
                alert(response);
                $('#modal_pop').stop().fadeOut();
                $('.pop_box').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
                if(${sessionScope.loginUser.auth<1}) {
                    $("#company-select1 option:selected").val(companySeq);
                    $('#select2-company-select1-container').text(companyName);
                    //$("#group-select1 option:selected").val(0);
                }
                searchData();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });
    }
    function deleteEvent(){////
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 이벤트를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteEvent.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    searchData();
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }

    function insertEventToVMProduct(){
        if( $('#orig_seq').val()==0){
            alert('[조직 전체]가 선택된 상태에선 이벤트 추가를 하실 수 없습니다\n조직선택 후 검색버튼을 눌러 활성화 시켜주세요.');
            return false;
        }
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var sizeCheck2 = $('#Dash_Table_Body2 input[type="checkbox"]:checked');
        var eventList = [];
        var vmList = [];
        var accText = '';
        var accText2 = '';
        var accBolean = true;
        if(sizeCheck2.length ==0){
            alert("상품을 선택해주세요"); return false;
        }
        if(sizeCheck.length == 0){
            alert("상품에 추가할 이벤트를 선택하세요"); return false;
        }else if(sizeCheck.length > 1) {
            alert("추가할 이벤트는 한개씩만 가능합니다"); return false;
        }
        else if(sizeCheck.length > 1) {
            alert("추가할 이벤트는 한개씩만 가능합니다"); return false;
        }else{
            if(!confirm("상품에 선택한 이벤트를 추가하시겠습니까?")) return;
            $.each(sizeCheck,function(idex,entry){
                eventList.push(entry.closest('tr').id);
            });
            $.each(sizeCheck2,function(idex,entry){
                vmList.push(entry.closest('tr').id);
            });
            $.each(vmList,function(idex,entry){
                accText = entry.split('/')[2]; //상품금액
                accText2 = $('#Dash_Table_Body1').find('#'+eventList[0]).find('td:eq(3)').text(); //이벤트금액
                if(accText2.includes('-') && parseInt(accText2.split('원')[0])*-1 > parseInt(accText)){
                     alert('판매상품보다 이벤트 할인금액이 더 큽니다.');
                    accBolean = false;
                }
            });
            if(accBolean){
                FunLoadingBarStart();
                $.ajax({
                    url:'${root}/company/ajax/insertEventToVMProduct.do',
                    type : 'POST',
                    data: {eventList : eventList,
                        vmList : vmList},
                    async: false,
                    success:function(response){
                        alert(response);
                        $('.allSelect1').find('div').removeClass("ez-checked");
                        $('.allSelect2').find('div').removeClass("ez-checked");
                        changeProductSelect2();
                        //searchData();
                        //location.reload();
                    },
                    error: function (xhr, status, error) {console.log(error);},
                    complete: function () {FunLoadingBarEnd();}
                });
            }
        }
    }
    function modifyEventModal(){//////
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        if(sizeCheck.length == 0||sizeCheck.length > 1){
            alert("수정할 이벤트 한개만 선택해주세요"); return false;
        }else{
            var eventList = [];
            $.each(sizeCheck,function(idex,entry){
                eventList.push(entry.closest('tr').id);
            });
            $.ajax({
                url:'${root}/company/ajax/getEventInfo.do',
                type : 'POST',
                data: {eventList : eventList},
                success:function(response){
                    var html ="";
                    var selectedValue = new Array();
                    selectedValue[0] = response.eventInfo.organizationSeq;

                    for(var i=0; i<response.orgInfo.length; i++){
                        html +="<option value='"+response.orgInfo[i].organizationSeq+"'>"+response.orgInfo[i].organizationName+"</option>";
                    }

                    $("#event_seq").val(response.eventInfo.seq);
                    $("#event_title").val(response.eventInfo.eventTitle);
                    $('#event_type').val(response.eventInfo.eventType).attr('selected',"selected");
                    $("#event_data").val(response.eventInfo.eventData);
                    $("#event_start_Time").val(response.eventInfo.eventStartTime);
                    $("#event_end_Time").val(response.eventInfo.eventEndTime);
                    $("#event_content").val(response.eventInfo.eventContent);
                    $('#company-select3').empty();
                    $("#company-select3").append('<option value="' + response.eventInfo.companySeq + '" seleted>' + response.eventInfo.companyName + '</option>');
                    $('#select2-company-select3-container').text(response.eventInfo.companyName);
                    $('#company-select3').attr('disabled', true);
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append('<option value="' + response.eventInfo.organizationSeq + '" seleted>' + response.eventInfo.organizationName + '</option>');
                    $('#multipleSelect').val(selectedValue).change();
                    $('#multipleSelect').attr('disabled', true);

                },
                error: function (xhr, status, error) {console.log(error);}
            });

            $('#modal_pop').stop().fadeIn();
            $('.pop_box').stop().fadeIn();
            $('#shadow_bg').stop().fadeIn();
            $('.pop_title h2').text('이벤트 수정');
        }
    }

    function searchData(){
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var organizationText = $("#group-select1 option:selected").text();
        var eventSeq = $("#event-select1 option:selected").val();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');

        if(companySeq == ''||organizationSeq==''){
            alert('소속과 조직 필수 선택입니다');
            return false;
        }

        $.ajax({
            url:'${root}/company/ajax/searchEventList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                eventSeq : eventSeq,
                sDate : sDate,
                eDate : eDate},
            datatype: 'JSON',
            success:function(response){
                ////////////////수정
                var html ="";//이벤트tr
                var html2 ="";//조직s
                var html3 ="";//자판기s
                var html4 ="";//상품s
                var html5 ="";//상품tr

                html2 += "<option value='" + organizationSeq + "' selected>" + organizationText + "</option>";
                /*if(organizationSeq!=0){
                    console.log(organizationSeq);
                    html2 +="<option value='"+ organizationSeq +"' selected>"+organizationText+"</option>";
                }else{
                    if(response.vmInfo.length >0) {
                        html2 += "<option value='" + response.vmInfo[0].organizationSeq + "' selected>" + response.vmInfo[0].organizationName + "</option>";
                    }
                }*/

                html3 +="<option value='0' selected>설치위치 전체</option>";
                html4 +="<option value='all' selected>상품 전체</option>";
                if(response.eventList.length <1){
                    html +="<tr style='pointer-events: none;'><td colspan=5>등록된 이벤트가 존재하지 않습니다</td></tr>";
                }
                if(response.productList.length<1){
                    html5 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=6>상품이 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.eventList.length; i++){
                    html +='<tr id="'+response.eventList[i].seq+'" ><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td onclick="detailEventModal(\''+response.eventList[i].seq+'\');">' + response.eventList[i].seq + '</td>';
                    html +='<td class="t_left" onclick="detailEventModal(\''+response.eventList[i].seq+'\');">' + response.eventList[i].eventTitle + '</td>';
                    html +='<td class="" onclick="detailEventModal(\''+response.eventList[i].seq+'\');">' + response.eventList[i].eventContent + '</td><td class="t_left" onclick="detailEventModal(\''+response.eventList[i].seq+'\');">' + response.eventList[i].eventStartTime + '</td></tr>';
                }
                for(var i=0; i<response.vmInfo.length; i++){
                    html3 +="<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+ response.vmInfo[i].vmId +")</option>";
                }
                for(var i=0; i<response.productList.length; i++){
                    //html4 +="<option value='"+response.productList[i].productCode+"'>["+response.productList[i].productCode+"]&nbsp;"+ response.productList[i].productName +"</option>";
                    html5 +='<tr id="'+response.productList[i].productCode+'/'+response.productList[i].vmSeq+'/'+response.productList[i].productPrice+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html5 +='<td style="pointer-events: none;">' + response.productList[i].vmId + '</td>';
                    html5 +='<td style="pointer-events: none;"class="">' + response.productList[i].productName + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productCode + '</td><td style="pointer-events: none;" class="">' + response.productList[i].productPrice + '</td>';
                    html5 +='<td style="pointer-events: none;"class="">' + response.productList[i].place + '</td><td style="pointer-events: none;" class="">' + response.productList[i].eventContent + '</td></tr>';
                }
                for(var i=0; i<response.productInfo.length; i++){
                    html4 +="<option value='"+response.productInfo[i].productCode+"'>["+response.productInfo[i].productCode+"]&nbsp;"+ response.productInfo[i].productName +"</option>";
                }



                //$('#vm-select2').attr('disabled',false);
                if(organizationSeq !=0) {
                    $('#group-select2').empty();
                    $("#group-select2").append(html2);
                    $('#group-select2').attr('disabled', true);
                    $('#vm-select2').empty();
                    $("#vm-select2").append(html3);
                    $('#product-select2').empty();
                    $("#product-select2").append(html4);
                    $('#Dash_Table_Body2').html(html5);
                }else{
                    $('#group-select2').html('<option value="">조직 선택</option>');
                    $('#group-select2').attr('disabled', false);
                    $("#vm-select2").html('<option value="">설치위치 선택</option>');
                    $("#product-select2").html('<option value="">상품 선택</option>');
                    $('#Dash_Table_Body2').html('<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=6>이벤트 혹은 조직을 먼저 조회해주세요</td></tr>');

                }
                $('#Dash_Table_Body1').html(html);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
                $('#orig_seq').val(organizationSeq);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }
    function detailEventModal(eventSeq){
        //alert(vmSeq+" / "+productCode);
        $('#modal_pop').stop().fadeIn();
        $('.pop_listEvent').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('.pop_title h2').text('이벤트 상세조회');

        $.ajax({
            url:'${root}/company/ajax/getEventDetail.do',
            type : 'POST',
            data:{ eSeq : eventSeq, eventSeq : eventSeq},
            datatype: 'JSON',
            success:function(response){
                var html =""; // vm-select4
                var html2=""; // product-select4
                var html3 =""; //Dash_Table_Body4

                if(response.productList.length <1){
                    html3 +='<tr style="pointer-events: none;"><td colspan=7>둥록된 상품이 존재하지 않습니다</td></tr>';
                }
                html +='<option value="0">설치위치 전체</option>';
                html2 +='<option value="all">상품 전체</option>';
                for(var i=0; i<response.productList.length; i++){
                    html3 +='<tr id="'+ response.productList[i].vmSeq +'/'+ response.productList[i].productCode +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.productList[i].vmId+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productName+'</td><td class="" style="pointer-events: none;">'+response.productList[i].productCode+'</td>';
                    html3 +='<td class="t_left" style="pointer-events: none;">'+response.productList[i].place+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productPrice+'</td><td class="t_left" style="pointer-events: none;">'+response.productList[i].productCount+'</td></tr>';
                }
                for(var i=0; i<response.productInfo.length; i++){
                    //html +="<option value='"+response.productInfo[i].vmSeq+"'>"+response.productInfo[i].place+"("+response.productInfo[i].vmId+")</option>";
                    html2 +="<option value='"+response.productInfo[i].productCode+"'>[" + response.productInfo[i].productCode + "]&nbsp;"+response.productInfo[i].productName+"</option>";
                }
                for(var i=0; i<response.productInfo2.length; i++){
                    html +="<option value='"+response.productInfo2[i].vmSeq+"'>"+response.productInfo2[i].place+"("+response.productInfo2[i].vmId+")</option>";
                }

                $("#td1_eventTitle").text('['+response.eventInfo.seq+'] '+response.eventInfo.eventTitle);
                $("#td2_comOrg").text(response.eventInfo.companyName);
                $("#td3_eventType").text(response.eventInfo.eventContent2);
                $("#td4_eventDate").text(response.eventInfo.eventStartTime);
                $("#td5_eventContent").text(response.eventInfo.eventContent??'');
                $("#td6_createDate").text(response.eventInfo.createDate);
                $("#td7_eventSeq").val(response.eventInfo.seq);

                $('#Dash_Table_Body4').html(html3);
                $('#vm-select4').empty();
                $("#vm-select4").append(html);
                $('#product-select4').empty();
                $("#product-select4").append(html2);
                $('input').ezMark();
                $('.allSelect4').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }
    function deleteProductFromEvent(){ //이벤트상세에서
        var eventSeq = $('#td7_eventSeq').val();
        var sizeCheck = $('#Dash_Table_Body4 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("이벤트를 삭제할 상품을 선택해주세요");
        }else{
            if(!confirm("선택한 상품에 해당 이벤트를 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedVMProductFromEvent.do',
                type : 'GET',
                data: {deleteList:deleteList,eventSeq:eventSeq},
                success:function(response){
                    alert(response);
                    detailEventModal(eventSeq);
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }



</script>
</body>
</html>
