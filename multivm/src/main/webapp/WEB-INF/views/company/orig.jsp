
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
        $('#mn_mf_orig').addClass("current");
        $('#lnb_company').addClass("on");
        $('#lnb_company').children('ul').show();
        $('#mn_mf_m_orig').addClass("current");
        $('#lnb_m_company').addClass("on");
        $('#lnb_m_company').next('ul').css('display','block');
        $('.subtit').text("조직관리");

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            조직관리
        </header>
        <div id="shadow_bg" style="display:none ;"></div>
        <div id="modal_pop" style="display:none ;">
            <div class="pop_box">
                <div class="pop_title">
                    <h2 id="pop_title_m">추가</h2>
                    <span><a href="javascript:void(0)"><img src="${root}/resources/images/ic_close.png" alt="닫기" onclick="$('#modal_pop').stop().fadeOut();$('#shadow_bg').stop().fadeOut();"></a></span>
                </div>
                <div class="pop_contbox">
                    <form method="post" id="modal_form" onsubmit="return false">
                        <fieldset>
                            <legend>조직입력</legend>
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
                                    <label for="org_name" class="form_title">조직명 <span>*</span></label>
                                    <input type="text" id="org_name" placeholder="입력해주세요" maxlength="20" onkeydown="if(event.keyCode == 13) addData();">
                                </li>
                            </ul>
                            <input type="hidden" id="org_seq" value="">
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
                        <option value="0" selected>전체</option>
                        <c:forEach var="orgList" items="${orgList}">
                            <option value="${orgList.seq}">${orgList.name}</option>
                        </c:forEach>
                    </select>
                </li>
                <li></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <div class="sub_tit">
                    <ul>
                        <li class=""><p>검색 결과 : <span id="totCnt" style="font-weight: bold;color: #0075fe;"><c:out value="${totCnt}"></c:out></span>건</p></li>
                        <li>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="deleteData()"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="addDataModal()">추가</a>
                            <a href="javascript:void(0)" class="button btn_delete" onclick="editClick();">수정</a>
                        </li>
                    </ul>
                </div>
                <table class="tb_horizen">
                    <colgroup>
                        <col width="5%">
                        <col width="*%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                        <th <c:if test="${sessionScope.loginUser.auth!=0}"> style="display: none;"</c:if>>소속명</th>
                        <th>조직명</th>
                        <th>등록일시</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                                <c:if test="${orgList==null||empty orgList}">
                                    <tr style="pointer-events: none;">
                                        <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td>&ensp;&emsp;</td><td colspan=3>조직이 존재하지 않습니다.</td>
                                    </tr>
                                </c:if>
                                <c:forEach var="orgList" items="${orgList}">
                                    <tr id="${orgList.seq}" onclick="editDataModal(${orgList.seq})">
                                        <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                        <td class="com_td"<c:if test="${sessionScope.loginUser.auth!=0}"> style="display: none;"</c:if>>${orgList.companyName}</td>
                                        <td>${orgList.name}</td><td>${orgList.createDate}</td>
                                    </tr>
                                </c:forEach>

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
    $('#company-select').select2();
    $('#group-select').select2();
    $('#mag_company').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });


    $('#company-select').change(companyChangeFunc=function(){
        var html ="";
        var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            $('#group-select').empty();
            //$('#Dash_Table_Body1').children().remove();
            html +='<tr style="pointer-events: none;"><td colspan=3>소속/조직을 선택해주세요.</td></tr>';
            $('#Dash_Table_Body1').html(html);
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
                if(response.origList.length<1){
                    html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>조직이 존재하지 않습니다.</td></tr>';
                }
                else {
                    html += "<option value='0' selected>전체</option>";
                    for (var i = 0; i < response.origList.length; i++) {
                        html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                        html2 +='<tr id="' + response.origList[i].seq + '"onclick="editDataModal('+response.origList[i].seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html2 +='<td class="com_td" <c:if test="${sessionScope.loginUser.auth!=0}"> style="display: none;"</c:if>>' + response.origList[i].companyName + '</td>';
                        html2 +='<td>' + response.origList[i].name + '</td><td>' + response.origList[i].createDate + '</td>';
                    }
                }
                $('#group-select').empty();
                $("#group-select").append(html);
                $("#Dash_Table_Body1").html(html2);
                $('#totCnt').text(response.origList.length);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#group-select').change(groupChangeFunc=function(){
        var html ="";
        var companySeq = $("#company-select option:selected").val();
        var companyName = $("#company-select option:selected").text();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationText = $("#group-select option:selected").text();

        if(organizationSeq==''){
            //html +='<tr style="pointer-events: none;"><td>소속/조직을 선택해주세요.</td></tr>';
            //$('#Dash_Table_Body1').html(html);
            //return false;
            organizationSeq=0;
        }
        $.ajax({
            url:'${root}/company/ajax/getSelectorOrg.do',
            type : 'POST',
            data:{
                companySeq : companySeq,
                organizationSeq2 : organizationSeq
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                /*if(response.length<0){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td>조직이 존재하지 않습니다.</td></tr>';
                }*/
                html2 +='<option value="0">전체</option>';
                for(var i=0; i<response.length; i++){
                    //html +='<tr id="' + response[i].seq + '"onclick="editDataModal('+response[i].seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    //html +='<td>' + response[i].name + '</td>';
                    html2 += "<option value='" + response[i].seq + "'>" + response[i].name + "</option>";
                }
                if(organizationSeq==0){
                    for(var i=0; i<response.length; i++){
                        html +='<tr id="' + response[i].seq + '"onclick="editDataModal('+response[i].seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html +='<td <c:if test="${sessionScope.loginUser.auth!=0}"> style="display: none;"</c:if>>' + response[i].companyName + '</td>';
                        html +='<td>' + response[i].name + '</td><td>' + response[i].createDate + '</td>';
                    }
                    $('#totCnt').text(response.length);
                }else{
                    html +='<tr id="' + organizationSeq + '"onclick="editDataModal('+organizationSeq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td <c:if test="${sessionScope.loginUser.auth!=0}"> style="display: none;"</c:if>>' + response[0].companyName + '</td>';
                    html +='<td>' + organizationText + '</td><td>' + response[0].createDate + '</td>';
                    $('#totCnt').text('1');
                }

                $('#company-select').val(response[0].companySeq).attr('selected',"selected");
                $('#select2-company-select-container').text(response[0].companyName);
                $('#group-select').empty();
                $("#group-select").append(html2);
                $('#group-select').val(organizationSeq).attr('selected',"selected");
                $('#select2-group-select-container').text(organizationText);
                $("#Dash_Table_Body1").html(html);
                $('input').ezMark();
                $('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));

            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });


    function addDataModal(){
        $("#pop_title_m").text("조직 추가");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();
        $('#modal_form').each(function() { this.reset();});
        $("#org_seq").val(0);

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
                    $("#mag_company").val('').change();
                },
                error: function (xhr, status, error) {console.log(error);}
            });
        }

    }
    function editDataModal(orgSeq){
        $("#pop_title_m").text("조직 수정");
        $('#modal_pop').stop().fadeIn();
        $('#shadow_bg').stop().fadeIn();

        $.ajax({
            url:'${root}/company/ajax/selectOrgInfo.do?organizationSeq='+orgSeq,
            type : 'GET',
            datatype: 'JSON',
            success:function(response){
                $('#mag_company').empty();
                $("#mag_company").append('<option value="' + response.companySeq + '" seleted>' + response.companyName + '</option>');
                $("#mag_company").val(response.companySeq).change();
                $("#org_name").val(response.name);
                $("#org_seq").val(response.seq);

            },
            error: function (xhr, status, error) {console.log(error);}
        });
    }

    function addData(){
        var companySeq = $("#mag_company option:selected").val();
        var organizationName = $("#org_name").val()
        var organizationSeq = $("#org_seq").val();

        var params = $("#modal_form").serialize();
        if(organizationName==''){
            alert("값을 입력하세요.");
            return false;
        }
        if(companySeq==''){
            alert('소속을 선택하세요.');
            return false;
        }
        var data = {
            companySeq : companySeq,
            seq : organizationSeq,
            name : organizationName};
        //alert(JSON.stringify(data)); //return false;
        $.ajax({
            url:'${root}/company/ajax/insModOrgInfo.do',
            data: data,
            type : 'POST',
            success:function(response){
                alert(response);
                if(response.includes('중복')){
                    return false;
                }
                //location.reload();
                companyChangeFunc();
                $('#modal_pop').stop().fadeOut();
                $('#shadow_bg').stop().fadeOut();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });

    }

    function deleteData(){
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var deleteList = [];
        if(sizeCheck.length == 0){
            alert("삭제할 조직을 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까?\n※ 등록된 자판기와 상품정보는 모두 삭제되며 복구할 수 없습니다. 지정된 조직관리자도 모두 삭제됩니다."))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            $.ajax({
                url:'${root}/company/ajax/deleteSelectedOrg.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    companyChangeFunc();
                    //location.reload();

                },
                error: function (xhr, status, error) {console.log(error);}
            });
        }
    }



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
