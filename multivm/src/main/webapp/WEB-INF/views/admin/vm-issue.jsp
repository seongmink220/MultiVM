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
    <title>자판기이슈조회</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
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
    .pop_box {
        width: 750px;
    }
    .scroll_contbox {
        height: 544px;
    }
    @media (max-width: 1023px) {
        .pop_box {
            overflow-y: hidden;
            /*width: 100%!important;*/
        }
    }

</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_md_m_vm-issue').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#lnb_admin2').children('ul').show();
        $('#mn_md_vm-issue').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('.subtit').text("자판기이슈조회");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        setDaate('today');

    });
</script>
<body>
<div id="wrap">
<!-- body -->
<section id="body_wrap">
    <header id="body_header">
        자판기이슈조회
    </header>
    <div id="shadow_bg" style="display: none;"></div>
    <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
    <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
    <input type="hidden" id="vm_seq" value="0">
    <div id="modal_pop" style="display: none;">
        <div class="pop_box">
            <div class="pop_title">
                <h2 id="pop_title_m">자판기상세조회</h2>
                <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
            </div>
            <div class="pop_contbox scroll_contbox">
                <div class="table_responsive">
                    <table class="tb_horizen">
                        <colgroup>
                            <col width="30%">
                            <col width="*">
                        </colgroup>
                        <tbody id="Dash_Table_Body3" style="pointer-events: none;">
                        <tr>
                            <td>소속/조직</td>
                            <td class="t_left" id="td1_company"></td>
                        </tr>
                        <tr>
                            <td>설치위치</td>
                            <td class="t_left" id="td2_place"></td>
                        </tr>
                        <tr>
                            <td>자판기ID</td>
                            <td class="t_left" id="td3_vmId"></td>
                        </tr>
                        <tr>
                            <td>단말기ID</td>
                            <td class="t_left" id="td4_terminalId"></td>
                        </tr>
                        <tr>
                            <td>자판기모델</td>
                            <td class="t_left" id="td5_vmModel"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <%--<div class="sub_tit">
                    <ul>
                        <li><h2>ACTION DATA 정보</h2></li>
                    </ul>
                </div>
                <div class="table_responsive">
                    <table class="scroll">
                        <thead>
                        <tr>
                            <th></th>
                            <th>ACTION</th>
                            <th>설명</th>
                        </tr>
                        </thead>
                        <tbody  id="Dash_Table_Body4">
                        <tr>
                            <td><input type="radio" name="actionData" value="AR"></td>
                            <td class="">AR</td>
                            <td class="t_left">App restart - 프로그램 / 광고 업데이트 진행됨</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="SR"></td>
                            <td class="">SR</td>
                            <td class="t_left">Android System Reboot</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="SE"></td>
                            <td class="">SE</td>
                            <td class="t_left">Android System End</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="SP"></td>
                            <td class="">SP</td>
                            <td class="t_left">판매 중지 Sale stoP</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="ST"></td>
                            <td class="">ST</td>
                            <td class="t_left">판매 사용 Sale starT</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="UT"></td>
                            <td class="">UT</td>
                            <td class="t_left">상품 정보 업데이트</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="GL"></td>
                            <td class="">GL</td>
                            <td class="t_left">로그 요청 - 해당 날짜 로그 서버 업로드</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="actionData" value="ST2"></td>
                            <td class="">ST2</td>
                            <td class="t_left">상태 정보 업로드 시간 설정. 1->10분(최소 10분)</td>
                        </tr>
                        </tbody>
                    </table>
                </div>--%>
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
                                <option value="0">전체</option>
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
                            <option value="0">전체</option>
                            <c:forEach var="orgList" items="${orgList}">
                                <option value="${orgList.seq}">${orgList.name}</option>
                            </c:forEach>
                        </c:when>
                        <c:when test="${sessionScope.loginUser.auth==1}">
                            <option value="0">전체</option>
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
                <label for="place-select">설치위치</label>
                <select name="place" id="place-select" style="width:100%">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <option value="0">전체</option>
                            <c:forEach var="vmList" items="${vmList}">
                                <option value="${vmList.seq}">${vmList.place}(${vmList.vmId})</option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option value="0">전체</option>
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
            </li>
            <li></li>
        </ul>
        <ul class="search_bar_pad">
            <li class="input-size02"><label>검색조건 선택</label>
                <select name="office" id="searchType" style="width:39%">
                    <option value="">선택</option>
                    <option value="1">타입</option>
                    <option value="2">코드</option>
                    <option value="3">설명</option>
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
                    <col width="10%">
                    <col width="15%">
                    <col width="15%">
                    <col width="8%">
                    <col width="8%">
                    <col width="8%">
                    <col width="*">
                    <col width="18%">
                </colgroup>
                <thead>
                <tr>
                    <th><%--<div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div>--%></th>
                    <th>자판기 ID</th>
                    <th>조직</th>
                    <th>설치위치</th>
                    <th>자판기모델</th>
                    <th>타입</th>
                    <th>코드</th>
                    <th>설명</th>
                    <th>등록일시</th>
                </tr>
                </thead>
                <tbody id="Dash_Table_Body1">

                <c:set var="vmIssueListLength" value="${fn:length(vmIssueList)}"/>
                <c:if test="${empty vmIssueList}">
                    <tr style="pointer-events: none;"><td colspan=11>이슈가 존재하지 않습니다.</td></tr>
                </c:if>
                <c:forEach var="vmIssueList" items="${vmIssueList}">
                    <tr id="${vmIssueList.vmSeq}" onclick="detailDataModal(${vmIssueList.vmSeq})">
                        <%--<td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>--%>
                        <td class=""><c:out value="${vmIssueListLength}" /></td>
                            <c:set var="vmIssueListLength" value="${vmIssueListLength-1}"/>
                        <td class="">${vmIssueList.vmId}</td>
                        <td class="">${vmIssueList.organizationName}</td>
                        <td class="">${vmIssueList.place}</td>
                        <td class="">${vmIssueList.vmModel}</td>
                        <td class="">${vmIssueList.type}</td>
                        <td class="">${vmIssueList.code}</td>
                        <td class="">${vmIssueList.info}</td>
                        <td class="">${vmIssueList.regDate}</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
            </div>
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
    $('#group-select').select2();
    $('#place-select').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });
    /*$(document).ready(function() {
        $('#company-select').select2();
    });*/

    $('#company-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
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

    $('#group-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationText = $("#group-select option[value='+organizationSeq+']").text();

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

                $('#company-select').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select-container').text(response.orgInfo[0].companyName);
                $('#group-select').empty();
                $("#group-select").append(html2);
                $('#group-select').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(organizationText);
                $('#place-select').empty();
                $("#place-select").append(html3);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#place-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#place-select option:selected").val();
        var vmText = $("#place-select option:selected").text();

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

                $('#company-select').val(response.vmInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select-container').text(response.vmInfo[0].companyName);
                $('#group-select').empty();
                $("#group-select").append(html2);
                $('#group-select').val(response.vmInfo[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(response.vmInfo[0].organizationName);
                $('#place-select').empty();
                $("#place-select").append(html3);
                $('#place-select').val(vmSeq).attr('selected',"selected");
                $('#select2-place-select-container').text(vmText);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    function searchData(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#place-select option:selected").val();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();
        sDate = sDate.replace(/\-/g, '');
        eDate = eDate.replace(/\-/g, '');
        //var vmId = $("#vending-search").val();
        if($('#searchValue').val() !='' && $('#searchType').val() ==''){
            alert('검색조건을 선택해주세요.');
            $('#searchType').focus();
            return false;
        }

        $("#company_seq").val(companySeq);
        $("#orig_seq").val(organizationSeq);

        $.ajax({
            url:'${root}/admin/ajax/getSearchVMIssueList.do',
            type : 'POST',
            data: { companySeq : companySeq,
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
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td colspan=11>이슈가 존재하지 않습니다.</td></tr>';
                }

                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].seq + '"onclick="detailDataModal('+response[i].seq +')"><td>'+ list_length +'</td>';
                    html +='<td>' + response[i].vmId + '</td>';
                    html +='<td>' + response[i].organizationName + '</td>';
                    html +='<td>' + response[i].place + '</td>';
                    html +='<td>' + response[i].vmModel + '</td>';
                    html +='<td>' + response[i].type + '</td>';
                    html +='<td>' + response[i].code + '</td>';
                    html +='<td>' + response[i].info + '</td>';
                    html +='<td>' + response[i].regDate + '</td></tr>';
                    list_length = list_length-1;
                }
                $("#Dash_Table_Body1").html(html);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                //getCompanyOrigList(companySeq);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }

    function editActionData(){
        var vmSeq = $("#vm_seq").val();
        var actionData = $('#actionData-select option:selected').val();

        $.ajax({
            url:'${root}/admin/ajax/updateVMActionData.do',
            type : 'POST',
            data:{vmSeq : vmSeq,
                actionData : actionData},
            datatype: 'JSON',
            success:function(response){
                alert(response);
                $('#modal_pop').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
            },
            error: function (xhr, status, error) {console.log(error);}
        });

    }


    function detailDataModal(seq){
        /*$('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/admin/ajax/getDetailVMIssueInfo.do?vmSeq='+seq,
            type : 'GET',
            datatype: 'JSON',
            success:function(response){
                $("#td1_company").text(response.vmIssue.companyName+' / '+response.vmIssue.organizationName);
                $("#td2_place").text(response.vmIssue.place);
                $("#td3_vmId").text(response.vmIssue.vmId);
                $("#td4_terminalId").text(response.vmIssue.terminalId);
                $("#td5_vmModel").text(response.vmIssue.vmModel);
            },
            error: function (xhr, status, error) {console.log(error);}
        });*/
    }


    $(".allSelect1").click(function(){
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
