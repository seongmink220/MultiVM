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
    <title>자판기관리</title>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    /*.form_title span {
        color: #f53a3a;
    }*/
</style>
<script type="text/javascript">
    var auth = ${sessionScope.loginUser.auth};
    $(document).ready(function (){
        $('#mn_mf_vending-machine').addClass("current");
        $('#lnb_company').addClass("on");
        $('#lnb_company').children('ul').show();
        $('#mn_mf_m_vending-machine').addClass("current");
        $('#lnb_m_company').addClass("on");
        $('#lnb_m_company').next('ul').css('display','block');
        $('.subtit').text("자판기관리")

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
<!-- body -->
<section id="body_wrap">
    <header id="body_header">
        자판기관리
    </header>
    <div id="shadow_bg" style="display: none;"></div>
    <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
    <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
    <input type="hidden" id="company_name" value="${sessionScope.loginUser.companyName}">
    <input type="hidden" id="orig_name" value="${sessionScope.loginUser.organizationName}">
    <input type="hidden" id="user_id2" value="${sessionScope.loginUser.seq}">
    <div id="modal_pop" style="display: none;">
        <div class="pop_box">
            <div class="pop_title">
                <h2>자판기 관리</h2>
                <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
            </div>
            <div class="pop_contbox">
                <div class="infotxt"><span class="red">*</span> 표시는 필수 입력사항입니다.</div>
                <form method="post" id="modal_form">
                    <fieldset>
                        <legend>조직 정보입력</legend>
                        <ul class="form_group input_width">
                            <li>
                                <label for="vending_id" class="form_title">자판기 ID <span>*</span></label>
                                <input type="text" id="vending_id" placeholder="입력해주세요" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                            </li>
                        </ul>
                        <ul class="form_group input_width">
                            <li>
                                <label for="terminal_id">단말기 ID</label>
                                <input type="text" id="terminal_id" placeholder="입력해주세요" maxlength="10" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                            </li>
                        </ul>
                        <ul <c:if test="${sessionScope.loginUser.auth>0}">style="display: none;"</c:if> class="form_group input_width">
                            <li>
                                <label for="mag_company">소속 <span>*</span></label>
                                <input id="org_company" type="hidden" value="0">
                                <select name="office" id="mag_company" data-placeholder="선택해주세요" style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value=""selected >선택해주세요</option>
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
                        </ul>
                        <ul class="form_group input_width">
                            <li>
                                <label for="mag_group">조직 <span>*</span></label>
                                <select name="office" id="mag_group" data-placeholder="선택해주세요" style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">소속을 선택해주세요</option>
                                        </c:when>
                                        <c:when test="${sessionScope.loginUser.auth==1}">
                                            <option value="">선택해주세요</option>
                                            <option value="${sessionScope.loginUser.organizationSeq}">${sessionScope.loginUser.organizationName}</option>
                                            <c:forEach var="defaultOrg" items="${defaultOrg}">
                                                <option value="${defaultOrg.seq}">${defaultOrg.name}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${sessionScope.loginUser.organizationSeq}">${sessionScope.loginUser.organizationName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                        </ul>
                        <ul class="form_group input_width">
                            <li>
                                <label for="vending_place" class="form_title">설치위치 <span>*</span></label>
                                <input type="text" id="vending_place" placeholder="입력해주세요" maxlength="50">
                            </li>
                        </ul>
                        <ul class="form_group input_width">
                            <li>
                                <label for="vending_model" class="form_title">자판기모델 <span>*</span></label>
                                <select name="office" id="vending_model" data-placeholder="선택해주세요" style="width: 100%;">
                                    <option id="vending_model1" value="1" selected>10N(멀티1)</option>
                                    <option id="vending_model3" value="3">10C(멀티3)</option>
                                </select>
                            </li>
                        </ul>
                        <ul class="form_group input_width">
                            <li>
                                <label for="user_id" class="form_title">관리자ID</label> <span style="font-size: 14px; color: #C97626">※ 자판기운영자 권한 사용자를 등록하시길 권장합니다.</span>
                                <%--<input type="text" id="user_id" placeholder="입력해주세요" maxlength="20" oninput="this.value = this.value.replace(/[^A-Za-z0-9]/g, '').replace(/(\..*)\./g, '$1');">--%>
                                <select name="office" id="user_id" data-placeholder="선택해주세요" style="width: 100%;">
                                    <option value=""selected >선택해주세요</option>
                                    <c:forEach var="userList" items="${userList}">
                                        <option value="${userList.seq}">${userList.id} (${userList.name}) - ${userList.auth2}</option>
                                    </c:forEach>
                                </select>
                            </li>
                        </ul>
                        <input type="hidden" id="vm_seq" value="0">
                    </fieldset>
                </form>
                <div class="pop_button">
                    <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('#shadow_bg').stop().fadeOut();">취소</a>
                    <a href="javascript:void(0)" class="button2 btn_ok"onclick="addData();">적용하기</a>
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
                <label for="group-select">조직</label>
                <select name="organization" id="group-select" style="width: 100%;">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==3}">
                            <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="0" selected>전체</option>
                            <c:forEach var="orgList" items="${orgList}" varStatus="status">
                                <option value="${orgList.seq}">${orgList.name}</option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <%--<c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <option value="0" selected>전체</option>
                            <c:forEach var="orgList" items="${orgList}">
                                <option value="${orgList.seq}">${orgList.name}</option>
                            </c:forEach>
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
                    </c:choose>--%>
                </select>
            </li>
            <li class="mar02">
                <label for="vending-select">설치위치</label>
                <select name="place" id="vending-select" style="width: 100%;">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <option value="0" selected>전체</option>
                            <c:forEach var="vmList" items="${vmList}">
                                <option value="${vmList.seq}">${vmList.place}</option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option value="0" selected>전체</option>
                            <c:forEach var="vmList" items="${vmList}">
                                <option value="${vmList.seq}">${vmList.place}</option>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </select>
            </li>
            <li class="mar02">
                <%--<label for="vending-search">단말기 ID / 자판기 ID</label>
                <input type="text" id="vending-search" placeholder="검색어를 입력해주세요" onkeydown="if(event.keyCode == 13) searchVM();">--%>
                    <label for="terminal-select">단말기 ID / 자판기 ID</label>
                    <select name="office" id="terminal-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="0" selected>전체</option>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.terminalId}/${vmList.vmId}</option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option value="0" selected>전체</option>
                                <c:forEach var="vmList" items="${vmList}">
                                    <option value="${vmList.seq}">${vmList.terminalId}/${vmList.vmId}</option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
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
            <div class="sub_tit">
                <ul>
                    <li><p>검색 결과 : <span id="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</p></li>
                    <li>
                    <c:if test="${sessionScope.loginUser.auth==0}">
                        <a href="javascript:void(0)" class="button btn_delete" onclick="deleteData()"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                    </c:if>
                    <c:if test="${sessionScope.loginUser.auth<2}">
                        <a href="javascript:void(0)" class="button btn_delete" onclick="addDataModal();">추가</a>
                        <a href="javascript:void(0)" class="button btn_delete" onclick="editClick()">수정</a>
                    </c:if>
                    </li>
                </ul>
            </div>
            <div class="table_responsive">
            <table class="tb_horizen">
                <colgroup>
                    <col width="5%">
                    <col width="15%">
                    <col width="15%">
                    <col width="20%">
                    <col width="*">
                    <col width="15%">
                </colgroup>
                <thead>
                <tr>
                    <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                    <th>자판기 ID</th>
                    <th>단말기 ID</th>
                    <th>조직</th>
                    <th>설치위치</th>
                    <th>관리자</th>
                </tr>
                </thead>
                <tbody id="Dash_Table_Body1">
                        <c:if test="${empty vmList}">
                            <tr style="pointer-events: none;">
                                <td>&ensp;&emsp;</td><td colspan=5>자판기가 존재하지 않습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="vmList" items="${vmList}">
                            <tr id="${vmList.seq}" <c:if test="${sessionScope.loginUser.auth>2}">style="pointer-events: none;"</c:if> <c:if test="${sessionScope.loginUser.auth<2}">onclick="editDataModal(${vmList.seq})"</c:if>>
                                <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                <td>${vmList.vmId}</td>
                                <td class="">${vmList.terminalId}</td>
                                <td class="">${vmList.organizationName}</td>
                                <td class="">${vmList.place}</td>
                                <td class="">${vmList.userName}</td>
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
    /*$('#company-select').select2();
    $('#group-select').select2();
    $('#terminal-select').select2();
    $('#vending-select').select2();
    $('#mag_company').select2();
    $('#mag_group').select2();
     */
    $('#mag_company').select2();
    $('#mag_group').select2();
    $('#user_id').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('#mag_company').change(changeMagCompanySelect=function(){
        var companySeq = $("#mag_company option:selected").val();
        if(companySeq==''){
            $('#mag_group').empty();
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
                if(response.origList.length>0){
                    html +=" <option value='' selected>선택하세요</option>";
                    for(var i=0; i<response.origList.length; i++){
                        html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                    }
                }
                if(response.userList.length>0){
                    html2 +=" <option value='' selected>선택하세요</option>";
                    for(var i=0; i<response.userList.length; i++){
                        html2 +="<option value='"+response.userList[i].seq+"'>"+response.userList[i].id+" ("+response.userList[i].name+") - "+response.userList[i].auth2+"</option>";
                    }
                }
                $('#mag_group').empty();
                $("#mag_group").append(html);
                $('#user_id').empty();
                $("#user_id").append(html2);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });


    function searchVM(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var vmSeq = $("#vending-select option:selected").val();
        var vmId = $("#terminal-select option:selected").text();
        //var vmId = $('#terminal-select').val();

        if(vmSeq!='0'){
            vmId = vmId.split('/')[1];
        }
        if(vmSeq=='전체'){
            vmSeq=0;
        }
        $("#company_seq").val(companySeq);
        $("#orig_seq").val(organizationSeq);


        /*if(companySeq==''){
            alert("소속을 선택하세요.");ㄴ
            return false;
        }*/
        /*if(organizationSeq==''||organizationSeq==null){
            if(confirm("해당 소속의 조직이 존재하지 않습니다. \n조직을 등록하시겠습니까?")){
                location.href="${root}/company/orig";
            }else location.reload();
        }*/

        console.log('companySeq'+companySeq);
        $.ajax({
            url:'${root}/company/ajax/selectVMList.do',
            type : 'POST',
            data: { companySeq : companySeq,
                organizationSeq : organizationSeq,
                seq : vmSeq,
                userSeq : ${sessionScope.loginUser.seq},
                auth : ${sessionScope.loginUser.auth}},
            datatype: 'JSON',
            success:function(response){
                console.log(response)
                var html ="";
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=5>자판기가 존재하지 않습니다.</td></tr>';
                }

                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].seq + '"' ;
                    if(auth>2){
                        html +='style="pointer-events: none;"';
                    }else{
                        html +='onclick="editDataModal('+response[i].seq +')"';
                    }
                    html +=    '><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].vmId + '</td>';
                    html +='<td>' + response[i].terminalId + '</td>';
                    html +='<td>' + response[i].organizationName + '</td>';
                    html +='<td>' + response[i].place + '</td>';
                    html +='<td>' + response[i].userName + '</td></tr>';
                }
                /*if(companySeq=='0') {
                    console.log('소속선택안했을시')
                    $("#mag_company option:selected").val(response[0].companySeq);
                    $('#select2-mag_company-container').text(response[0].companyName);

                }*/
                $("#Dash_Table_Body1").html(html);
                $('#totCnt').text(response.length);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                getCompanyOrigList(companySeq);

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }

    function addDataModal(){
        $("#pop_title h2").text("자판기 추가");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        $("#vm_seq").val(0);
        //$("#terminal_id").val().prop("selected",true);
        /*if($('#orig_seq').val()==null||$('#orig_seq').val()==0){
            ("#mag_group option:eq(0)").prop("selected",true);
        }
        else $("#mag_group").val($('#orig_seq').val()).prop("selected",true);*/
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
                    $('#mag_company').empty();
                    $("#mag_company").append(html);
                    $('#mag_group').empty();
                    $("#mag_group").append('<option value="">선택해주세요</option>');
                    $("#vending_model").val("1").prop("selected", true);
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
                    $('#mag_company').empty();
                    $("#mag_company").append('<option value="' + $('#company_seq').val() + '" seleted>' + $('#company_name').val() + '</option>');
                    $('#select2-mag_company-container').text($('#company_name').val());
                    $('#mag_group').empty();
                    $("#mag_group").append(html);
                    if(${sessionScope.loginUser.auth>1}) {
                        //$('#multipleSelect').val($('#orig_seq').val()).attr('selected',"selected");
                        $('#mag_group').val($('#orig_seq').val()).change();
                    }
                },
                error: function (xhr, status, error) {console.log(error);}
            });
        }





    }
    function editDataModal(vmSeq){
        if(auth<2){
            $("#pop_title h2").text("자판기 정보수정");
            $('#modal_pop').stop().fadeIn();
            $('#shadow_bg').stop().fadeIn();

            $.ajax({
                url:'${root}/company/ajax/selectVMInfo.do?vmSeq='+vmSeq,
                type : 'GET',
                datatype: 'JSON',
                success:function(response){
                    var html =""; //소속
                    var html2 =""; //조직
                    var html3 =""; //관리자

                    for(var i=0; i<response.comList.length; i++){
                        html +="<option value='"+response.comList[i].seq+"'>"+response.comList[i].name+"</option>";
                    }
                    for(var i=0; i<response.orgList.length; i++){
                        html2 +="<option value='"+response.orgList[i].organizationSeq+"'>"+response.orgList[i].organizationName+"</option>";
                    }

                    for(var i=0; i<response.userList.length; i++){
                        if(response.userList[i].seq == response.vmInfo.userSeq){
                            html3 +="<option value='"+response.userList[i].seq+"' selected>"+response.userList[i].id+" ("+response.userList[i].name+") - "+response.userList[i].auth2+"</option>";
                        }else html3 +="<option value='"+response.userList[i].seq+"'>"+response.userList[i].id+" ("+response.userList[i].name+") - "+response.userList[i].auth2+"</option>";
                    }

                    $("#vending_id").val(response.vmInfo.vmId);
                    $("#terminal_id").val(response.vmInfo.terminalId);
                    $("#vm_seq").val(response.vmInfo.seq);
                    $("#vending_place").val(response.vmInfo.place);
                    $('#org_company').val(response.vmInfo.companySeq);
                    //$("#user_id").val(0);
                    //$("#vending_model").val(response.vmInfo.vmModel).prop("selected", true);
                    if(response.vmInfo.vmModel == '3'){
                        $("#vending_model3").prop("selected", true);
                    }else $("#vending_model1").prop("selected", true);

                    $('#mag_company').empty();
                    $('#mag_group').empty();
                    $('#user_id').empty();
                    $('#user_id').html(html3);
                    if(${sessionScope.loginUser.auth==0}){
                        $("#mag_company").append(html);
                        $("#mag_group").append(html2);
                    }else if(${sessionScope.loginUser.auth==1}){
                        $("#mag_company").append('<option value="' + response.vmInfo.companySeq + '" seleted>' + response.vmInfo.companyName + '</option>');
                        $("#mag_group").append(html2);
                    }else{
                        $("#mag_company").append('<option value="' + response.vmInfo.companySeq + '" seleted>' + response.vmInfo.companyName + '</option>');
                        $("#mag_group").append('<option value="' + response.vmInfo.organizationSeq + '" seleted>' + response.vmInfo.organizationName + '</option>');
                    }
                    $('#mag_company').val(response.vmInfo.companySeq).attr('selected',"selected");
                    $('#select2-mag_company-container').text(response.vmInfo.companyName);
                    $('#mag_group').val(response.vmInfo.organizationSeq).change();
                },
                error: function (xhr, status, error) {console.log(error);}
            });
        }
    }

    function deleteData(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 데이터를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?\n※자판기에 등록된 상품 및 정보가 모두 삭제되며 복구할 수 없습니다."))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedVM.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    searchVM();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }

    function addData(){
        var terminalId = $("#terminal_id").val()
        var vmSeq = $("#vm_seq").val();
        var place = $("#vending_place").val();
        var userId = $("#user_id option:selected").val();
        var vmId = $("#vending_id").val();
        var companySeq = $("#mag_company option:selected").val();
        var org_companySeq = $('#org_company').val();
        var organizationSeq = $("#mag_group option:selected").val();
        var vmModel = $("#vending_model option:selected").val();

        var params = $("#modal_form").serialize();
        if(vmId==''||place==''){
            alert("값을 입력하세요.");
            return false;
        }
        if(companySeq==''){
            alert("소속을 선택하세요.");
            return false;
        }
        if(organizationSeq==''||organizationSeq==null){
            alert("조직을 선택하세요.");
            return false;
        }
        if(vmSeq!=0 && org_companySeq!=companySeq){
            alert("자판기 수정시 소속 변경은 불가합니다.");
            return false;
        }
        var data = {
            companySeq : companySeq,
            organizationSeq : organizationSeq,
            vmId : vmId,
            terminalId : terminalId,
            place : place,
            userSeq : userId,
            seq : vmSeq,
            vmModel:vmModel};
        //alert(JSON.stringify(data)); return false;
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/company/ajax/insModVMInfo.do',
            data: data,
            type : 'POST',
            success:function(response){
                alert(response);
                if(response.indexOf('성공')!=-1){
                    searchVM();
                    $('#modal_pop').stop().fadeOut();
                    $('#shadow_bg').stop().fadeOut();
                }
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
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
