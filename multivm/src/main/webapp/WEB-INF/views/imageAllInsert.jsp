<%--
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-08
  Time: 오후 3:21
  전체 상품정보.
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

    <%--<link rel="stylesheet" href="${root}/resources/css/jquery.dm-uploader.min.css">
    <link rel="stylesheet" href="${root}/resources/css/jquery.dm-uploader.css">--%>
    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">--%>
    <%--<link href="${root}/resources/fine-uploader/fine-uploader-gallery.min.css" rel="stylesheet">--%>
    <link href="${root}/resources/fine-uploader/fine-uploader-new.css" rel="stylesheet">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="${root}/resources/js/jquery-3.6.0.min.js"></script>
   <%-- <script src="${root}/resources/fine-uploader/fine-uploader.min.js"></script>--%>
    <script src="${root}/resources/fine-uploader/fine-uploader.js"></script>


    <script type="text/template" id="qq-template-manual-trigger">
        <div class="qq-uploader-selector qq-uploader" qq-drop-area-text="파일을 드래그 해주세요.">
            <div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
                <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
            </div>
            <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
                <span class="qq-upload-drop-area-text-selector"></span>
            </div>
            <div class="buttons buttons1">
                <div class="qq-upload-button-selector qq-upload-button">
                    <div>파일선택</div>
                </div>
                <div class="qq-submit-button">
                    <button type="button" id="trigger-upload" class="btn btn-primary">
                        <i class="icon-upload icon-white"></i> 적용하기
                    </button>
                </div>
            </div>
            <span class="qq-drop-processing-selector qq-drop-processing">
                <span>Processing dropped files...</span>
                <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
            </span>
            <ul class="qq-upload-list-selector qq-upload-list" aria-live="polite" aria-relevant="additions removals">
                <li>
                    <div class="qq-progress-bar-container-selector">
                        <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-progress-bar-selector qq-progress-bar"></div>
                    </div>
                    <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                    <img class="qq-thumbnail-selector" qq-max-size="100" qq-server-scale>
                    <span class="qq-upload-file-selector qq-upload-file"></span>
                    <span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
                    <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
                    <span class="qq-upload-size-selector qq-upload-size"></span>
                    <button type="button" class="qq-btn qq-upload-cancel-selector qq-upload-cancel">취소</button>
                    <button type="button" class="qq-btn qq-upload-retry-selector qq-upload-retry">다시시도</button>
                    <button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">삭제</button>
                    <span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
                </li>
            </ul>

            <dialog class="qq-alert-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">닫기</button>
                </div>
            </dialog>

            <dialog class="qq-confirm-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">아니오</button>
                    <button type="button" class="qq-ok-button-selector">예</button>
                </div>
            </dialog>

            <dialog class="qq-prompt-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <input type="text">
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">취소</button>
                    <button type="button" class="qq-ok-button-selector">업로드</button>
                </div>
            </dialog>
        </div>
    </script>

    <style>
        #body_header {margin:0; display: block; font-weight: bold; font-size: 22px; padding-bottom: 16px;}
        .buttons1 {
            float: left;
        }
        .qq-submit-button{
            float: left;
        }
        #fine-uploader-manual-trigger .buttons {
            width: 50%!important;
        }
        #trigger-upload {
            color: white;
            width: 125px;
            background-color: #0075fe; /*#00ABC7;*/
            font-size: 14px;
            margin-bottom: 10px;
            padding: 7px 10px;
            background-image: none;
            border-radius: 2px;
            box-shadow: 0 1px 1px rgb(255 255 255 / 37%) inset, 1px 0 1px rgb(255 255 255 / 7%) inset, 0 1px 0 rgb(0 0 0 / 36%), 0 -2px 12px rgb(0 0 0 / 8%) inset;
            border: none;
        }
        .qq-upload-button-hover {
            background: #002060!important;
        }
        #trigger-upload:hover {
            background: #002060!important;
        }

        #fine-uploader-manual-trigger .qq-upload-button {
            margin-right: 15px;
        }

        #fine-uploader-manual-trigger .buttons {
            width: 36%;
        }

        #fine-uploader-manual-trigger .qq-uploader .qq-total-progress-bar-container {
            width: 60%;
        }
    </style>
    <title>상품이미지 일괄업로드</title>
</head>

<body style="background-color: #f6f7fb; font-size: small;">
<%--<div id="wrap">
    <section id="body_wrap">
        <header id="body_header">
            이미지 일괄업로드
        </header>
    </section>
    <div class="col-md-6 col-sm-12">
        &lt;%&ndash;<div class="file-upload-wrapper">
            <input type="file" id="input-file-now" class="file-upload" />
        </div>&ndash;%&gt;
    </div>

</div><!-- /file list -->
</div>--%>
<div id="wrap" style="background-color: #f6f7fb;">
    <!-- body -->
    <section id="body_wrap">
        <header id="body_header">
            상품이미지 일괄 업로드
        </header>
        <span style="color:#453452;">※ 파일명을 엑셀일괄등록시 지정한 '상품이미지 파일명'으로 지정하면 자동매칭 됩니다.(파일확장자(.jpg,.png,..) 제외</span><br/>
        <span style="color:#0074fc;">>> 최대 50개 업로드 가능/파일당 최대 12MB 파일크기 허용</span>
    </section>
    <br/>
    <div id="fine-uploader-manual-trigger"></div>
</div>
<script>
    $(document).ready(function (){
        console.log(${organizationSeq});
    });

    var manualUploader = new qq.FineUploader({
        element: document.getElementById('fine-uploader-manual-trigger'),
        template: 'qq-template-manual-trigger',
        /*scaling: {
            sendOriginal: false,
            sizes: [
                {name: "small", resize:true, maxWidth: 350, maxHeight: 350, quality:100}
            ]
        },*/
        request: {
            endpoint: '${root}/popup/imageAllInsert/upload',
            method: 'POST',
            params: {organizationSeq:${organizationSeq}}
        },
        thumbnails: {
            placeholders: {
                waitingPath: '${root}/resources/fine-uploader/placeholders/waiting-generic.png',
                notAvailablePath: '${root}/resources/fine-uploader/placeholders/not_available-generic.png'
            }
        },
        validation: {
            allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'],
            itemLimit: 100,
            sizeLimit: 12485760 //12MB곶
        },
        callbacks: {
            onComplete: function(id, name, responseJSON, maybeXhr) {
                if(responseJSON.success=="success")
                {
                    alert("successfully uploaded");
                }
            },
            onCancel: function(id, name) {
            },
            onError: function(id, name, reason, maybeXhrOrXdr) {
            },
            onAllComplete: function(successful, failed) {
            }
        },
        autoUpload: false,
        debug: true
    });

    qq(document.getElementById("trigger-upload")).attach("click", function() {
        manualUploader.uploadStoredFiles();
    });

</script>
</body>
</html>
