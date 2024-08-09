<%--
&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: ys958
  Date: 2022-02-18
  Time: 오후 8:38
  To change this template use File | Settings | File Templates.
&ndash;%&gt;
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.1.3/cropper.css">
    <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">-->
    <link type="text/css" href="https://fengyuanchen.github.io/cropperjs/css/cropper.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script src="./js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="./js/jquery.ezmark.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.6/umd/popper.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.1.3/cropper.js"></script>
    <!--<script src="https://fengyuanchen.github.io/cropperjs/js/cropper.js"></script>-->




</head>
<style>
    body {
        margin: 20px;
    }
    .col-md-9 {
        -ms-flex: 0 0 75%;
        flex: 0 0 75%;
        max-width: 100%;
    }

    .btn {
        padding-left: .75rem;
        padding-right: .75rem;
    }

    label.btn {
        margin-bottom: 0;
    }

    .d-flex > .btn {
        flex: 1;
    }
    .row {
        width: 100%;
    }
    .container {
        width: 100%;
    }

    .footer {
        font-size: .875rem;
    }

    .img-container,
    .img-preview {
        background-color: #f7f7f7;
        text-align: center;
        width: 100%;
    }

    .img-container {
        margin-bottom: 1rem;
        //max-height: 497px;
        min-height: 200px;
    }

    @media (min-width: 768px) {
        .img-container {
            min-height: 497px;
        }
    }

    .img-container > img {
        max-width: 100%;
    }

    .docs-preview {
        margin-right: -1rem;
    }

    .img-preview {
        float: left;
        margin-bottom: .5rem;
        margin-right: .5rem;
        overflow: hidden;
    }

    .img-preview > img {
        max-width: 100%;
    }

    .preview-lg {
        height: 9rem;
        width: 16rem;
    }

    .preview-md {
        height: 4.5rem;
        width: 8rem;
    }

    .preview-sm {
        height: 2.25rem;
        width: 4rem;
    }

    .preview-xs {
        height: 1.125rem;
        margin-right: 0;
        width: 2rem;
    }

    .docs-data > .input-group {
        margin-bottom: .5rem;
    }

    .docs-data > .input-group > label {
        justify-content: center;
        min-width: 5rem;
    }

    .docs-data > .input-group > span {
        justify-content: center;
        min-width: 3rem;
    }

    .docs-buttons > .btn,
    .docs-buttons > .btn-group,
    .docs-buttons > .form-control {
        margin-bottom: .5rem;
        margin-right: .25rem;
    }

    .docs-toggles > .btn,
    .docs-toggles > .btn-group,
    .docs-toggles > .dropdown {
        margin-bottom: .5rem;
    }

    .docs-tooltip {
        display: block;
        margin: -.5rem -.75rem;
        padding: .5rem .75rem;
    }

    .docs-tooltip > .icon {
        margin: 0 -.25rem;
        vertical-align: top;
    }

    .tooltip-inner {
        white-space: normal;
    }

    .btn-upload .tooltip-inner,
    .btn-toggle .tooltip-inner {
        white-space: nowrap;
    }

    .btn-toggle {
        padding: .5rem;
    }

    .btn-toggle > .docs-tooltip {
        margin: -.5rem;
        padding: .5rem;
    }

    @media (max-width: 400px) {
        .btn-group-crop {
            margin-right: -1rem!important;
        }
        .btn-group-crop > .btn {
            padding-left: .5rem;
            padding-right: .5rem;
        }
        .btn-group-crop .docs-tooltip {
            margin-left: -.5rem;
            margin-right: -.5rem;
            padding-left: .5rem;
            padding-right: .5rem;
        }
    }

    .docs-options .dropdown-menu {
        width: 100%;
    }

    .docs-options .dropdown-menu > li {
        font-size: .875rem;
        padding-left: 1rem;
        padding-right: 1rem;
    }

    .docs-options .dropdown-menu > li:hover {
        background-color: #f7f7f7;
    }

    .docs-options .dropdown-menu > li > label {
        display: block;
    }

    .docs-cropped .modal-body {
        text-align: center;
    }

    .docs-cropped .modal-body > img,
    .docs-cropped .modal-body > canvas {
        max-width: 100%;
    }
    .btn-group>.btn-group {
        float: left;
        margin-bottom: 0.5rem;
        margin-right: 0.25rem;
    }

</style>

<body>

<div class="modal-content">

    <div class="modal-header">
        <h5 class="modal-title">이미지 변경</h5>



    </div>
    <div class="modal-body">


        <!-- Content -->
        <div class="wrap">
            <div class="">
                <div class="col-md-9">
                    <!-- <h3>Demo:</h3> -->
                    <div class="img-container">
                        <img src="https://fengyuanchen.github.io/cropperjs/images/picture.jpg" alt="Picture">
                    </div>
                </div>

            </div>
        </div>
        <div class="" id="actions">
            <div class="col-md-9 docs-buttons">
                <!-- <h3>Toolbar:</h3> -->
                <button type="button" class="btn btn-primary" data-method="setDragMode" data-option="move" title="Move">
            <span class="docs-tooltip" data-toggle="tooltip" title="cropper.setDragMode(&quot;move&quot;)">
              <span class="fa fa-arrows"></span>
            </span>
                </button>
                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="setDragMode" data-option="crop" title="Crop">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.setDragMode(&quot;crop&quot;)">
              <span class="fa fa-crop"></span>
                  </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="zoom" data-option="0.1" title="Zoom In">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.zoom(0.1)">
              <span class="fa fa-search-plus"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="zoom" data-option="-0.1" title="Zoom Out">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.zoom(-0.1)">
              <span class="fa fa-search-minus"></span>
                  </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="move" data-option="-10" data-second-option="0" title="Move Left">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(-10, 0)">
              <span class="fa fa-arrow-left"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="move" data-option="10" data-second-option="0" title="Move Right">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(10, 0)">
              <span class="fa fa-arrow-right"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="-10" title="Move Up">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(0, -10)">
              <span class="fa fa-arrow-up"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="move" data-option="0" data-second-option="10" title="Move Down">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.move(0, 10)">
              <span class="fa fa-arrow-down"></span>
                  </span>
                    </button>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-primary" data-method="scaleX" data-option="-1" title="Flip Horizontal">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.scaleX(-1)">
              <span class="fa fa-arrows-h"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="scaleY" data-option="-1" title="Flip Vertical">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.scaleY(-1)">
              <span class="fa fa-arrows-v"></span>
                  </span>
                    </button>
                </div>

                <div class="btn-group">

                    <button type="button" class="btn btn-primary" data-method="clear" title="Clear">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.clear()">
              <span class="fa fa-remove"></span>
                  </span>
                    </button>
                    <button type="button" class="btn btn-primary" data-method="reset" title="Reset">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.reset()">
              <span class="fa fa-refresh"></span>
                  </span>
                    </button>
                    <label class="btn btn-primary btn-upload" for="inputImage" title="Upload image file">
                        <input type="file" class="sr-only" id="inputImage" name="file" accept=".jpg,.jpeg,.png,.gif,.bmp,.tiff">
                        <span class="docs-tooltip" data-toggle="tooltip" title="Import image with Blob URLs">
              <span class="fa fa-upload"></span>
                  </span>
                    </label>
                </div>

                <div class="btn-group">

                    <div class="btn-group btn-group-crop">
                        <button type="button" class="btn btn-success" data-method="getCroppedCanvas" data-option="{ &quot;maxWidth&quot;: 4096, &quot;maxHeight&quot;: 4096 }">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.getCroppedCanvas({ maxWidth: 4096, maxHeight: 4096 })">
              저장
            </span>
                        </button>
                        <button type="button" class="btn btn-success" data-method="getCroppedCanvas" data-option="{ &quot;width&quot;: 160, &quot;height&quot;: 90 }">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.getCroppedCanvas({ width: 90, height: 90 })">
              90&times;90
            </span>
                        </button>
                        <button type="button" class="btn btn-success" data-method="getCroppedCanvas" data-option="{ &quot;width&quot;: 320, &quot;height&quot;: 180 }">
                  <span class="docs-tooltip" data-toggle="tooltip" title="cropper.getCroppedCanvas({ width: 180, height: 180 })">
              180&times;180
            </span>
                        </button>


                    <!-- Show the cropped image in modal -->
                    <div class="modal fade docs-cropped" id="getCroppedCanvasModal" role="dialog" aria-hidden="true" aria-labelledby="getCroppedCanvasTitle" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="getCroppedCanvasTitle">Cropped</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body"></div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                                    <a class="btn btn-primary" id="download" href="javascript:void(0);" download="cropped.jpg">로컬에 다운로드</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.modal -->


                </div>
                <!-- /.docs-buttons -->

                <div class="docs-toggles">
                    <!-- <h3>Toggles:</h3> -->
                    <div class="btn-group d-flex flex-nowrap" data-toggle="buttons">


                        <label class="btn btn-primary">
                            <input type="radio" class="sr-only" id="aspectRatio3" name="aspectRatio" value="1">
                            <span class="docs-tooltip" data-toggle="tooltip" title="aspectRatio: 1 / 1">
              1:1
            </span>
                        </label>
                        <label class="btn btn-primary">
                            <input type="radio" class="sr-only" id="aspectRatio5" name="aspectRatio" value="NaN">
                            <span class="docs-tooltip" data-toggle="tooltip" title="aspectRatio: NaN">
              Free
            </span>
                        </label>
                    </div>
                </div>
                <!-- /.docs-toggles -->
            </div>
            </div>
        </div>


    </div>
</div>

<script type="text/javascript">
    let cropper;
    let cropperModalId = '#cropperModal';
    let $jsPhotoUploadInput = $('.js-photo-upload');

    $jsPhotoUploadInput.on('change', function() {
        var files = this.files;
        if (files.length > 0) {
            var photo = files[0];

            var reader = new FileReader();
            reader.onload = function(event) {
                var image = $('.js-avatar-preview')[0];
                image.src = event.target.result;

                cropper = new Cropper(image, {
                    viewMode: 1,
                    aspectRatio: 1,
                    minContainerWidth: 400,
                    minContainerHeight: 400,
                    minCropBoxWidth: 271,
                    minCropBoxHeight: 271,
                    movable: true,
                    ready: function () {
                        console.log('ready');
                        console.log(cropper.ready);
                    }
                });

                $(cropperModalId).modal();
            };
            reader.readAsDataURL(photo);
        }
    });

    $('.js-save-cropped-avatar').on('click', function(event) {
        event.preventDefault();

        console.log(cropper.ready);

        var $button = $(this);
        $button.text('uploading...');
        $button.prop('disabled', true);

        const canvas = cropper.getCroppedCanvas();
        const base64encodedImage = canvas.toDataURL();
        $('#avatar-crop').attr('src', base64encodedImage);
        $(cropperModalId).modal('hide');
    });


    $(document).ready(function() {

        var Cropper = window.Cropper;
        var URL = window.URL || window.webkitURL;
        var container = document.querySelector('.img-container');
        var image = container.getElementsByTagName('img').item(0);
        var cropper;
        var options;

        $('#myModal').on('shown.bs.modal', function(e) {

            //init_cropper();
            cropper.destroy();
            cropper = new Cropper(image, options);
        })

        window.onload = init_cropper();

        function init_cropper() {

            'use strict';

            var download = document.getElementById('download');
            var actions = document.getElementById('actions');
            var dataX = document.getElementById('dataX');
            var dataY = document.getElementById('dataY');
            var dataHeight = document.getElementById('dataHeight');
            var dataWidth = document.getElementById('dataWidth');
            var dataRotate = document.getElementById('dataRotate');
            var dataScaleX = document.getElementById('dataScaleX');
            var dataScaleY = document.getElementById('dataScaleY');
            options = {
                aspectRatio: 321 / 180,
                preview: '.img-preview',
                ready: function(e) {
                    console.log(e.type);
                },
                cropstart: function(e) {
                    console.log(e.type, e.detail.action);
                },
                cropmove: function(e) {
                    console.log(e.type, e.detail.action);
                },
                cropend: function(e) {
                    console.log(e.type, e.detail.action);
                },
                crop: function(e) {
                    var data = e.detail;

                    console.log(e.type);
                    dataX.value = Math.round(data.x);
                    dataY.value = Math.round(data.y);
                    dataHeight.value = Math.round(data.height);
                    dataWidth.value = Math.round(data.width);
                    dataRotate.value = typeof data.rotate !== 'undefined' ? data.rotate : '';
                    dataScaleX.value = typeof data.scaleX !== 'undefined' ? data.scaleX : '';
                    dataScaleY.value = typeof data.scaleY !== 'undefined' ? data.scaleY : '';
                },
                zoom: function(e) {
                    console.log(e.type, e.detail.ratio);
                }
            };
            cropper = new Cropper(image, options);
            var originalImageURL = image.src;
            var uploadedImageType = 'image/jpeg';
            var uploadedImageURL;

            // Tooltip
            $('[data-toggle="tooltip"]').tooltip();

            // Buttons
            if (!document.createElement('canvas').getContext) {
                $('button[data-method="getCroppedCanvas"]').prop('disabled', true);
            }

            if (typeof document.createElement('cropper').style.transition === 'undefined') {
                $('button[data-method="rotate"]').prop('disabled', true);
                $('button[data-method="scale"]').prop('disabled', true);
            }

            // Download
            if (typeof download.download === 'undefined') {
                download.className += ' disabled';
            }

            // Options
            actions.querySelector('.docs-toggles').onchange = function(event) {
                var e = event || window.event;
                var target = e.target || e.srcElement;
                var cropBoxData;
                var canvasData;
                var isCheckbox;
                var isRadio;

                if (!cropper) {
                    return;
                }

                if (target.tagName.toLowerCase() === 'label') {
                    target = target.querySelector('input');
                }

                isCheckbox = target.type === 'checkbox';
                isRadio = target.type === 'radio';

                if (isCheckbox || isRadio) {
                    if (isCheckbox) {
                        options[target.name] = target.checked;
                        cropBoxData = cropper.getCropBoxData();
                        canvasData = cropper.getCanvasData();

                        options.ready = function() {
                            console.log('ready');
                            cropper.setCropBoxData(cropBoxData).setCanvasData(canvasData);
                        };
                    } else {
                        options[target.name] = target.value;
                        options.ready = function() {
                            console.log('ready');
                        };
                    }

                    // Restart
                    cropper.destroy();
                    cropper = new Cropper(image, options);
                }
            };

            // Methods
            actions.querySelector('.docs-buttons').onclick = function(event) {
                var e = event || window.event;
                var target = e.target || e.srcElement;
                var cropped;
                var result;
                var input;
                var data;

                if (!cropper) {
                    return;
                }

                while (target !== this) {
                    if (target.getAttribute('data-method')) {
                        break;
                    }

                    target = target.parentNode;
                }

                if (target === this || target.disabled || target.className.indexOf('disabled') > -1) {
                    return;
                }

                data = {
                    method: target.getAttribute('data-method'),
                    target: target.getAttribute('data-target'),
                    option: target.getAttribute('data-option') || undefined,
                    secondOption: target.getAttribute('data-second-option') || undefined
                };

                cropped = cropper.cropped;

                if (data.method) {
                    if (typeof data.target !== 'undefined') {
                        input = document.querySelector(data.target);

                        if (!target.hasAttribute('data-option') && data.target && input) {
                            try {
                                data.option = JSON.parse(input.value);
                            } catch (e) {
                                console.log(e.message);
                            }
                        }
                    }

                    switch (data.method) {
                        case 'rotate':
                            if (cropped) {
                                cropper.clear();
                            }

                            break;

                        case 'getCroppedCanvas':
                            try {
                                data.option = JSON.parse(data.option);
                            } catch (e) {
                                console.log(e.message);
                            }

                            if (uploadedImageType === 'image/jpeg') {
                                if (!data.option) {
                                    data.option = {};
                                }

                                data.option.fillColor = '#fff';
                            }

                            break;
                    }

                    result = cropper[data.method](data.option, data.secondOption);

                    switch (data.method) {
                        case 'rotate':
                            if (cropped) {
                                cropper.crop();
                            }

                            break;

                        case 'scaleX':
                        case 'scaleY':
                            target.setAttribute('data-option', -data.option);
                            break;

                        case 'getCroppedCanvas':
                            if (result) {
                                // Bootstrap's Modal
                                $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);

                                if (!download.disabled) {
                                    download.href = result.toDataURL(uploadedImageType);
                                }
                            }

                            break;

                        case 'destroy':
                            cropper = null;

                            if (uploadedImageURL) {
                                URL.revokeObjectURL(uploadedImageURL);
                                uploadedImageURL = '';
                                image.src = originalImageURL;
                            }

                            break;
                    }

                    if (typeof result === 'object' && result !== cropper && input) {
                        try {
                            input.value = JSON.stringify(result);
                        } catch (e) {
                            console.log(e.message);
                        }
                    }
                }
            };

            document.body.onkeydown = function(event) {
                var e = event || window.event;

                if (!cropper || this.scrollTop > 300) {
                    return;
                }

                switch (e.keyCode) {
                    case 37:
                        e.preventDefault();
                        cropper.move(-1, 0);
                        break;

                    case 38:
                        e.preventDefault();
                        cropper.move(0, -1);
                        break;

                    case 39:
                        e.preventDefault();
                        cropper.move(1, 0);
                        break;

                    case 40:
                        e.preventDefault();
                        cropper.move(0, 1);
                        break;
                }
            };

            // Import image
            var inputImage = document.getElementById('inputImage');

            if (URL) {
                inputImage.onchange = function() {
                    var files = this.files;
                    var file;

                    if (cropper && files && files.length) {
                        file = files[0];

                        if (/^image\/\w+/.test(file.type)) {
                            uploadedImageType = file.type;

                            if (uploadedImageURL) {
                                URL.revokeObjectURL(uploadedImageURL);
                            }

                            image.src = uploadedImageURL = URL.createObjectURL(file);
                            cropper.destroy();
                            cropper = new Cropper(image, options);
                            inputImage.value = null;
                        } else {
                            window.alert('Please choose an image file.');
                        }
                    }
                };
            } else {
                inputImage.disabled = true;
                inputImage.parentNode.className += ' disabled';
            }
        };

    });


</script>
</body>
</html>
--%>
