<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-15
  Time: 오후 7:08
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
    <title>사용자관리</title>
</head>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mf_user').addClass("current");
        $('#lnb_company').addClass("on");
        $('#lnb_company').children('ul').show();
        $('#mn_mf_m_user').addClass("current");
        $('#lnb_m_company').addClass("on");
        $('#lnb_m_company').next('ul').css('display','block');
        $('.subtit').text("사용자관리")
        //$(".depth-1").not('#lnb_company')ㄹ.removeClass("on");
        //$(".depth-1").not('#lnb_company').children('ul').hide();

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
        $("#keyShow").css("display", "inline-block");
        $(".user2 li").click(function(){ //tab1
            $(".user2 li.current").removeClass("current");
            $(this).addClass("current")

            //if($('.tab1').hasClass("current")){

            //}
        })
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            사용자관리
        </header>
        <div id="shadow_bg" style="display: none;"></div>
        <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
        <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
        <div id="modal_pop" style="display: none;">
            <div class="pop_box">
                <div class="pop_title">
                    <h2>사용자 추가</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" onclick="$('#modal_pop').stop().fadeOut();$('#shadow_bg').stop().fadeOut();" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <div class="infotxt"><span class="red">*</span> 표시는 필수 입력사항입니다.</div>
                    <form method="post" id="modal_form">
                        <fieldset>
                            <legend>사용자 정보입력</legend>
                            <ul class="tabs user1">
                                <li class="tab-1" >활성화</li>
                                <li class="tab-2" >비활성화</li>
                            </ul>
                            <ul class="form_group input_width2">
                                <li>
                                    <label for="mag_id" class="form_title">ID <span>*</span></label>
                                    <input type="text" id="mag_id" onchange="$('#isIdCheck').val(0);" placeholder="키보드 영문자로 변경해주세요" oninput="this.value = this.value.replace(/[^A-Za-z0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="20">
                                    <a href="javascript:void(0)" class="button btn_delete" onclick="idCheck();">중복확인</a>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="key" class="form_title">패스워드 <span>*</span></label>
                                    <input autocomplete="false" type="password" id="key" placeholder="입력해주세요" maxlength="20"/>
                                    <div id="keyShow"><img src="${root}/resources/images/eye-thin.png"></div>
                                    <script>/*패스워드 보이기,숨기기*/
                                    $("#key").on("keyup", function(event) {
                                        if (event.keyCode === 13) {
                                            event.preventDefault();
                                            $("#checkKey").triggerHandler("click");
                                        } else {
                                            if (this.value) {
                                                $("#keyShow").css("display", "inline-block");
                                            } else {
                                                $("#keyShow").hide();
                                            }
                                        }
                                    }).focus();

                                    $("#keyShow").on("click", function() {
                                        if ($("#key").attr("type") == "password") {
                                            $("#key").attr("type", "text");
                                            /*$($(this)).text("H I D E");*/
                                            $($(this)).attr('class',"eye_hide")
                                        } else {
                                            $("#key").attr("type", "password");
                                            /*$($(this)).text("S H O W");*/
                                            $($(this)).attr('class',"eye_show")
                                        }
                                    });

                                    $(document).ready(function() {
                                        $(".user1>li").click(function () {
                                            $(".user1 li.current").removeClass("current");
                                            $(this).addClass("current")

                                            if ($(".tab-2").hasClass('current')) {
                                                $("#mag_use").val('N');
                                                    //$("#modal_form").find("input").attr("disabled", true);
                                            }else  $("#mag_use").val('Y');
                                            if ($(".tab-1").hasClass('current')) {
                                                $("#mag_use").val('Y');
                                            }else  $("#mag_use").val('N');
                                        });
                                    });
                                    </script>
                                </li>


                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="mag_name" class="form_title">사용자명 <span>*</span></label>
                                    <input type="text" id="mag_name" placeholder="입력해주세요" maxlength="20">
                                </li>
                            </ul>
                            <ul <c:if test="${sessionScope.loginUser.auth>0}">style="display: none;"</c:if> class="form_group input_width">
                                <li>
                                    <label for="mag_company">소속 <span>*</span></label>
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
                                    <label for="mag_group">조직 <c:if test="${sessionScope.loginUser.auth<3}"><span style="font-size: small;">&nbsp;※조직관리자 권한은 필수선택</span></c:if></label>
                                    <select name="group" id="mag_group" data-placeholder="선택해주세요" style="width:100%;">
                                        <option value=""selected >선택해주세요</option>
                                        <c:forEach var="orgList" items="${orgList}">
                                            <option value="${orgList.seq}">${orgList.name}</option>
                                        </c:forEach>
                                    </select>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="mag_auth">권한 <span>*</span></label>
                                    <select name="mag" id="mag_auth" style="width:100%;">
                                        <option value="">선택해주세요</option>
                                        <c:if test="${sessionScope.loginUser.auth==0}">
                                        <option value="0">시스템관리자</option>
                                        </c:if>
                                        <option value="1">소속관리자</option>
                                        <option value="3">조직관리자</option>
                                        <option value="4">자판기운영자</option>
                                    </select>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="mag_email" class="form_title">이메일</label>
                                    <input type="email" id="mag_email" pattern="^\S+@(([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6})$" required title="이메일의 형식이 아닙니다" placeholder="입력해주세요">
                                </li>
                            </ul>
                            <input type="hidden" id="mag_seq">
                            <input type="hidden" id="mag_use">
                            <input type="hidden" id="isIdCheck">
                        </fieldset>
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok" onclick="addData();">적용하기</a>
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
                    </select>
                </li>
                <li class="input-size01">
                    <label for="user-search">사용자명</label>
                    <input type="text" id="user-search" placeholder="검색어를 입력해주세요" onkeydown="if(event.keyCode == 13) searchUser();">
                </li>
                <li class="check_tab">
                    <label for="user2">사용여부</label>
                    <ul class="tabs2 user2" id="user2">
                        <li class="current tab1" value="all">전체</li>
                        <li class="tab2" value="Y">사용</li>
                        <li class="tab3" value="N">미사용</li>
                    </ul>
                </li>
            </ul>
            <ul class="search_bar_pad2">
                <li><a href="javascript:void(0)" class="button3 button_position2" onclick="searchUser();">조회</a></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="sub_tit">
                    <ul>
                        <li><p>검색 결과 : <span id="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</p>
                        </li>
                        <li>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="deleteData()"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="addDataModal();">추가</a>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="editClick();">수정</a>
                        </li>
                    </ul>
                </div>
                <div class="table_responsive">
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="10%">
                        <col width="10%">
                        <col width="*">
                        <col width="*">
                        <col width="10%">
                        <col width="10%">
                        <col width="25%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                        <th>아이디</th>
                        <th>패스워드</th>
                        <th>사용자명</th>
                        <th>조직</th>
                        <th>권한</th>
                        <th>사용여부</th>
                        <th>이메일</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser.auth==0}">
                            <c:forEach var="userList" items="${userList}">
                                <tr id="${userList.seq}" onclick="editDataModal(${userList.seq})">
                                    <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>${userList.id}</td>
                                    <td>****</td>
                                    <td>${userList.name}</td>
                                    <td>${userList.organizationName}</td>
                                    <c:choose>
                                        <c:when test="${userList.auth==0}">
                                            <td style="color:#ff0018;">시스템관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==1}">
                                            <td>소속관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==3}">
                                            <td>조직관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==4}">
                                            <td>자판기운영자</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>권한없음</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${userList.useYN}</td>
                                    <td>${userList.email}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${userList==null||empty userList}">
                                <tr style="pointer-events: none;">
                                    <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>&ensp;&emsp;</td><td colspan=7>사용자가 존재하지 않습니다</td>
                                </tr>
                            </c:if>
                            <c:forEach var="userList" items="${userList}">
                                <tr id="${userList.seq}" onclick="editDataModal(${userList.seq})">
                                    <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>${userList.id}</td>
                                    <td>****</td>
                                    <td>${userList.name}</td>
                                    <td>${userList.organizationName}</td>
                                    <c:choose>
                                        <c:when test="${userList.auth==0}">
                                            <td style="color:#ff0018;">시스템관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==1}">
                                            <td>소속관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==3}">
                                            <td>조직관리자</td>
                                        </c:when>
                                        <c:when test="${userList.auth==4}">
                                            <td>자판기운영자</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>권한없음</td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td>${userList.useYN}</td>
                                    <td>${userList.email}</td>
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
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    $('#company-select').select2();
    $('#group-select').select2();
    $('#mag_company').select2();
    $('#mag_group').select2();
    $('#mag_auth').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('#company-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            $('#group-select').empty();
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+companySeq,
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.origList.length>0){
                    html +=" <option value=\"0\" selected>전체</option>";
                    for(var i=0; i<response.origList.length; i++){
                        html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                    }
                }
                $('#group-select').empty();
                $("#group-select").append(html);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
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
                if(response.origList.length>0){
                    html +=" <option value='' selected>선택하세요</option>";
                    for(var i=0; i<response.origList.length; i++){
                        html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                    }
                }
                $('#mag_group').empty();
                $("#mag_group").append(html);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    function idCheck(){
        //중복아이디체크
        var userSeq = $("#mag_seq").val();
        var id = $("#mag_id").val();
        if(id==''){
            alert('지정할 아이디를 입력하세요.');
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/idCheck.do',
            type : 'GET',
            data : {id : id, seq : userSeq},
            success:function(response){
               alert(response);
               if(response.includes('가능')) $("#isIdCheck").val(1);
               else $("#isIdCheck").val(0);
            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }

    function searchUser(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();//전체면 0
        var userName = $("#user-search").val();
        var useYN = $(".tabs2").children(".current").attr("value");

        $("#company_seq").val(companySeq);
        $("#orig_seq").val(organizationSeq);

        if(companySeq==''){
            alert("소속을 선택하세요.");
            return false;
        }
        if(organizationSeq==''||organizationSeq==null){
            if(confirm("해당 소속의 조직이 존재하지 않습니다. \n조직을 등록하시겠습니까?")){
                location.href="${root}/company/orig";
            }else location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectUsertList.do',
            type : 'POST',
            data: { companySeq : companySeq,
                organizationSeq : organizationSeq,
                name : userName,
                organizationName : userName,
                useYN : useYN},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=7>사용자가 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].seq + '"onclick="editDataModal('+response[i].seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].id + '</td>';
                    html +='<td>****</td>';//html +='<td>' + response[i].password + '</td>';
                    html +='<td>' + response[i].name + '</td>';
                    html +='<td>' + response[i].organizationName + '</td>';
                    if(response[i].auth==0){
                        html +='<td style="color:#ff0018;">시스템관리자</td>';
                    }
                    else if(response[i].auth==1){
                        html +='<td>소속관리자</td>';
                    }
                    else if(response[i].auth==3){
                        html +='<td>조직관리자</td>';
                    }
                    else if(response[i].auth==4){
                        html +='<td>자판기운영자</td>';
                    }
                    else{
                        html +='<td>권한없음</td>';
                    }
                    //html +='<td>' + response[i].auth + '</td>';
                    html +='<td>' + response[i].useYN + '</td>';
                    html +='<td>' + response[i].email + '</td>';
                }
                $('#Dash_Table_Body1').html(html);
                $('#totCnt').text(response.length);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys",$('#nowpage'));

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }

    function addDataModal(){
        $(".pop_title h2").text("사용자 추가");
        $(".tab-1").attr("class","tab-1 current");
        $(".tab-2").removeClass("current");
        $("#mag_auth").val('').prop("selected",true);
        $('#select2-mag_auth-container').text('선택해주세요');
        $('#mag_id').attr('disabled', false);
        $("#mag_seq").val(0);
        $("#mag_use").val('Y');
        $("#isIdCheck").val(0);
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        //$("#mag_group").val('').prop("selected",true);
        /*if($('#orig_seq').val()==null||$('#orig_seq').val()==0){
            ("#mag_group option:eq(0)").prop("selected",true);
        }
        else{ $("#mag_group").val($('#orig_seq').val()).prop("selected",true);}*/
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
    function editDataModal(userSeq){
        $(".pop_title h2").text("사용자 수정");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        //$(".user1").find('li').removeClass("current");
        $.ajax({
            url:'${root}/company/ajax/selectUserInfo.do',
            type : 'GET',
            data: { seq : userSeq,
                userSeq : userSeq },
            datatype: 'JSON',
            success:function(response){
                var html =""; //소속
                var html2 =""; //조직

                for(var i=0; i<response.comList.length; i++){
                    html +="<option value='"+response.comList[i].seq+"'>"+response.comList[i].name+"</option>";
                }
                html2 +="<option value='0'>선택해주세요</option>";
                for(var i=0; i<response.orgList.length; i++){
                    html2 +="<option value='"+response.orgList[i].organizationSeq+"'>"+response.orgList[i].organizationName+"</option>";
                }

                $("#mag_id").val(response.userInfo.id);
                $("#key").val(response.userInfo.password);
                $("#mag_name").val(response.userInfo.name);
                //$("#mag_group").val(response.userInfo.organizationSeq).prop("selected",true);
                $("#mag_email").val(response.userInfo.email);
                $("#mag_seq").val(response.userInfo.seq);
                $("#mag_use").val(response.userInfo.useYN);
                $("#isIdCheck").val(1);
                if(response.userInfo.useYN=='Y'){
                    $(".tab-1").attr("class","current tab-1");
                    $(".tab-2").attr("class","tab-2");
                }else{
                    $(".tab-1").attr("class","tab-1");
                    $(".tab-2").attr("class","current tab-2");
                }

                $('#mag_company').empty();
                $('#mag_group').empty();
                if(${sessionScope.loginUser.auth==0}){
                    $("#mag_company").append(html);
                    $("#mag_group").append(html2);
                }else if(${sessionScope.loginUser.auth==1}){
                    $("#mag_company").append('<option value="' + response.userInfo.companySeq + '" seleted>' + response.userInfo.companyName + '</option>');
                    $("#mag_group").append(html2);
                }else{
                    $("#mag_company").append('<option value="' + response.userInfo.companySeq + '" seleted>' + response.userInfo.companyName + '</option>');
                    $("#mag_group").append('<option value="' + response.userInfo.organizationSeq + '" seleted>' + response.userInfo.organizationName + '</option>');
                }
                $('#mag_company').val(response.userInfo.companySeq).attr('selected',"selected");
                $('#select2-mag_company-container').text(response.userInfo.companyName);
                $('#mag_group').val(response.userInfo.organizationSeq).change();
                $("#mag_auth").val(response.userInfo.auth).change();
                if(${sessionScope.loginUser.auth>0}){
                    $('#mag_id').attr('disabled', true);
                    if(response.userInfo.auth==1){
                        $("#mag_auth").prop('disabled', true);
                    }
                }

            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }

    function addData(){
        var companySeq = $("#mag_company option:selected").val();
        var organizationSeq = $("#mag_group option:selected").val();
        var id = $("#mag_id").val();
        var password = $("#key").val();
        var name = $("#mag_name").val();
        var auth = $("#mag_auth option:selected").val();
        var email = $("#mag_email").val();
        var useYN = $("#mag_use").val();
        var seq = $("#mag_seq").val();
        var isIdCheck = $("#isIdCheck").val();

        if(isIdCheck==0){
            alert('아이디 중복확인을 해주세요.');
            return false;
        }

        var params = $("#modal_form").serialize();
        if(id==''||password==''||name==''){
            alert("필수값을 모두 입력하세요.");
            return false;
        }
        if(auth==''){
            alert("권한을 선택하세요.");
            return false;
        }
        if(companySeq==''){
            alert("소속을 선택하세요.");
            return false;
        }
        if(auth=='3'&&(organizationSeq==''||typeof organizationSeq == "undefined"||organizationSeq==0)){
            alert("조직을 선택하세요.");
            return false;
        }
        if(email==''){
            email=' ';
        }
        var data = {
            companySeq : companySeq,
            organizationSeq : organizationSeq,
            id : id,
            password : password,
            name : name,
            auth : auth,
            email : email,
            useYN : useYN,
            seq : seq};
        //alert(JSON.stringify(data)); return false;
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/company/ajax/insModUser.do',
            data: data,
            type : 'POST',
            success:function(response){
                alert(response);
                searchUser();
                $('#modal_pop').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });

    }

    function deleteData(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 사용자를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedUser.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    searchUser();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }
//////////////////////////////////////////////////













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
