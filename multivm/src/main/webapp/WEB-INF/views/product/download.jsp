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
    <title>상품정보내리기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<style>
    .tb_horizen {margin-bottom: 20px;min-width: 100%;}
    #chkBf_price{display:block!important;}
    /*.chkBox_2{float: left;}*/
    #lab_price{
        color:#000000;
        position: relative;
        top: -3.6px;
        font-size: 13px;
        -webkit-user-select: none !important;
        -moz-user-select: -moz-none !important;
        -ms-user-select: none !important;
        user-select: none !important;
    }
    .price_0>td{
        background-color: #fff1f1;
      }
</style>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mg_download').addClass("current");
        $('#lnb_product').addClass("on");
        $('#mn_mg_m_download').addClass("current");
        $('#lnb_m_product').addClass("on");
        $('#lnb_m_product').next('ul').css('display','block');
        $('#lnb_product').children('ul').show();
        $('.subtit').text("상품 정보 업데이트")

        $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

        searchProduct();
    });

    function chkInputNumber(e){
        if(e.key >=0 && e.key <=9){
            return true;
        }else return false;
    }

</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            상품 정보 업데이트
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
                <li class="mar02">
                    <label for="group-select">조직</label>
                    <select name="organization" id="group-select" style="width: 100%;">
                        <c:choose>
                            <c:when test="${sessionScope.loginUser.auth==0}">
                                <option value="">소속을 선택해주세요</option>
                            </c:when>
                            <c:when test="${sessionScope.loginUser.auth==3}">
                                <option value="${sessionScope.loginUser.organizationSeq}" selected>${sessionScope.loginUser.organizationName}</option>
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
                <li></li>
                <li></li>
            </ul>
        </div>

        <section id="body_contents" class="table_copy_outline">
            <div class="table_copy table_copy2">
                <div class="item table_outline_a">
                    <div class="sub_tit">
                        <ul>
                            <li><h2>상품 마스터 정보</h2></li>
                            <li>
                                <label for="chkBf_price"><input type="checkbox" id="chkBf_price"><span id="lab_price">&nbsp;자판기 설정가격 고정</span></label>
                                <a href="javascript:void(0)" class="button" onclick="sendData();"><img src="${root}/resources/images/ic_send.png">내리기</a></li>
                        </ul>
                    </div>
                    <div class="table_selectbox2_2">
                        <ul>
                            <li class="">
                                <input type="text" id="product_search" maxlength="20" onkeydown="if(event.keyCode == 13) searchProduct();" placeholder="검색어 입력">
                                <a href="javascript:void(0)" class="button3 " onclick="searchProduct();">검색</a></li>
                        </ul>
                    </div>
                    <span style="font-size: 13px; color:#e12727">※ 기존에 등록된 상품정보를 다시 내리기 할 경우, 변경된 정보(가격 등)는  <span style="font-weight: bold; color:#e12727; ">초기화</span> 됩니다.</span>
                    <div class="table_box">
                        <table class="tb_horizen">
                            <colgroup>
                                <col width="5%">
                                <col width="20%">
                                <col width="52%">
                                <col width="12%">
                                <col width="11%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th><div class="ez-checkbox c_position2 allSelect1"><input type="checkbox" class="ez-hide"></div></th>
                                <th>상품코드</th>
                                <th>상품명</th>
                                <th>가격</th>
                                <th>최근변경일</th>
                            </tr>
                            </thead>
                            <tbody id="Dash_Table_Body1">
                            <c:choose>
                                <c:when test="${sessionScope.loginUser.auth==0}">
                                    <tr style="pointer-events: none;">
                                        <td>&ensp;&emsp;</td><td colspan=4>소속/조직을 선택해주세요.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${empty masterProductList}">
                                        <tr style="pointer-events: none;">
                                            <td>&ensp;&emsp;</td><td colspan=4>상품이 존재하지 않습니다.</td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="masterProductList" items="${masterProductList}">
                                        <tr id="${masterProductList.productCode}">
                                            <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                            <td>${masterProductList.productCode}</td>
                                            <td class="t_left">${masterProductList.productName}</td>
                                            <td class="t_right">${masterProductList.productPrice}</td>
                                            <td></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                        <div class="pagination" id="pagination_ys">
                        </div><input type="hidden" id="nowpage" value="1">
                    </div>
                </div>
                <div class="item copy_arrow"></div>
                <div class="item table_outline_a">
                    <div class="sub_tit">
                        <ul>
                            <li><h2>업데이트된 상품 정보</h2></li>
                            <li><a href="javascript:void(0)" class="button" onclick="deleteData();"><img src="${root}/resources/images/ic_delete.png">삭제</a>
                                <a href="javascript:void(0)" class="button" onclick="saveData();"><img src="${root}/resources/images/ic_save.png">저장</a></li>
                        </ul>
                    </div>
                    <div class="table_selectbox"><input id="userAuth" type="hidden" value="${sessionScope.loginUser.auth}">
                        <ul>
                            <li>
                                <label for="vm-select">단말기 ID / 자판기 ID / 설치위치</label>
                                <select name="vm" id="vm-select" style="width: 170%!important;">
                                    <c:choose>
                                        <c:when test="${sessionScope.loginUser.auth==0}">
                                            <option value="">조직과 소속을 선택해주세요</option>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${empty vmList}">
                                            </c:if>
                                            <c:forEach var="vmList" items="${vmList}">
                                                <c:if test="${status.index eq 0}">
                                                    <option value="${vmList.seq}" selected>${vmList.terminalId}&nbsp;&nbsp;/&nbsp;&nbsp;${vmList.vmId}&nbsp;&nbsp;/&nbsp;&nbsp;${vmList.place}</option>
                                                </c:if>
                                                <c:if test="${status.index ne 0}">
                                                    <option value="${vmList.seq}">${vmList.terminalId}&nbsp;&nbsp;/&nbsp;&nbsp;${vmList.vmId}&nbsp;&nbsp;/&nbsp;&nbsp;${vmList.place}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </li>
                        </ul>
                    </div>
                    <span style="float:right; font-size: 13px;color: #000000;">※ '가격' 변경 후엔 저장버튼을 눌러주세요.</span>
                    <div class="table_box">
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
                                        <td>&ensp;&emsp;</td><td colspan=3>단말기 ID / 자판기 ID 을 선택해주세요.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${empty myVMProductList}">
                                        <tr style="pointer-events: none;">
                                            <td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td>
                                        </tr>
                                    </c:if>
                                        <c:forEach var="myVMProductList" items="${myVMProductList}">
                                            <tr id="${myVMProductList.productCode}">
                                                <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                                                <td>${myVMProductList.productCode}</td>
                                                <td class="t_left">${myVMProductList.productName}</td>
                                                <td class="t_right"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="width: 85px;" value="${myVMProductList.productPrice}"></td>
                                            </tr>
                                        </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
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
    $('#vm-select').select2({
        placeholder: "선택해주세요"
    });

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });



   $('#company-select').change(changeCompanySelect=function(){
       var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            var html ="";
            var html2 ="";
            html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=4>소속을 선택하세요.</td></tr>';
            html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>소속을 선택하세요.</td></tr>';
            $('#vm-select').empty();
            $('#group-select').empty();
            $('#Dash_Table_Body1').html(html);
            $('#Dash_Table_Body2').html(html2);
            return false;
        }
        //alert($(this).val());
        $.ajax({
            url:'${root}/product/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+companySeq,
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 = "";
                var html3 = "";
                html +="<option value=''>선택해주세요</option>";
                html2 +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=4>상품이 존재하지 않습니다.</td></tr>";
                html3 +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=3>단말기 ID / 자판기 ID 을 선택해주세요.</td></tr>";
                for(var i=0; i<response.length; i++){
                    html +="<option value='"+response[i].seq+"'>"+response[i].name+"</option>";
                }
                $('#group-select').empty();
                $("#group-select").append(html);
                $('#vm-select').empty();
                $("#product_search").val("");
                $('#Dash_Table_Body1').html(html2);
                $('#Dash_Table_Body2').html(html3);
                //$('#Dash_Table_Body1').children().remove();
                //$('#Dash_Table_Body2').children().remove();
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });
//마스터상품정보만 바뀌게 + 시스템관리자의 경우엔 단말기불러오기(이거해야돼)
   $('#group-select').change(changeCompanySelect=function(){
       var companySeq = $("#company-select option:selected").val();
       var organizationSeq = $("#group-select option:selected").val();
       var useYN = 'Y';
       var html ="";
       /*var userSeq = '';
       if($("#userAuth").val()==0||$("#userAuth").val()==1){
           userSeq = ${sessionScope.loginUser.seq}
       }*/
       if(organizationSeq==''){
           $("#vm-select").empty();
           html +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=4>조직을 선택해주세요.</td></tr>";
           $('#Dash_Table_Body1').html(html);
           return false;
       }
       $.ajax({
           url:'${root}/product/ajax/getSelectorVMList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                useYN : useYN,
                orderDate : 'Y'
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 ="";
                var html3 ="";
                if(response.masterProduct.length<1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
                }
                else{
                    for(var i=0; i<response.masterProduct.length; i++){
                        html +='<tr id="' + response.masterProduct[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                        html +='<td>' + response.masterProduct[i].productCode + '</td>';
                        html +='<td class="t_left">' + response.masterProduct[i].productName + '</td>';
                        html +='<td class="t_right">' + response.masterProduct[i].productPrice + '</td><td>' + response.masterProduct[i].modifyDate + '</td></tr>';
                    }
                }
                if(response.vmList.length<1){
                    //html2 +="<option value=''></option>";
                }
                else{
                    html2 +="<option value=''>선택해주세요</option>";
                    for(var i=0; i<response.vmList.length; i++){
                        html2 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].terminalId+"&nbsp;&nbsp;/&nbsp;&nbsp;"+response.vmList[i].vmId+"&nbsp;&nbsp;/&nbsp;&nbsp;"+response.vmList[i].place+"</option>";
                    }
                }
                $('#Dash_Table_Body1').html(html);
                html3 +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=3>단말기 ID / 자판기 ID 을 선택해주세요.</td></tr>";
                $('#Dash_Table_Body2').html(html3);
                $('#vm-select').empty();
                $("#product_search").val("");
                $("#vm-select").append(html2);
                $('input').ezMark();
                $('.c_position2').find('div').removeClass("ez-checked");
                //$('.allSelect1').find('div').removeClass("ez-checked");
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
           error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

   $('#vm-select').change(changeCompanySelect3=function(){
       var companySeq = $("#company-select option:selected").val();
       var organizationSeq = $("#group-select option:selected").val();
       var vmSeq = $("#vm-select option:selected").val();
       var html ="";
       /*var userSeq = '';
       if($("#userAuth").val()==0||$("#userAuth").val()==1){
           userSeq = ${sessionScope.loginUser.seq}
       }*/
       if(vmSeq==''){
           //$('#Dash_Table_Body2').children().remove();
           html +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=3>단말기 ID / 자판기 ID 을 선택해주세요.</td></tr>";
           $('#Dash_Table_Body2').html(html);
           return false;
       }
       $.ajax({
           url:'${root}/product/ajax/getSelectorVMProductList.do',
           type : 'POST',
           data:{ companySeq : companySeq,
               organizationSeq : organizationSeq,
               vmSeq : vmSeq,
               orderDate : 'Y'
           },
           datatype: 'JSON',
           success:function(response){
               var html ="";
               if(response.vmProductList.length<1){
                   html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
               }

               for(var i=0; i<response.vmProductList.length; i++){
                   html +='<tr id="' + response.vmProductList[i].productCode + '" class="' + (response.vmProductList[i].productPrice=='0'?'price_0':'') + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                   if(response.vmProductList[i].productPrice=='0'){
                       html +='<td>' + response.vmProductList[i].productCode + '</td>';
                       html +='<td class="t_left">' + response.vmProductList[i].productName + '<span style="float:right; font-size:13px; color:red; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요</span></td>';
                   }else{
                       html +='<td>' + response.vmProductList[i].productCode + '</td>';
                       html +='<td class="t_left">' + response.vmProductList[i].productName + '</td>';
                   }
                   html +='<td class="t_right"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width: 85px;" value=" ' + response.vmProductList[i].productPrice + '"></td></tr>';
               }

               $('#Dash_Table_Body2').html(html);
               $('input').ezMark();
               //$('.allSelect2').find('div').removeClass("ez-checked");
               $('.c_position2').find('div').removeClass("ez-checked");
               $("#pagination_ys2").empty();
               pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2",$('#nowpage2'));
           },
           error: function (xhr, status, error) {
               console.log(error);
           }
       });
   });

   function sendData(){
       var companySeq = $("#company-select option:selected").val();
       var organizationSeq = $("#group-select option:selected").val();
       var vmSeq = $("#vm-select option:selected").val();
       var checked = $("#chkBf_price").is(':checked')?'1':'0';

       if(vmSeq=='' || typeof vmSeq =='undefined'){
           alert('단말기 ID / 자판기 ID 를 선택하세요.');
           return false;
       }
       var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
       var sizeCheck2 = $('#Dash_Table_Body2 input');
       var sendList = []; //1
       var checkList = []; //2
       var deleteDupList = [];
       var selectList = []; //1

       if(sizeCheck.length == 0){
           alert("내려받을 마스터 상품을 선택하세요.");
           return false;
       }

       $.each(sizeCheck,function(idex,entry){ //마스터상품(체크)
           sendList.push(entry.closest('tr').id);
       });
       $.each(sizeCheck2,function(idex,entry){ //자판기상품(전체)
           checkList.push(entry.closest('tr').id);
       });
       selectList = sendList;
       sendList = sendList.filter(x => !checkList.includes('UBsave_'+x)); //이미 주가한(아직저장X) 상품목록 삭제
       if(sendList.length<1) {
           alert('이미 추가된 상품정보입니다.');
           return false;
       }

       deleteDupList = sendList.filter(x => !checkList.includes(x));
       sendList = sendList.filter(x => !deleteDupList.includes(x));

       if(sendList.length<1) sendList.push('NO');
       if(deleteDupList.length<1) deleteDupList.push('NO');

       console.log('------------------------------------------');
       console.log(selectList); //등록된 자판기상품 전체
       console.log(sendList); //중복된 상품 리스트
       console.log(deleteDupList); //새로 추가할 상품 리스트(중복제거)
       if(!confirm("선택한 상품을 자판기로 내려받으시겠습니까?\n" +
           "※ '저장'하기 전에는 반영되지 않습니다. 확인 후에 오른쪽 상단의 '저장'을 해주세요.\n\n" +
           "이미 내려받기한 상품은 목록에서 제외되므로 내려받은 상품을 저장 한 후에 진행하시길 바랍니다.")){
           return false;
       }
       else{
           FunLoadingBarStart();
           $.ajax({
               url:'${root}/product/ajax/sendSelectedProductCheck.do',
               type : 'POST',
               async : false,
               data: {sendList:sendList,
                   deleteDupList : deleteDupList,
                   companySeq : companySeq,
                   organizationSeq : organizationSeq,
                   vmSeq : vmSeq,
                   vmPrice : checked},
               datatype: 'JSON',
               success:function(response){
                   console.log(response.status);
                   console.log(response.productList);
                   console.log(response.dup_productList);
                   var html = "";
                   var html2 = ""; //0원 상품
                   var html3 = ""; //이전 가격과 다른 상품
                   var html4 = ""; //0원 상품 + 이전 가격과 다른 상품
                   //$('#Dash_Table_Body2').find('tr.0_price:last').after('<tr><td>gggggggg</td></tr>')
                   if(response.status=="success") {
                       console.log('case:1');
                       for(var i=0; i<response.productList.length; i++){
                           if(response.productList[i].productPrice != '0') {
                               html += '<tr id="UBsave_' + response.productList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                               html += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                               html += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '</p></td>';
                               html += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                           }else{
                               html2 += '<tr id="UBsave_' + response.productList[i].productCode + '" class="price_0"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                               html2 += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                               html2 += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '<span style="float:right; font-size:13px; color:red; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요</span></p></td>';
                               html2 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                           }
                       }
                       //$('#Dash_Table_Body2').prepend(html);

                       if ($('#Dash_Table_Body2').find('tr').hasClass('price_0')) {
                           if ($('#Dash_Table_Body2').find('tr').hasClass('price_bf')) {
                               // 맨 위
                               $('#Dash_Table_Body2').prepend(html2);
                               // bf 아래
                               $('#Dash_Table_Body2').find('tr.price_bf:last').after(html);

                           } else {
                               // 맨 위
                               $('#Dash_Table_Body2').prepend(html2);
                               // 0 아래
                               $('#Dash_Table_Body2').find('tr.price_0:last').after(html);
                           }
                       }else{ // 아무것도 없을 때
                           if ($('#Dash_Table_Body2').find('tr').hasClass('price_bf')) {
                               // 맨 위
                               $('#Dash_Table_Body2').prepend(html2);
                               // bf 아래
                               $('#Dash_Table_Body2').find('tr.price_bf:last').after(html);

                           } else {
                               $('#Dash_Table_Body2').prepend(html);
                               $('#Dash_Table_Body2').prepend(html2);
                           }
                       }



                       $('input').ezMark();
                       //('.allSelect1').find('div').removeClass("ez-checked");
                       //$('.allSelect2').find('div').removeClass("ez-checked");
                       $('.c_position2').find('div').removeClass("ez-checked");
                       $("#pagination_ys2").empty();
                       pagination($('#Dash_Table_Body2 tr'), "#pagination_ys2",$('#nowpage2'));

                   }else {
                       if ($("#Dash_Table_Body2").children('tr:eq(0)').id == '') {
                           $('#Dash_Table_Body2').children().remove();
                       }
                       var list = response.message;
                       console.log(list);

                       if (response.status.includes('dup')) {
                           if (confirm(response.status.includes('any') ? '목록에는 삭제됐지만 ' : '중복된 상품이 존재합니다. (상품코드: ' + response.message + ')\n 덮어쓰시겠습니까?\n\n' +
                               '※ \'확인\' 할 경우 덮어쓰기 합니다!!\n' +
                               '\'취소\' 시엔 중복된 상품을 제외하고 추가됩니다.')) {
                               //확인
                               console.log(response.productList);
                               console.log(response.productList.length)
                               console.log('case:2');
                               if (response.productList.length != 0) {
                                   for (var i = 0; i < response.productList.length; i++) {
                                       if (response.productList[i].productPrice != '0') {
                                           html += '<tr id="UBsave_' + response.productList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                                           html += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '</p></td>';
                                           html += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                                       } else {
                                           html2 += '<tr id="UBsave_' + response.productList[i].productCode + '" class="price_0"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html2 += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                                           html2 += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '<span style="float:right; font-size:13px; color:red; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요</span></p></td>';
                                           html2 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                                       }
                                   }
                               }
                               for (var i = 0; i < response.dup_productList.length; i++) {
                                   if (response.dup_productList[i].productPrice != '0') {
                                       if (response.dup_productList[i].productPrice != response.dup_productList[i].prePrice) {
                                           html3 += '<tr id="UBsave_' + response.dup_productList[i].productCode + '" class="price_bf"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html3 += '<td><p style="color:#0075fe;">' + response.dup_productList[i].productCode + '</p></td>';
                                           html3 += '<td class="t_left"><p style="color:#0075fe;">' + response.dup_productList[i].productName + '<span style="float:right; font-size:13px; color:#0075fe; display: inline-block; padding-bottom:1px;"><i class="fas fa-user-clock"/>&nbsp;이전가격:' + response.dup_productList[i].prePrice + '</span></p></td>';
                                           html3 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.dup_productList[i].productPrice + '"></p></td></tr>';
                                       } else {
                                           html += '<tr id="UBsave_' + response.dup_productList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html += '<td><p style="color:#0075fe;">' + response.dup_productList[i].productCode + '</p></td>';
                                           html += '<td class="t_left"><p style="color:#0075fe;">' + response.dup_productList[i].productName + '</p></td>';
                                           html += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.dup_productList[i].productPrice + '"></p></td></tr>';
                                       }
                                   } else {
                                       if (response.dup_productList[i].productPrice != response.dup_productList[i].prePrice) {
                                           html4 += '<tr id="UBsave_' + response.dup_productList[i].productCode + '" class="price_0"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html4 += '<td><p style="color:#0075fe;">' + response.dup_productList[i].productCode + '</p></td>';
                                           html4 += '<td class="t_left"><p style="color:#0075fe;">' + response.dup_productList[i].productName + '<span style="float:right; font-size:13px; color:#0075fe; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요&nbsp;<i class="fas fa-user-clock"/>&nbsp;이전가격:' + response.dup_productList[i].prePrice + '</span></p></td>';
                                           html4 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.dup_productList[i].productPrice + '"></p></td></tr>';
                                       } else {
                                           html2 += '<tr id="UBsave_' + response.dup_productList[i].productCode + '" class="price_0"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                           html2 += '<td><p style="color:#0075fe;">' + response.dup_productList[i].productCode + '</p></td>';
                                           html2 += '<td class="t_left"><p style="color:#0075fe;">' + response.dup_productList[i].productName + '<span style="float:right; font-size:13px; color:#0075fe; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요</span></p></td>';
                                           html2 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.dup_productList[i].productPrice + '"></p></td></tr>';
                                       }
                                   }
                               }
                               list.forEach(function (element) {
                                   $('#Dash_Table_Body2 tr[id=' + element + ']').remove();
                                   console.log(element);
                               });

                               //$('#Dash_Table_Body2 tr[id=]').remove();
                           } else {
                               //취소
                               console.log(response.productList);
                               console.log('case:3');
                               //html += '<tr id=""><td colspan=4><p style="color:#43b825;">추가한 상품이 아래에 표시됩니다</p></td>';
                               for (var i = 0; i < response.productList.length; i++) {
                                   if (response.productList[i].productPrice != '0') {
                                       html += '<tr id="UBsave_' + response.productList[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                       html += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                                       html += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '</p></td>';
                                       html += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                                   } else {
                                       html2 += '<tr id="UBsave_' + response.productList[i].productCode + '" class="price_0"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                                       html2 += '<td><p style="color:#0075fe;">' + response.productList[i].productCode + '</p></td>';
                                       html2 += '<td class="t_left"><p style="color:#0075fe;">' + response.productList[i].productName + '<span style="float:right; font-size:13px; color:red; display: inline-block; padding-bottom:1px;"><i class="fas fa-exclamation-triangle" style="color:red"/>&nbsp;가격을 수정해주세요</span></p></td>';
                                       html2 += '<td class="t_right"><p style="color:#0075fe;"><input type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" style="width:85px" value="' + response.productList[i].productPrice + '"></p></td></tr>';
                                   }
                               }
                           }

                           console.log('1 '+html)
                           console.log('2 '+html2)
                           console.log('3 '+html3)
                           console.log('4 '+html4)
                           //$('#Dash_Table_Body2').prepend(html); 4(이전가격+0원)->2(0원)->3(이전가격)->1
                           if ($('#Dash_Table_Body2').find('tr').hasClass('price_0')) {
                               if ($('#Dash_Table_Body2').find('tr').hasClass('price_bf')) {
                                   // 맨 위
                                   $('#Dash_Table_Body2').prepend(html2);
                                   $('#Dash_Table_Body2').prepend(html4);
                                   // 0 아래
                                   $('#Dash_Table_Body2').find('tr.price_0:last').after(html3);
                                   // bf 아래
                                   $('#Dash_Table_Body2').find('tr.price_bf:last').after(html);

                               } else {
                                   // 맨 위
                                   $('#Dash_Table_Body2').prepend(html2);
                                   $('#Dash_Table_Body2').prepend(html4);
                                   // 0 아래
                                   $('#Dash_Table_Body2').find('tr.price_0:last').after(html);
                                   $('#Dash_Table_Body2').find('tr.price_0:last').after(html3);
                               }
                           }else{ // 아무것도 없을 때
                               if ($('#Dash_Table_Body2').find('tr').hasClass('price_bf')) {
                                   // 맨 위
                                   $('#Dash_Table_Body2').prepend(html3);
                                   $('#Dash_Table_Body2').prepend(html2);
                                   $('#Dash_Table_Body2').prepend(html4);
                                   // bf 아래
                                   $('#Dash_Table_Body2').find('tr.price_bf:last').after(html);

                               } else {
                                   $('#Dash_Table_Body2').prepend(html);
                                   $('#Dash_Table_Body2').prepend(html3);
                                   $('#Dash_Table_Body2').prepend(html2);
                                   $('#Dash_Table_Body2').prepend(html4);
                               }
                           }
                           $('input').ezMark();
                           //$('.allSelect1').find('div').removeClass("ez-checked");
                           //$('.allSelect2').find('div').removeClass("ez-checked");
                           $('.c_position2').find('div').removeClass("ez-checked");
                           $("#pagination_ys2").empty();
                           pagination($('#Dash_Table_Body2 tr'), "#pagination_ys2", $('#nowpage2'));
                       }
                       /*$('#Dash_Table_Body2').prepend(html);
                       $('input').ezMark();
                       $('.allSelect2').find('div').removeClass("ez-checked");
                       $("#pagination_ys2").empty();
                       pagination($('#Dash_Table_Body2 tr'), "#pagination_ys2",$('#nowpage2'));*/

                       //changeCompanySelect2();
                   }
               }, error: function (xhr, status, error) {console.log(error);}
               , complete: function () {FunLoadingBarEnd();}
           });
       }
   }

   function deleteData(){
       var sizeCheck = $('#Dash_Table_Body2 input[type="checkbox"]:checked');
       //var sizeCheck2 = $('#Dash_Table_Body2 input');
       $.each(sizeCheck,function(idex,entry){
           entry.closest('tr').remove();
       });

       $("#pagination_ys2").empty();
       pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2",$('#nowpage2'));

   }

   function saveData(){
       var companySeq = $("#company-select option:selected").val();
       var organizationSeq = $("#group-select option:selected").val();
       var vmSeq = $("#vm-select option:selected").val();

       if(vmSeq=='' || typeof vmSeq =='undefined'){
           alert('단말기 ID / 자판기 ID 를 선택하세요.');
           return false;
       }

       //alert(" dgd "+companySeq+"  "+ organizationSeq +"  "+vmSeq);
       if(companySeq==''){alert("소속을 선택해주세요");return false;}
       if(organizationSeq==''){alert("조직을 선택해주세요");return false;}
       if(vmSeq==''){alert("자판기ID 혹은 단말기ID를 선택해주세요");return false;}
       if(!confirm("이대로 저장하시겠습니까?"))	return;

       var saveList = [{companySeq:companySeq,organizationSeq:organizationSeq,vmSeq:vmSeq,deleteType:0 }];
       for (let i = 1; i <= $('#Dash_Table_Body2').find('tr').length; i++) {
           saveList.push({
               id: $('#Dash_Table_Body2').find('tr:nth-child(' + i + ')').attr('id'),
               amount: $('#Dash_Table_Body2').find('tr:nth-child(' + i + ') > td').find('input[type="text"]').val()
           })
       }
       console.log(saveList);
       /*$.each(sizeCheck,function(idex,entry){
           saveList.push(entry.closest('tr').id);
       });
        if(saveList.length==0){
            saveList.push('null');
        }*/
       FunLoadingBarStart();
       $.ajax({
           url:'${root}/product/ajax/saveProduct.do',
           type : 'POST',
           contentType:'application/json',
           dataType: 'json',
           data: JSON.stringify(saveList),
           datatype: 'JSON',
           success:function(response){
               if(response.status!="success") alert(response.message);
               else alert("성공적으로 적용되었습니다.");
               changeCompanySelect3();

           }, error: function (xhr, status, error) {console.log(error);
           }, complete: function () {FunLoadingBarEnd();}
       });


   }





   ///////////////////////////////////////////

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

    window.onload = function(){

        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys",$('#nowpage'));
        pagination($('#Dash_Table_Body2 tr'),"#pagination_ys2",$('#nowpage2'));

    }

    function searchProduct(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var useYN = 'Y';
        var productName = $("#product_search").val();

        if(organizationSeq==''){
            $("#vm-select").empty();
            html +="<tr style='pointer-events: none;'><td>&ensp;&emsp;</td><td colspan=4>조직을 선택해주세요.</td></tr>";
            $('#Dash_Table_Body1').html(html);
            return false;
        }
        $.ajax({
            url:'${root}/product/ajax/selectProductList.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq,
                useYN : useYN,
                productName : productName, productCode : productName,
                orderDate : 'Y'
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length<1){
                    html +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=3>상품이 존재하지 않습니다.</td></tr>';
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr id="' + response[i].productCode + '"><td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
                    html +='<td>' + response[i].productCode + '</td>';
                    html +='<td class="t_left">' + response[i].productName + '</td>';
                    html +='<td class="t_right">' + response[i].productPrice + '</td><td class="t_right">' + response[i].modifyDate + '</td></tr>';

                }

                $('#Dash_Table_Body1').html(html);
                $('input').ezMark();
                $('.c_position2').find('div').removeClass("ez-checked");
                //$('.allSelect1').find('div').removeClass("ez-checked");
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
