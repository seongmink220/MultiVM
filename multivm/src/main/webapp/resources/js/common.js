/*

//index.js
$(document).ready(function(){
    $('#lnb .depth-1 > li > a').click(function(){
        $('#lnb .depth-1 > li').removeClass('on');
        $(this).parent('li').addClass('on');
        $('#lnb .depth-2').stop().slideUp();
        $(this).parent('li').children('.depth-2').stop().slideToggle();
    });
    $('#lnb .depth-1 > li.on .depth-2').show();


    $('.btn_x').click(function(){
        $('#shadow_bg').stop().fadeOut();
        $('.pop_common').stop().fadeOut();
    });

    $('.logo_btn_x').click(function(){
        $('#shadow_bg').stop().fadeOut();
        $('.logo_pop_common').stop().fadeOut();
    });

});

var now = new Date();
var firstDate, lastDate, beforeDate, toDate, thisWeekStart, lastMonthStart, lastMonthEnd;
firstDate = new Date(now.getFullYear(), now.getMonth(), 1);
lastDate = new Date(now.getFullYear(), now.getMonth()+1, 0);
beforeDate = new Date(now.getFullYear(), now.getMonth(), now.getDate()-1);
toDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
thisWeekStart = new Date(now.getFullYear(), now.getMonth(), now.getDate()-7);
lastMonthStart = new Date(now.getFullYear(), now.getMonth()-1, 1);
lastMonthEnd = new Date(now.getFullYear(), (now.getMonth()-1)+1, 0);


function BeforeDateRadio() {
    makeDatePickerStart($('#sDate'),beforeDate);
    makeDatePickerStart($('#eDate'),beforeDate);
}

function ThisWeekRadio() {
    makeDatePickerStart($('#sDate'),thisWeekStart);
    makeDatePickerStart($('#eDate'),toDate);
}

function ThisDateRadio() {
    makeDatePickerStart($('#sDate'),toDate);
    makeDatePickerStart($('#eDate'),toDate);
}

function ThisMonthRadio() {
    makeDatePickerStart($('#sDate'),firstDate);
    makeDatePickerStart($('#eDate'),lastDate);
}

function LastMonthRadio() {
    makeDatePickerStart($('#sDate'),lastMonthStart);
    makeDatePickerStart($('#eDate'),lastMonthEnd);
}





*/
/* sitemap */
$("#siteMapOp").on("click",function(){
    $("body").addClass("is-open");
    $(".sitemap_bg").addClass("on");
    $(".sitemap").addClass("on").attr("aria-hidden", "false");
    $("#siteMapCls").focus();
    $(document).on("keyup", function(evt){
        var keycode = evt.which;
        if(keycode == 27){
            $("body").removeClass("is-open");
            $(".sitemap_bg").removeClass("on");
            $(".sitemap").removeClass("on").attr("aria-hidden", "true");
        }
    });
});
$("#siteMapCls").on("click",function(){
    $("body").removeClass("is-open");
    $(".sitemap_bg").removeClass("on");
    $(".sitemap").removeClass("on").attr("aria-hidden", "true");
    $("#siteMapOp").focus();
});

$(".sitemap_bg").on("click",function(){
    $(this).removeClass("on");
    $("body").removeClass("is-open");
    $(".sitemap").removeClass("on").attr("aria-hidden", "true");
    $("#siteMapOp").focus();
});

$(".sitemap .gnb .tit").click(function() {
    if($(this).hasClass("on")){
        $(this).removeClass("on");
        $(this).next(".depth2").stop().slideUp();
    } else{
        $(this).addClass("on");
        $(this).next(".depth2").stop().slideDown();
        $(this).parent().siblings().find(".depth2").stop().slideUp();
        $(this).parent().siblings().find(".tit").removeClass("on");
    }
});

/* sub header */
$(window).scroll(function(){
    var scroll = $(window).scrollTop();
    var headerH = $(".header").height();
    if (scroll>headerH){
        $(".sub_header .header").addClass("last_bg");
    } else{
        $(".sub_header .header").removeClass("last_bg");
    }
});

/* page_depth */
var page_depthH = $(".top_ban").height() - $("#hr").height() - ($(".page_depth").height()*3);

function menuScrollEvent() {
    if($(this).scrollTop() > page_depthH) {
        $(".page_depth").addClass("fixed");
    }else{
        $(".page_depth").removeClass("fixed");
    }
}
$(window).scroll(function(){
    menuScrollEvent();
});

$(".page_depth .depth1>a").click(function(e){
    e.preventDefault();
    if(!$(this).hasClass("on")){
        $(".page_depth .depth2>a").removeClass("on");
        $(".page_depth .depth2 ul").hide();
        $(this).next("ul").show();
        $(this).addClass("on");
    } else{
        $(this).next("ul").hide();
        $(this).removeClass("on");
    }
});

$(".page_depth .depth2>a").click(function(e){
    e.preventDefault();
    if(!$(this).hasClass("on")){
        $(".page_depth .depth1>a").removeClass("on");
        $(".page_depth .depth1 ul").hide();
        $(this).next("ul").show();
        $(this).addClass("on");
    } else{
        $(this).next("ul").hide();
        $(this).removeClass("on");
    }
});

/* btn_top */
$(".btn_top").click(function(){
    $("html, body").stop().animate({"scrollTop": 0}, 400);
});

$(window).scroll(function(){
    if($(this).scrollTop() > 500){
        $(".btn_top").fadeIn(300);
    }else{
        $(".btn_top").fadeOut(300);
    }
});

function goUrl(f) {
    var url = f.url.value;
    if(!url) {
        alert('이동하실 목록을 선택해주세요');
        return false;
    } else {
        window.open(url);
        return false;
    }
}