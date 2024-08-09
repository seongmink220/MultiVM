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
    <title>공지사항</title>
</head>
<script type="text/javascript">
    $(document).ready(function (){
        $('#mn_mc_notice').addClass("current");
        $('#lnb_customer').addClass("on");
        $('#mn_mc_m_notice').addClass("current");
        $('#lnb_m_customer').addClass("on");
        $('#lnb_m_customer').next('ul').css('display','block');
        $('#lnb_customer').children('ul').show();
        $('.subtit').text("공지사항")
    });
</script>
<body>
<div id="wrap">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            공지사항
        </header>
        <%--<div id="shadow_bg" style="display: none;"></div>
        <div id="modal_pop" style="display: none;">
            <div class="pop_box">
                <div class="pop_title">
                    <h2>보정</h2>
                    <span><a href="#none"><img src="${root}/resources/images/ic_close.png" alt="닫기"></a></span>
                </div>
                <div class="pop_contbox">
                    <form action="#none" method="post">
                        <fieldset>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="vending-id" class="form_title">자판기 ID</label>
                                    <input type="text" id="vending-id" placeholder="121212121" disabled />
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="terminal-id" class="form_title">단말기 ID</label>
                                    <input type="text" id="terminal-id" placeholder="121212121" disabled>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="product-name" class="form_title">상품명</label>
                                    <input type="text" id="product-name" placeholder="콜라" disabled>
                                </li>
                            </ul>
                            <ul class="form_group input_width">
                                <li>
                                    <label for="product-code" class="form_title">상품코드</label>
                                    <input type="text" id="product-code" placeholder="00001" disabled>
                                </li>
                            </ul>
                            <ul class="form_group form_half input_width">
                                <li>
                                    <label for="product-price" class="form_title">현재고</label>
                                    <input type="text" id="product-price" placeholder="9" disabled>
                                </li>
                                <li>
                                    <label for="product-sale" class="form_title">보정재고</label>
                                    <input type="text" id="product-sale" placeholder="입력해주세요">
                                </li>
                            </ul>
                        </fieldset>
                    </form>
                    <div class="pop_button">
                        <a href="#none" class="button2 btn_cancel">취소</a>
                        <a href="#none" class="button2 btn_ok">수정하기</a>
                    </div>
                </div>
            </div>
        </div>--%>
        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="top_search_bar">
            <ul>
                <li class="input-size02"><label for="sDate">조회일자</label><input id="sDate"type="date">&nbsp;~&nbsp;<input id="eDate" type="date"></li>
                <li class="input-size03">
                    <label for="notice-search">게시물 검색</label>
                    <select name="office" id="notice-search">
                        <option value="title" selected>제목</option>
                        <option value="content">내용</option>
                        <option value="titCont">제목+내용</option>
                    </select>
                    <input type="text" id="notice-keyword" placeholder="검색어를 입력해주세요">
                </li>
                <li class="label_none">
                    <label for=""></label><a href="javascript:void(0);" class="button3 button_position2" onclick="searchData()">검색</a>
                </li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div class="table_outline">
                <table class="tb_horizen">
                    <colgroup>
                        <col class="t_none" width="5%">
                        <col width="75%">
                        <col width="10%">
                        <col width="10%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="t_none">번호</th>
                        <th>제목</th>
                        <th>첨부파일</th>
                        <th>등록일</th>
                    </tr>
                    </thead>
                    <tbody id="Dash_Table_Body1">
                    <c:if test="${empty noticeList}">
                        <tr><td colspan="4">등록된 공지사항이 없습니다.</td></tr>
                    </c:if>
                        <c:forEach var="noticeList" items="${noticeList}"  varStatus="status">
                            <tr onclick="location_href(${noticeList.seq});">
                                <%--<td><c:out value="${status.count}" /></td>--%>
                                    <td class="t_none">${noticeList.seq}</td>
                                <td style="text-align: left;">${noticeList.title}</td>
                                <td class="attach">
                                    <c:if test="${noticeList.file1 ne null}">
                                        <img src="${root}/resources/images/ic_attach.png"></td>
                                    </c:if>
                                <td>${noticeList.createDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="bottom_btn">
                    <ul>
                        <li></li>
                        <c:if test="${sessionScope.loginUser.auth==0}">
                        <li>
                            <a href="${root}/customer/write?seq=0" class="button btn_delete" onclick="">글쓰기</a>
                        </li>
                        </c:if>
                    </ul>
                </div>
                <div class="pagination" id="pagination_ys">
                </div>
                <input type="hidden" id="nowpage" value="1">
            </div>
        </section>
    </section>
</div>
<script type="text/javascript">
    window.onload = function(){
        pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
    }

    function searchData(){
        var notice_search = $("#notice-search option:selected").val();
        var notice_keyword = $("#notice-keyword").val();
        var sDate = $('#sDate').val();
        var eDate = $('#eDate').val();

        if(notice_keyword==''&&sDate==''&&eDate==''){alert("검색할 조건을 선택하세요.");return false;}
        $.ajax({
            url:'${root}/customer/ajax/searchNoticeList.do',
            type : 'POST',
            data:{ notice_search : notice_search,
                notice_keyword : notice_keyword,
                sDate : sDate,
                eDate : eDate},
            datatype: 'JSON',
            success:function(response){
                var html ="";
                if(response.length <1){
                    html +="<tr><td colspan=4>검색결과가 존재하지 않습니다.</td></tr>";
                }
                for(var i=0; i<response.length; i++){
                    html +='<tr onclick="location_href('+response[i].seq+')"><td class="t_none">'+ (response.length-i) +'</td><td style="text-align: left;">'+response[i].title+'</td>';
                    if(response[i].file1!=null) {
                        html += '<td class="attach"><img src="${root}/resources/images/ic_attach.png"></td>';
                    }
                    else html += '<td class="attach"></td>';
                    html +='<td>'+response[i].createDate+'</td>';

                }
                $('#Dash_Table_Body1').html(html);
                $("#pagination_ys").empty();
                pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }
    function location_href(seq){
        location.href="${root}/customer/view?seq="+seq;
    }

</script>
</body>
</html>
