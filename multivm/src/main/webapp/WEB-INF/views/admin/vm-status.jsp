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
    <title>상태조회</title>
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
        $('#mn_md_m_vm-status').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#lnb_admin2').children('ul').show();
        $('#mn_md_vm-status').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('.subtit').text("상태조회");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
<!-- body -->
<section id="body_wrap">
    <header id="body_header">
        상태조회
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
                            <td>상온/냉장 여부</td>
                            <td class="t_left" id="td5_useTemper"></td>
                        </tr>
                        <tr>
                            <td>설정온도</td>
                            <td class="t_left" id="td6_setTemper"></td>
                        </tr>
                        <tr>
                            <td>LED밝기</td>
                            <td class="t_left" id="td7_led"></td>
                        </tr>
                        <tr>
                            <td>김서림 방지 설정여부</td>
                            <td class="t_left" id="td8_antiFog"></td>
                        </tr>
                        <tr>
                            <td>긴급전화번호</td>
                            <td class="t_left" id="td9_tel"></td>
                        </tr>
                        <tr>
                            <td>업데이트일시</td>
                            <td class="t_left" id="td10_updateDate"></td>
                        </tr>
                        <tr>
                            <td>ACTION DATA설정</td>
                            <td class="t_left" style="pointer-events: all;" id="td11_actionData"><select id="actionData-select">
                                <option value="">없음</option>
                                <%--<option value="AR">AR&emsp;&ensp;App restart - 프로그램 / 광고 업데이트 진행됨</option>--%>
                                <option value="SR">SR&emsp;&ensp;Android System Reboot</option>
                               <%-- <option value="SE">SE&emsp;&ensp;Android System End</option>
                                <option value="SP">SP&emsp;&ensp;판매 중지 Sale stoP</option>
                                <option value="ST">ST&emsp;&ensp;판매 사용 Sale starT</option>--%>
                                <option value="UT">UT&emsp;&ensp;상품 정보 업데이트</option>
                                <option value="GL">GL&emsp;&ensp;로그 요청 - 해당 날짜 로그 서버 업로드</option>
                                <%--<option value="ST2">ST2&ensp;&ensp;상태 정보 업로드 시간 설정. 1->10분(최소 10분)</option>--%>
                                <option value="UP">UP&emsp;&ensp;자판기 앱 업데이트</option>
                            </select><a href="javascript:void(0);" class="button" onclick="editActionData();">수정</a></td>

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
            <%--<li class="input-size01">
                <label for="vending-search">단말기 ID / 자판기 ID</label>
                <input type="text" id="vending-search" placeholder="검색어를 입력해주세요" onkeydown="if(event.keyCode == 13) searchVM();">
            </li>--%>
            </li>
            <li></li>
        </ul>
        <ul class="search_bar_pad2">
            <li><a href="javascript:void(0);" class="button3 button_position2" onclick="searchVM();">조회</a></li>
            <li></li>
            <li></li>
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
                    <col width="*">
                    <col width="8%">
                    <col width="3%">
                    <col width="5%">
                    <col width="5%">
                    <col width="10%">
                    <col width="18%">
                </colgroup>
                <thead>
                <tr>
                    <th><%--<div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div>--%></th>
                    <th>자판기 ID</th>
                    <th>조직</th>
                    <th>설치위치</th>
                    <th>현재온도</th>
                    <th>상태</th>
                    <th>금일 재고수량</th>
                    <th>금일 판매수량</th>
                    <th>금일 판매금액</th>
                    <th>등록일시</th>
                </tr>
                </thead>
                <tbody id="Dash_Table_Body1">

                <c:set var="vmStatusListLength" value="${fn:length(vmStatusList)}"/>
                <c:if test="${empty vmStatusList}">
                    <tr style="pointer-events: none;"><td colspan=10>자판기가 존재하지 않습니다.</td></tr>
                </c:if>
                <c:forEach var="vmStatusList" items="${vmStatusList}">
                    <tr id="${vmStatusList.vmSeq}" onclick="detailDataModal(${vmStatusList.vmSeq})">
                        <%--<td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>--%>
                        <td class=""><c:out value="${vmStatusListLength}" /></td>
                            <c:set var="vmStatusListLength" value="${vmStatusListLength-1}"/>
                        <td class="">${vmStatusList.vmId}</td>
                        <td class="">${vmStatusList.organizationName}</td>
                        <td class="">${vmStatusList.place}</td>
                        <td class="">${vmStatusList.temper}</td>
                        <td class="">${vmStatusList.st}</td>
                        <td class="">${vmStatusList.jg}</td>
                        <td class="">${vmStatusList.pm}</td>
                        <td class=""><fmt:formatNumber value="${vmStatusList.mc}" pattern="#,###" /></td>
                        <td class="">${vmStatusList.regDate}</td>
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

    function searchVM(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#place-select option:selected").val();
        //var vmId = $("#vending-search").val();

        $("#company_seq").val(companySeq);
        $("#orig_seq").val(organizationSeq);

        $.ajax({
            url:'${root}/admin/ajax/getSearchVMStatusList.do',
            type : 'POST',
            data: { companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var list_length = response.length;
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td colspan=10>자판기가 존재하지 않습니다.</td></tr>';
                }

                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].vmSeq + '"onclick="detailDataModal('+response[i].vmSeq +')"><td>'+ list_length +'</td>';
                    html +='<td>' + response[i].vmId + '</td>';
                    html +='<td>' + response[i].organizationName + '</td>';
                    html +='<td>' + response[i].place + '</td>';
                    html +='<td>' + response[i].temper + '</td>';
                    html +='<td>' + response[i].st + '</td>';
                    html +='<td>' + response[i].jg + '</td>';
                    html +='<td>' + response[i].pm + '</td>';
                    html +='<td>' + response[i].mc.toLocaleString('ko-KR') + '</td>';
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

    /*function addDataModal(){
        $("#pop_title_m").text("자판기 추가");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        $("#vm_seq").val(0);
        //$("#terminal_id").val().prop("selected",true);
        if($('#orig_seq').val()==null||$('#orig_seq').val()==0){
            ("#mag_group option:eq(0)").prop("selected",true);
        }
        else $("#mag_group").val($('#orig_seq').val()).prop("selected",true);
        //임시
        $("#user_id").val(${sessionScope.loginUser.id});
    }*/

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


    function detailDataModal(vmSeq){
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/admin/ajax/getDetailVMStatusInfo.do?vmSeq='+vmSeq,
            type : 'GET',
            datatype: 'JSON',
            success:function(response){
                var actionData = response.vmInfo.actionData;
                $("#td1_company").text(response.vmStatus.companyName+' / '+response.vmStatus.organizationName);
                $("#td2_place").text(response.vmStatus.place);
                $("#td3_vmId").text(response.vmStatus.vmId);
                $("#td4_terminalId").text(response.vmStatus.terminalId);
                $("#td5_useTemper").text(response.vmInfo.useTemper);
                $("#td6_setTemper").text(response.vmInfo.setTemper);
                $("#td7_led").text(response.vmInfo.led);
                $("#td8_antiFog").text(response.vmInfo.antiFog);
                $("#td9_tel").text(response.vmInfo.tel);
                $("#td10_updateDate").text(response.vmInfo.updateDate);
                //$("#td11_actionData").text(response.vmStatus.userId);
                $("#vm_seq").val(response.vmStatus.vmSeq)
                if(actionData==null){
                    actionData = '';
                }
                $("#actionData-select").val(actionData).prop("selected",true);
            },
            error: function (xhr, status, error) {console.log(error);}
        });
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
