/**
 * @license Copyright (c) 2003-2022, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
    //1
    config.resize_dir = 'both';  //  사이즈 둘 다 조정
    config.image_previewText = ' ';
    config.enterMode = '2';// 엔터모드는 <br/>

    config.extraPlugins = 'autolink';
    config.extraPlugins = 'imageresize';
    config.extraPlugins = 'uploadfile';
    config.extraPlugins = 'uploadwidget';
    config.extraPlugins = 'emoji';
    //config.extraPlugins = 'easyimage';
    config.removePlugins = 'easyimage, cloudservices, exportpdf, youtube';
    config.cloudServices_tokenUrl = 'https://example.com/cs-token-endpoint';
    config.cloudServices_uploadUrl = '/app/Data';
    config.resize_enabled = false;

    /*config.filebrowserUploadUrl      = '/notice/ckedit/fileupload.do';
    config.filebrowserImageUploadUrl = '/notice/ckedit/fileupload.do';
    config.imageUploadUrl = '/notice/ckedit/fileupload.do';*/

    /*config.toolbarGroups = [
        { name: 'clipboard', groups: [ 'undo', 'clipboard' ] },
        { name: 'forms', groups: [ 'forms' ] },
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
        { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
        '/',
        { name: 'styles', groups: [ 'styles' ] },
        { name: 'colors', groups: [ 'colors' ] },
        { name: 'insert', groups: [ 'insert' ] },
        { name: 'links', groups: [ 'links' ] },
        { name: 'tools', groups: [ 'tools' ] },
        { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
        { name: 'document', groups: [ 'document', 'mode', 'doctools' ] },
        { name: 'others', groups: [ 'others' ] },
        { name: 'about', groups: [ 'about' ] }
    ];*/

    config.removeButtons = 'Save,NewPage,Print,Scayt,SelectAll,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,CreateDiv,Language,Flash,PageBreak,Iframe,Templates,Anchor,Unlink,Preview,Source,About,Paste,PasteText,PasteFromWord,Form,Checkbox,Subscript,Superscript,CopyFormatting,RemoveFormat,BidiLtr,BidiRtl,HorizontalRule,Smiley';
};
