<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>멀티자판기</title>

    <link rel="stylesheet" href="${root}/resources/css/resset.css">
    <link rel="stylesheet" href="${root}/resources/css/layout.css">
    <link rel="stylesheet" href="${root}/resources/css/contents.css">
    <link rel="stylesheet" href="${root}/resources/css/basic.css">
    <link rel="stylesheet" href="${root}/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.min.css">
    <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9">
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>--%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="${root}/resources/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="${root}/resources/js/jquery.ezmark.min.js"></script>
    <script type="text/javascript" src="${root}/resources/js/common.js"></script>
    <script type="text/javascript" src="${root}/resources/js/index.js"></script>
    <script src="${root}/resources/js/paging.js"></script>
    <script type="text/javascript" src="${root}/resources/js/util.js"></script>

</head>
<body>
<div id="wrap">
    <!-- header -->
    <div id="gnb" class="gnb">
        <ul>
            <li><h1 class="ubcn-logo"><img src="${root}/resources/images/ubcn.png" onclick="location.href='${root}/index';" alt="bingo multi 관리자"></h1></li>
                <%--<li><h1 class="ubcn-logo"><img src="${root}/resources/images/ubcn.png" onclick="alert(seriesData);" alt="bingo multi 관리자"></h1></li>--%>
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
    <script type="text/javascript">
        //<![CDATA[
        var header = $('#gnb,#gnb_m');
        $(window).scroll(function(e){
            if(header.offset().top !== 0){
                if(!header.hasClass('shadow')){
                    header.addClass('shadow');
                }
            }else{
                header.removeClass('shadow');
            }
        });
        //]]>
    </script>
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
                        <li class="ic_none" id="lnb_m_admin1">
                            <%--<a href="#none"><img src="${root}/resources/images/ic_lnb1.png">관리자시스템</a>--%>
                        </li>
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


    <!-- body -->
    <section id="body_wrap">
        <header id="body_header" class="item_none">
            빙고멀티 관리시스템
        </header>

        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->
        <div class="main_greeting">
            <ul>
                <li>안녕하세요, ${sessionScope.loginUser.name}님!</li>
                <li>MVP 관리시스템에 오신 것을 환영합니다</li>
            </ul>
        </div>

        <section id="body_contents" class="">
            <div>
                <div class="main_group">
                    <div class="graph_box">
                        <ul class="contetns_title_sales2 line_none" style="pointer-events: none;">
                            <li>
                                <ul class="tabs3">
                                    <li class="current" data-tab="tab-1">주간매출</li>
                                    <%--<li data-tab="tab-2"></li>--%>
                                </ul>
                            </li>
                        </ul>
                        <ul class="graph_view_none" style="display: none;">
                            등록된 매출이 없습니다.
                        </ul>
                        <ul class="graph_view weekly" style="text-align: center;">
                            <div id="bar_graph" style="height:100%;width:100%;"></div>
                        </ul>
                        <ul class="graph_view monthly" style="text-align: center; display: none;">
                            <div id="bar_graph2" style="height:100%;width:100%;"></div>
                        </ul>
                    </div>
                    <div class="notice_box">
                        <c:if test="${!empty noticeList}">
                            <ul class="contetns_title">
                                <li>공지사항</li>
                                <li>
                                        <a class="btn_more" href="${root}/customer/notice">더보기</a>
                                </li>
                            </ul>
                            <ul class="notice_list">
                                <c:forEach var="noticeList" items="${noticeList}">
                                <li><div><a href="${root}/customer/view?seq=${noticeList.seq}">${noticeList.title}</a></div><span>${noticeList.createDate}</span></li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${empty noticeList}">
                            <ul class="notice_list_none">
                            등록된 게시물이 없습니다.
                            </ul>
                        </c:if>
                    </div>
                </div>
                <div class="main_group2">
                    <div class="sales_box">
                        <div class="sales_yesterday">
                            <ul>
                                <li><img src="${root}/resources/images/ic_sales01.png"></li>
                                <li>전일 매출현황</li>
                                <li>\ <fmt:formatNumber value="${yesterdayAmount}" pattern="#,###" /></li>
                            </ul>
                        </div>
                        <div class="sales_today">
                            <ul>
                                <li><img src="${root}/resources/images/ic_sales02.png"></li>
                                <li>금일 매출현황</li>
                                <li>\ <fmt:formatNumber value="${todayAmount}" pattern="#,###" /></li>
                            </ul>
                        </div>
                    </div>
                    <div class="sales_shop">
                        <ul class="contetns_title">
                            <li>매장 매출현황</li>
                            <li></li>
                        </ul>
                        <c:if test="${empty salesList}">
                        <div class="table_outline2_none">
                            등록된 내용이 없습니다.
                        </div>
                        </c:if>
                        <c:if test="${!empty salesList}">
                        <div class="table_responsive"><%--table_outline2 init_2--%>
                                    <table class="tb_horizen2 m_tb_horizen2">
                                        <colgroup>
                                            <col width="15%">
                                            <col width="30%">
                                            <col width="30%">
                                            <col width="25%">
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>매장</th>
                                            <th>금일 매출</th>
                                            <th>건수</th>
                                        </tr>
                                        </thead>
                                        <tbody id="Dash_Table_Body1">
                                        <c:forEach var='salesList' items="${salesList}" varStatus="status">
                                            <c:if test="${salesList eq null}">
                                                등록된 내용이 없습니다.
                                            </c:if>
                                            <tr>
                                                <td><c:out value="${status.count}" /></td>
                                                <td>${salesList.place}</td>
                                                <td><fmt:formatNumber value="${salesList.amount}" pattern="#,###" /></td>
                                                <td>${salesList.itemCount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </section>
    </section>
</div>

<div class="copyright">Copyright © 2022 유비씨엔(주) All Rights Reserved.</div>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript">
    var xAxis = ${xAxis};
    var seriesData =${series};

    if(seriesData==null||seriesData==''){
        $('.graph_view_none').show();
        $('.graph_view').hide();
    }

    const chart = Highcharts.chart('bar_graph', {
        title: {
            text: ''
        },
        subtitle: {
            text: ''
        },
        exporting: {
            enabled: false
        },
        credits: {enabled: false},
        yAxis: {
            title: {
                text: ''
            },
            labels:{
                format:'{value:,.0f}'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        plotOptions: {
            column: {
                dataLabels: { enabled: true }
            }
        },
        xAxis: xAxis
        //,series: series
        ,series: [{
            type: 'column',
            data: seriesData,
            showInLegend: false
        }]
        ,tooltip: {
            formatter: function() {
                return '' + this.point.y.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")+' 원<br/>[판매상품개수: '+ this.point.itemCount+' 건]';
            }
        }
    });

    function openM(){
        $('#left_fix_bar').show()
    }

    //Toast 메시지
    $(document).ready(function() {
        iziToast.show({
            id: 'yshwang',
            theme: 'dark',
            icon: 'far fa-gear',
           // title: '🚨 [자판기 매출정보 서비스 검색기간 조정]',
            title: '🚨 [사이트 안내]',
            displayMode: 2,
            message: '사이트 정상적인 이용을 위해' +
                '<br>' +
                '키보드의 Ctrl + R 을 입력하여 새로고침을 부탁드립니다.'
            ,
            position: 'topCenter', // bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter
            transitionIn: 'flipInX',
            transitionOut: 'flipOutX',
            progressBarColor: 'rgb(0, 255, 184)',
            //image: './pop/img/bullhorn.png',
            imageWidth: 70,
            layout: 2,
            timeout: 100000,
            onClosing: function(){
                //console.info('onClosing');
            },
            onClosed: function(instance, toast, closedBy){
               // console.info('Closed | closedBy: ' + closedBy);
            },
            iconColor: 'rgb(0, 255, 184)'
        });

        /*iziToast.warning({
                title: '프로세스 에러 발생',
                message: '미등록가맹점 - 영광자판음료',
                position: 'topCenter',
            });*/

        /*
        iziToast.info({
            title: 'UBCn Toast 내부 테스트',
            message: '내부만 보여지는 내용입니다.',
            position: 'topLeft'
        });
        iziToast.error({
            title: 'UBCn Toast 내부 테스트',
            message: '내부만 보여지는 내용입니다.',
            position: 'topLeft'
        });
        iziToast.question({
            title: 'UBCn Toast 내부 테스트',
            message: '내부만 보여지는 내용입니다.',
            position: 'topLeft'
        });
        */

    });


</script>
</body>
</html>