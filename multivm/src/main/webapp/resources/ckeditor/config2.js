/**
 * @license Copyright (c) 2003-2022, CKSource Holding sp. z o.o. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
    //config2
    config.resize_dir = 'both';  //  사이즈 둘 다 조정
    config.image_previewText = ' ';
    config.enterMode = '2';// 엔터모드는 <br/>

    config.extraPlugins = 'autolink';
    config.extraPlugins = 'imageresize';
    config.extraPlugins = 'uploadfile';
    config.extraPlugins = 'uploadwidget';
    config.extraPlugins = 'emoji';
    //config.extraPlugins = 'easyimage';
    config.removePlugins = 'easyimage, cloudservices, exportpdf';
    config.cloudServices_tokenUrl = 'https://example.com/cs-token-endpoint';
    config.cloudServices_uploadUrl = '/app/Data';
    config.toolbarStartupExpanded = false;
    //config.fontSize_defaultLabel = '36';
    config.resize_enabled = false;

    /*config.filebrowserUploadUrl      = '/notice/ckedit/fileupload.do';
    config.filebrowserImageUploadUrl = '/notice/ckedit/fileupload.do';
    config.imageUploadUrl = '/notice/ckedit/fileupload.do';*/

    config.toolbarGroups = [
        { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
        { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
        { name: 'tools', groups: [ 'tools' ] },
        { name: 'clipboard', groups: [ 'undo', 'clipboard' ] },
        { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
        { name: 'forms', groups: [ 'forms' ] },
        { name: 'links', groups: [ 'links' ] },
        { name: 'insert', groups: [ 'insert' ] },
        '/',
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
        { name: 'styles', groups: [ 'styles' ] },
        { name: 'colors', groups: [ 'colors' ] },
        { name: 'others', groups: [ 'others' ] },
        { name: 'about', groups: [ 'about' ] }
    ];

    config.removeButtons = 'Source,Save,NewPage,ExportPdf,Preview,Print,Templates,PasteFromWord,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,RemoveFormat,CopyFormatting,BidiLtr,BidiRtl,Language,Anchor,HorizontalRule,Iframe,PageBreak,Smiley,PasteText,Copy,ShowBlocks,About,Unlink,CreateDiv,Blockquote,Subscript,Superscript,Paste,Cut,Format,Styles';

};
