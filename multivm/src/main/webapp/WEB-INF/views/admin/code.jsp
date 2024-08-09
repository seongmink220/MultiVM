
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
    <title>조직관리</title>
</head>
<style>
    /*td.com_td {
        border-right: 1px solid #d8d8d8;
    }*/
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_md_m_vm-code').addClass("current");
        $('#lnb_admin2').addClass("on");
        $('#lnb_admin2').children('ul').show();
        $('#mn_md_vm-code').addClass("current");
        $('#lnb_m_admin2').addClass("on");
        $('#lnb_m_admin2').next('ul').css('display','block');
        $('.subtit').text("코드 관리");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        searchCode()
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            코드 관리
        </header>
        <div id="shadow_bg" style="display:none ;"></div>
        <div id="modal_pop" style="display:none ;">
            <div class="pop_box">
                <div class="pop_title">
                    <h2 id="pop_title_m">추가</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form" name="modal_form" onsubmit="return false">
                        <fieldset>
                            <legend>정보입력</legend>
                            <ul class="form_group input_width" style="display: none;">
                                <li>
                                    <label for="type">코드타입</label>
                                    <select name="type" id="type" data-placeholder="선택해주세요" style="width: 100%;">
                                        <option value="issue">이슈</option>
                                        <option value="error" selected>에러</option>
                                    </select>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="vmModel">자판기모델<span>*</span></label>
                                    <select name="vmModel" id="vmModel" data-placeholder="선택해주세요" style="width: 100%;">
                                        <option value="1">10N(멀티1)</option>
                                        <option value="3" selected>10C(멀티3)</option>
                                    </select>
                                </li>
                            </ul>
                            <ul class="form_group input_width2">
                                <li>
                                    <label for="code" class="form_title">코드 <span>*</span></label>
                                    <input type="text" name="code" id="code" onchange="$('#isIdCheck').val(0);" placeholder="최대 10자리 영문숫자코드" oninput="this.value = this.value.replace(/[^A-Za-z0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength="10">
                                    <a href="javascript:void(0)" class="button btn_delete" onclick="idCheck();">중복확인</a>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="info">코드 설명</label>
                                    <textarea cols="50" rows="3" id="info" name="info" placeholder="최대 100자 입력가능" maxlength="100"></textarea>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="solution">조치 방법</label>
                                    <textarea cols="50" rows="3" id="solution" name="solution" placeholder="최대 200자 입력가능" maxlength="200"></textarea>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="url">부가 정보(url)</label>
                                    <textarea cols="50" rows="3" id="url" name="url" placeholder="최대 128자 입력가능" maxlength="128"></textarea>
                                </li>
                            </ul>
                            <input type="hidden" id="isIdCheck">
                            <input type="hidden" id="seq">
                            <input type="hidden" id="org_code">
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
                    <label for="model-select">자판기모델</label>
                    <select name="company" id="model-select" style="width: 100%;">
                        <option value="all" selected>전체</option>
                        <option value="1">10N(멀티1)</option>
                        <option value="3">10C(멀티3)</option>
                    </select>
                </li>
                <li class="mar02">
                    <label for="search-type">검색조건 선택</label>
                    <select name="organization" id="search-type" style="width: 100%;">
                        <option value="code" selected>코드</option>
                        <option value="info">코드 정보</option>
                    </select>
                </li>
                <li class="input-size01">
                    <label for="search-value"></label>
                    <input type="text" id="search-value" placeholder="검색어를 입력해주세요" onkeydown="if(event.keyCode == 13) searchCode();">
                </li>
                <li class="label_none2"><label for=""></label><a href="javascript:void(0)" class="button3 button_position2" onclick="searchCode();">조회</a></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="sub_tit">
                    <ul>
                        <li class=""><p>검색 결과 : <span id="totCnt" style="font-weight: bold;color: #0075fe;"></span>건</p></li>
                        <li>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="addDataModal()">추가</a>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="editClick();">수정</a>
                        </li>
                    </ul>
                </div>
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="20%">
                        <col width="15%">
                        <col width="*%">
                        <col width="22%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                        <th>자판기모델</th>
                        <th>코드</th>
                        <th>코드정보</th>
                        <th>등록일시</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                               <%-- <c:if test="${codeList==null||empty codeList}">
                                    <tr style="pointer-events: none;">
                                        <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td>&ensp;&emsp;</td><td colspan=4>코드가 존재하지 않습니다.</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="codeList" items="${codeList}">
                                    <tr id="${codeList.seq}" onclick="editDataModal(${codeList.seq})">
                                        <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td class="com_td">${codeList.vmModel}</td>
                                        <td>${codeList.code}</td><td class="t_left">${codeList.info}</td><td>${codeList.regDate}</td>
                                    </tr>
                                </c:forEach>--%>
                    </tbody>
                </table>
                <div class="pagination" id="pagination_ys">
                </div>
                <input type="hidden" id="nowpage" value="1">
            </div>
        </section>
    </section>
</div>
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>--%>

<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">
    $('#model-select').select2();
    //$('#search-type').select2();
    //$('#type').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });
    
    function searchCode(){
        var vmModel = $("#model-select option:selected").val();
        var searchType = $("#search-type option:selected").val();//전체면 0
        var searchValue = $("#search-value").val();

        $.ajax({
            url:'${root}/admin/ajax/getSearchCodeList.do',
            type : 'GET',
            data : {vmModel : vmModel, type : 'error'
                , code : searchType=='code'?searchValue:'', info :searchType=='info'?searchValue:''},
            success:function(response){
                var html ="";

                if(response.length <1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=5>코드가 존재하지 않습니다.</td></tr>';
                }

                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].seq + '"onclick="editDataModal('+response[i].seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    if(response[i].vmModel == '1'){
                        html +='<td class="com_td">10N(멀티1)</td>';
                    }else if(response[i].vmModel == '3'){
                        html +='<td class="com_td">10C(멀티3)</td>';
                    }else{
                        html +='<td class="com_td">' + response[i].vmModel + '</td>';
                    }
                    html +='<td>' + response[i].code + '</td>';
                    html +='<td class="t_left">' + response[i].info + '</td>';
                    html +='<td>' + response[i].regDate + '</td></tr>';
                }
                $('#Dash_Table_Body1').html(html);
                $('#totCnt').text(response.length);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys",$('#nowpage'));
            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }

    function addDataModal(){
        $("#pop_title_m").text("코드 추가");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        $("#seq").val(0);
        $("#isIdCheck").val(0);
        $("#org_code").val('');
    }

    function idCheck(){
        //중복코드체크
        var seq = $("#seq").val();
        var id = $("#code").val();
        var vmModel = $("#vmModel option:selected").val();
        var type = $("#type option:selected").val();
        var orgCode = $("#org_code").val();
        if(id==''){
            alert('코드를 입력하세요.');
            return false;
        }
        $.ajax({
            url:'${root}/admin/ajax/chkDupCode.do',
            type : 'GET',
            data : {code : id, seq : seq, vmModel : vmModel, type : type},
            success:function(response){
                if(response == 0){
                    $("#isIdCheck").val(1);
                    alert(seq!=0 && orgCode!='' &&orgCode==id ?'이전과 동일한 코드입니다.':'사용가능한 코드입니다.')
                }
                else $("#isIdCheck").val(0);
            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }

    function editDataModal(seq){
        $.ajax({
            url:'${root}/admin/ajax/getSearchCodeList.do?seq='+seq,
            type : 'GET',
            datatype: 'JSON',
            success:function(response){
                console.log(response)
                $("#type").val('error');
                $("#vmModel").val(response[0].vmModel);
                $("#seq").val(response[0].seq);
                $("#code").val(response[0].code);
                $("#info").val(response[0].info);
                $("#solution").val(response[0].solution);
                $("#url").val(response[0].url);
                $("#regDate").val(response[0].regDate);
                $("#isIdCheck").val(1);
                $("#org_code").val(response[0].code);

            },
            error: function (xhr, status, error) {console.log(error);}
        });

        $("#pop_title_m").text("코드 수정");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
    }

    function addData(){
        var seq = $("#seq").val()
        //var params = $("#modal_form").serialize();
        var params = new URLSearchParams($("#modal_form").serialize());
        params.append('seq', seq);
        params = params.toString();
        var url = '';

        if($("#code").val() == ''){
            alert("코드를 입력하세요.");
            $("#code").focus();
            return false;
        }
        if( $("#isIdCheck").val()!=1){
            alert('코드 중복확인을 해주세요.')
            return false;
        }

        if(seq == '0'){
            url = '${root}/admin/ajax/insertCode.do'
        }else{
            url = '${root}/admin/ajax/modifyCode.do'
        }
        $.ajax({
            url: url,
            type : 'POST',
            data : params,
            success:function(response){
                console.log(response)
                if(response == '1'){
                    alert('성공적으로 완료되었습니다.')
                    searchCode();
                    $('#modal_pop').stop().fadeOut();
                    $('#shadow_bg').stop().fadeOut();
                }else{
                    alert('에러발생');
                }
            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }



    $(".allSelect1").click(function(){
        //$(this).toggleClass('ez-checkbox');
        $('#Dash_Table_Body1').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body1').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body1').find("input").prop('checked', allChildrenChecked).change();

    });


</script>
</body>
</html>
