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
    <title>자판기로그조회</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    tr {
        pointer-events: none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_md_log').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#mn_md_m_log').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('#lnb_admin2').children('ul').show();
        $('.subtit').text("자판기로그조회");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            자판기 로그조회
        </header>
        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar">
            <ul>
                <li class="mar02">
                    <label for="company-select1">소속</label>
                    <select name="company" id="company-select1" style="width:100%">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="0" selected>전체</option>
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
                    <label for="group-select1">조직</label>
                    <select name="organization" id="group-select1" style="width:100%">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth<=1}">
                                <option value="0" selected>전체</option>
                                <c:forEach var="orgList" items="${orgList}">
                                    <option value="${orgList.seq}">${orgList.name}</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option value="${sessionScope.loginUser.organizationSeq}">${sessionScope.loginUser.organizationName}</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </li>
                <li class="mar02">
                    <label for="place-select1">설치위치</label>
                    <select name="office" id="place-select1" style="width:100%">
                                <option value="0" selected>전체</option>
                                <c:if test="${empty vmList}">
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.place}(${vmList.vmId})</option>
                                </c:forEach>
                    </select>
                </li>
                <li class="">
                    <%--<label for="vending-select">자판기 ID</label>
                    <select name="office" id="vending-select">
                                <option value="0" selected>전체</option>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.vmId}</option>
                                </c:forEach>
                    </select>--%>
                </li>
            </ul>
            <ul class="search_bar_pad">
                <li class="input-size02"><label>등록 기간</label><input id="sDate"type="date">&nbsp;~&nbsp;<input id="eDate" type="date"></li>
                <li>
                    <label for="dateSelect">기간구분</label>
                    <ul class="tabs2" id="dateSelect">
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

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="table_responsive">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="20%">
                        <col width="15%">
                        <col width="*">
                        <col width="20%">
                        <col width="10%">

                    </colgroup>
                    <thead>
                    <tr>
                        <th></th>
                        <th>자판기 일시</th>
                        <th>자판기 ID</th>
                        <th>파일</th>
                        <th>등록일시</th>
                        <th>다운로드</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:if test="${empty logList}">
                        <tr><td colspan=6>저장된 로그내역이 없습니다</td></tr>
                    </c:if>
                    <c:set var="logListLength" value="${fn:length(logList)}"/>
                    <c:forEach var='logList' items="${logList}" varStatus="status">
                        <tr>
                            <td><c:out value="${logListLength}" /></td>
                            <c:set var="logListLength" value="${logListLength-1}"/>
                            <td>${logList.regDate}</td>
                            <td>${logList.vmId}</td>
                            <td>${logList.fileName}</td>
                            <td>${logList.createDate}</td>
                            <td class="attach">
                            <c:if test="${logList.fileName ne null}">
                                <a style="pointer-events: all;" href="http://devmultivm.ubcn.co.kr/image/product/log/${logList.fileName}" download=""><img src="${root}/resources/images/ic_attach.png"></a>
                            </c:if>
                            </td>
                        </tr>
                    </c:forEach>
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
    $('#company-select1').select2();
    $('#group-select1').select2();
    $('#place-select1').select2();

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
            data:{companySeq : companySeq},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //자판기
                html2 +="<option value='0' selected>전체</option>";
                html3 +="<option value='0' selected>전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html3 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+ response.vmList[i].vmId +")</option>";
                }
                $('#group-select').empty();
                $("#group-select").append(html2);
                $('#place-select').empty();
                $("#place-select").append(html3);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#group-select1').change(changeCompanySelect=function(){
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var organizationText = $("#group-select1 option[value='+organizationSeq+']").text();

        if(organizationSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq, companySeq : companySeq},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //자판기
                html2 +="<option value='0' selected>전체</option>";
                html3 +="<option value='0' selected>전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html3 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+ response.vmList[i].vmId +")</option>";
                }

                $('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                $('#group-select1').empty();
                $("#group-select1").append(html2);
                $('#group-select1').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select1-container').text(organizationText);
                $('#place-select1').empty();
                $("#place-select1").append(html3);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#place-select1').change(changeCompanySelect=function(){
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var vmSeq = $("#place-select1 option:selected").val();
        var vmText = $("#place-select1 option:selected").text();

        if(organizationSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 = ""; //조직
                var html3 = ""; //자판기
                html2 +="<option value='0' selected>전체</option>";
                html3 +="<option value='0' selected>전체</option>";

                for(var i=0; i<response.orgInfo.length; i++){
                    html2 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.vmInfo.length; i++){
                    html3 +="<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+ response.vmInfo[i].vmId +")</option>";
                }

                $('#company-select1').val(response.vmInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.vmInfo[0].companyName);
                $('#group-select1').empty();
                $("#group-select1").append(html2);
                $('#group-select1').val(response.vmInfo[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select1-container').text(response.vmInfo[0].organizationName);
                $('#place-select1').empty();
                $("#place-select1").append(html3);
                $('#place-select1').val(vmSeq).attr('selected',"selected");
                $('#select2-place-select1-container').text(vmText);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });


    function searchData(){
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        //var terminalId = $("#terminal-select option:selected").text();
        var vmSeq = $("#place-select1 option:selected").val();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');

        var param = {
            companySeq : companySeq,
            organizationSeq : organizationSeq,
            vmSeq : vmSeq,
            sDate : sDate,
            eDate : eDate};

        //if(companySeq==''){alert("소속을 선택해주세요");return false;}
        //if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
        //if(vmSeq==''){alert("자판기ID를 선택해주세요");return false;}
        //if(terminalId==''){alert("단말기ID를 선택해주세요");return false;}
        //alert(JSON.stringify(param));
        $.ajax({
            url:'${root}/admin/ajax/getSearchLogList.do',
            type : 'POST',
            data: param,
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var list_length = response.length;
                if(response.length <1){
                    html +='<tr><td colspan=6>저장된 로그내역이 없습니다</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr><td>'+ list_length +'</td><td>'+response[i].regDate+'</td><td>'+response[i].vmId+'</td><td>'+response[i].fileName+'</td><td>'+response[i].createDate+'</td><td class="attach">';
                    if(response[i].fileName!=null) {
                        html += '<a style="pointer-events: all;" href="http://devmultivm.ubcn.co.kr/image/product/log/'+response[i].fileName+'" download=""><img src="${root}/resources/images/ic_attach.png"></a>';
                    }
                    html+='</td>';
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
