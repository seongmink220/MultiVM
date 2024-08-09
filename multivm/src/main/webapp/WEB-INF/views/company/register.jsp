
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
  <title>소속관리</title>
</head>
<script type="text/javascript">
  $(document).ready(function (){
    $('#mn_mf_company').addClass("current");
    $('#lnb_company').addClass("on");
    $('#lnb_company').children('ul').show();
    $('#mn_mf_m_company').addClass("current");
    $('#lnb_m_company').addClass("on");
    $('#lnb_m_company').next('ul').css('display','block');
    $('.subtit').text("소속관리")

    $("#company-select").select2();
    //$('#company-select').select2({}).focus(function () { $(this).select2('open'); });

    $(document).on('select2:open', () => {
      document.querySelector('.select2-search__field').focus();
    });

    $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

  });
</script>
<body>
<div id="wrap">
  <!-- body -->
  <section id="body_wrap">
    <header id="body_header">
      소속관리
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
              <legend>소속입력</legend>
              <ul class="form_group input_width">
                <li>
                  <label for="org_name" class="form_title">소속 <span style="font-size: small; color:#b9b9b9;">&nbsp;(* 20자 이내)</span></label>
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
        <li>
          <label for="company-select">소속</label>
          <select name="company" id="company-select">
                <option value="">선택해주세요</option>
                <c:forEach var="companyList" items="${companyList}">
                  <option value="${companyList.seq}">${companyList.name}</option>
                </c:forEach>
          </select>
        </li>
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
            <th>소속명</th><th>등록일시</th>
          </tr>
          </thead>
          <tbody id="Dash_Table_Body1">
              <c:if test="${companyPageList==null||empty companyPageList}">
                <tr style="pointer-events: none;">
                  <td><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                  <td>&ensp;&emsp;</td><td colspan=2>등록된 소속이 존재하지 않습니다.</td>
                </tr>
              </c:if>
              <c:forEach var="companyPageList" items="${companyPageList}">
                <tr id="${companyPageList.seq}" onclick="editDataModal(${companyPageList.seq})">
                  <td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>
                  <td>${companyPageList.name}</td><td>${companyPageList.createDate}</td>
                </tr>
              </c:forEach>
          </tbody>
        </table>
        <div class="pagination" id="pagination_ys">
        </div><input type="hidden" id="nowpage" value="1">
      </div>
    </section>
  </section>
</div>
<%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />--%>
<link rel="stylesheet" href="${root}/resources/css/select2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script type="text/javascript">

 $('#company-select').change(companyChangeFunc=function(){
    //var companySeq =$(this).val();
    var companySeq = $("#company-select option:selected").val();
    if(companySeq==''){
      location.reload();
    }
    $.ajax({
      url:'${root}/company/ajax/selectCompanyInfo.do?companySeq='+companySeq,
      type : 'GET',
      datatype: 'JSON',
      success:function(response){
        var html ="";
        var html2 ="";
        if(response==null){
          html2 +='<tr style="pointer-events: none;"><td>&ensp;&emsp;</td><td colspan=2>소속이 존재하지 않습니다.</td></tr>';
        }
        else {
            html2 +='<tr id="' + response.seq + '"onclick="editDataModal('+response.seq +')"><td onclick="event.cancelBubble=true"><div class="ez-checkbox c_position2"><input type="checkbox" class="ez-hide"></div></td>';
            html2 +='<td>' + response.name + '</td><td>' + response.createDate + '</td>';
        }
        //$("#group-select").html(html);
        $("#Dash_Table_Body1").html(html2);
        $('#totCnt').text('1');
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
    $("#pop_title_m").text("소속 추가");
    $('#modal_pop').stop().fadeIn();
    $('#shadow_bg').stop().fadeIn();
    $('#modal_form').each(function() { this.reset();});
    $("#org_seq").val(0);
  }
  function editDataModal(companySeq){
    $("#pop_title_m").text("소속 수정");
    $('#modal_pop').stop().fadeIn();
    $('#shadow_bg').stop().fadeIn();

    $.ajax({
      url:'${root}/company/ajax/selectCompanyInfo.do?companySeq='+companySeq,
      type : 'GET',
      datatype: 'JSON',
      success:function(response){
        $("#org_name").val(response.name);
        $("#org_seq").val(response.seq);
      },
      error: function (xhr, status, error) {console.log(error);}
    });
  }

  function addData(){
    //var companySeq = $("#company-select option:selected").val();
    var companyName = $("#org_name").val()
    var companySeq = $("#org_seq").val();

    var params = $("#modal_form").serialize();
    if(companyName==''){
      alert("값을 입력하세요.");
      return false;
    }
    var data = {
      seq : companySeq,
      name : companyName};
    //alert(JSON.stringify(data)); //return false;
    $.ajax({
      url:'${root}/company/ajax/insModCompanyInfo.do',
      data: data,
      type : 'POST',
      success:function(response){
        alert(response);
        if(response.includes('중복')){
          return false;
        }
        location.reload();
        //$('#modal_pop').stop().fadeOut();
        //$('#shadow_bg').stop().fadeOut();
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
      alert("삭제할 소속을 선택하세요");
    }else{
      if(!confirm("정말 삭제하시겠습니까?\n※ 자판기 등록이력이 있는 경우엔 삭제되지 않습니다. (시스템사업부서에 요청 바랍니다_삭제사유 필요)"))	return;
      $.each(sizeCheck,function(idex,entry){
        deleteList.push(entry.closest('tr').id);
      });
      $.ajax({
        url:'${root}/company/ajax/deleteSelectedCompany.do',
        type : 'GET',
        data: {deleteList:deleteList},
        success:function(response){
          alert(response);
          location.reload();


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
