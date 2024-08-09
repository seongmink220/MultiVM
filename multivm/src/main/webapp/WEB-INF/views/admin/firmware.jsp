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
    <title>프로그램 관리</title>
    <script src="${root}/resources/ckeditor/ckeditor.js"></script>
    <script src="${root}/resources/ckeditor/config.js"></script>
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
        $('#mn_md_firmware').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#mn_md_m_firmware').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('#lnb_admin2').children('ul').show();
        $('.subtit').text("프로그램 관리");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            프로그램 관리
        </header>
        <div id="shadow_bg" style="display: none;"></div>
        <div id="modal_pop" style="display: ;">
            <div class="pop_box" style="display: none;">
                <div class="pop_title">
                    <h2 id="pop_title_m">프로그램 등록</h2>
                    <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form1">
                        <fieldset>
                            <legend>프로그램 정보입력</legend>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="currVersion" class="form_title">버전 <span>*</span></label>
                                    <input type="text" id="currVersion" placeholder="입력해주세요" maxlength="20">
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="firmware_desc">프로그램 설명</label>
                                    <textarea cols="50" rows="3" id="firmware_desc" placeholder=""></textarea>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="program_file">파일 <span>*</span></label>
                                    <%-- <a class="button filebox bs3-primary" onclick="document.getElementById('program_file').click();">이미지 변경</a>
                                     <input type="file" id="program_file" style="display:none"/>--%>
                                    <div class="filebox bs3-primary">
                                        <input class="upload-name" value="선택된 파일 없음" disabled="disabled">
                                        <label for="program_file" >파일선택</label>
                                        <input type="file" name ="program_file" id="program_file" class="upload-hidden">
                                    </div>
                                    <script>
                                        $(document).ready(function(){
                                            var fileTarget = $('.filebox .upload-hidden');

                                            fileTarget.on('change', function(){
                                                if(window.FileReader){
                                                    var filename = $(this)[0].files[0].name;
                                                    var filetype = filename.slice(filename.indexOf(".") + 1).toLowerCase();
                                                    /*if(filetype!='xlsx'&&filetype!='xls'){
                                                        alert('xlsx, xls 파일이 아닙니다.');
                                                        return false;
                                                    }*/
                                                } else {
                                                    var filename = $(this).val().split('/').pop().split('\\').pop();
                                                }


                                                $(this).siblings('.upload-name').val(filename);
                                            });
                                        });
                                    </script>
                                </li>
                            </ul>
                            <input type="hidden" id="vm_seq" value="0">
                        </fieldset>
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok"onclick="addProgram();">등록하기</a>
                    </div>
                </div>
            </div>

            <div class="pop_box3" style="display: none;">
                <div class="pop_title">
                    <h2>프로그램 상세조회</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_box3').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox scroll_contbox">
                    <div class="table_responsive">
                        <table class="tb_horizen cont_table">
                            <colgroup>
                                <col width="20%">
                                <col width="*">
                            </colgroup>
                            <tbody id="Dash_Table_Body3" style="pointer-events: none;">
                            <tr>
                                <td>버전</td>
                                <td id="td1_version" class="cont"></td>
                            </tr>
                            <tr>
                                <td>설명</td>
                                <td id="td2_desc" class="cont"></td>
                            </tr>
                            <tr>
                                <td>SHA256</td>
                                <td id="td3_sha256" class="cont"></td>
                            </tr>
                            <tr>
                                <td>파일이름</td>
                                <td id="td4_fileName" class="cont"></td>
                            </tr>
                            <tr>
                                <td>등록일자</td>
                                <td id="td5_createDate" class="cont"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <input type="hidden" id="td6_firmwareSeq" value="">
                    <div class="sub_tit3">
                        <ul>
                            <li><h2>등록된 자판기 목록</h2></li>
                            <li style="pointer-events: all;">
                                <select name="addVm-select3" id="addVm-select3" style="width: 45%; height: 40px; padding: 0 8px;" >
                                    <option value="0">전체</option>
                                </select>
                                <a href="javascript:void(0)" class="button btn_delete" onclick="deleteProgramVM();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_responsive">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="15%">
                                <col width="*">
                                <col width="30%">
                                <col width="15%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2 allSelect3"><input type="checkbox" class="ez-hide"></div></th>
                                <th>단말기ID</th>
                                <th>소속/조직</th>
                                <th>설치위치</th>
                                <th>상태</th>
                            </tr>
                            </thead>
                            <tbody  id="Dash_Table_Body4">
                            <%--<tr><td><div class="ez-checkbox c_position3 allSelect3"><input type="checkbox" class="ez-hide"></div></td>
                            <td class=""></td><td class="t_left">내 주세요</td><td class="t_left">내 주세요</td></tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar" style="display:none ;">
            <ul>
                <li>
                    <label for="office-select">소속</label>
                    <!--<input list="office-list" name="office" id="office" placeholder="선택 및 입력해주세요">
                    <datalist id="office-list">
                        <option value="1" label="1">
                        <option value="2" label="2">
                        <option value="3" label="3">
                        <option value="4" label="4">
                    </datalist>-->

                    <!--<select name="office" id="office-select">
                        <option value="all">선택해주세요</option>
                        <option value="e_name">유비씨엔</option>
                    </select>-->

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
                        <ul>
                            <li style="width:80%!important;">
                                <select name="program-select" id="program-select">
                                    <option value="0">프로그램 전체</option>
                                    <c:forEach var="programList" items="${programList}">
                                        <option value="${programList.seq}">${programList.fileName}</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li class="button_position3"></li>
                        </ul>
                    </div>
                    <div class="table_selectbox2_4">
                        <ul>
                            <%--<li class=""><input type="text" id="office-input" placeholder="검색어를 입력해주세요"><a href="#none" class="button3 " onclick="">검색</a></li>--%>
                            <li class="button_position3">
                                <a href="javascript:void(0);" class="button" onclick="addProgramModal();">프로그램 등록</a>
                                <%--<a href="#none" class="button" onclick="">수정</a>--%>
                                <a href="javascript:void(0);" class="button" onclick="deleteProgram();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                                <%--<a href="#none" class="button" onclick=""><img src="${root}/resources/images/ic_copy.png"></a></li>--%>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                            <table class="tb_horizen">
                                <colgroup>
                                    <col width="5%">
                                    <col width="10%">
                                    <col width="20%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                                    <th>seq</th>
                                    <th>버전</th>
                                    <th>파일</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body1">
                                <c:if test="${empty programList}">
                                    <tr><td colspan=4>프로그램을 등록하세요</td></tr>
                                </c:if>
                                <c:forEach var="programList" items="${programList}">
                                <tr id="${programList.seq}">
                                    <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>${programList.seq}</td>
                                    <td class="t_left" onclick="detailProgramModal(${programList.seq})">${programList.currVersion}</td>
                                    <td class="t_left" onclick="detailProgramModal(${programList.seq})">${programList.fileName}</td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="pagination" id="pagination_ys">
                        </div><input type="hidden" id="nowpage" value="1">
                    </div>
                </div>
                <div class="item copy_arrow"></div>
                <div class="item table_outline_a">
                    <div class="table_selectbox3">
                        <ul>
                            <li>
                                <select name="company-select2" id="company-select2" style="width: 100%;" >
                                    <option value="0">소속 전체</option>
                                    <c:forEach var="companyList" items="${companyList}">
                                        <option value="${companyList.seq}">${companyList.name}</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li>
                                <select name="group-select2" id="group-select2"style="width: 100%;">
                                    <option value="0">조직 전체</option>
                                    <c:if test="${empty orgList}">
                                    </c:if>
                                    <c:forEach var="orgList" items="${orgList}">
                                        <option value="${orgList.seq}">${orgList.name}</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li>
                                <select name="vm-select2" id="vm-select2">
                                    <option value="0">자판기 전체</option>
                                    <c:if test="${empty vmList}">
                                    </c:if>
                                    <c:forEach var="vmList" items="${vmList}">
                                        <option value="${vmList.seq}">${vmList.place}<br/>(${vmList.vmId})</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li>
                                <select name="version-select2" id="version-select2">
                                    <option value="0">버전 전체</option>
                                    <c:if test="${empty programList}">
                                    </c:if>
                                    <c:forEach var="programList" items="${programList}">
                                        <option value="${programList.seq}">${programList.currVersion}</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <%--<li>
                                <input type="text" id="search-input" placeholder="검색어를 입력해주세요">
                            </li>
                            <li class="button_position3"><a href="#none" class="button3" onclick="">검색</a></li>--%>
                        </ul>
                    </div>
                    <div class="table_selectbox2_4">
                        <ul>
                            <li class="button_position3">
                            <%--<li class="button_position3"><a href="#none" class="button" onclick=""><img src="${root}/resources/images/ic_delete.png">삭제</a>--%>
                                <a href="javascript:void(0);" class="button" onclick="insertProgramtoVM();"><img src="${root}/resources/images/ic_save.png">선택한 자판기에 프로그램 추가</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                            <table class="tb_horizen">
                                <colgroup>
                                    <col width="5%">
                                    <col width="20%">
                                    <col width="30%%">
                                    <col width="30%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><div class="ez-checkbox c_position2 allSelect2"><input type="checkbox" class="ez-hide"></div></th>
                                    <th class="table_vm_th1">자판기ID</th>
                                    <th class="table_vm_th2">소속/조직명</th>
                                    <th class="table_vm_th3">설치위치</th>
                                    <th class="table_vm_th4">버전</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body2">
                                <c:if test="${empty vmList}">
                                    <tr style="pointer-events: none;">
                                        <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="vmList" items="${vmList}">
                                    <tr id="${vmList.seq}">
                                        <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td style="pointer-events: none;">${vmList.vmId}</td>
                                        <td class="" style="pointer-events: none;">${vmList.companyName}/${vmList.organizationName}</td>
                                        <td class="" style="pointer-events: none;">${vmList.place}</td>
                                        <td class="t_left" style="pointer-events: none;">${vmList.currVersion}</td>
                                    </tr>
                                </c:forEach>

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
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">


    $('#program-select').select2();
    $('#company-select2').select2();
    $('#group-select2').select2();
    $('#vm-select2').select2();
    $('#version-select2').select2();//addVm-select3
    $('#addVm-select3').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('#program-select').change(changeProgramSelect=function(){
        var firmwareSeq = $("#program-select option:selected").val();
        if(firmwareSeq==''){
            location.reload();
            return false;
        }
        //alert($(this).val());
        $.ajax({
            url:'${root}/admin/ajax/selectProgram.do',
            type : 'POST',
            data:{seq : firmwareSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                for(var i=0; i<response.length; i++){
                    html +='<tr id="'+response[i].seq+'" ><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].seq + '</td>';
                    html +='<td class="t_left" onclick="detailProgramModal(\''+response[i].seq+'\');">' + response[i].currVersion + '</td>';
                    html +='<td class="t_left" onclick="detailProgramModal(\''+response[i].seq+'\');">' + response[i].fileName + '</td></tr>';
                }

                //$('#group-select2').empty();
                //$("#group-select2").append(html);
                $('#Dash_Table_Body1').html(html);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#company-select2').change(changeCompanySelect=function(){
        // 소속선택 > 조직전체, 자판기전체, 버전은 그대로
        var companySeq = $("#company-select2 option:selected").val();
        var organizationSeq = $("#group-select2 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var firmwareSeq = $("#version-select2 option:selected").val();

        /*if(vmSeq!=0){
            changeVMSelect1();
        }
        if(organizationSeq!=0){
            changeGroupSelect1();
        }*/
        if(companySeq==''){
            location.reload();
        }
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/company/ajax/selectCompany.do',
            type : 'POST',
            data:{companySeq : companySeq,
                firmwareSeq : firmwareSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                html +="<option value='0' selected>조직 전체</option>";
                html2 +="<option value='0' selected>자판기 전체</option>";
                //html3 +='<tr><td>&ensp;&emsp;</td><td colspan=3>조직을 선택하세요.</td></tr>';

                if(response.vmList.length<1||response.origList.length<1){
                    html3 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.origList.length; i++){
                    html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html2 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    html3 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">' + response.vmList[i].vmId + '</td>';
                    html3 +='<td style="pointer-events: none;" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html3 +='<td style="pointer-events: none;" class="">' + response.vmList[i].place + '</td>';
                    html3 +='<td style="pointer-events: none;" class="t_left">' + response.vmList[i].currVersion + '</td></tr>';
                }

                //$('#group-select option').remove();
                $('#group-select2').empty();
                $("#group-select2").append(html);
                $('#vm-select2').empty();
                $("#vm-select2").append(html2);
                $('#Dash_Table_Body2').html(html3);
                $('input').ezMark();
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });
    });
///////////////////////////////////////
    $('#group-select2').change(changeGroupSelect1=function(){
        // 조직선택> 소속지정, 자판기전체, 버전은 그대로
        //var companySeq = $("#company-select2 option:selected").val();
        var organizationSeq = $("#group-select2 option:selected").val();
        var organizationText = $("#group-select2 option:selected").text();
        var firmwareSeq = $("#version-select2 option:selected").val();

        if(organizationSeq==''){
            location.reload();
        }
        if(organizationSeq==0){
            changeCompanySelect();
        }
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/admin/ajax/selectVMList.do',
            type : 'GET',
            data:{ firmwareSeq : firmwareSeq,
                organizationSeq : organizationSeq,
                vmSeq : 0},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                    //$("#group-select2").val(0).prop("selected",true);
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) {
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }

                for(var i=0; i<response.vmList.length; i++){
                    html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    html2 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td>' + response.vmList[i].vmId + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].place + '</td>';
                    html2 +='<td style="pointer-events: none;" class="t_left">' + response.vmList[i].currVersion + '</td></tr>';
                }
                //$("#group-select2").val(response[0].organizationSeq).prop("selected",true);
                $('#group-select2').empty();
                $("#group-select2").append(html3);
                $('#group-select2').val(organizationSeq).attr('selected',"selected");
                $('#company-select2').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select2-container').text(response.orgInfo[0].companyName);
                $('#select2-group-select2-container').text(organizationText);
                $('#vm-select2').empty();
                $("#vm-select2").append(html);
                $('#Dash_Table_Body2').html(html2);
                $('input').ezMark();
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });
    });

    $('#vm-select2').change(changeVMSelect1=function(){
        // 자판기선택> 소속지정, 조직지정, 버전은 그대로
        //var companySeq = $("#company-select2 option:selected").val();
        //var organizationSeq = $("#group-select2 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var vmText = $("#vm-select2 option:selected").text();
        var firmwareSeq = $("#version-select2 option:selected").val();

        if(vmSeq==''){
            location.reload();
        }
        if(vmSeq==0){
            changeGroupSelect1();
        }
        $.ajax({
            url:'${root}/admin/ajax/selectVMList.do',
            type : 'GET',
            data:{ firmwareSeq : firmwareSeq,
                organizationSeq : 0,
                vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) { //null이 없음
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.vmInfo.length; i++) { //null이 없음
                    html += "<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+response.vmInfo[i].vmId+")</option>";
                }
                // 그 소속의 자판기List들...
                $('#vm-select2').val(vmSeq).attr('selected',"selected");
                $('#select2-vm-select2-container').text(vmText);
                for(var i=0; i<response.vmList.length; i++){
                    //html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"()</option>";
                    html2 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td style="pointer-events: none;">' + response.vmList[i].vmId + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].place + '</td>';
                    html2 +='<td style="pointer-events: none;" class="t_left">' + response.vmList[i].currVersion + '</td></tr>';
                }
                //$("#company-select2").val(response[0].companySeq).prop("selected",true);
                //$("#group-select2").val(response[0].organizationSeq).prop("selected",true);
                $('#Dash_Table_Body2').html(html2);
                $('#group-select2').empty();
                $("#group-select2").append(html3); //orgInfo
                $('#vm-select2').empty();
                $("#vm-select2").append(html); //vmInfo
                $('#company-select2').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select2-container').text(response.orgInfo[0].companyName);
                $('#group-select2').val(response.vmList[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select2-container').text(response.vmList[0].organizationName);
                $('#vm-select2').val(vmSeq).attr('selected',"selected");
                $('#select2-vm-select2-container').text(vmText);
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

    $('#version-select2').change(changeVersionSelect1=function(){
        // 자판기선택> 소속지정, 조직지정, 버전은 그대로
        var companySeq = $("#company-select2 option:selected").val();
        var organizationSeq = $("#group-select2 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var firmwareSeq = $("#version-select2 option:selected").val();

        if(firmwareSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/admin/ajax/selectVMList.do',
            type : 'GET',
            data:{ companySeq : companySeq,
                firmwareSeq : firmwareSeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.vmList.length; i++){
                    html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"()</option>";
                    html2 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td style="pointer-events: none;">' + response.vmList[i].vmId + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 +='<td style="pointer-events: none;" class="">' + response.vmList[i].place + '</td>';
                    html2 +='<td style="pointer-events: none;" class="t_left">' + response.vmList[i].currVersion + '</td></tr>';
                }
                //$("#company-select2").val(response[0].companySeq).prop("selected",true);
                //$("#group-select2").val(response[0].organizationSeq).prop("selected",true);
                //$('#vm-select2').empty();
                //$("#vm-select2").append(html);
                $('#Dash_Table_Body2').html(html2);
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

    function detailProgramModal(seq){
        $('.pop_box3').stop().fadeIn();
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        FunLoadingBarStart();
        $.ajax({
            url:'${root}/admin/ajax/getDetailProgramInfo.do',
            type : 'GET',
            data:{ seq : seq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";

                if(response.programVMList.length <1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>설치된 자판기가 존재하지 않습니다</td></tr>';
                }
                html +='<option value="0">전체</option>';
                for(var i=0; i<response.programVMList.length; i++){
                    html +="<option value='"+response.programVMList[i].seq+"'>"+response.programVMList[i].place+"("+response.programVMList[i].vmId+")</option>";
                    html2 +='<tr id="'+ response.programVMList[i].seq +'"><td><div class="ez-checkbox c_position2 allSelect3"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td style="pointer-events: none;" class="">'+response.programVMList[i].vmId+'</td><td style="pointer-events: none;" class="t_left">'+response.programVMList[i].companyName+'/'+response.programVMList[i].organizationName+'</td><td style="pointer-events: none;" class="t_left">'+response.programVMList[i].place+'</td>';
                    if(response.programVMList[i].firmwareStatus==null){
                        html2 +='<td style="pointer-events: none;" class="">설치전</td></tr>';
                    }
                    else html2 +='<td style="pointer-events: none;" class="">'+response.programVMList[i].firmwareStatus+'</td></tr>';
                }
                $("#td1_version").text(response.programInfo.currVersion);
                $("#td2_desc").text(response.programInfo.desc);
                $("#td3_sha256").text(response.programInfo.sha256);
                $("#td4_fileName").text(response.programInfo.fileName);
                $("#td5_createDate").text(response.programInfo.createDate);
                $("#td6_firmwareSeq").val(response.programInfo.seq);

                $('#Dash_Table_Body4').html(html2);
                $('#addVm-select3').empty();
                $("#addVm-select3").append(html);
                $('input').ezMark();
                $('.allSelect3').find('div').removeClass("ez-checked");

            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });
    }

    $('#addVm-select3').change(changeAddVMSelect3=function(){
        var vmSeq = $("#addVm-select3 option:selected").val();
        var firmwareSeq = $("#td6_firmwareSeq").val();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/admin/ajax/selectVMList.do',
            type : 'GET',
            data:{vmSeq : vmSeq,firmwareSeq:firmwareSeq},
            datatype: 'JSON',
            success:function(response){
                var html2 ="";
                if(response.vmList.length<1){
                    html2 +='<tr><td>&ensp;&emsp;</td><td colspan=4>등록된 자판기가 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.vmList.length; i++){
                    html2 +='<tr id="'+ response.vmList[i].seq +'"><td><div class="ez-checkbox c_position3"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td style="pointer-events: none;" class="">'+response.vmList[i].vmId+'</td><td style="pointer-events: none;" class="t_left">'+response.vmList[i].companyName+'/'+response.vmList[i].organizationName+'</td><td style="pointer-events: none;" class="t_left">'+response.vmList[i].place+'</td>';
                    if(response.vmList[i].firmwareStatus==null){
                        html2 +='<td style="pointer-events: none;" class="">설치전</td></tr>';
                    }
                    else html2 +='<td style="pointer-events: none;" class="">'+response.vmList[i].firmwareStatus+'</td></tr>';
                }
                $('#Dash_Table_Body4').html(html2);
                $('input').ezMark();
                $('.allSelect3').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $(".allSelect1").click(function(){
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
        var allChildrenChecked = $('#Dash_Table_Body4').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body4').find("input").prop('checked', allChildrenChecked).change();

    });
    window.onload = function(){
        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
        pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
    }

    function deleteProgram(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 프로그램을 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/admin/ajax/deleteSelectedProgram.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    //changeProgramSelect();
                    location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }
    function insertProgramtoVM(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var sizeCheck2 = $('#Dash_Table_Body2 input[type="checkbox"]:checked');
        var vmList = [];
        var programList = [];
        if(sizeCheck2.length ==0){
            alert("자판기를 선택해주세요"); return false;
        }
        if(sizeCheck.length == 0){
            alert("자판기에 추가할 프로그램을 선택하세요"); return false;
        }else if(sizeCheck.length > 1) {
            alert("추가할 프로그램은 한개씩만 가능합니다"); return false;
        }else{
            if(!confirm("이 버전으로 프로그램을 추가하시겠습니까?")) return;
            $.each(sizeCheck,function(idex,entry){
                programList.push(entry.closest('tr').id);
            });
            $.each(sizeCheck2,function(idex,entry){
                vmList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/admin/ajax/insertProgramToVM.do',
                type : 'POST',
                data: {programList : programList,
                        vmList : vmList},
                success:function(response){
                    alert(response);
                    changeCompanySelect();
                    $('.allSelect1').find('div').removeClass("ez-checked");
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }
    function addProgramModal(){

        $('#modal_pop').stop().fadeIn();
        $('.pop_box').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        //CKEDITOR.instances.product_info.setData('');
        //$("#advTitle").val('');
        //$("#advContent").val('');
        //$('.input01').find('.ez-checkbox').removeClass('ez-checked');
        //$("#advOwner").val('');
    }
    function addProgram(){
        var form = new FormData();
        var currVersion = $("#currVersion").val();
        var firmware_desc = $("#firmware_desc").val();
        //var desc = CKEDITOR.instances.product_info.getData();
        //var fileName =$("#fileName")[0].files[0];

        if(currVersion==''){
            alert('필수값을 모두 채워주세요.')
        }
        if($("#program_file").val()!=''){
            if($("#program_file")[0].files[0].size > 20000000){
                alert("파일크기가 20MB를 초과합니다");
                return false;
            }
        }else alert('프로그램 파일을 첨부해주세요.');

        form.append( "currVersion", currVersion );
        form.append( "content", firmware_desc );
        form.append( "upload_firmwarefile", $("#program_file")[0].files[0] ); //신규 이미지 파일

        //alert("df "+$("#product_image")[0].files[0]);
        if(currVersion==''){
            alert("값을 입력하세요.");
            return false;
        }
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/admin/ajax/insertProgram.do',
            data: form,
            type : 'POST',
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success:function(response){
                alert(response);
                //$(".product").load(location.href + ".product");
                $('#modal_pop').stop().fadeOut();
                $('.pop_box').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
                //changeProgramSelect();
                location.reload();
                //$('.input01').children('.ez-checkbox').eq(0).attr("class","");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }, complete: function () {FunLoadingBarEnd();}
        });
    }
    function deleteProgramVM(){
        var sizeCheck = $('#Dash_Table_Body4 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("해당 프로그램을 삭제할 자판기를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/admin/ajax/deleteSelectedProgramVM.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    $('#modal_pop').stop().fadeOut();
                    $('.pop_box3').stop().fadeOut();
                    $('#shadow_bg').stop().fadeOut();
                    changeVersionSelect1();
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }


</script>
</body>
</html>
