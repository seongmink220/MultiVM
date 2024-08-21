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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>광고 관리</title>
    <script src="${root}/resources/ckeditor/ckeditor.js"></script>
    <script src="${root}/resources/ckeditor/config.js"></script>
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
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mf_adv').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#lnb_admin2').children('ul').show();
        $('#mn_mf_m_adv').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('.subtit').text("광고 관리");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            광고 관리
        </header>
        <input type="hidden" id="company_seq" value="${sessionScope.loginUser.companySeq}">
        <input type="hidden" id="orig_seq" value="${sessionScope.loginUser.organizationSeq}">
        <input type="hidden" id="orig_seq2" value="${sessionScope.loginUser.organizationSeq}">
        <input type="hidden" id="company_name" value="${sessionScope.loginUser.companyName}">
        <input type="hidden" id="orig_name" value="${sessionScope.loginUser.organizationName}">
        <div id="shadow_bg" style="display: none;"></div>
        <div id="modal_pop" style="display: none;">
            <div class="pop_box pop_ins" style="display: none;">
                <div class="pop_title">
                    <h2>광고 신규등록</h2>
                    <span><a href="javascript:void(0);"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut(); $('#adv_file').val('');"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form">
                    <table class="cont_table" summary="게시물 상세보기입니다">
                        <caption class="blind">광고 신규등록</caption>
                        <tbody>
                        <tr>
                            <th>광고명<span style="color: #f53a3a;">&nbsp;*</span></th></th>
                            <th class="cont"><input type="text" id="adv_title" placeholder="입력해주세요" maxlength="20"></th>
                        </tr>
                        <tr>
                            <th>광고주</th>
                            <th class="cont"><input type="text" id="adv_owner" placeholder="입력해주세요" maxlength="20"></th>
                        </tr>
                        <tr>
                            <th>광고유형<span style="color: #f53a3a;">&nbsp;*</span></th>
                            <th class="cont">
                                <label class="box-radio-input"><input type="radio" name="adv_type" value="H" checked="checked"><span>가로형</span></label>
                                <label class="box-radio-input"><input type="radio" name="adv_type" value="V"><span>세로형</span></label>
                            </th>
                        </tr>
                        <tr>
                            <th>파일<span style="color: #f53a3a;">&nbsp;*</span></th></th>
                            <td class="cont">
                                <div class="filebox bs3-primary">
                                    <input class="upload-name" value="선택된 파일 없음" disabled="disabled">
                                    <label for="adv_file" >파일선택</label>
                                    <input type="file" name ="adv_file" id="adv_file" class="upload-hidden" accept=".mkv,.avi,.mp4,.wmv,.mov">
                                </div>
                                <script>
                                    $(document).ready(function(){
                                        var fileTarget = $('.filebox .upload-hidden');

                                        fileTarget.on('change', function(){
                                            if(window.FileReader){
                                                var filename = $(this)[0].files[0].name;
                                                var filetype = filename.slice(filename.indexOf(".") + 1).toLowerCase();
                                                if(filetype!='mkv'&&filetype!='avi'&&filetype!='mp4'&&filetype!='wmv'&&filetype!='mov'){
                                                    alert('등록 가능한 파일확장자가 아닙니다.\n ※ mkv, avi, mp4, wmv, mov 파일확장자만 지원합니다.');
                                                    $('#adv_file').val("");
                                                    $('.upload-name').val("선택된 파일 없음");
                                                    return false;
                                                }
                                            } else {
                                                var filename = $(this).val().split('/').pop().split('\\').pop();
                                            }


                                            $(this).siblings('.upload-name').val(filename);
                                        });
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr <c:if test="${sessionScope.loginUser.auth>0}">style="display: none;"</c:if>>
                            <th>소속<span style="color: #f53a3a;">&nbsp;*</span></th>
                            <td class="cont">
                                <select name="company-select3" id="company-select3" style="width: 100%;">
                                    <option value="">선택해주세요</option>
                                    <c:forEach var="companyList" items="${companyList}">
                                        <option value="${companyList.seq}">${companyList.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>조직<span style="color: #f53a3a;">&nbsp;*</span></th></th>
                            <td class="cont">
                                <select id="multipleSelect" data-placeholder="선택해주세요" style="width: 100%;" multiple>
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">선택해주세요</option>
                                        </c:when>
                                        <c:when test="${sessionScope.loginUser.auth==1}">
                                            <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                                            <c:forEach var="defaultOrg" items="${defaultOrg}">
                                                <option value="${defaultOrg.seq}">${defaultOrg.name}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>광고 설명</th>
                            <td class="cont">
                                <textarea cols="50" rows="4" id="adv_Content" placeholder="내용을 입력해주세요"></textarea>
                                <div id="text_count">(0 / 100)</div>
                                <script>
                                    $(document).ready(function() {
                                        $('#adv_Content').on('keyup', function() {
                                            $('#text_count').html("("+$(this).val().length+" / 100)");

                                            if($(this).val().length > 100) {
                                                $(this).val($(this).val().substring(0, 100));
                                                $('#text_count').html("(100 / 100)");
                                            }
                                        });
                                    });
                                </script>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                        <input type="hidden" value="0" id="adv_seq">
                    </form>
                    <div class="pop_button">
                        <a href="javascript:void(0)" class="button2 btn_cancel" onclick="$('.pop_box').stop().fadeOut();$('#shadow_bg').stop().fadeOut();">취소</a>
                        <a href="javascript:void(0)" class="button2 btn_ok"onclick="addAdv();">등록하기</a>
                    </div>
                </div>
            </div>
            <div class="pop_box3 pop_listAdv" style="display: none;">
                <div class="pop_title">
                    <h2>상세조회</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_listAdv').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox scroll_contbox">
                    <div class="table_responsive">
                        <table class="tb_horizen cont_table">
                            <colgroup>
                                <col width="35%">
                                <col width="65%">
                            </colgroup>
                            <tbody id="Dash_Table_Body3" style="pointer-events: none;">
                            <tr>
                                <td>광고명</td>
                                <td id="td1_advTitle" class="cont"></td>
                            </tr>
                            <tr>
                                <td>광고유형</td>
                                <td id="td5_advType" class="cont"></td>
                            </tr>
                            <tr>
                                <td>파일</td>
                                <td id="td2_advFile" class="cont video-wrap"></td>
                            </tr>
                            <tr>
                                <td>광고설명</td>
                                <td id="td3_advContent" class="cont"></td>
                            </tr>
                            <tr>
                                <td>등록일</td>
                                <td id="td4_createDate" class="cont"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <input type="hidden" id="td5_advSeq" value="">
                    <div class="sub_tit3">
                        <ul>
                            <li><h2>등록된 자판기 목록</h2></li>
                            <li>
                                <select name="vm-select4" id="vm-select4" style="width: 35%; height: 40px; padding: 0 8px;">
                                    <option value="0">전체</option>
                                </select>
                                <a href="javascript:void(0)" class="button btn_delete" onclick="deleteVMFromAdv();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_responsive">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="20%">
                                <col width="*">
                                <col width="15%">
                                <col width="15%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2 allSelect4"><input type="checkbox" class="ez-hide"></div></th>
                                <th>단말기ID</th>
                                <th>소속/조직</th>
                                <th>설치위치</th>
                                <th>상태</th>
                            </tr>
                            </thead>
                            <tbody id="Dash_Table_Body4">
                            <%--<tr>
                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                <td>00001</td>
                                <td class="t_left">가산디지털역</td>
                                <td>1번 출구</td>
                                <td>가동중</td>
                            </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="pop_box3 pop_listVm" style="display: none;">
                <div class="pop_title">
                    <h2>자판기 상세조회</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('.pop_listVm').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="table_responsive">
                    <table class="tb_horizen cont_table">
                        <colgroup>
                            <col width="35%">
                            <col width="65%">
                        </colgroup>
                        <tbody id="Dash_Table_Body5" style="pointer-events: none;">
                        <tr>
                            <td>소속/조직</td>
                            <td id="td1_comOrg" class="cont"></td>
                        </tr>
                        <tr>
                            <td>설치위치</td>
                            <td id="td2_place" class="cont"></td>
                        </tr>
                        <tr>
                            <td>자판기ID</td>
                            <td id="td3_vmId" class="cont"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" id="td4_vmSeq" value="">
                <div class="pop_contbox scroll_contbox">
                    <div class="sub_tit3">
                        <ul>
                            <li><h2>등록된 광고 목록</h2></li>
                            <li>
                                <select name="adv-select5" id="adv-select5" style="width: 35%; height: 40px; padding: 0 8px;">
                                    <option value="0">전체</option>
                                </select>
                                <a href="javascript:void(0)" class="button btn_delete" onclick="deleteAdvFromVM();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_responsive">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="15%">
                                <col width="20%">
                                <col width="*%">
                                <col width="10%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2 allSelect5"><input type="checkbox" class="ez-hide"></div></th>
                                <th>광고ID</th>
                                <th>광고명</th>
                                <th>조직/광고주</th>
                                <th>광고유형</th>
                            </tr>
                            </thead>
                            <tbody id="Dash_Table_Body6">
                            <tr>
                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                <%--<td>00001</td>
                                <td class="t_left">가산디지털역</td>
                                <td>1번 출구</td>
                                <td>가동중</td>--%>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <section id="body_contents" class="table_copy_outline">
            <div class="table_copy table_copy2 mar01">
                <div class="item table_outline_a">
                    <div class="table_selectbox3">
                        <span style="font-size: 14px;">※광고는 조직별로 등록합니다. 등록시 여러 조직 선택가능</span>
                        <ul>
                            <li>
                                <select name="company-select1" id="company-select1" style="width: 100%;" >
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="0">소속 전체</option>
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
                            <li>
                                <select name="group-select1" id="group-select1">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth<2}">
                                            <option value="0">조직 전체</option>
                                            <c:if test="${empty orgList}">
                                            </c:if>
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
                            <li>
                                <select name="adv-select1" id="adv-select1">
                                    <option value="0">광고 전체</option>
                                    <c:forEach var="advList" items="${advList}">
                                        <option value="${advList.seq}">[${advList.seq}]&nbsp;${advList.advTitle}</option>
                                    </c:forEach>
                                </select>
                            </li>
                            <li class="button_position3">
                                <%--<a href="javascript:void(0);" class="button3 " onclick="searchAdv();">검색</a>--%>
                            </li>
                        </ul>
                    </div>
                    <div class="table_selectbox2_4">
                        <ul>
                            <%--<li class="">&lt;%&ndash;<input type="text" id="office-input" placeholder="검색어를 입력해주세요">&ndash;%&gt;
                                <a href="#none" class="button3 " onclick="">검색</a>
                            </li>--%>
                            <li class="button_position3">
                                <div style="font-size: 14px; margin: 19px 0px 0px -19px; float: left;"> 검색결과: <span id="totalCnt" style="font-weight: bold; color:#0075fe;">${fn:length(advList)}</span>건</div>
                                <a href="javascript:void(0);" class="button" onclick="addAdvModal();">광고 신규등록</a>
                                <a href="javascript:void(0);" class="button" onclick="modifyAdvModal();">수정</a>
                                <a href="javascript:void(0);" class="button" onclick="deleteAdv();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
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
                                    <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                                    <th>광고ID</th>
                                    <th>광고명</th>
                                    <th>조직/광고주</th>
                                    <th>광고유형</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body1">

                                        <c:if test="${empty advList}">
                                            <tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>등록된 광고가 없습니다.</td></tr>
                                        </c:if>
                                        <c:forEach var="advList" items="${advList}">
                                            <tr id="${advList.seq}">
                                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                                <td onclick="detailAdvModal(${advList.seq});">${advList.seq}</td>
                                                <td onclick="detailAdvModal(${advList.seq});" class="">${advList.advTitle}</td>
                                                <td onclick="detailAdvModal(${advList.seq});" class="">${advList.organizationName}/${advList.advOwner}</td>
                                                <td onclick="detailAdvModal(${advList.seq});" class="t_left"><c:choose><c:when test="${advList.advType eq 'H'}">가로형</c:when><c:when test="${advList.advType eq 'V'}">세로형</c:when><c:otherwise>알 수 없음</c:otherwise></c:choose></td>
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
                                <select name="group-select2" id="group-select2"style="width: 100%;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth<2}">
                                            <option value="0">조직 전체</option>
                                            <c:if test="${empty orgList}">
                                            </c:if>
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
                            <li>
                                <select name="vm-select2" id="vm-select2">
                                    <option value="0">설치위치 전체</option>
                                    <c:if test="${empty vmList}">
                                    </c:if>
                                    <c:forEach var="vmList" items="${vmList}">
                                        <option value="${vmList.seq}">${vmList.place}(${vmList.vmId})</option>
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
                            <div style="font-size: 14px; margin: 19px 0px 0px -19px; float: left;"> 검색결과: <span id="totalCnt2" style="font-weight: bold; color:#0075fe;">0</span>건</div>
                            <a href="javascript:void(0);" class="button" onclick="insertAdvtoVM();"><img src="${root}/resources/images/ic_save.png">선택한 자판기에 광고 추가</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                            <table class="tb_horizen">
                                <colgroup>
                                    <col width="5%">
                                    <col width="20%">
                                    <col width="25%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th><div class="ez-checkbox c_position2 allSelect2"><input type="checkbox" class="ez-hide"></div></th>
                                    <th class="table_vm_th1">자판기ID</th>
                                    <th class="table_vm_th2">조직</th>
                                    <th class="table_vm_th3">설치위치</th>
                                </tr>
                                </thead>
                                <tbody id="Dash_Table_Body2">
                                <%--<tr>
                                    <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                    <td>00001</td>
                                    <td class="t_left">포카리스웨트</td>
                                    <td class="t_right">1,500</td>
                                </tr>--%>
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth==0}">
                                        <tr style="pointer-events: none;"><td colspan=4>소속을 선택하세요</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${empty vmList}">
                                        </c:if>
                                        <c:forEach var="vmList" items="${vmList}">
                                            <tr id="${vmList.seq}"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                            <td onclick="detailVMModal(${vmList.seq})">${vmList.vmId}</td>
                                            <td onclick="detailVMModal(${vmList.seq})" class="">${vmList.companyName}/${vmList.organizationName}</td>
                                            <td onclick="detailVMModal(${vmList.seq})" class="">${vmList.place}</td>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
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
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />--%>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/video.js/7.8.1/video-js.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/video.js/7.8.1/video.min.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">

    $('#company-select1').select2();
    $('#group-select1').select2();
    $('#adv-select1').select2();
    $('#group-select2').select2();
    $('#vm-select2').select2();
    $('#company-select3').select2();
    $('#multipleSelect').select2();
    $('#vm-select4').select2();
    $('#adv-select5').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('#company-select1').change(changeCompanySelect1=function(){
        // 소속선택 > 조직전체, 자판기전체, 버전은 그대로
        var companySeq = $("#company-select1 option:selected").val();
        var advSeq = $("#adv-select1 option:selected").val();
        var advText = $("#adv-select1 option:selected").text();
        if(companySeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{companySeq : companySeq, page : 'adv'},
            datatype: 'JSON',
            success:function(response){
                var html ="";//자판기s
                var html2 ="";//자판기tr
                var html3 ="";//조직s
                var html4 ="";//광고tr
                var html5 ="";//광고s
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                    //$("#group-select2").val(0).prop("selected",true);
                }
                if(response.advList.length<1){
                    html4 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>등록된 광고가 없습니다.</td></tr>';
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";
                html5 +="<option value='0' selected>광고 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) {
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                for(var i=0; i<response.advList.length; i++){
                    html4 +='<tr id="'+response.advList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].seq + '</td><td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].advTitle + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + response.advList[i].organizationName + '/' + response.advList[i].advOwner + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + (response.advList[i].advType=='V'?'세로형':'가로형') + '</td></tr>';
                }
                for(var i=0; i<response.advInfo.length; i++){
                    html5 +="<option value='"+response.advInfo[i].seq+"'>[" + response.advInfo[i].seq + "]&nbsp;"+response.advInfo[i].advTitle+"</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    if(companySeq!=0) {
                        html2 += '<tr id="' + response.vmList[i].seq + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');">' + response.vmList[i].vmId + '</td>';
                        html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                        html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].place + '</td>';
                    }
                }
                if(companySeq==0) html2 += '<tr style="pointer-events: none;"><td colspan=4>소속을 선택하세요</td></tr>';


                //$('#group-select option').remove();
                $('#group-select1').empty();
                $("#group-select1").append(html3);
                $('#adv-select1').empty();
                $("#adv-select1").append(html5);
                $('#group-select2').empty();
                $("#group-select2").append(html3);
                $('#vm-select2').empty();
                $("#vm-select2").append(html);
                //$('#adv-select1').val(advSeq).attr('selected',"selected");
                //$('#select2-adv-select1-container').text(advText);
                $('#Dash_Table_Body1').html(html4);
                $('#Dash_Table_Body2').html(html2);
                $('#totalCnt').text(numberWithCommas(response.advList.length));
                $('#totalCnt2').text(numberWithCommas(response.vmList.length));

                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
                $('#orig_seq2').val(0);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#group-select1').change(changeGroupSelect1=function(organizationSeq){
        var companySeq = $("#company-select1 option:selected").val();
        if(typeof(organizationSeq) === 'object'){
            //alert('group-select1에서 클릭');
            organizationSeq = $("#group-select1 option:selected").val();//$(this).val() //$("#group-select2 option:selected").val();
        }
        var advSeq = $("#adv-select1 option:selected").val();
        var advText = $("#adv-select1 option:selected").text();

        //var organizationSeq = $(this).val() //$("#group-select2 option:selected").val();
        var organizationText = $("#group-select1 option[value='+organizationSeq+']").text();//$("#group-select2 option:selected").val(organizationSeq).text();
        if(organizationSeq==''){
            location.reload();
        }
        /*if(organizationSeq==0){
            alert('여기?');
            changeCompanySelect();
        }*/
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{organizationSeq : organizationSeq,companySeq : companySeq, page : 'adv'},
            datatype: 'JSON',
            success:function(response){
                var html ="";//자판기s
                var html2 ="";//자판기tr
                var html3 ="";//조직
                var html4 ="";
                var html5 ="";//광고
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                    //$("#group-select2").val(0).prop("selected",true);
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";
                html5 +="<option value='0' selected>광고 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) {
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                if(response.advList.length<1){
                    html4 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>등록된 광고가 없습니다.</td></tr>';
                }
                for(var i=0; i<response.advList.length; i++){
                    html4 +='<tr id="'+response.advList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].seq + '</td><td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].advTitle + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + response.advList[i].organizationName + '/' + response.advList[i].advOwner + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + (response.advList[i].advType=='V'?'세로형':'가로형') + '</td></tr>';
                }
                for(var i=0; i<response.advInfo.length; i++){
                    html5 +="<option value='"+response.advInfo[i].seq+"'>[" + response.advInfo[i].seq + "]&nbsp;"+response.advInfo[i].advTitle+"</option>";
                }
                for(var i=0; i<response.vmList.length; i++){
                    html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    html2 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');">' + response.vmList[i].vmId + '</td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].place + '</td>';
                }
                //$("#group-select2").val(response[0].organizationSeq).prop("selected",true);
                $('#group-select1').empty();
                $("#group-select1").append(html3);
                $('#adv-select1').empty();
                $("#adv-select1").append(html5);
                $('#group-select2').empty();
                $("#group-select2").append(html3);
                $('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                $('#group-select1').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select1-container').text(organizationText);
                $('#group-select2').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select2-container').text(organizationText);
                //$('#adv-select1').val(advSeq).attr('selected',"selected");
                //$('#select2-adv-select1-container').text(advText);
                $('#orig_seq2').val(organizationSeq);
                $('#vm-select2').empty();
                $("#vm-select2").append(html);
                $('#Dash_Table_Body1').html(html4);
                $('#Dash_Table_Body2').html(html2);
                $('#totalCnt').text(numberWithCommas(response.advList.length));
                $('#totalCnt2').text(numberWithCommas(response.vmList.length));
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#group-select2').change(changeGroupSelect2=function(){
        changeGroupSelect1($(this).val());
    });
    $('#vm-select2').change(changeVMSelect2=function(){
        // 자판기선택> 소속지정, 조직지정, 버전은 그대로
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var vmSeq = $("#vm-select2 option:selected").val();
        var vmText = $("#vm-select2 option:selected").text();
        var advSeq = $("#adv-select1 option:selected").val();
        var advText = $("#adv-select1 option:selected").text();

        if(vmSeq==''){
            location.reload();
        }
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{companySeq : companySeq,
                organizationSeq : organizationSeq,
                vmSeq : vmSeq, page : 'adv'},
            datatype: 'JSON',
            success:function(response){
                var html ="";//자판기s
                var html2 ="";//자판기tr
                var html3 ="";//조직s
                var html4 ="";//xxxx
                var html5 ="";//광고s
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                    //$("#group-select2").val(0).prop("selected",true);
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";
                html5 +="<option value='0' selected>광고 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) {
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                if(response.advList.length<1){
                    html4 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>등록된 광고가 없습니다.</td></tr>';
                }
                for(var i=0; i<response.advList.length; i++){
                    html4 +='<tr id="'+response.advList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].seq + '</td><td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].advTitle + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + response.advList[i].organizationName + '/' + response.advList[i].advOwner + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + (response.advList[i].advType=='V'?'세로형':'가로형') + '</td></tr>';
                }
                for(var i=0; i<response.advInfo.length; i++){
                    html5 +="<option value='"+response.advInfo[i].seq+"'>"+response.advInfo[i].advTitle+"</option>";
                }

                for(var i=0; i<response.vmList.length; i++){
                    //html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    html2 +='<tr id="'+response.vmList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');">' + response.vmList[i].vmId + '</td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 +='<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].place + '</td>';
                }
                for(var i=0; i<response.vmInfo.length; i++){
                    html +="<option value='"+response.vmInfo[i].seq+"'>"+response.vmInfo[i].place+"("+response.vmInfo[i].vmId+")</option>";
                }
                //$("#group-select2").val(response[0].organizationSeq).prop("selected",true);
                $('#group-select1').empty();
                $("#group-select1").append(html3);
                $('#adv-select1').empty();
                $("#adv-select1").append(html5);
                $('#group-select2').empty();
                $("#group-select2").append(html3);
                $('#vm-select2').empty();
                $("#vm-select2").append(html);
                $('#company-select1').val(response.vmInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.vmInfo[0].companyName);
                $('#group-select1').val(response.vmInfo[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select1-container').text(response.vmInfo[0].organizationName);
                $('#group-select2').val(response.vmInfo[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select2-container').text(response.vmInfo[0].organizationName);
                $('#vm-select2').val(vmSeq).attr('selected',"selected");
                $('#select2-vm-select2-container').text(vmText);
                //$('#adv-select1').val(advSeq).attr('selected',"selected");
                //$('#select2-adv-select1-container').text(advText);

                $('#Dash_Table_Body1').html(html4);
                $('#Dash_Table_Body2').html(html2);
                $('#totalCnt').text(numberWithCommas(response.advList.length));
                $('#totalCnt2').text(numberWithCommas(response.vmList.length));
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            },
            complete: function () {
                FunLoadingBarEnd();
            }
        });
    });
    $('#adv-select1').change(changeAdvSelect1=function(){
        // 자판기선택> 소속지정, 조직지정, 버전은 그대로
        var companySeq = $("#company-select1 option:selected").val();
        var organizationSeq = $("#group-select1 option:selected").val();
        var advSeq = $("#adv-select1 option:selected").val();
        var advText = $("#adv-select1 option:selected").val();

        if(advSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/selectVMList2.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                advSeq : advSeq,
                organizationSeq : organizationSeq,
                page : 'adv'},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                var html4 ="";
                var html5 ="";
                var html6 ="";
                if(response.vmList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>자판기가 존재하지 않습니다.</td></tr>';
                    //$("#group-select2").val(0).prop("selected",true);
                }
                html +="<option value='0' selected>자판기 전체</option>";
                html3 +="<option value='0' selected>조직 전체</option>";
                html6 +="<option value='0' selected>광고 전체</option>";

                for(var i=0; i<response.orgInfo.length; i++) {
                    html3 += "<option value='" + response.orgInfo[i].organizationSeq + "'>" + response.orgInfo[i].organizationName + "</option>";
                }
                if(response.advList.length<1){
                    html4 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>등록된 광고가 없습니다.</td></tr>';
                }
                for(var i=0; i<response.advList.length; i++){
                    //html5 +="<option value='"+response.advList[i].seq+"'>"+response.advList[i].advTitle+"</option>";
                    html4 +='<tr id="'+response.advList[i].seq+'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].seq + '</td><td onclick="detailAdvModal('+response.advList[i].seq+');">' + response.advList[i].advTitle + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + response.advList[i].organizationName + '/' + response.advList[i].advOwner + '</td>';
                    html4 +='<td onclick="detailAdvModal('+response.advList[i].seq+');" class="">' + (response.advList[i].advType=='V'?'세로형':'가로형') + '</td></tr>';
                }
                for(var i=0; i<response.advInfo.length; i++){
                    html6 +="<option value='"+response.advInfo[i].seq+"'>[" + response.advInfo[i].seq + "]&nbsp;"+response.advInfo[i].advTitle+"</option>";
                }

                for(var i=0; i<response.vmList.length; i++){
                    html +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].place+"("+response.vmList[i].vmId+")</option>";
                    html2 += '<tr id="' + response.vmList[i].seq + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');">' + response.vmList[i].vmId + '</td>';
                    html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].companyName + '/' + response.vmList[i].organizationName + '</td>';
                    html2 += '<td onclick="detailVMModal('+response.vmList[i].seq+');" class="">' + response.vmList[i].place + '</td>';

                }

                $('#group-select1').empty();
                $("#group-select1").append(html3);
                $('#adv-select1').empty();
                $("#adv-select1").append(html6);
                $('#group-select2').empty();
                $("#group-select2").append(html3);
                $('#vm-select2').empty();
                $("#vm-select2").append(html);
                $('#adv-select1').val(advSeq).attr('selected',"selected");
                $('#select2-adv-select1-container').text(advText);
                $('#company-select1').val(response.orgInfo[0].companySeq).attr('selected',"selected");
                $('#select2-company-select1-container').text(response.orgInfo[0].companyName);
                $('#group-select1').val(response.advList[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select1-container').text(response.advList[0].organizationName);
                $('#group-select2').val(response.advList[0].organizationSeq).attr('selected',"selected");
                $('#select2-group-select2-container').text(response.advList[0].organizationName);
                $('#Dash_Table_Body1').html(html4);
                $('#Dash_Table_Body2').html(html2);
                $('#totalCnt').text(numberWithCommas(response.advList.length));
                $('#totalCnt2').text(numberWithCommas(response.vmList.length));
                $('#orig_seq2').val(response.advList[0].organizationSeq);

                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $('.allSelect2').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#company-select3').change(changeCompanySelect3=function(){
        var companySeq = $("#company-select3 option:selected").val();
        if(companySeq==''){
            alert('소속을 선택해주세요');
            return false;
        }
        $.ajax({
            url:'${root}/company/ajax/selectCompany.do',
            type : 'POST',
            data:{companySeq:companySeq},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                //html +="<option value=''>조직 선택</option>";
                for(var i=0; i<response.origList.length; i++){
                    html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                }
                $('#multipleSelect').empty();
                $("#multipleSelect").append(html);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#vm-select4').change(changeVMSelect4=function(){
        var vmSeq = $("#vm-select4 option:selected").val();
        var advSeq = $("#td5_advSeq").val();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/getDetailAdvInfo.do',
            type : 'GET',
            data:{ advSeq : advSeq, vmSeq : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html =""; //tr4
                if(response.advVMList.length <1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>둥록된 자판기가 존재하지 않습니다</td></tr>';
                }
                for(var i=0; i<response.advVMList.length; i++){
                    html +='<tr id="'+ response.advVMList[i].seq +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td style="pointer-events: none;">'+response.advVMList[i].vmId+'</td><td class="t_left" style="pointer-events: none;">'+response.advVMList[i].companyName+'/'+response.advVMList[i].organizationName+'</td><td class="t_left"style="pointer-events: none;">'+response.advVMList[i].place+'</td><td style="pointer-events: none;">가동중</td></tr>';
                }
                $('#Dash_Table_Body4').html(html);
                $('input').ezMark();
                $('.allSelect4').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
    $('#adv-select5').change(changeAdvSelect5=function(){
        var advSeq = $("#adv-select5 option:selected").val();
        var vmSeq = $("#td4_vmSeq").val();
        if(vmSeq==''){
            location.reload();
        }
        $.ajax({
            url:'${root}/company/ajax/getAdvDetailVM.do',
            type : 'POST',
            data:{ advSeq : advSeq, vmSeq2 : vmSeq},
            datatype: 'JSON',
            success:function(response){
                var html3 =""; //tr4
                for(var i=0; i<response.advList.length; i++){
                    html3 +='<tr id="'+ response.advList[i].advSeq +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.advList[i].advSeq+'</td><td class="t_left" style="pointer-events: none;">'+response.advList[i].advTitle+'</td><td class="t_left" style="pointer-events: none;">'+response.advList[i].organizationName+'/'+response.advList[i].advOwner+'</td><td class=""style="pointer-events: none;">'+(response.advList[i].advType=='V'?'세로형':'가로형')+'</td>';
                }

                $('#Dash_Table_Body6').html(html3);
                $('input').ezMark();
                $('.allSelect5').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $(".allSelect1").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body1').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body1').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body1').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect2").click(function(){
        $('#Dash_Table_Body2').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body2').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body2').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect4").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body4').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body4').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body4').find("input").prop('checked', allChildrenChecked).change();

    });
    $(".allSelect5").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body6').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body6').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body6').find("input").prop('checked', allChildrenChecked).change();

    });
    window.onload = function(){
        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
        pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));
    }

    //====================================================

    function addAdvModal(){
        $('#modal_pop').stop().fadeIn();
        $('.pop_box').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#company-select3').attr('disabled', false);
        $('#multipleSelect').attr('disabled', false);
        $('#modal_form').each(function() { this.reset();});
        $('#radio_h').attr('checked', true);
        $(":radio[name='adv_type'][value='H']").attr('checked', true);
        $(":radio[name='adv_type'][value='V']").attr('checked', false);
        //$("input[name='adv_type']:checked").val();
        $("#adv_seq").val(0);
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
                    $('#company-select3').empty();
                    $("#company-select3").append(html);
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append('<option value="">선택해주세요</option>');
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
                    $('#company-select3').empty();
                    $("#company-select3").append('<option value="' + $('#company_seq').val() + '" seleted>' + $('#company_name').val() + '</option>');
                    $('#select2-company-select3-container').text($('#company_name').val());
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append(html);
                    if(${sessionScope.loginUser.auth>1}) {
                        //$('#multipleSelect').val($('#orig_seq').val()).attr('selected',"selected");
                        $('#multipleSelect').val($('#orig_seq').val()).change();
                    }
                },
                error: function (xhr, status, error) {console.log(error);}
            });

        }
        $('.pop_title h2').text('광고 신규등록');
    }//완
    function addAdv(){
        var form = new FormData();
        var companySeq = $("#company-select3 option:selected").val();
        //var organizationSeq = $("#multipleSelect option:selected").val();
        var organizationSeq = $("#multipleSelect").val();
        var advTitle = $("#adv_title").val();
        var advOwner = $("#adv_owner").val();
        var advContent = $("#adv_Content").val();
        var advSeq = $("#adv_seq").val();
        var advType = $("input[name='adv_type']:checked").val();

        if(advSeq == 0){
            if(advTitle==''||companySeq==''||organizationSeq.length===0||!($("#adv_file").val())){
                alert("필수값을 모두 채워주세요.");
                return false;
            }
            if(advType==''){
                alert('광고유형을 선택하세요.');
                return false;
            }
        }
        if($("#adv_file").val()!=''){
            if($("#adv_file")[0].files[0].size > 101000000){
                alert("파일크기가 100MB를 초과합니다");
                return false;
            }
        }form.append("upload_advfile", $("#adv_file")[0].files[0]);

        form.append("seq", advSeq);
        form.append("companySeq", companySeq);
        form.append("array_organizationSeq", organizationSeq);
        form.append("advTitle", advTitle);
        form.append("advOwner", advOwner);
        form.append("advContent", advContent);
        form.append("advFile",$(".upload-name").val());
        form.append("advType", advType);
        //form.append("upload_advfile", $("#adv_file")[0].files[0]);
        FunLoadingBarStart();

        // console.log("companySeq == " + companySeq);
        // console.log("organizationSeq == " + organizationSeq);
        // console.log("advTitle == " + advTitle);
        // console.log("advOwner == " + advOwner);
        // console.log("advContent == " + advContent);
        // console.log("advSeq == " + advSeq);
        // console.log("advType == " + advType);
        // console.log("$(#adv_file)[0].files[0] == " + $("#adv_file"));
        // console.log("$(.upload-name).val() == " + $(".upload-name").val());

        $.ajax({
            url:'${root}/company/ajax/insertAdv.do',
            data: form,
            type : 'POST',
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            success:function(response){
                alert(response);
                $('#modal_pop').stop().fadeOut();
                $('.pop_box').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
                $("#company-select1").val(companySeq).trigger("change");


                changeAdvSelect1();
                //location.reload();
                //$('.input01').children('.ez-checkbox').eq(0).attr("class","");
            },
            error: function (xhr, status, error) {
                console.log(error);
            },
            complete: function () {
                FunLoadingBarEnd();
            }
        });
    } //완
    function deleteAdv(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 광고를 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteAdv.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    changeAdvSelect1();
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }//완
    function detailVMModal(vmSeq){
        $('#modal_pop').stop().fadeIn();
        $('.pop_listVm').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('.pop_title h2').text('자판기 상세조회');

        $.ajax({
            url:'${root}/company/ajax/getAdvDetailVM.do',
            type : 'POST',
            data:{ vmSeq2 : vmSeq, },
            datatype: 'JSON',
            success:function(response){
                //var html =""; //tr5(info)
                var html2=""; // adv-select5
                var html3 =""; //tr6

                if(response.advList.length <1){
                    html3 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>둥록된 광고가 존재하지 않습니다</td></tr>';
                }else html2 +='<option value="0">광고 전체</option>';

                for(var i=0; i<response.advList.length; i++){
                    html2 +="<option value='"+response.advList[i].advSeq+"'>[" + response.advList[i].advSeq + "]&nbsp;"+response.advList[i].advTitle+"</option>";
                    html3 +='<tr id="'+ response.advList[i].advSeq +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.advList[i].advSeq+'</td><td class="t_left" style="pointer-events: none;">'+response.advList[i].advTitle+'</td><td class="t_left" style="pointer-events: none;">'+response.advList[i].organizationName+'/'+response.advList[i].advOwner+'</td><td class=""style="pointer-events: none;">'+(response.advList[i].advType=='V'?'세로형':'가로형')+'</td>';
                }

                $("#td3_vmId").text(response.vmInfo.vmId);
                $("#td1_comOrg").text(response.vmInfo.companyName+' / '+response.vmInfo.organizationName);
                $("#td2_place").text(response.vmInfo.place);
                $('#td4_vmSeq').val(response.vmInfo.seq);

                $('#Dash_Table_Body6').html(html3);
                $('#adv-select5').empty();
                $("#adv-select5").append(html2);
                $('input').ezMark();
                $('.allSelect5').find('div').removeClass("ez-checked");
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }
    function detailAdvModal(advSeq){
        $('#modal_pop').stop().fadeIn();
        $('.pop_listAdv').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('.pop_title h2').text('광고 상세조회');

        $.ajax({
            url:'${root}/company/ajax/getDetailAdvInfo.do',
            type : 'GET',
            data:{ advSeq : advSeq},
            datatype: 'JSON',
            success:function(response){
                //var html =""; //tr3(info)
                var html2=""; // vm-select4
                var html3 =""; //tr4

                if(response.advVMList.length <1){
                    html3 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>둥록된 자판기가 존재하지 않습니다</td></tr>';
                }else html2 +='<option value="0">자판기 전체</option>';

                for(var i=0; i<response.advVMList.length; i++){
                    html2 +="<option value='"+response.advVMList[i].seq+"'>"+response.advVMList[i].place+"("+response.advVMList[i].vmId+")</option>";
                    html3 +='<tr id="'+ response.advVMList[i].seq +'"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html3 +='<td style="pointer-events: none;">'+response.advVMList[i].vmId+'</td><td class="t_left" style="pointer-events: none;">'+response.advVMList[i].companyName+'/'+response.advVMList[i].organizationName+'</td><td class="t_left"style="pointer-events: none;">'+response.advVMList[i].place+'</td><td style="pointer-events: none;">가동중</td></tr>';
                }
                $("#td1_advTitle").text(response.advInfo.advTitle);
                var fileName = response.advInfo.advFile;
                fileName = fileName.split('.')[1];
                if(fileName=='jpg'||fileName=='gif'||fileName=='png'||fileName=='jpeg'){
                    $("#td2_advFile").html('<img src="http://devmultivm.ubcn.co.kr/image/product/adv/'+response.advInfo.advFile+'"></img>')
                }else if(fileName=='mp4'||fileName=='avi'||fileName=='mkv'||fileName=='wmv'||fileName=='mov'){
                    $("#td2_advFile").html('<video controls id="adv_video" src="http://devmultivm.ubcn.co.kr/image/product/adv/'+response.advInfo.advFile+'"autoplay loop muted style="max-width:640px; max-height:360px;"></video>')
                    //$("#td2_advFile").html('<video controls id="adv_video" src="${root}/resources/test/'+response.advInfo.advFile+'" autoplay loop muted style="max-width:640px; max-height:360px;"></video>')
                }else
                    $("#td2_advFile").text('미리보기 없음')
               //$("#td2_advFile").text(response.advInfo.advFile);
                $("#td3_advContent").text(response.advInfo.advContent);
                $("#td4_createDate").text(response.advInfo.createDate);
                $("#td5_advSeq").val(response.advInfo.seq);
                $('#Dash_Table_Body4').html(html3);
                $('#vm-select4').empty();
                $("#vm-select4").append(html2);
                if(response.advInfo.advType=='H') {
                    $("#td5_advType").text('가로형');
                }else $("#td5_advType").text('세로형');
                $('input').ezMark();
                $('.allSelect4').find('div').removeClass("ez-checked");

                /*var player = videojs("adv_video", {
                    sources : [
                        { src : "${root}/resources/test/"+response.advInfo.advFile //"http://devmultivm.ubcn.co.kr/image/product/adv/'+response.advInfo.advFile"
                            ,type : "video/mp4"}
                    ],
                    controls : true,
                    playsinline : true,
                    autoplay: 'muted',
                    muted : true,
                    preload : "metadata",
                });*/

                //$("#video_obj").play();

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });


        /*<video src="video/test.mp4" id="video_obj" controls></video>
        document.getElementById("video_obj").play();*/
    }//완
    function modifyAdvModal(){ //체크한거
        $("#adv_file").val('');
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        if(sizeCheck.length == 0||sizeCheck.length > 1){
            alert("수정할 광고 한개만 선택해주세요"); return false;
        }else{
            var advList = [];
            $.each(sizeCheck,function(idex,entry){
                advList.push(entry.closest('tr').id);
            });

            // alert("advList == " + advList);
            $.ajax({
                url:'${root}/company/ajax/getAdvInfo.do',
                type : 'POST',
                data: {advList : advList},
                success:function(response){
                    var html ="";
                    var selectedValue = new Array();
                    if(${sessionScope.loginUser.auth==0}){}
                    for(var i=0; i<response.orgInfo.length; i++){
                        html +="<option value='"+response.orgInfo[i].organizationSeq+"'>"+response.orgInfo[i].organizationName+"</option>";
                    }
                    for(var i=0; i<response.orgList.length; i++) {
                        selectedValue[i] = response.orgList[i].organizationSeq;
                    }
                    //alert(selectedValue);

                    $("#adv_seq").val(response.advInfo.seq);
                    $("#adv_title").val(response.advInfo.advTitle);
                    $("#adv_owner").val(response.advInfo.advOwner);
                    $(".upload-name").val(response.advInfo.originFile);
                    //$("#adv_file").val(response.advInfo.advFile);
                    $("#adv_Content").val(response.advInfo.advContent);
                    $('#company-select3').empty();
                    $("#company-select3").append('<option value="' + response.advInfo.companySeq + '" seleted>' + response.advInfo.companyName + '</option>');
                    $('#select2-company-select3-container').text(response.advInfo.companyName);
                    $('#company-select3').attr('disabled', true);
                    $('#multipleSelect').empty();
                    $("#multipleSelect").append('<option value="' + response.advInfo.organizationSeq + '" seleted>' + response.advInfo.organizationName + '</option>');
                    $('#multipleSelect').val(selectedValue).change();
                    $('#multipleSelect').attr('disabled', true);
                    if(response.advInfo.advType=='H'){
                        $(":radio[name='adv_type'][value='H']").attr('checked', true);
                        $(":radio[name='adv_type'][value='V']").attr('checked', false);
                    }else{
                        $(":radio[name='adv_type'][value='H']").attr('checked', false);
                        $(":radio[name='adv_type'][value='V']").attr('checked', true);
                    }


                    //alert(response);
                    //changeCompanySelect();
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);}
            });

            $('#modal_pop').stop().fadeIn();
            $('.pop_box').stop().fadeIn();
            $('#shadow_bg').stop().fadeIn();
            $('.pop_title h2').text('광고 수정');




        }
    }
    function insertAdvtoVM(){
        if( $('#orig_seq2').val()==0){
            alert('[조직 전체]가 선택된 상태에선 이벤트 추가를 하실 수 없습니다\n조직을 선택하여 활성화 시켜주세요.');
            return false;
        }
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var sizeCheck2 = $('#Dash_Table_Body2 input[type="checkbox"]:checked');
        var advList = [];
        var vmList = [];

        if(sizeCheck2.length ==0){
            alert("자판기를 선택해주세요"); return false;
        }
        else if(sizeCheck.length == 0){
            alert("자판기에 추가할 광고를 선택하세요"); return false;
        }else{
            if(!confirm("선택한 자판기에 광고를 추가하시겠습니까?")) return;
            $.each(sizeCheck,function(idex,entry){
                advList.push(entry.closest('tr').id);
            });
            $.each(sizeCheck2,function(idex,entry){
                vmList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/insertAdvToVM.do',
                type : 'POST',
                data: {advList : advList,
                    vmList : vmList},
                success:function(response){
                    alert(response);
                    changeAdvSelect1();
                    //location.reload();
                    $('.allSelect1').find('div').removeClass("ez-checked");
                    $('.allSelect2').find('div').removeClass("ez-checked");
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }

    }

    function deleteAdvFromVM(){ //자판기상세에서
        var vmSeq = $('#td4_vmSeq').val();
        var sizeCheck = $('#Dash_Table_Body6 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 광고를 선택해주세요");
        }else{
            if(!confirm("선택한 광고를 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedAdvFromVM.do',
                type : 'GET',
                data: {deleteList:deleteList,vmSeq:vmSeq},
                success:function(response){
                    alert(response);
                    /*$('#modal_pop').stop().fadeOut();
                    $('.pop_box3').stop().fadeOut();
                    $('#shadow_bg').stop().fadeOut();*/
                    detailVMModal(vmSeq);
                    //location.reload();
                },
                error: function (xhr, status, error) {console.log(error);},
                complete: function () {FunLoadingBarEnd();}
            });
        }
    }
    function deleteVMFromAdv(){ //광고상세에서
        var advSeq = $('#td5_advSeq').val();
        var sizeCheck = $('#Dash_Table_Body4 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("자판기에서 삭제할 광고를 선택해주세요");
        }else{
            if(!confirm("자판기에 선택한 광고를 삭제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            FunLoadingBarStart();
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedVMFromAdv.do',
                type : 'GET',
                data: {deleteList:deleteList,advSeq:advSeq},
                success:function(response){
                    alert(response);
                    /*$('#modal_pop').stop().fadeOut();
                    $('.pop_box3').stop().fadeOut();
                    $('#shadow_bg').stop().fadeOut();*/
                    detailAdvModal(advSeq);
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
