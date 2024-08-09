<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-10
  Time: 오후 6:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!-- header -->
<div class="gnb">
    <ul>
        <li><h1 class="ubcn-logo"><img src="${root}/resources/images/ubcn.png" alt="bingo multi 관리자" onclick="location.href='${root}/index';"></h1></li>
    </ul>
    <ul>
        <li class="subtit"></li>
        <li>
            <div class="user-name"><span>${sessionScope.loginUser.name}</span>님 환영합니다.</div>
            <div class="ubcn-logout"><a href="${root}/logout">로그아웃</a></div>
        </li>
    </ul>
</div>
<div id="gnb_m" class="gnb_m">
    <ul>
        <li><img src="${root}/resources/images/ic_list.png"></li>
        <li class="subtit_m"><img src="${root}/resources/images/m_logo.png" alt="bingo multi"></li>
    </ul>
</div>
<header id="left_fix_bar">
    <nav id="lnb">
        <ul class="depth-1">
            <%--<li id="lnb_admin1" class="arrow_none"><a href="#none"><img src="${root}/resources/images/ic_lnb1.png">관리자시스템</a></li>--%>

           <li id="lnb_admin2" ><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb2.png">자판기 운영</a>
               <ul class="depth-2" style="">
                <c:if test="${sessionScope.loginUser.auth==0}">
                   <li id="mn_md_firmware"><a href="${root}/admin/firmware">프로그램관리</a></li>
                </c:if>
                   <li id="mn_md_vm-status"><a href="${root}/admin/vm-status">상태조회</a></li>
                   <li id="mn_mg_vm-slot"><a href="${root}/product/vm-slot">슬롯현황</a></li>
                <c:if test="${sessionScope.loginUser.auth<3}">
                    <li id="mn_mf_adv"><a href="${root}/company/adv">광고관리</a></li>
                </c:if>
                <c:if test="${sessionScope.loginUser.auth==0}">
                   <li id="mn_md_vm-issue"><a href="${root}/admin/vm-issue">자판기이슈조회</a></li>
                   <li id="mn_md_log"><a href="${root}/admin/log">자판기로그조회</a></li>
                   <li id="mn_md_code"><a href="${root}/admin/code">코드관리</a></li>
                </c:if>
               </ul>
           </li>

            <li id="lnb_company" ><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb3.png">운영권한</a>
                <ul class="depth-2" style="">
                    <c:if test="${sessionScope.loginUser.auth==0}">
                        <li id="mn_mf_company"><a href="${root}/company/register">소속관리</a></li>
                    </c:if>
                    <c:if test="${sessionScope.loginUser.auth<3}">
                        <li id="mn_mf_orig"><a href="${root}/company/orig">조직관리</a></li>
                        <li id="mn_mf_user"><a href="${root}/company/user">사용자관리</a></li>
                    </c:if>
                    <li id="mn_mf_vending-machine"><a href="${root}/company/vending-machine">자판기관리</a></li>
                    <c:if test="${sessionScope.loginUser.auth<3}">
                        <li id="mn_mf_event"><a href="${root}/company/event">이벤트관리</a></li>
                    </c:if>
                </ul>
            </li>
            <li id="lnb_product"><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb4_on.png">상품관리</a>
                <ul class="depth-2" style="">
                    <li id="mn_mg_list" ><a href="${root}/product/list" >상품마스터정보</a></li>
                    <%--<li id="mn_mg_vending-machine" ><a href="${root}/product/vending-machine">자판기 상품현황</a></li>--%>
                    <c:if test="${sessionScope.loginUser.auth < 4}">
                        <li id="mn_mg_copy"><a href="${root}/product/copy">상품마스터복제</a></li>
                    </c:if>
                    <li id="mn_mg_vending-machine"><a href="${root}/product/vending-machine">자판기상품정보</a></li>
                    <li id="mn_mg_download"><a href="${root}/product/download">상품정보업데이트</a></li>
                </ul>
            </li>
            <li id="lnb_sales"><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb5.png">매출관리</a>
                <ul class="depth-2" style="">
                    <li id="mn_ms_transaction"><a href="${root}/sales/transaction">거래내역</a></li>
                    <li id="mn_ms_salesReport"><a href="${root}/sales/salesReport">매출집계</a></li>
                </ul>
            </li>
            <li id="lnb_board"><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb6.png">이력관리</a>
                <ul class="depth-2" style="">
                    <li id="mn_mv_store"><a href="${root}/board/store">입고현황</a></li>
                    <li id="mn_mv_release"><a href="${root}/board/release">출고현황</a></li>
                    <li id="mn_mv_stock"><a href="${root}/board/stock">재고현황</a></li>
                </ul>
            </li>
            <li id="lnb_customer"><a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb7_on.png">고객센터</a>
                <ul class="depth-2" style="">
                    <li id="mn_mc_notice"><a href="${root}/customer/notice">공지사항</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</header>

<!--mobile header2 -->
<div id="header2">
    <!-- m_nav -->
    <div class="m_nav">
        <h1 class="logo"><a href="javascript:void(0);" onclick="location.href='${root}/index';"><img src="${root}/resources/images/m_logo.png" alt="bingo multi"></a></h1>
        <div class="btn_menu">
            <div class="line2"></div>
            <div class="line2"></div>
            <div class="line2"></div>
        </div>
        <div class="aside">
            <div class="m_head">
                <div class="m_logo"><a href="javascript:void(0);" onclick="location.href='${root}/index';"><img src="${root}/resources/images/m_logo.png" alt="bingo multi"></a></div>
                <div class="btn_close">
                    <div class="line2"></div>
                    <div class="line2"></div>
                    <div class="line2"></div>
                </div>
            </div>
            <div class="m_link">
                <ul>
                    <li><img src="${root}/resources/images/user2.png"><span>${sessionScope.loginUser.name}님 환영합니다.</span></li>
                </ul>
            </div>
            <div class="m_menu">
                <ul class="depth1">
                    <%--<li class="ic_none" id="lnb_m_admin1">
                        <a href="#none"><img src="${root}/resources/images/ic_lnb1.png">관리자시스템</a>
                    </li>--%>
                    <li id="lnb_m_admin2" >
                        <a href="javascript:void(0)"><img src="${root}/resources/images/ic_lnb2.png">자판기 운영</a>
                        <ul class="depth2" style="">
                            <c:if test="${sessionScope.loginUser.auth==0}">
                            <li id="mn_md_m_firmware"><a href="${root}/admin/firmware">프로그램관리</a></li>
                            </c:if>
                            <li id="mn_md_m_vm-status"><a href="${root}/admin/vm-status">상태조회</a></li>
                            <li id="mn_mg_m_vm-slot"><a href="${root}/product/vm-slot">슬롯현황</a></li>
                            <c:if test="${sessionScope.loginUser.auth<3}">
                                <li id="mn_mf_m_adv"><a href="${root}/company/adv">광고관리</a></li>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.auth==0}">
                            <li id="mn_md_m_vm-issue"><a href="${root}/admin/vm-issue">자판기이슈조회</a></li>
                            <li id="mn_md_m_log"><a href="${root}/admin/log">자판기로그조회</a></li>
                            <li id="mn_md_m_code"><a href="${root}/admin/code">코드관리</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);" id="lnb_m_company"><img src="${root}/resources/images/ic_lnb3.png">운영권한</a>
                        <ul class="depth2">
                            <c:if test="${sessionScope.loginUser.auth==0}">
                                <li id="mn_mf_m_company"><a href="${root}/company/register">소속관리</a></li>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.auth<3}">
                                <li id="mn_mf_m_orig"><a href="${root}/company/orig">조직관리</a></li>
                                <li id="mn_mf_m_user"><a href="${root}/company/user">사용자관리</a></li>
                            </c:if>
                            <li id="mn_mf_m_vending-machine"><a href="${root}/company/vending-machine">자판기관리</a></li>
                            <c:if test="${sessionScope.loginUser.auth<3}">
                                <li id="mn_mf_m_event"><a href="${root}/company/event">이벤트관리</a></li>
                            </c:if>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);" id="lnb_m_product"><img src="${root}/resources/images/ic_lnb4.png">상품관리</a>
                        <ul class="depth2">
                            <li id="mn_mg_m_list"><a href="${root}/product/list">상품마스터정보</a></li>
                            <%--<li id="mn_mg_m_vending-machine"><a href="${root}/product/vending-machine">자판기 상품현황</a></li>--%>
                            <c:if test="${sessionScope.loginUser.auth < 4}">
                                <li id="mn_mg_m_copy"><a href="${root}/product/copy">상품마스터복제</a></li>
                            </c:if>
                            <li id="mn_mg_m_vending-machine"><a href="${root}/product/vending-machine">자판기상품정보</a></li>
                            <li id="mn_mg_m_download"><a href="${root}/product/download">상품정보업데이트</a></li>

                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);" id="lnb_m_sales"><img src="${root}/resources/images/ic_lnb5.png">매출관리</a>
                        <ul class="depth2">
                            <li id="mn_ms_m_transaction"><a href="${root}/sales/transaction">거래내역</a></li>
                            <li id="mn_ms_m_salesReport"><a href="${root}/sales/salesReport">매출집계</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);" id="lnb_m_board"><img src="${root}/resources/images/ic_lnb6.png">이력관리</a>
                        <ul class="depth2">
                            <li id="mn_mv_m_store"><a href="${root}/board/store">입고현황</a></li>
                            <li id="mn_mv_m_release"><a href="${root}/board/release">출고현황</a></li>
                            <li id="mn_mv_m_stock"><a href="${root}/board/stock">재고현황</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0);" id="lnb_m_customer"><img src="${root}/resources/images/ic_lnb7.png">고객센터</a>
                        <ul class="depth2">
                            <li id="mn_mc_m_notice"><a href="${root}/customer/notice">공지사항</a></li>
                        </ul>
                    </li>
                    <li class="ic_none m_logout">
                        <a href="${root}/logout"><img src="${root}/resources/images/logout2.png">로그아웃</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="aside_dim"></div>
    </div>
    <!-- //m_nav -->
</div>
<!-- //header2 -->
<script type="text/javascript">
    var header = $('#gnb, #gnb_m');
    $(window).scroll(function(e){
        if(header.offset().top !== 0){
            if(!header.hasClass('shadow')){
                header.addClass('shadow');
            }
        }else{
            header.removeClass('shadow');
        }
    });

    /*$(function () {
        $(".depth-1 li a").click(function () {
            $(this).addClass("on");
            $(this).parent("li").addClass("current");
            $(".depth-1 li").addClass("on");
            $(".depth-1").not().addClass("on");
            $(this).addClass("current");
        });
        $('.depth-2 > li > a').click(function(e){

            $(this).parent("li").addClass("current");
            //e.stopPropagation();
        })
    })*/

   /*$(document).ready(function(){

        $('li > a').click(function(){
            //$(this).next($('.depth-2')).slideToggle('fast');
            $(this).next($('.depth-2')).slideToggle('on');
        })
        $('.depth-2 > li > a').click(function(e){
            e.stopPropagation();
        })

        // 버튼 클릭 시 색 변경
        $('.depth-1 li a').focus(function(){
            $(this).addClass('on');
        })
       $(".depth-1 li a").blur(function(){
           $(this).removeClass('on');
       })
       $('.depth-1 li a').focus(function(){
           $(this).addClass('current');
       })
        $(".depth-2 li a").blur(function(){
            $(this).removeClass('current');
        })

    })*/
</script>
