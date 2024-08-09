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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1.0, minimum-scale=1, user-scalable=yes,initial-scale=1.0" />
    <c:set var="root" value="${pageContext.request.contextPath}" />
    <title>공지사항</title>
    <%--<link rel="stylesheet" type="text/css" href="${root}/resources/gu-upload/css/guupload.css"/>
    <script type="text/javascript" src="${root}/resources/gu-upload/guuploadManager.js"></script>--%>
    <script src="${root}/resources/ckeditor/ckeditor.js"></script>
    <script src="${root}/resources/ckeditor/config.js"></script>
    <script type="text/javascript" src="${root}/resources/js/common2.js"></script>
</head>
<style>
    .resize_tr{
        max-height: 300px;
    }
    input.upload-name.input_width3 {
        height: 150px!important;
        white-break:normal;
    }
    .guFileList {
        border: 1px solid #d9d9d9;
    }
    .uploadHead {
        border-color: #e1e1e1;
    }
    /*div#attachFile {
        float: left;
    }*/
    .filebox.bs3-primary {
        margin-top: 5px;
    }
    .guFileList {
        height: 133px;
        background-color: #f5f5f5;
    }
    /*background-color: #f5f5f5;*/
    /*border: 1px solid #ebebeb;*/
    .upload-btn-wrapper {
        position: relative;
        overflow: hidden;
        display: inline-block;
    }

    .upload-btn {
        border: 2px solid gray;
        color: gray;
        background-color: white;
        padding: 8px 20px;
        border-radius: 8px;
        font-size: 20px;
        font-weight: bold;
    }

    .upload-btn-wrapper input[type=file] {
        font-size: 100px;
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
    }

    #fileDragDesc {
        width: 100%;
        height: 100%;
        margin-left: auto;
        margin-right: auto;
        padding: 5px;
        text-align: center;
        line-height: 133px;
        vertical-align:middle;
    }

    #attachFile {
        height: 133px;
        background-color: #f5f5f5;
        border: 1px solid #d9d9d9;
        border-color: #e1e1e1;
    }
      /*#dropZone {
          width: 100%;
          height: 133px;
          background-color: #f5f5f5;
          border: 1px solid #d9d9d9;
          border-color: #e1e1e1;
      }*/

</style>
<script type="text/javascript">

    window.onload = function() {
        if($('#type').val()=='update'){
            $("#fileDragDesc").hide();
            $("fileListTable").show();
        }
    }
    //https://pqina.nl/filepond/  registerPlugin fileupload https://codepen.io/jujuc/pen/MWWzYMZ
    function afterFileTransfer(realname, filename, filesize){
        var realname9 = document.getElementById( 'realname' );
        var filename9 = document.getElementById( 'filename' );
        var filesize9 = document.getElementById( 'filesize' );

        realname9.value = realname;
        filename9.value = filename;
        filesize9.value = filesize;

        document.write_form.submit();
    }


    $(document).ready(function (){
        $('#mn_mc_notice').addClass("current");
        $('#lnb_customer').addClass("on");
        $('#mn_mc_m_notice').addClass("current");
        $('#lnb_m_customer').addClass("on");
        $('#lnb_m_customer').next('ul').css('display','block');
        $('#lnb_customer').children('ul').show();
        $('.subtit').text("공지사항")

        ck4 = CKEDITOR.replace("content_v2",{
            //filebrowserUploadMethod :'form',
            filebrowserUploadUrl: '/customer/ckeditor/file-upload.do'
        });


        /*var fileTarget = $('.filebox .upload-hidden');

        fileTarget.on('change', function(){
            if(window.FileReader){
                var filename = $(this)[0].files[0].name;
            } else {
                var filename = $(this).val().split('/').pop().split('\\').pop();
            }

            $(this).siblings('.upload-name').val(filename+"");
        });*/

        $("#input_file").bind('change', function() {
            selectFile(this.files);
            //this.files[0].size gets the size of your file.
            //alert(this.files[0].size);
        });

        /*var option = {
            fileid: "attachFile",
            uploadURL: "customer/ajax/uploadFile.do",
            maxFileSize: 12,
            maxFileCount: 4,
            useButtons: false,
            afterFileTransfer: afterFileTransfer
        }
        guManager = new guUploadManager(option);*/
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
                <input type="hidden" id="fileCount" name="fileCount" value="${fileCount}"/>
                <form action="${root}/customer/write" id="write_form" name="write_form" method="post" enctype="multipart/form-data" >
                    <table class="bbs_view" summary="게시물 상세보기입니다">
                        <caption class="blind">게시물 상세</caption>
                        <colgroup>
                            <col width="20%" />
                            <col width="80%" />
                        <colgroup>
                        <tbody>
                        <tr>
                            <th class="subject2">제목</th>
                            <td class="subject2 cont"><input type="text" id="title" name="title" maxlength="30" placeholder="제목을 입력해주세요." value="${noticeInfo.title}"></td>
                            <input type="hidden" id="type" name="type" value="${type}"/>
                            <input type="hidden" id="seq" name="seq" value="${noticeInfo.seq}"/>
                            <input type="hidden" id="createDate" name="createDate"  value="${noticeInfo.createDate}"/>
                            <input type="hidden" id="createUserSeq" name="createUserSeq" value="${noticeInfo.createUserSeq}"/>
                            <input type="hidden" id="modifyDate"  name="modifyDate" value="${noticeInfo.modifyDate}"/>
                            <input type="hidden" id="modifyUserSeq" name="modifyUserSeq" value="${noticeInfo.modifyUserSeq}"/>
                            <input type="hidden" id="file1" name="file1" value="${noticeInfo.file1}"/>
                            <input type="hidden" id="file2" name="file2" value="${noticeInfo.file2}"/>
                            <input type="hidden" id="file3" name="file3" value="${noticeInfo.file3}"/>
                            <input type="hidden" id="file4" name="file4" value="${noticeInfo.file4}"/>
                        </tr>
                        <tr>
                            <td class="view_content2" colspan="2">
                                <!--이곳에 게시판 에디터를 넣어주세요-->
                                <textarea id="content_v2" name="content_v2">${noticeInfo.content}</textarea>
                            </td>
                        </tr>
                        <tr class="resize_tr">
                            <th>첨부파일</th>
                            <td class="cont">
                                <div class="filebox bs3-primary" id="attachFile" style="width:80%;">
                                    <input type="file" id="input_file" name="input_file" multiple="multiple" />
                                    <%--<input class="upload-name input_width3" value="선택된 파일 없음" disabled="disabled">
                                    <label for="ex_filename">파일선택</label>
                                    <input type="file" id="ex_filename" class="upload-hidden" multiple="multiple" onchange="selectedFiles(this)">
                                   <input type="hidden" id="fileListSize" value="${fn:length(noticeFile)}"/>
                                    <c:forEach var="noticeFile" items="${noticeFile}" varStatus="status">
                                        <input type="hidden" id="${'f'+noticeFile.index}" value="${noticeFile.fileName}"/>
                                        <input type="hidden" id="${'rf'+noticeFile.index}" value="${noticeFile.fileSize}"/>
                                        <input type="hidden" id="${'seqf'+noticeFile.index}" value="${noticeFile.seq}"/>
                                    </c:forEach>--%>
                                    <div id="dropZone" style="width:100%; height: 100%;">
                                        <div id="fileDragDesc"> 파일을 드래그 해주세요. </div>
                                        <table id="fileListTable" width="100%" border="0px">
                                            <tbody id="fileTableTbody">
                                            <c:forEach var="noticeFile" items="${noticeFile}" varStatus="status">
                                                <tr id="fileTr_${status.index}">
                                                    <td id="dropZone" class="left">
                                                        <span id="filename_span">${noticeFile.fileName}&ensp;(${noticeFile.fileSize})</span>
                                                        <a type='button' href='#' onclick='deleteFile(${status.index}, ${noticeFile.seq}); return false;' style='color: #a9a9b1;'>&ensp;x</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="filebox bs3-primary">
                                    <label for="ex_filename" onclick="$('#input_file').click();">파일선택</label>
                                </div>

                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="bottom_btn">
                        <ul>
                            <li></li>
                            <li>
                                <a href="javascript:cancelNotice();" class="button btn_delete">취소</a><a href="javascript:void(0)" class="button btn_delete" onclick="if(!checkForm()){ return false;}">등록</a>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>
        </section>
    </section>
</div>
<script type="text/javascript">
    $(function() {
        // 파일 드롭 다운
        fileDropDown();
    });

    function checkForm(){
        //var tit = $('#title').val();
        //var con = document.getElementById("content");
        var tit = document.getElementById("title");
        var contents = CKEDITOR.instances.content_v2.getData();

        if(tit.value ==''){
            alert('제목을 입력하세요.');
            return false;
        }
        if(contents==''){
            alert('내용을 입력하세요.');
            return false;
        }
        //파일체크 추가
        //alert(tit.value +" /와/ "+contents)
        //return true;
        uploadFile();
        //document.getElementById('write_form').submit();
    }

    function selectedFiles(upload){
        var files = upload.files;
        if(files.length > 4){
            alert('첨부한 파일의 개수는 4개까지 가능합니다.');
            $('#ex_filename').val('');
            return false;
        }
        for (var i = 0; i < files.length; i++) {
            //alert("Filename " + files[i].name);
            if(files[i].size >=12000000){
                alert('한개의 파일크기가 12MB를 넘을 수 없습니다.');
                $('#ex_filename').val('');
                return false;
            }

        }
    }
    $(function() {
        $("#undefined").change(function(e){

            alert($('input[type=file]')[0].files[0].name); //파일이름

            //  $('input[type=file]')[0].files[0].name;
            //  $("#imgUpload")[0].files[0].type;
            //  $("#imgUpload")[0].files[0].size;

        });

    });
    function cancelNotice(){
        if(!confirm("정말 취소하시겠습니까? \n입력한 내용은 저장되지 않습니다."))	return;
        location.href="${root}/customer/notice";

    }





    //파일 업로드

    var fileIndex = 0;
    // 등록할 전체 파일 사이즈
    var totalFileSize = 0;
    // 파일 리스트
    var fileList = new Array();
    // 파일 사이즈 리스트
    var fileList_count = 0;
    if($('#type').val() == 'update'){
        fileList_count = ${fileCount}; //$('fileCount').val();
        fileIndex = ${fileCount};
    }
    // 파일 개수
    var fileSizeList = new Array();
    // 등록 가능한 파일 사이즈 MB
    var uploadSize = 12;
    // 등록 가능한 총 파일 사이즈 MB
    var maxUploadSize = 48;

    function fileDropDown() {
        var dropZone = $("#dropZone");
        //Drag기능
        dropZone.on('dragenter', function(e) {
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color', '#E3F2FC');
        });
        dropZone.on('dragleave', function(e) {
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color', '#FFFFFF');
        });
        dropZone.on('dragover', function(e) {
            e.stopPropagation();
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color', '#E3F2FC');
        });
        dropZone.on('drop', function(e) {
            e.preventDefault();
            // 드롭다운 영역 css
            dropZone.css('background-color', '#FFFFFF');

            var files = e.originalEvent.dataTransfer.files;
            if (files != null) {
                if (files.length < 1) {
                    /* alert("폴더 업로드 불가"); */
                    console.log("폴더 업로드 불가");
                    return;
                }else if(fileList_count > 4){
                    alert("첨부할 수 있는 파일은 4개까지 가능합니다.");
                }
                /*else if(fileList.length > 3){
                    alert("첨부할 수 있는 파일은 4개까지 가능합니다.");
                }*/
                else {
                    selectFile(files)
                }
            } else {
                alert("ERROR");
            }
        });
    }

    // 파일 선택시
    function selectFile(fileObject) {
        var files = null;

        if (fileObject != null) {
            // 파일 Drag 이용하여 등록시
            files = fileObject;
        } else {
            // 직접 파일 등록시
            files = $('#multipaartFileList_' + fileIndex)[0].files;
        }

        // 다중파일 등록
        if (files != null) {

            if (( files != null && files.length > 0 ) || fileList_count!=0) {
                $("#fileDragDesc").hide();
                $("fileListTable").show();
            } else {
                $("#fileDragDesc").show();
                $("fileListTable").hide();
            }

            for (var i = 0; i < files.length; i++) {
                // 파일 이름
                var fileName = files[i].name;
                var fileNameArr = fileName.split("\.");
                // 확장자
                var ext = fileNameArr[fileNameArr.length - 1];

                var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
                console.log("fileSize="+fileSize);
                if (fileSize <= 0) {
                    console.log("0kb file return");
                    return;
                }

                var fileSizeKb = fileSize / 1024; // 파일 사이즈(단위 :kb)
                var fileSizeMb = fileSizeKb / 1024;    // 파일 사이즈(단위 :Mb)

                var fileSizeStr = "";
                if ((1024*1024) <= fileSize) {    // 파일 용량이 1메가 이상인 경우
                    console.log("fileSizeMb="+fileSizeMb.toFixed(2));
                    fileSizeStr = fileSizeMb.toFixed(2) + " MB";
                } else if ((1024) <= fileSize) {
                    console.log("fileSizeKb="+parseInt(fileSizeKb));
                    fileSizeStr = parseInt(fileSizeKb) + " KB";
                } else {
                    console.log("fileSize="+parseInt(fileSize));
                    fileSizeStr = parseInt(fileSize) + " byte";
                }

                /* if ($.inArray(ext, [ 'exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml' ]) >= 0) {
                    // 확장자 체크
                    alert("등록 불가 확장자");
                    break; */
                if ($.inArray(ext, [ 'hwp', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'png', 'pdf', 'jpg', 'jpeg', 'gif', 'zip' ]) <= 0) {
                    // 확장자 체크
                    /* alert("등록이 불가능한 파일 입니다.");
                    break; */
                    alert("등록이 불가능한 파일 입니다.("+fileName+")");
                } else if (fileSizeMb > uploadSize) {
                    // 파일 사이즈 체크
                    alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
                    break;
                } else if((fileList_count+1) >4){
                    alert("첨부할 수 있는 파일은 4개까지 가능합니다.");
                }
                else {
                    // 전체 파일 사이즈
                    totalFileSize += fileSizeMb;
                    fileList_count ++;

                    // 파일 배열에 넣기
                    fileList[fileIndex] = files[i];

                    // 파일 사이즈 배열에 넣기
                    fileSizeList[fileIndex] = fileSizeMb;

                    // 업로드 파일 목록 생성
                    addFileList(fileIndex, fileName, fileSizeStr);

                    // 파일 번호 증가
                    fileIndex++;
                }
            }
        } else {
            alert("ERROR");
        }
    }

    // 업로드 파일 목록 생성
    function addFileList(fIndex, fileName, fileSizeStr) {
        /* if (fileSize.match("^0")) {
            alert("start 0");
        } */

        var html = "";
        html += "<tr id='fileTr_" + fIndex + "'>";
        html += "    <td id='dropZone' class='left' >";
        html += "<span id='filename_span'>"+fileName + " (" + fileSizeStr +") "
            //+ "<a href='#' onclick='deleteFile(" + fIndex + "); return false;' class='btn small bg_02'> 삭제</a>"
            //+ "<img src=\"/resources/images/ic_close.png\" alt=\"삭제\" onclick='deleteFile(" + fIndex + "); return false;'style=\"vertical-align: middle;\"/></span>"
        + "<a type='button' href='#' onclick='deleteFile(" + fIndex + "); return false;' style='color: #a9a9b1;'>&ensp;x</a>"
        html += "    </td>"
        html += "</tr>"

        $('#fileTableTbody').append(html);
    }

    // 업로드 파일 삭제
    function deleteFile(fIndex, deleteSeq) {

        if(deleteSeq!=null){//if($('#type').val() == 'update'){
            //파일 삭제시 db도 삭제
            if(confirm('파일을 삭제하시겠습니까? \n등록을 취소해도 복구할 수 없습니다.')){
                $.ajax({
                    url : '${root}/customer/ajax/file-delete.do',
                    data : { seq : deleteSeq },
                    type : 'POST',
                    enctype : 'multipart/form-data',
                    success : function(response) {
                        alert(response);
                    }
                });

            }
        }

        console.log("deleteFile.fIndex=" + fIndex);
        // 전체 파일 사이즈 수정
        totalFileSize -= fileSizeList[fIndex];

        // 파일 배열에서 삭제
        delete fileList[fIndex];
        fileList_count--;

        // 파일 사이즈 배열 삭제
        delete fileSizeList[fIndex];

        // 업로드 파일 테이블 목록에서 삭제
        $("#fileTr_" + fIndex).remove();

        console.log("totalFileSize="+totalFileSize+", fileList_count="+fileList_count);

        if (totalFileSize > 0 || fileList_count != 0) {
            $("#fileDragDesc").hide();
            $("fileListTable").show();
        } else {
            $("#fileDragDesc").show();
            //$("#fileDragDesc").hide();
            $("fileListTable").hide();
        }

    }

    // 파일 등록
    function uploadFile() {
        // 등록할 파일 리스트
        var uploadFileList = Object.keys(fileList);
        var contents = CKEDITOR.instances.content_v2.getData();


        // 파일이 있는지 체크
        /*if (uploadFileList.length > 4) {
            // 파일등록 경고창
            alert("파일");
            return;
        }
    */
        // 용량을 500MB를 넘을 경우 업로드 불가
        if (totalFileSize > maxUploadSize) {
            // 파일 사이즈 초과 경고창
            alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
            return;
        }

        if (confirm("등록 하시겠습니까?")) {
            // 등록할 파일 리스트를 formData로 데이터 입력
            var form = $('#write_form')[0];
            var formData = new FormData(form);
            formData.append("content", contents);
            for (var i = 0; i < uploadFileList.length; i++) {
                formData.append('files', fileList[uploadFileList[i]]);
            }
            //alert(formData+" d/d "+fileList+" s/s "+ uploadFileList+" count: "+fileList_count); return false;

            $.ajax({
                url : '${root}/customer/write',
                data : formData,
                type : 'POST',
                enctype : 'multipart/form-data',
                processData : false,
                contentType : false,
                async: false,
                //dataType : 'json',
                //cache : false,
                success : function(response) {
                   location.href='${root}/customer/view?seq='+response;
                }
            });
        }
    }



</script>
</body>
</html>
