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
        <!-- 컨텐츠 : 중간 : 컨텐츠 영역 -->

        <section id="body_contents" class="">
            <div class="table_outline3">
                <table class="bbs_view" summary="게시물 상세보기입니다">
                    <caption class="blind">게시물 상세</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="80%" />
                    <colgroup>
                    <tbody>
                    <tr>
                        <th class="subject" colspan="2">${noticeInfo.title}</th>
                    </tr>
                    <tr>
                        <td class="view_detail" colspan="2">
                            <span>작성자 : 관리자</span><span>등록일 : ${noticeInfo.createDate}</span>
                            <c:if test="${!empty noticeFile}">
                                <span class="attachFile"><img src="${root}/resources/images/ic_attach.png">첨부파일 :
                                <c:forEach var='noticeFile' items="${noticeFile}" varStatus="status">
                                    <a href="${noticeFile.fileRealName}" download="${noticeFile.fileName}"><U>${noticeFile.fileName}</U></a>&nbsp;
                                    <%--<c:if test="${noticeFile[status.index+1].fileRealName ne null}">
                                        ,&nbsp;
                                    </c:if>--%>

                                </c:forEach>
                                </span>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="view_content" colspan="2">
                            ${noticeInfo.content}
                        </td>
                    </tr>
                    <tr>
                        <th>▲&nbsp;&nbsp;이전글</th>
                        <c:if test="${prev eq null}">
                            <td class="cont"><a>이전글이 없습니다.</a></td>
                        </c:if>
                        <c:if test="${prev ne null}">
                            <td class="cont"><a href="${root}/customer/view?seq=${prev.seq}">${prev.title}</a></td>
                        </c:if>
                    </tr>
                    <tr>
                        <th>▼&nbsp;&nbsp;다음글</th>
                        <c:if test="${next eq null}">
                            <td class="cont"><a>다음글이 없습니다.</a></td>
                        </c:if>
                        <c:if test="${next ne null}">
                            <td class="cont"><a href="${root}/customer/view?seq=${next.seq}">${next.title}</a></td>
                        </c:if>
                    </tr>
                    </tbody>
                </table>
                <div class="bottom_btn">
                    <ul>
                        <li></li>
                        <li>
                            <a href="${root}/customer/notice" class="button btn_delete">목록</a>
                            <c:if test="${sessionScope.loginUser.auth==0}">
                            <a href="${root}/customer/write?seq=${noticeInfo.seq}" class="button btn_delete" onclick="">수정</a><a href="javascript:deleteData(${noticeInfo.seq});" class="button btn_delete" onclick="">삭제</a>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
    </section>
</div>
<script type="text/javascript">
    function deleteData(seq){
        if(!confirm("정말 삭제하시겠습니까?"))	return;
        $.ajax({
            url:'${root}/customer/ajax/delete.do',
            type : 'GET',
            data: {seq:seq},
            success:function(response){
                alert(response);
                location.href="${root}/customer/notice";
            },
            error: function (xhr, status, error) {console.log(error);}
        });

    }

</script>
</body>
</html>
