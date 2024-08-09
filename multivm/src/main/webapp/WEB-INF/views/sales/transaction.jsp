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
    <title>거래내역</title>

    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_ms_transaction').addClass("current");
        $('#lnb_sales').addClass("on");
        $('#lnb_sales').children('ul').show();
        $('#mn_ms_m_transaction').addClass("current");
        $('#lnb_m_sales').addClass("on");
        $('#lnb_m_sales').next('ul').css('display','block');
        $('.subtit').text("거래내역");

    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            거래내역
        </header>
        <div id="shadow_bg" style="display:none;"></div>
        <div id="modal_pop" style="display:none;">
            <div class="pop_box2">
                <div class="pop_title">
                    <h2>거래 상세내역</h2>
                    <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="closeModal();"></a></span>
                </div>
                <div class="pop_contbox">
                    <div class="table_responsive">
                    <table class="tb_horizen">
                        <colgroup>
                            <col width="5%">
                            <col width="12%">
                            <col width="12%">
                            <col width="15%">
                            <col width="*">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>순번</th>
                            <th>자판기 ID</th>
                            <th>단말기 ID</th>
                            <th>매출일시</th>
                            <th>판매제품</th>
                            <th>상품코드</th>
                            <th>개수</th>
                            <th>판매금액</th>
                            <th>슬롯번호</th>
                            <th>투출여부</th>
                        </tr>
                        </thead>
                        <tbody id="Dash_Table_Body2">
                        </tbody>
                    </table>
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
                                <option value='전체' selected>전체</option>
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
                                <option value='전체' selected>전체</option>
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
                <li class="label_none"><label></label><a href="javascript:void(0);" class="button3 button_position2" onclick="searchData();">조회</a></li>
                <li></li>
            </ul>
        </div>
        <input type="hidden" id="search_sDate" value="">
        <input type="hidden" id="search_eDate" value="">
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

        <section id="body_contents" class="">
            <div class="table_outline tabletable_responsive_outline">
                <div class="table_selectbox2">
                    <ul>
                        <li class="button_position4">
                            ※ 해당 매출정보는 일부 자료가 누락될 수 있으므로 정확한 정산내역은 VMMS 홈페이지를 참조합시오 : <a style="position: relative;z-index:99999996;text-decoration : underline; color: #0fbad6; " target="_self" href="javascript:window.open('https://vmms.ubcn.co.kr/');">VMMS로 이동</a>
                        </li>
                        <li class="button_position3">
                            <a href="javascript:saveExcelFile();" class="button" onclick=""><img src="${root}/resources/images/ic_save.png">엑셀저장</a>
                        </li>
                    </ul>
                </div>
                <div style="font-size: 14px;margin: 3px;"> 검색결과: <span id="totalCnt" style="font-weight: bold; color:#0075fe;">0</span>건</div>
                <div class="">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="12%">
                        <col width="12%">
                        <col width="15%">
                        <col width="*">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="15%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>순번</th>
                        <th>자판기 ID</th>
                        <th>단말기 ID</th>
                        <th>매출일시</th>
                        <th>판매제품</th>
                        <th>상품코드</th>
                        <th>총결제금액</th>
                        <th>결제수단</th>
                        <th>취소일시</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:set var="salesListLength" value="${fn:length(salesList)}"/>
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <tr style="pointer-events: none;"><td colspan=9>소속/조직을 선택해주세요.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${empty salesList}">
                                <tr style="pointer-events: none;"><td colspan=9>거래내역이 존재하지 않습니다</td></tr>
                            </c:if>
                        <c:forEach var='salesList' items="${salesList}" varStatus="status">
                            <tr onclick="detailModal(${salesList.transactionNo})">
                                <%--<td><c:out value="${status.count}" /></td>--%>
                                <td><c:out value="${salesListLength}" /></td>
                                <c:set var="salesListLength" value="${salesListLength-1}"/>
                                <td>${salesList.vmId}</td>
                                <td class="">${salesList.terminalId}</td>
                                <td class="">${salesList.transactionDate} ${salesList.transactionTime}</td>
                                <c:choose>
                                    <c:when test="${salesList.itemCount>1}">
                                        <td class="">${salesList.productName} 외 ${salesList.itemCount-1}건 </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="">${salesList.productName}</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${salesList.itemCount>1}">
                                    <td class="">${salesList.productCode} 외 ${salesList.itemCount-1}건 </td>
                                    </c:when>
                                    <c:otherwise>
                                    <td class="">${salesList.productCode}</td>
                                    </c:otherwise>
                                </c:choose>
                                        <td class="">${salesList.amount}</td>
                                        <td class="">${salesList.payType}</td>
                                        <td class="">${salesList.cancelDate}</td>
                            </tr>
                        </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
                </div>
                <div class="pagination" id="pagination_ys">
                </div><input type="hidden" id="nowpage" value="1">
            </div>
        </section>
    </section>
</div>
<%--<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>--%>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">

    /*$('#terminal-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        //var terminalId = $("#terminal-select option:selected").val();
        var terminalId = $("#terminal-select option:selected").text();
        alert(terminalId);

        if($(this).val()==''){
            $('#vending-select').children().remove();
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectOrig.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                terminalId : terminalId
            },
            datatype: 'JSON',
            success:function(response){
                var html2 =""; //자판기ID
                if(response.length>0){
                    html2 +="<option value='0' label='전체'/>";
                    for(var i=0; i<response.length; i++){
                        html2 +="<option value='"+response[i].seq+"' label='"+response[i].vmId+"'/>";
                    }
                }
                $('#vending-select').html(html2);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });*/

    function searchData(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationName = $("#group-select option:selected").text();
        var vmSeq = $("#terminal-select option:selected").val();
        var vmId = $("#terminal-select option:selected").text();
        var place = $("#vending-select option:selected").text();
        //var terminalId = $("#terminal-select option:selected").text();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        if(vmSeq!='전체'){
            vmId = vmId.split('/')[1];
        }

        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');

        if(companySeq==''){alert("소속을 선택해주세요");return false;}
        if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        if(vmId==''){alert("자판기ID를 선택해주세요");return false;}
        //if(terminalId==''){alert("단말기ID를 선택해주세요");return false;}

        $.ajax({
            url:'${root}/sales/ajax/getSearchSalesList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmId : vmId,
                sDate : sDate,
                eDate : eDate},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var list_length = response.length;
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td colspan=9>내역이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                        html +='<tr onclick="detailModal(\''+response[i].transactionNo+'\');"><td>'+ list_length +'</td><td>'+response[i].vmId+'</td><td>'+response[i].terminalId+'</td><td>'+response[i].transactionDate+'&nbsp;'+response[i].transactionTime+'</td>';
                        if(response[i].itemCount>1){
                            html +='<td>'+response[i].productName+' 외 '+(response[i].itemCount-1)+'건</td><td>'+response[i].productCode+' 외 '+(response[i].itemCount-1)+'건</td>';
                        }
                        else html +='<td>'+response[i].productName+'</td><td>'+response[i].productCode+'</td>';
                        html +='<td>'+numberWithCommas(response[i].amount)+'</td><td>'+response[i].payType+'</td><td>'+response[i].cancelDate+'</td></tr>';
                        list_length = list_length-1;
                }
                $('#search_orgSeq').val(organizationSeq);
                $('#search_orgName').val(organizationName);
                $('#search_vmId').val(vmId);
                $('#search_place').val(place);
                $('#search_sDate').val(sDate);
                $('#search_eDate').val(eDate);
                $('#Dash_Table_Body1').html(html);
                $('#totalCnt').text(numberWithCommas(response.length));
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function detailModal(transactionNo){
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/sales/ajax/getDetailSalesInfo.do',
            type : 'POST',
            data:{ transactionNo : transactionNo},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td colspan=10>내역이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    if(response[i].shipResult=='미투출'){
                        html +='<tr style="background-color: #f7abab; pointer-events: none;"><td>'+ response[i].seq +'</td><td>'+response[i].vmId+'</td><td>'+response[i].terminalId+'</td><td>'+response[i].transactionDate+'&nbsp;'+response[i].transactionTime+'</td>';
                    }else html +='<tr style="pointer-events: none;"><td>'+ response[i].seq +'</td><td>'+response[i].vmId+'</td><td>'+response[i].terminalId+'</td><td>'+response[i].transactionDate+'&nbsp;'+response[i].transactionTime+'</td>';

                    html +='<td>'+response[i].productName+'</td><td>'+response[i].productCode+'</td>';
                    html +='<td>'+response[i].count+'</td><td>'+numberWithCommas(response[i].productPrice)+'</td><td>'+response[i].slotNo+'</td><td>'+response[i].shipResult+'</td></tr>';
                }
                $('#Dash_Table_Body2').html(html);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

</script>

</body>
</html>
