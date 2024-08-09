<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-08
  Time: 오후 3:21
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
    <title>상품 마스터 복제</title>

</head>
<style>
    .tb_horizen {margin-bottom: 20px;min-width: 100%;}
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mg_copy').addClass("current");
        $('#lnb_product').addClass("on");
        $('#mn_mg_m_copy').addClass("current");
        $('#lnb_m_product').addClass("on");
        $('#lnb_m_product').next('ul').css('display','block');
        $('#lnb_product').children('ul').show();
        $('.subtit').text("상품 마스터 복제");
        //$(".depth-1").not('#lnb_product').removeClass("on");
        //$(".depth-1").not('#lnb_product').children('ul').hide();

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/
    });
</script>
<body>

<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            상품 마스터 복제
        </header>

        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar">
            <ul>
                <li class="mar02">
                    <label for="company-select">소속</label>
                    <select name="company" id="company-select" style="width: 100%;">
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
            </ul>
        </div>

        <section id="body_contents" class="table_copy_outline">
            <div class="table_copy table_copy2">
                <div class="item table_outline_a">
                    <div class="table_selectbox">
                        <ul>
                            <li>
                                <label for="group-select">조직</label>
                                <select name="organization" id="group-select" style="width: 100%;">
                                <c:choose>
                                    <c:when test="${sessionScope.loginUser.auth==0}">
                                        <option value="">소속을 선택해주세요</option>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="defaultOrig" items="${defaultOrig}" varStatus="status">
                                            <c:choose>
                                                <c:when test="${selectOrgSeq eq defaultOrig.seq}">
                                                    <option value="${defaultOrig.seq}" selected>${defaultOrig.name}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${defaultOrig.seq}">${defaultOrig.name}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                                </select>
                            </li>
                            <li class="button_position"><a href="javascript:void(0)" class="button" onclick="deleteData(1);"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                                <a href="javascript:void(0)" class="button" onclick="copyData();"><img src="${root}/resources/images/ic_copy.png">조직복제</a></li>
                        </ul>
                    </div>
                    <div class="table_selectbox2_2">
                        <ul>
                            <li class="">
                                <input type="text" id="product_search" maxlength="20" onkeydown="if(event.keyCode == 13) searchProduct();" placeholder="검색어 입력">
                                <a href="javascript:void(0)" class="button3 " onclick="searchProduct();">검색</a>
                            </li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="20%">
                                <col width="*">
                                <col width="15%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2  allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                                <th>상품코드</th>
                                <th>상품명</th>
                                <th>가격</th>
                            </tr>
                            </thead>
                            <tbody id="Dash_Table_Body1">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser.auth==0}">
                                    <tr style="pointer-events: none;">
                                        <td>&ensp;&emsp;</td><td colspan=3>소속/조직을 선택해주세요.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${empty defaultOrigProductList}">
                                        <tr style="pointer-events: none;">
                                            <td colspan=4>상품이 존재하지 않습니다.</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="defaultOrigProductList" items="${defaultOrigProductList}">
                                        <tr id="${defaultOrigProductList.productSeq}">
                                            <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                            <td>${defaultOrigProductList.productCode}</td>
                                            <td class="t_left">${defaultOrigProductList.productName}</td>
                                            <td class="t_right">${defaultOrigProductList.productPrice}</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                        </div><div class="pagination" id="pagination_ys">
                    </div><input type="hidden" id="nowpage" value="1">
                    </div>
                </div>
                <div class="item copy_arrow"></div>
                <div class="item table_outline_a">
                    <div class="table_selectbox">
                        <ul>
                            <li>
                                <label for="my-group-select">조직</label>
                                <select name="my-organization" id="my-group-select" style="width: 100%;">
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
                            <li class="button_position"><a href="javascript:void(0)" class="button" onclick="deleteData(2);"><img src="${root}/resources/images/ic_delete.png">삭제</a></li>
                        </ul>
                    </div>
                    <div class="table_box">
                        <div class="table_responsive">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="20%">
                                <col width="*">
                                <col width="15%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2 allSelect2"><input type="checkbox" class="ez-hide"></div></th>
                                <th>상품코드</th>
                                <th>상품명</th>
                                <th>가격</th>
                            </tr>
                            </thead>
                            <tbody id="Dash_Table_Body2">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser.auth==0}">
                                    <tr style="pointer-events: none;">
                                        <td>&ensp;&emsp;</td><td colspan=3>소속/조직을 선택해주세요.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${empty productList}">
                                        <tr style="pointer-events: none;">
                                            <td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="productList" items="${productList}">
                                        <tr id="${productList.productSeq}">
                                            <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                            <td>${productList.productCode}</td>
                                            <td class="t_left">${productList.productName}</td>
                                            <td class="t_right">${productList.productPrice}</td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table></div>
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
    $('#company-select').select2();
    $('#group-select').select2({
        placeholder: "선택해주세요"
    });
    $('#my-group-select').select2({
        placeholder: "선택해주세요"
    });

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });


    $('#company-select').change(changeCompanySelect=function(){
        if($(this).val()==''){
            var html ="";
            html +='<tr  style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>소속을 선택하세요.</td></tr>';
            $('#group-select').empty();
            $('#Dash_Table_Body1').html(html);
            $('#my-group-select').empty();
            $('#Dash_Table_Body2').html(html);
            return false;
        }
        //alert($(this).val());
        $.ajax({
            url:'${root}/product/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+$(this).val(),
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                html +="<option value=''>선택하세요</option>";
                html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>조직을 선택하세요.</td></tr>';
                html3 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>복제받을 조직을 선택하세요.</td></tr>';
                for(var i=0; i<response.length; i++){
                    html +="<option value='"+response[i].seq+"'>"+response[i].name+"</option>";
                }

                $('#group-select').empty();
                $("#group-select").append(html);
                $('#my-group-select').empty();
                $("#my-group-select").append(html);
                $("#product_search").val("");
                $('#Dash_Table_Body1').html(html2);
                $('#Dash_Table_Body2').html(html3);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

//////////////////////////////
    $('#group-select').change(changeCompanySelect1=function(){
        $("#product_search").val("");
        searchProduct();
    });

    $('#my-group-select').change(changeCompanySelect2=function(){

        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#my-group-select option:selected").val();
        var useYN = 'Y';

        if(organizationSeq==''){
            $('#Dash_Table_Body2').children().remove();
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/selectProductList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                useYN : useYN
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length<1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].productSeq + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].productCode + '</td>';
                    html +='<td class="t_left">' + response[i].productName + '</td>';
                    html +='<td class="t_right">' + response[i].productPrice + '</td></tr>';

                }
                $('#Dash_Table_Body2').children().remove();
                $("#Dash_Table_Body2").html(html);
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



    function deleteData(id){

        var sizeCheck;

        if(id==1){
            sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        }else sizeCheck = $('#Dash_Table_Body2 input[type="checkbox"]:checked');
        var deleteList = [];
        //alert(sizeCheck.length +"  //  "+$('#Dash_Table_Body1 input[type="checkbox"]:checked').closest('tr').id); return;
        if(sizeCheck.length == 0){
            alert("삭제할 상품을 선택하세요");
        }else{
            if(!confirm("정말 삭제하시겠습니까? "))	return;
            $.each(sizeCheck,function(idex,entry){
                deleteList.push(entry.closest('tr').id);
            });
            $.ajax({
                url:'${root}/product/ajax/deleteSelectedProduct.do',
                type : 'GET',
                data: {deleteList:deleteList},
                success:function(response){
                    alert(response);
                    //window.location.reload();
                    changeCompanySelect1();
                    changeCompanySelect2();
                    //$('input').ezMark();
                    //$('.allSelect2').find('div').removeClass("ez-checked");
                    //$('.allSelect1').find('div').removeClass("ez-checked");


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

    $(".allSelect2").click(function(){
        $('#Dash_Table_Body2').find("input").prop("checked", $(this).find('input').prop('checked')).change();
        var allChildrenChecked = $('#Dash_Table_Body2').find("input").not(':checked').size() == 0;
        $('#Dash_Table_Body2').find("input").prop('checked', allChildrenChecked).change();

    });


    function copyData(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#my-group-select option:selected").val();
        var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
        var copyList = [];
        //alert(sizeCheck.length +"  //  "+companySeq +" /// "+organizationSeq);
        if(organizationSeq == $("#group-select option:selected").val()){
            alert('같은 조직간에 복제는 불가능합니다.');
            return false;
        }
        if(sizeCheck.length == 0){
            alert("추가할 상품을 선택하세요");
            return false;
        }else{
            if(!confirm("정말 복제하시겠습니까?"))	return;
            $.each(sizeCheck,function(idex,entry){
                copyList.push(entry.closest('tr').id);
            });

            var dataParam = {copyList:copyList,
                companySeq : companySeq,
                organizationSeq : organizationSeq};

            FunLoadingBarStart();
            $.ajax({
                url:'${root}/product/ajax/copySelectedProduct.do',
                type : 'GET',
                data: dataParam,
                datatype: 'JSON',
                success:function(response){
                    if(response.message.includes('중복')){
                        if(confirm('중복된 상품코드가 존재합니다.\n선택한 상품으로 덮어쓰시겠습니까?\n(* \'취소\'시 중복아닌 상품만 추가됩니다)')){
                            dataParam.type = 'cover'
                            confirm_copyData(dataParam);
                        } else confirm_copyData(dataParam);
                    }
                    else alert(response.message);
                    changeCompanySelect2();
                    //window.location.reload();
                    $("#pagination_ys2").empty();
                    pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2",$('#nowpage2'));
                }, error: function (xhr, status, error) {console.log(error);
                }, complete: function () {FunLoadingBarEnd();}
            });
        }
    }

    function confirm_copyData(dataParam){
        console.log(" confirm_copyData _ dataParam: "+JSON.stringify(dataParam));
        FunLoadingBarStart();
        $.ajax({
            url:'${root}/product/ajax/updateDupProduct.do',
            type : 'POST',
            data: dataParam,
            datatype: 'JSON',
            success:function(response){
                alert(response);
                changeCompanySelect2();
                //window.location.reload();
                $("#pagination_ys2").empty();
                pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2",$('#nowpage2'));
            }, error: function (xhr, status, error) {console.log(error);}
            , complete: function () {FunLoadingBarEnd();}
        });
    }

    window.onload = function(){

        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
        //pagination($('#Dash_Table_Body2 tr'),$("#pagination_ys2"));
        pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2", $('#nowpage2'));

    }

    function searchProduct(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var useYN = 'Y';
        var productName = $("#product_search").val();

        if(organizationSeq==''){
            $('#Dash_Table_Body1').children().remove();
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/selectProductList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                useYN : useYN,
                productName : productName, productCode : productName
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length<1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].productSeq + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].productCode + '</td>';
                    html +='<td class="t_left">' + response[i].productName + '</td>';
                    html +='<td class="t_right">' + response[i].productPrice + '</td></tr>';

                }
                $('#Dash_Table_Body1').children().remove();
                $("#Dash_Table_Body1").html(html);
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
    }


</script>
</body>
</html>
