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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>매출집계</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    tr {
        pointer-events: none;
    }
    .total_1>td{background: #f3dec4!important;}
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_ms_salesReport').addClass("current");
        $('#lnb_sales').addClass("on");
        $('#lnb_sales').children('ul').show();
        $('#mn_ms_m_salesReport').addClass("current");
        $('#lnb_m_sales').addClass("on");
        $('#lnb_m_sales').next('ul').css('display','block');
        $('.subtit').text("매출집계");

        $(".sales_tab li").click(function () { //tab1
            $(".sales_tab li.current").removeClass("current");
            $(this).addClass("current");

            if($('#toProduct_b').hasClass('current')){
               $('#toProduct_input').show();
               $('#searchType').val('toProduct');
            }
            else {
                $('#toProduct_input').hide();
                $('#toProduct_input').val('');
                $('#searchType').val('toDay');
            }
        });

    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            매출집계
        </header>
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
                                <option value="0" selected>전체</option>
                                <c:forEach var="orgList" items="${orgList}">
                                    <option value="${orgList.seq}">${orgList.name}</option>
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
                <li class="input-size02"><label>기간</label><input id="sDate"type="date">&nbsp;~&nbsp;<input id="eDate" type="date"></li>
                <li>
                    <label for="dateSelect">기간구분</label>
                    <ul class="tabs2 day_tab" id="dateSelect">
                        <li class="current" data-tab="tab-1" value="today" onclick="setDate('today');">오늘</li>
                        <li data-tab="tab-2" value="last_week" onclick="setDate('last_week');">일주일</li>
                        <li data-tab="tab-3" value="this_month" onclick="setDate('this_month');">이번달</li>
                        <li data-tab="tab-4" value="last_month" onclick="setDate('last_month');">지난달</li>
                    </ul>
                </li>
                <li>
                    <label for="to_b">판매구분</label>
                    <ul class="tabs2 sales_tab" id="to_b">
                        <li class="current" id="toDay_b" data-tab="toDay">일별</li>
                        <li id="toProduct_b" data-tab="toProduct">상품별</li>
                    </ul>
                </li>
                <%--<li class="" id="toProduct_input" style="display: none;">
                    <label for="product-name">상품명/상품코드</label>
                    <input type="text" id="product-name" placeholder="&구분시 여러상품 검색가능" maxlength="20" onkeydown="if(event.keyCode == 13) searchData();">
                    &lt;%&ndash;<select id="multipleSelect_product" data-placeholder="선택해주세요" style="width: 100%;" multiple></select>&ndash;%&gt;
                </li>--%>
                <li class="">
                    <label for="toProduct_input"></label>
                    <input type="text" class="mar-right-10" id="toProduct_input" placeholder="상품명 또는 상품코드 입력" maxlength="16" onkeydown="if(event.keyCode == 13) searchData();"style="display:none;">
                    <input type="hidden" id="searchType" value="toDay">
                    <input type="hidden" id="search_sDate" value="">
                    <input type="hidden" id="search_eDate" value="">
                    <input type="hidden" id="search_productName" value="">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth<=1}">
                            <input type="hidden" id="search_orgName" value="전체">
                            <input type="hidden" id="search_orgSeq" value="0">
                            <input type="hidden" id="search_vmId" value="전체">
                            <input type="hidden" id="search_place" value="전체">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" id="search_orgName" value="${sessionScope.loginUser.organizationName}">
                            <input type="hidden" id="search_orgSeq" value="${sessionScope.loginUser.organizationSeq}">
                            <input type="hidden" id="search_vmId" value="${vmList[0].vmId}">
                            <input type="hidden" id="search_place" value="${vmList[0].place}">
                        </c:otherwise>
                    </c:choose>

                    <a href="javascript:void(0);" class="button3 button_position2 top-7" onclick="searchData();">조회</a></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="table_selectbox2">
                    <ul>
                        <li class="button_position4">
                            ※ 해당 매출정보는 일부 자료가 누락될 수 있으므로 정확한 정산내역은 VMMS 홈페이지를 참조합시오 : <a style="position: relative;z-index:99999996;text-decoration : underline; color: #0fbad6; " target="_self" href="javascript:window.open('https://vmms.ubcn.co.kr/');">VMMS로 이동</a>
                        </li>
                        <li class="button_position3">
                            <a href="javascript:saveExcelFile2();" class="button" onclick=""><img src="${root}/resources/images/ic_save.png">엑셀저장</a>
                        </li>
                    </ul>
                </div>
                <div style="font-size: 14px; margin: 3px;"> 검색결과: <span id="totalCnt" style="font-weight: bold; color:#0075fe;">0</span>건</div>
                <div id="toDay">
                <div class="table_responsive">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="10%">
                        <col width="21%">
                        <col width="21%">
                        <col width="21%">
                        <col width="*%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>날짜</th>
                        <th>자판기 ID</th>
                        <th>단말기 ID</th>
                        <th>거래건수</th>
                        <th>금액</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:set var="sub_itemCount" value="0" />
                    <c:set var="sub_amount" value="0" />
                    <c:set var="total_itemCount" value="0" />
                    <c:set var="total_amount" value="0" />
                    <%--<c:if test="${empty dailySales}">
                        <tr><td colspan=7>거래내역이 존재하지 않습니다</td></tr>
                    </c:if>--%>
                    <c:set var="dailySalesListLength" value="${fn:length(dailySalesList)}"/>
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <tr><td colspan=7>소속/조직을 선택해주세요.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${empty dailySalesList}">
                                <tr><td colspan=7>내역이 존재하지 않습니다</td></tr>
                            </c:if>
                            <c:forEach var='dailySales' items="${dailySalesList}" varStatus="status">
                            <tr>
                                <%--<td><c:out value="${status.count}" /></td>--%>
                                <td><c:out value="${dailySalesListLength}" /></td>
                                <c:set var="dailySalesListLength" value="${dailySalesListLength-1}"/>
                                <td>${dailySales.transactionDate}</td>
                                <td>${dailySales.vmId}</td>
                                <td>${dailySales.terminalId}</td>
                                <td>${dailySales.itemCount}</td>
                                <td>${dailySales.amount}</td>
                                <c:set var="sub_itemCount" value="${sub_itemCount + dailySales.itemCount}" />
                                <c:set var="sub_amount" value="${sub_amount + dailySales.amount}" />
                                    <c:set var="total_itemCount" value="${total_itemCount + dailySales.itemCount}" />
                                    <c:set var="total_amount" value="${total_amount + dailySales.amount}" />
                            </tr>
                            <c:if test="${dailySales.transactionDate ne dailySalesList[status.index+1].transactionDate}">
                                <tr class="total">
                                    <td colspan="4">${dailySales.transactionDate} 소계</td>
                                    <td><fmt:formatNumber value="${sub_itemCount}" pattern="#,###" /></td>
                                    <td><fmt:formatNumber value="${sub_amount}" pattern="#,###" /></td>
                                </tr>
                                <c:set var="sub_itemCount" value="0" />
                                <c:set var="sub_amount" value="0" />
                            </c:if>
                            <c:if test="${status.last}">
                            </c:if>
                        </c:forEach>
                            <c:if test="${!empty dailySalesList}">
                            <tr class="total_1">
                                <td colspan="4">합계</td>
                                <td><fmt:formatNumber value="${total_itemCount}" pattern="#,###" /></td>
                                <td><fmt:formatNumber value="${total_amount}" pattern="#,###" /></td>
                            </tr>
                            </c:if>

                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
                </div>

                <div id="toProduct" style="display: none;">
                <div class="table_responsive">
                    <table class="tb_horizen">
                        <colgroup>
                            <col width="5%">
                            <col width="10%">
                            <col width="21%">
                            <col width="21%">
                            <col width="21%">
                            <col width="*%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순번</th>
                            <th>상품</th>
                            <th>자판기 ID</th>
                            <th>단말기 ID</th>
                            <th>거래건수</th>
                            <th>금액</th>
                        </tr>
                        </thead>
                        <tbody id="Dash_Table_Body2">
                        <c:set var="sub_itemCount2" value="0" />
                        <c:set var="sub_amount2" value="0" />
                        <c:set var="total_itemCount2" value="0" />
                        <c:set var="total_amount2" value="0" />
                        <%--<c:if test="${empty dailySales}">
                            <tr><td colspan=7>거래내역이 존재하지 않습니다</td></tr>
                        </c:if>--%>
                        <c:set var="productSalesListLength" value="${fn:length(productSalesList)}"/>
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <tr><td colspan=7>소속/조직을 선택해주세요.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${empty productSalesList}">
                                    <tr><td colspan=7>내역이 존재하지 않습니다</td></tr>
                                </c:if>
                                <c:forEach var='productSales' items="${productSalesList}" varStatus="status">
                                    <tr>
                                            <%--<td><c:out value="${status.count}" /></td>--%>
                                        <td><c:out value="${productSalesListLength}" /></td>
                                        <c:set var="productSalesListLength" value="${productSalesListLength-1}"/>
                                        <td>${productSales.productName}</td>
                                        <td>${productSales.vmId}</td>
                                        <td>${productSales.terminalId}</td>
                                        <td>${productSales.itemCount}</td>
                                        <td>${productSales.amount}</td>
                                        <c:set var="sub_itemCount2" value="${sub_itemCount2 + productSales.itemCount}" />
                                        <c:set var="sub_amount2" value="${sub_amount2 + productSales.amount}" />
                                        <c:set var="total_itemCount2" value="${total_itemCount2 + productSales.itemCount}" />
                                        <c:set var="total_amount2" value="${total_amount2 + productSales.amount}" />
                                    </tr>
                                    <c:if test="${productSales.productCode ne productSalesList[status.index+1].productCode}">
                                        <tr class="total">
                                            <td colspan="4">소계(${productSales.productName})</td>
                                            <td><fmt:formatNumber value="${sub_itemCount2}" pattern="#,###" /></td>
                                            <td><fmt:formatNumber value="${sub_amount2}" pattern="#,###" /></td>
                                        </tr>
                                        <c:set var="sub_itemCount2" value="0" />
                                        <c:set var="sub_amount2" value="0" />
                                    </c:if>
                                    <c:if test="${status.last}">
                                    </c:if>
                                </c:forEach>
                                <c:if test="${!empty productSalesList}">
                                    <tr class="total_1">
                                        <td colspan="4">합계</td>
                                        <td><fmt:formatNumber value="${total_itemCount2}" pattern="#,###" /></td>
                                        <td><fmt:formatNumber value="${total_amount2}" pattern="#,###" /></td>
                                    </tr>
                                </c:if>

                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
                </div>
            </div>
        </section>
    </section>
</div>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    /*$('#multipleSelect_product').select2();*/
    //vending:설치위치, termianl:단말ID,vmID
    function searchData(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationName = $("#group-select option:selected").text();
        var vmSeq = $("#terminal-select option:selected").val();
        var vmId = $("#terminal-select option:selected").text();
        var place = $("#vending-select option:selected").text();
        var productName = $('#toProduct_input').val();
        var searchType = $('#searchType').val();
        //var terminalId = $("#terminal-select option:selected").text();
        //단말기/자판기

        if(vmSeq!='전체'){
            vmId = vmId.split('/')[1];
        }

        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');

        if(companySeq==''){alert("소속을 선택해주세요");return false;}
        if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        //if(vmSeq==''){alert("자판기를 선택해주세요");return false;}
        if(vmId==''){alert("자판기ID를 선택해주세요");return false;}
        //if(terminalId==''){alert("단말기ID를 선택해주세요");return false;}

        $.ajax({
            url:'${root}/sales/ajax/getSearchDailySalesList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmId : vmId,
                productName : productName,
                sDate : sDate,
                eDate : eDate,
                searchType : searchType},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var sub_itemCount = 0;
                var sub_amount = 0;
                var total_itemCount = 0;
                var total_amount = 0;
                var save_transationDate="";
                var save_productCode="";
                var list_length = response.length;
                if(response.length <1){
                    html +='<tr><td colspan=6>내역이 존재하지 않습니다.</td></tr>';
                }else {
                    if(searchType == 'toProduct') {
                        for (var i = 0; i < response.length; i++) {
                            if (i != 0 && save_productCode != response[i].productCode) {
                                html += '<tr class="total"><td colspan="4">' + save_transationDate + '(' + save_productCode + ') 소계</td><td>' + sub_itemCount.toLocaleString('ko-KR') + '</td><td>' + sub_amount.toLocaleString('ko-KR') + '</td></tr>';
                                sub_itemCount = 0;
                                sub_amount = 0;
                            }
                            html += '<tr><td>' + (list_length) + '</td><td>' + response[i].productName + '(' + response[i].productCode + ')</td><td>' + response[i].vmId + '</td><td>' + response[i].terminalId + '</td><td>' + response[i].itemCount.toLocaleString('ko-KR') + '</td><td>' + response[i].amount.toLocaleString('ko-KR') + '</td>';
                            list_length = list_length - 1;
                            sub_itemCount += response[i].itemCount;
                            sub_amount += response[i].amount;
                            total_itemCount += response[i].itemCount;
                            total_amount += response[i].amount;
                            if (i == response.length - 1) {
                                html += '<tr class="total"><td colspan="4">' + response[i].productName + '(' + response[i].productCode + ') 소계</td><td>' + sub_itemCount.toLocaleString('ko-KR') + '</td><td>' + sub_amount.toLocaleString('ko-KR') + '</td></tr>';
                                sub_itemCount = 0;
                                sub_amount = 0;
                            }
                            save_transationDate = response[i].productName;
                            save_productCode = response[i].productCode;
                        }
                        html += '<tr class="total_1"><td colspan="4">합계</td><td>' + total_itemCount.toLocaleString('ko-KR') + '</td><td>' + total_amount.toLocaleString('ko-KR') + '</td></tr>';
                    }
                    else{
                        for (var i = 0; i < response.length; i++) {
                            if (i != 0 && save_transationDate != response[i].transactionDate) {
                                html += '<tr class="total"><td colspan="4">' + save_transationDate + ' &nbsp;소계</td><td>' + sub_itemCount.toLocaleString('ko-KR') + '</td><td>' + sub_amount.toLocaleString('ko-KR') + '</td></tr>';
                                sub_itemCount = 0;
                                sub_amount = 0;
                            }
                            html += '<tr><td>' + (list_length) + '</td><td>' + response[i].transactionDate + '</td><td>' + response[i].vmId + '</td><td>' + response[i].terminalId + '</td><td>' + response[i].itemCount.toLocaleString('ko-KR') + '</td><td>' + response[i].amount.toLocaleString('ko-KR') + '</td>';
                            list_length = list_length - 1;
                            sub_itemCount += response[i].itemCount;
                            sub_amount += response[i].amount;
                            total_itemCount += response[i].itemCount;
                            total_amount += response[i].amount;
                            if (i == response.length - 1) {
                                html += '<tr class="total"><td colspan="4">' + response[i].transactionDate + ' &nbsp;소계</td><td>' + sub_itemCount.toLocaleString('ko-KR') + '</td><td>' + sub_amount.toLocaleString('ko-KR') + '</td></tr>';
                                sub_itemCount = 0;
                                sub_amount = 0;
                            }
                            save_transationDate = response[i].transactionDate;
                        }
                        html += '<tr class="total_1"><td colspan="4">합계</td><td>' + total_itemCount.toLocaleString('ko-KR') + '</td><td>' + total_amount.toLocaleString('ko-KR') + '</td></tr>';
                    }
                }
                $('#search_orgSeq').val(organizationSeq);
                $('#search_orgName').val(organizationName);
                $('#search_vmId').val(vmId);
                $('#search_place').val(place);
                $('#search_sDate').val(sDate);
                $('#search_eDate').val(eDate);
                $('#search_productName').val(productName);
                $('#totalCnt').text(numberWithCommas(response.length));
                if(searchType =='toDay') {
                    $('#Dash_Table_Body1').html(html);
                    $('#toProduct').hide();
                    $('#toDay').show();
                }else{
                    $('#Dash_Table_Body2').html(html);
                    $('#toDay').hide();
                    $('#toProduct').show();
                }

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    /*function saveExcelFile(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#terminal-select option:selected").val();
        var vmId = $("#terminal-select option:selected").text();
        var terminalId = $("#terminal-select option:selected").text();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        if(vmSeq!='전체'){
            vmId = vmId.split('/')[1];
        }

        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');
        if(companySeq==''){alert("소속을 선택해주세요");return false;}

        $.ajax({
            url:'${root}/sales/ajax/getDeadlineSalesData.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmId : vmId,
                sDate : sDate,
                eDate : eDate},
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
                a.download = "멀티자판기_매출집계.xlsx";
                document.body.appendChild(a);
                a.click();



            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }*/
    function saveExcelFile2(){
        //searchData();
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $('#search_orgSeq').val();
        var vmId = $('#search_vmId').val();
        var productName = $('#search_productName').val();
        var sDate = $('#search_sDate').val();
        var eDate = $('#search_eDate').val();
        var searchType = $('#searchType').val();

        if(companySeq==''){alert("소속을 선택해주세요");return false;}

        $.ajax({
            url:'/sales/ajax/getExcelSalesData.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                organizationName : $("#search_orgName").val(),
                place : $("#search_place").val(),
                productName : productName,
                vmId : vmId,
                sDate : sDate,
                eDate : eDate,
                searchType : searchType},
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
                a.download = "멀티자판기_매출집계.xlsx";
                document.body.appendChild(a);
                a.click();

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

</script>
</body>
</html>
