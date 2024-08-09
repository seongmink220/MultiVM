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
    <title>입고현황</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    tr {
        pointer-events: none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mv_store').addClass("current");
        $('#lnb_board').addClass("on");
        $('#lnb_board').children('ul').show();
        $('#mn_mv_m_store').addClass("current");
        $('#lnb_m_board').addClass("on");
        $('#lnb_m_board').next('ul').css('display','block');
        $('.subtit').text("입고현황");

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
            입고현황
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
                <%--<li class="input-size02"><label></label><input placeholder="입력해주세요" id="searchValue" type="text" style="width: 95%"></li>--%>
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
                <li class="label_none2"><label></label><a href="javascript:void(0);" class="button3 button_position2" onclick="searchData();">조회</a></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="table_responsive">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="15%">
                        <col width="10%">
                        <col width="10%">
                        <col width="5%">
                        <col width="*%">
                        <col width="15%">
                        <col width="8%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>NO</th>
                        <th>일시</th>
                        <th>자판기 ID</th>
                        <th>단말기 ID</th>
                        <th>슬롯번호</th>
                        <th>상품명</th>
                        <th>상품코드</th>
                        <th>입고수량</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <tr><td colspan=8>소속/조직을 선택해주세요.</td></tr>
                        </c:when>
                        <c:otherwise>
                    <c:if test="${empty storeList}">
                        <tr><td colspan=8>내역이 존재하지 않습니다</td></tr>
                    </c:if>
                    <c:set var="storeListLength" value="${fn:length(storeList)}"/>
                    <c:forEach var='storeList' items="${storeList}" varStatus="status">
                        <tr>
                            <%--<td><c:out value="${status.count}" /></td>--%>
                            <td><c:out value="${storeListLength}" /></td>
                            <c:set var="storeListLength" value="${storeListLength-1}"/>
                            <td>${storeList.storeDate} ${storeList.storeTime}</td>
                            <td>${storeList.vmId}</td>
                            <td>${storeList.terminalId}</td>
                            <td>${storeList.slotNo}</td>
                            <td>${storeList.productName}</td>
                            <td>${storeList.productCode}</td>
                            <td>${storeList.productCount}</td>
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
        //var vmId = $("#vending-select option[value='+vmSeq+']").text();
        var vmId = $("#vending-select option:selected").text();
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
        if(vmId==''){alert("자판기를 선택해주세요");return false;}
        //if(terminalId==''){alert("단말기ID를 선택해주세요");return false;}
        if($('#searchValue').val() !='' && $('#searchType').val() ==''){
            alert('검색조건을 선택해주세요.');
            $('#searchType').focus();
            return false;
        }

        $.ajax({
            url:'${root}/board/ajax/getSearchStoreList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq,
                sDate : sDate,
                eDate : eDate,
                searchValue : $("#searchValue").val(),
                searchType : $("#searchType").val()},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var list_length = response.length;
                console.log(response)
                if(response.length <1){
                    html +='<tr><td colspan=8>내역이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr><td>'+ list_length +'</td><td>'+response[i].storeDate+'&nbsp;'+response[i].storeTime+'</td><td>'+response[i].vmId+'</td><td>'+response[i].terminalId+'</td><td>'+response[i].slotNo+'</td><td>'+response[i].productName+'</td><td>'+response[i].productCode+'</td><td>'+response[i].productCount+'</td>';
                    list_length = list_length-1;

                }
                $('#Dash_Table_Body1').html(html);
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }


</script>
</body>
</html>
