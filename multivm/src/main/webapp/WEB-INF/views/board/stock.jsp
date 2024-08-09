<%--
  Created by IntelliJ IDEA.
  User: hys
  Date: 2022-02-16
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>재고현황</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    /*tr {
        pointer-events: none;
    }*/
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mv_stock').addClass("current");
        $('#lnb_board').addClass("on");
        $('#lnb_board').children('ul').show();
        $('#mn_mv_m_stock').addClass("current");
        $('#lnb_m_board').addClass("on");
        $('#lnb_m_board').next('ul').css('display','block');
        $('.subtit').text("재고현황");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        $("#searchValue").on("keyup",function(key){
            if(key.keyCode==13) {
                searchData();
            }
        });
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            재고현황
        </header>
        <div id="shadow_bg" style="display: none;"></div>
        <div id="modal_pop" style="display: none;">
            <div class="pop_box">
                <div class="pop_title">
                    <h2>재고 보정</h2>
                    <span><a href="javascript:closeModal();"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <form action="#none" method="post" id="modal_form">
                        <input type="hidden" id="companySeq">
                        <input type="hidden" id="organizationSeq">
                        <input type="hidden" id="vmSeq">
                        <input type="hidden" id="productSeq">
                        <fieldset>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="vending-id" class="form_title">자판기 ID</label>
                                    <input type="text" id="vending-id" disabled />
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="terminal-id" class="form_title">단말기 ID</label>
                                    <input type="text" id="terminal-id" disabled>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="product-name" class="form_title">상품명</label>
                                    <input type="text" id="product-name" disabled>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="product-code" class="form_title">상품코드</label>
                                    <input type="text" id="product-code" disabled>
                                </li>
                                <li>
                                    <label for="slot-no" class="form_title">슬롯번호</label>
                                    <input type="text" id="slot-no" disabled>
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-count" class="form_title">현재고</label>
                                    <input type="text" id="product-count" disabled>
                                </li>
                                <li>
                                    <label for="product-edit" class="form_title">보정재고</label>
                                    <input type="text" id="product-edit" placeholder="입력해주세요" maxlength="10">
                                </li>
                            </ul>
                        </fieldset>
                        <input type="hidden" id="stock-seq" value="">
                    </form>
                    <div class="pop_button">
                        <a href="javascript:closeModal();" class="button2 btn_cancel">취소</a>
                        <a href="javascript:modifyData();" class="button2 btn_ok">수정하기</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar">
            <ul>
                <li class="mar02">
                    <label for="company-select">소속</label>
                    <select name="company" id="company-select" style="width:100%">
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
                    <select name="organization" id="group-select" style="width:100%">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="">소속을 선택해주세요</option>
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
                <li class="mar02">
                    <label for="terminal-select">단말기 ID / 자판기 ID</label>
                    <select name="office" id="terminal-select" style="width:100%">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                            </c:when>
                            <c:otherwise>
                                <option value="전체" selected>전체</option>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.terminalId}&nbsp;/&nbsp;${vmList.vmId}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="mar02">
                    <label for="vending-select">설치위치</label>
                    <select name="office" id="vending-select" style="width:100%">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                            </c:when>
                            <c:otherwise>
                                <option value="전체" selected>전체</option>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.place}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
            </ul>
            <ul class="search_bar_pad">
                <li class="input-size02"><label>검색조건 선택</label>
                    <select name="office" id="searchType" style="width:39%">
                        <option value="">선택</option>
                        <option value="1">상품명</option>
                        <option value="2">상품코드</option>
                        <option value="3">슬롯번호</option>
                    </select>
                    <input placeholder="입력해주세요" id="searchValue" type="text" maxlength="25" style="width: 53%">
                </li>
               <%-- <li class="input-size02"><label>기간</label><input id="sDate"type="date">&nbsp;~&nbsp;<input id="eDate" type="date"></li>
                <li>
                    <label for="dateSelect">기간구분</label>
                    <ul class="tabs2 day_tab" id="dateSelect">
                        <li class="current" data-tab="tab-1" value="today" onclick="setDate('today');">오늘</li>
                        <li data-tab="tab-2" value="last_week" onclick="setDate('last_week');">일주일</li>
                        <li data-tab="tab-3" value="this_month" onclick="setDate('this_month');">이번달</li>
                        <li data-tab="tab-4" value="last_month" onclick="setDate('last_month');">지난달</li>
                    </ul>
                </li>--%>
                <li class="label_none2"><label></label><a href="javascript:void(0);" class="button3 button_position2" onclick="searchData();">조회</a></li>
                <li></li>
                <%--<li></li>
                <li></li>--%>
            </ul>
            <%--<ul class="search_bar_pad">
                <li class="input-size02"><label>기간</label><input id="sDate"type="date">&nbsp;~&nbsp;<input id="eDate" type="date"></li>
                <li>
                    <label for="dateSelect"></label>
                    <ul class="tabs2" id="dateSelect">
                        <li class="current" data-tab="tab-1" value="today" onclick="setDate('today');">오늘</li>
                        <li data-tab="tab-2" value="last_week" onclick="setDate('last_week');">일주일</li>
                        <li data-tab="tab-3" value="this_month" onclick="setDate('this_month');">이번달</li>
                        <li data-tab="tab-4" value="last_month" onclick="setDate('last_month');">지난달</li>
                    </ul>
                </li>
                <li><label></label><a href="javascript:void(0);" class="button3 button_position2" onclick="searchData();">조회</a></li>
                <li></li>
            </ul>--%>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="table_responsive">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="15%">
                        <col width="15%">
                        <col width="5%">
                        <col width="*">
                        <col width="10%">
                        <col width="7%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>NO</th>
                        <th>자판기 ID</th>
                        <th>단말기 ID</th>
                        <th>슬롯번호</th>
                        <th>상품명</th>
                        <th>상품코드</th>
                        <th>현재고</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <tr style="pointer-events: none;"><td colspan=8>소속/조직을 선택해주세요.</td></tr>
                        </c:when>
                        <c:otherwise>
                    <c:if test="${empty stockList}">
                        <tr style="pointer-events: none;"><td colspan=8>내역이 존재하지 않습니다</td></tr>
                    </c:if>
                    <c:set var="stockListLength" value="${fn:length(stockList)}"/>
                    <c:forEach var='stockList' items="${stockList}" varStatus="status">
                        <tr onclick="editModal(${stockList.seq});">
                            <td><c:out value="${status.count}" /></td>
                            <%--<td><c:out value="${stockListLength}" /></td>
                                <c:set var="stockListLength" value="${stockListLength-1}"/>--%>
                            <td>${stockList.vmId}</td>
                            <td>${stockList.terminalId}</td>
                            <td>${stockList.slotNo}</td>
                            <td>${stockList.productName}</td>
                            <td>${stockList.productCode}</td>
                            <td>${stockList.productCount}</td>
                        </tr>
                    </c:forEach>
                    </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
                </div>
                <div class="pagination" id="pagination_ys">
                </div>
                <input type="hidden" id="nowpage" value="1">
            </div>
        </section>
    </section>
</div>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    function searchData(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#vending-select option:selected").val();
        var vmId = $("#vending-select option:selected").text();
        //var terminalId = $("#terminal-select option:selected").text();

        if(vmSeq!='전체'){
            vmId = vmId.split('/')[1];
        }

        if(companySeq==''){alert("소속을 선택해주세요");return false;}
        if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        if(vmId==''){alert("자판기ID를 선택해주세요");return false;}

        if($('#searchValue').val() !='' && $('#searchType').val() ==''){
            alert('검색조건을 선택해주세요.');
            $('#searchType').focus();
            return false;
        }

        $.ajax({
            url:'${root}/board/ajax/getSearchStockList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq,
                searchValue : $("#searchValue").val(),
                searchType : $("#searchType").val()},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var list_length = response.length;
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td colspan=8>내역이 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr onclick="editModal('+response[i].seq+')"><td>'+ (i+1) +'</td><td>'+response[i].vmId+'</td><td>'+response[i].terminalId+'</td><td>'+response[i].slotNo+'</td><td>'+response[i].productName+'</td><td>'+response[i].productCode+'</td><td>'+response[i].productCount+'</td>';
                    list_length = list_length-1;
                }
                $('#Dash_Table_Body1').html(html);
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys",$('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function editModal(stockSeq){
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/board/ajax/detailProductStock.do',
            type : 'POST',
            data:{ seq : stockSeq},
            datatype: 'JSON',
            success:function(response){
                $('#product-edit').val('');
                $('#vending-id').val(response.vmId);
                $('#terminal-id').val(response.terminalId);
                $('#product-name').val(response.productName);
                $('#product-code').val(response.productCode);
                $('#slot-no').val(response.slotNo);
                $('#product-count').val(response.productCount);
                $('#stock-seq').val(response.seq);
                $('#companySeq').val(response.companySeq);
                $('#organizationSeq').val(response.organizationSeq);
                $('#vmSeq').val(response.vmSeq);
                $('#productSeq').val(response.productSeq);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function modifyData(){

        $.ajax({
            url:'${root}/board/ajax/editProductStock.do',
            type : 'POST',
            data:{
                companySeq : $('#companySeq').val(), organizationSeq : $('#organizationSeq').val(), vmSeq : $('#vmSeq').val(), productSeq : $('#productSeq').val()
                , productCount : $('#product-count').val(), editCount : $('#product-edit').val(), slotNo : $('#slot-no').val(),  seq : $('#stock-seq').val()
            },
            datatype: 'JSON',
            success:function(response){
                alert(response);
                searchData();
                closeModal();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }


</script>
</body>
</html>
