/*function makeDatePicker(target){
	$(target).datepicker({
		dateFormat: 'yy-mm-dd' //Input Display Format 변경
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		// ,changeYear: true //콤보박스에서 년 선택 가능
		// ,changeMonth: true //콤보박스에서 월 선택 가능
		// ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
		// ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		// ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		// ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
		,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		// ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+1M", //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
		zindex:1200
	});
//초기값을 오늘 날짜로 설정
	$(target).datepicker('setDate', 'today');
}

function makeDatePickerStart(target,dt){
	//if(isEmpty(dt)) dt ="-1M";
	$(target).datepicker({
		dateFormat: 'yy-mm-dd' //Input Display Format 변경
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		// ,changeYear: true //콤보박스에서 년 선택 가능
		// ,changeMonth: true //콤보박스에서 월 선택 가능
		// ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
		// ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
		// ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		// ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
		,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		// ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+1M", //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
		zindex:1200
	});
	//초기값을 오늘 날짜로 설정
	$(target).datepicker('setDate', dt);
}


/!* 사업자 등록번호 하이픈*!/
function addHyphenCno(obj){
	var number = obj.value.replace(/[^0-9]/g,"");
	var cNo = '';
	if(number.length < 4){
		return number;
	}else if(number.length <= 5){
		cNo += number.substr(0, 3);
		cNo += '-';
		cNo += number.substr(3);
	}else if(number.length <10){
		cNo += number.substr(0, 3);
		cNo += '-';
		cNo += number.substr(3, 2);
		cNo += '-';
		cNo += number.substr(5);
	}else{
		cNo += number.substr(0, 3);
		cNo += '-';
		cNo += number.substr(3, 2);
		cNo += '-';
		cNo += number.substr(5);
	}
	 obj.value = cNo;
}

/!* 핸드폰 하이픈*!/
function addHyphen(obj) {

	var number = obj.value.replace(/[^0-9]/g, "");
	var phone = "";


	if(number.length < 4) {
		return number;
	} else if(number.length < 7) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3);
	} else if(number.length < 11) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 3);
		phone += "-";
		phone += number.substr(6);
	} else {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 4);
		phone += "-";
		phone += number.substr(7);
	}

	obj.value = phone;
}
/!* pageing 처리*!/

function paging(totalCnt,dataSize ,pageSize, pageNo){

	totalCnt = parseInt(totalCnt);
	dataSize = parseInt(dataSize);
	pageSize = parseInt(pageSize);
	pageNo =  parseInt(pageNo);

	var html= new Array();
	if(totalCnt ==0){
		return false;
	}

	var pageCnt = totalCnt % dataSize;
	if(pageCnt == 0){
		pageCnt = parseInt(totalCnt / dataSize);
	}else{
		pageCnt = parseInt(totalCnt / dataSize)+1;
	}

	var pRCnt = parseInt(pageNo / pageSize);
	if(pageNo % pageSize == 0){
		pRCnt = parseInt(pageNo / pageSize) - 1;
	}
	//이전 화살표

	if(pageNo > pageSize) {
		var s2;
		if (pageNo % pageSize == 0) {
			s2 = pageNo - pageSize;
		} else {
			s2 = pageNo - pageNo % pageSize;
		}
		html.push('<a href="#n" class="pLeft"><i class="fas fa-angle-double-left fa-1x" onclick="PageData(' + s2 + ')"></i></a>');
	}else{
		//html.push('<a href="#n" class=""><i class="fas fa-caret-left"></i></a>');
	}

	for(var index=pRCnt * pageSize + 1;index<(pRCnt + 1)*pageSize + 1;index++){
		if(index == pageNo){
			html.push(' <a href="#n" class="on" onclick="PageData('+index+')"><strong>');
			html.push(index);
			html.push('</strong></a>');
		}else{
			html.push(' <a href="#n" class="off" onclick="PageData('+index+')">');
			html.push(index);
			html.push('</a>');
		}

		if(index == pageCnt){
			break;
		}
	}
	//다음 화살표
	if(pageCnt > (pRCnt + 1) * pageSize){
		var nextPage = (pRCnt + 1)*pageSize+1;
		html.push('<a href="#n" class="pRight"><i class="fas fa-angle-double-right fa-1x" onclick="PageData(' + nextPage + ')"></i></a>');
	}else{
		//html.push('<a href="#n" class=""><i class="fas fa-caret-right"></i></a>');
	}

	return html.join("");

}


function enterCheck(target) {
	if(event.keyCode ==13){
		$(target).click();
	}
}


function pageMove(url){
	location.href=url;
}

//spinner
var spinner = {
	on : function(text) {
		var title = text ? text : "";
		var str = '';
		str += '<div id="loading_container">';
		str += '	<div class="loading">';
		str += '		<p class="load_img"></p>';
		str += '		<p class="text">'+ title +'</p>';
		str += '	</div>';
		str += '</div>';
		$('body').append(str);
	},
	off : function() {
		$('body #loading_container').remove();
	}
}

var escapeHtml = {
		encode : function(text) {
					return	text
							.replace(/&/g, "&amp;")
							.replace(/</g, "&lt;")
							.replace(/>/g, "&gt;")
							.replace(/"/g, "&quot;")
							.replace(/'/g, "&#039;");
		},
		decode : function(text) {
					return	text
						.replace(/&amp;/g, "&")
						.replace(/&lt;/g, "<")
						.replace(/&gt;/g, ">")
						.replace(/&quot;/g, '"')
						.replace(/&#039;/g, "'");
		}
}

/!*************************유효성 관련***************************!/
//줄임(...)
function reduceStr(str, number) {
	if(isEmpty(str)) return str;
	if(isEmpty(number)) return str;
	
	str = str.substr(0, number) + "...";
	return str;
}

//천단위 (,) 생성
function numberWithCommas(number) {
	//if(!number) return 0;
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//input 정수만 가능 
$(document).on('click keyup blur', '.integer_check', function() {
	var $this = $(this);
	var value = $this.val();
	var reg = /^[0-9_]+$/;
	var replaced = value;
	
	if(!reg.test(value)) {
		var replaced = value.replace(/[^0-9]/g, "");
    }
	
	if(!replaced) $this.val("");
	else $this.val(parseInt(replaced, 10));
});
//글자 수 제한
$(document).on('keyup', 'input[type=text]', function() {
	var $this = $(this);
	if(!$this.attr('maxlength')) return false;
    if($this.val().length > $this.attr('maxlength')) {
    	$this.val($this.val().substr(0, $this.attr('maxlength')));
    }
});

//숫자 맥스값
$(document).on('keyup blur', 'input[type=text], input[type=number]', function() {
	var $this = $(this);
	if(!$this.attr('maxnumber')) return false;
    if(Number($this.val()) > Number($this.attr('maxnumber'))) {
    	$this.val(Number($this.attr('maxnumber')));
    }
});

//콤마 add. 
$(document).on('blur', '.add_commas', function() {
	var $this = $(this);
	var value = $this.val();
	if(!isEmpty(value)) {
		$this.val(numberWithCommas(value));
	}
});

//원 add. 
$(document).on('blur', '.add_won', function() {
	var $this = $(this);
	var value = $this.val();
	if(!isEmpty(value)) {
		$this.val(value +"원");
	}
});

//퍼센트 add
$(document).on('blur', '.add_percent', function() {
	var $this = $(this);
	var value = $this.val();
	if(!isEmpty(value)) {
		$this.val(value +"%");
	}
});

//기간설정 - 앞 숫자 비교.
$(document).on('keyup blur', '.d-day-validation', function() {
	var $this = $(this);
	var $parentDiv = $this.closest('div');
	var $firstDay = $parentDiv.find('input:eq(0)');
	var $nextDay = $parentDiv.find('input:eq(1)');

	if(!$firstDay.val()) return false;
	if(Number($firstDay.val()) <= Number($nextDay.val())) {
		alert("앞에 입력한 값보다 작은 값을 입력해주세요.");
		$nextDay.val("");
		return false;
	}
});
//넘어온 값이 빈값인지 체크합니다. 
//!value 하면 생기는 논리적 오류를 제거하기 위해 
//명시적으로 value == 사용 
//[], {} 도 빈값으로 처리
var isEmpty = function(value) {
		if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ) {
			return true
		} else {
			return false
		}
	};
var isNull = function(value) {
    if(value == null || value == undefined) {
    	value = 0;
        return value;
    } else {
        return value;
    }
};

var isNullCheck = function(value){
    if(value == null || value == undefined) {
        return true;
    } else {
        return false;
    }
};
//날짜 계산(date)
//return - 0000 + delimiter + 00 + delimiter + 00
function calcDate(dateStr, calc, delimiter) {
	var fullDate = dateStr.split(" "); // 0000-00-00;
	fullDate.split("-");
	var year = fullDate.split("-")[0];
	var month = fullDate.split("-")[1];
	var date = fullDate.split("-")[2];
	
	var dt = new Date(year, month, date);
	dt.setDate(dt.getDate() + Number(calc));
	
	year = dt.getFullYear();
	month = dt.getMonth();
	date = dt.getDate();
	
	return year + delimiter + month + delimiter + date;
}

//TimeStamp 형식 날짜 변환
function dateConversion(date, delim) {
	if(!delim) delim = "-";

	if(typeof date == "string") date = date.split("\.")[0];
	
	var dt = new Date(date);
	var year = dt.getFullYear();
	var month = ('0' + (dt.getMonth() + 1)).slice(-2);
	var date = ('0' + dt.getDate()).slice(-2)
	
	return year + delim + month + delim + date;
} 

var enterEvent = function(selector, callback) {
	// enter event
	$(selector).off();
	$(selector).on('keyup', function(e) {
		var $this = $(this);
	    if (e.keyCode == 13) callback($this);        
	});
};

//"YYYY-MM-DD ~ YYYY-MM-DD"(today ~ today+num);
function datePlus(num) {
	var today = new Date();
	var tempDate = new Date();
	tempDate.setDate(tempDate.getDate() + num);
	var sdate = dateConversion(today, "-");
	var edate = dateConversion(tempDate, "-");
	return sdate + " ~ " + edate;
}

//"YYYY-MM-DD ~ YYYY-MM-DD"(today-num ~ today);
function dateMinus(num) {
	var today = new Date();
	var tempDate = new Date();
	tempDate.setDate(tempDate.getDate() - num);
	var sdate = dateConversion(tempDate, "-");
	var edate = dateConversion(today, "-");
	return sdate + " ~ " + edate;
}

//"YYYY-MM-DD"(today+29);
function datePlusSolo29() {
	var tempDate = new Date();
	tempDate.setDate(tempDate.getDate() + 29);
	return tempDate.setDate(tempDate.getDate() + 29);
}

//Byte 체크
function getByte(str) {
    var len = 0;
    if(!str) return len;
    for(var idx=0; idx<str.length; idx++) { 
        if ( (str.charCodeAt(idx)<0) || (str.charCodeAt(idx)>127) ) 
            len += 2;
        else
            len ++;
    }
    return len;
}

function incisionByByte(str, count) {
	var len = 0;
	var index = 0;
    if(!str || !count) return len;
    for(var idx=0; idx<str.length; idx++) { 
        if ( (str.charCodeAt(idx)<0) || (str.charCodeAt(idx)>127) ) len += 2;
        else len ++;
        if(len == count) {
        	index = idx + 1;
        	break;
        }
        if(len > count) {
        	index = idx;
        	break;
        }
    }
    var incision = str.substr(0, index);
    return incision;
}

/!*************************유효성 관련***************************!/

/!*************************sorting***************************!/
//@Param - arr, acend("DESC", ASC), id(기준 key)
//return - sorting된 arr; 
function sorting(arr, acend, id) {
	if(acend.toUpperCase() == "DESC") {
		if(id) {
			arr.sort(function(a, b) { // 내림차순
				return a[id] > b[id] ? -1 : a[id] < b[id] ? 1 : 0;
			});
		} else {
			arr.sort(function(a, b) { // 내림차순
				return a > b ? -1 : a < b ? 1 : 0;
			});
		}
	}
	if(acend.toUpperCase() == "ASC") {
		if(id) {
			arr.sort(function(a, b) { // 오름차순
				return a[id] < b[id] ? -1 : a[id] > b[id] ? 1 : 0;
			});
		} else {
			arr.sort(function(a, b) { // 오름차순
				return a < b ? -1 : a > b ? 1 : 0;
			});
		}
	}
	return arr;
}

//Util 부분 (2자리 출력)
function pad(n, width) {
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}
/!*************************sorting***************************!/


var ajaxFactory = (function() {
	
	var defaultOpt = {};
	defaultOpt.type = "POST";
	defaultOpt.contentType = "application/json";
	defaultOpt.dataType = "json";
	
	var get = function(uri, data, bsCallback, callback) {
		var opt = {};
		opt = makeOpt(bsCallback, callback);
		opt.type = "GET";
		opt.contentType = "text/html";
		opt.url =  uri;
		opt.data = data;
		excuteAjax(opt);
	};
	
	var post = function(uri, data, bsCallback, callback) {
		var opt = {};
		opt = makeOpt(bsCallback, callback);
		opt.url =  uri;
		opt.data = data;
		if(typeof data == "object") opt.data = JSON.stringify(data);
		
		excuteAjax(opt);
	};
	
	var put = function(uri, data, bsCallback, callback) {
		var opt = {};
		opt = makeOpt(bsCallback, callback);
		opt.type = "PUT";
		opt.url =  uri;
		opt.data = data;
		if(typeof data == "object") opt.data = JSON.stringify(data);
		
		excuteAjax(opt);
	};
	
	var del = function(uri, data, bsCallback, callback) {
		var opt = {};
		opt = makeOpt(bsCallback, callback);
		opt.type = "DELETE";
		opt.url =  uri;
		
		excuteAjax(opt);
	};
	
	var multipart = function(uri, data, bsCallback, callback) {
		var opt = {};
		opt = makeOpt(bsCallback, callback);
		opt.type = "POST";
		opt.processData = false;
		opt.contentType = false;
		opt.url =  uri;
		opt.data = data;
		
		excuteAjax(opt);
	};
	
	var makeOpt = function(bsCallback, callback) {
		var opt = {};
		$.extend(opt, defaultOpt);
		
		if(typeof bsCallback == "function") {
			opt.beforeSend = function() {
				bsCallback();
			}
		}
		opt.success = function(res) {
            spinner.off();
			callback(res);
		};
		
		return opt;
	};
	
	var excuteAjax = function(opt) {
		try {
			$.ajax(opt);
		} catch (e) {
			//console.log("excuteAjax Exception: ", e);
		}
	};
	
	return {
		get : get,
		post : post,
		put : put,
		del : del,
		multipart : multipart
	}
	
}());

var ajaxPromiseFactory = (function() {
	var defaultOpt = {};
	defaultOpt.type = "POST";
	defaultOpt.contentType = "application/json";
	defaultOpt.dataType = "json";
	
	var get = function(uri, data, bsCallback) {
		var opt = {};
		opt = makeOpt(bsCallback);
		opt.type = "GET";
		opt.contentType = "text/html";
		opt.url =  uri;
		opt.data = data;
		
		return excuteAjax(opt);
	};
	
	var post = function(uri, data, bsCallback) {
		var opt = {};
		opt = makeOpt(bsCallback);
		opt.url =  uri;
		opt.data = data;
		if(typeof data == "object") opt.data = JSON.stringify(data);
		
		return excuteAjax(opt);
	};
	
	var put = function(uri, data, bsCallback) {
		var opt = {};
		opt = makeOpt(bsCallback);
		opt.type = "PUT";
		opt.url =  uri;
		opt.data = data;
		if(typeof data == "object") opt.data = JSON.stringify(data);
		
		return excuteAjax(opt);
	};
	
	var del = function(uri, data, bsCallback) {
		var opt = {};
		opt = makeOpt(bsCallback);
		opt.type = "DELETE";
		opt.url =  uri;
		
		return excuteAjax(opt);
	};
	
	var multipart = function(uri, data, bsCallback) {
		var opt = {};
		opt = makeOpt(bsCallback);
		opt.type = "POST";
		opt.processData = false;
		opt.contentType = false;
		opt.url =  uri;
		opt.data = data;
		
		return excuteAjax(opt);
	};
	
	var makeOpt = function(bsCallback) {
		var opt = {};
		$.extend(opt, defaultOpt);
		
		if(typeof bsCallback == "function") {
			opt.beforeSend = function() { 
				bsCallback();
			}
		}
		return opt;
	};
	
	var excuteAjax = function(opt) {
		return new Promise(function(resolve, reject) {
			$.ajax(opt)
			.done(function(res) {
				spinner.off();
				if(res.status == 200) {
					resolve(res);
				} else {
					reject(res.message)
				}
			})
			.fail(function(err) {
				var errJSON = err.responseJSON;
				spinner.off();
				//console.log(errJSON.error + "("+errJSON.status+")");
			});
		});
	};
	
	return {
		get : get,
		post : post,
		put : put,
		del : del,
		multipart : multipart
	}
	
}());*/

//모바일 슬라이드

$(document).ready(function() {

	var current=0;
	var slide_length = $('.slide_ul>li').length;//이미지의 갯수를 변수로
	var btn_ul = '<ul class="slide_btn"></ul>';//버튼 LIST 작성할 UL



	$('.slide_ul>li').hide();//이미지 안보이게
	$('.slide_ul>li').first().show();//이미지 하나만 보이게


	$(btn_ul).prependTo($('.slide'))//slide 클래스위에 생성
	for (var i = 0 ; i < slide_length; i++){//동그라미 버튼 생성 이미지 li 개수 만큼
		var child = '<li><a href="#none">'+i+'</a></li>';
		$(child).appendTo($('.slide_btn'));
	}

	$('.slide_btn > li > a').first().addClass('active');
	$('.slide_btn > li > a').on('click' , slide_stop);

//모바일 슬라이드,자동 슬라이드 함수
	function autoplay(){

		if(current == slide_length-1){
			current = 0;
		}else{
			current++;
		}
		$('.slide_ul>li').stop().fadeOut(1000);
		$('.slide_ul>li').eq(current).stop().fadeIn(1000);
		$('.slide_btn > li > a').removeClass('active');
		$('.slide_btn > li > a').eq(current).addClass('active');
	}
	setInterval(autoplay,5000);//반복

//모바일 슬라이 버튼 클릭시 호출되는 함수
	function slide_stop(){
		var fade_idx = $(this).parent().index();
		current = $(this).parent().index();//클릭한 버튼의 Index 를 받아서 그 다음 이미지부터 슬라이드 재생.
		if($('.slide_ul > li:animated').length >= 1) return false; //버튼 반복 클릭시 딜레이 방지
		$('.slide_ul > li').fadeOut(400);
		$('.slide_ul > li').eq(fade_idx).fadeIn(400);
		$('.slide_btn > li > a').removeClass('active');
		$(this).addClass('active');

	}
});


$(document).ready(function(){//Start

	/* header2 aside menu */
	function layerClose(){
		$('#header2 .aside').animate( { left: '-100%' }, { queue: false, duration: 300 });
		$('#header2 .aside_dim').fadeOut('fast');
		$('body').css('overflow-y', 'auto');
	}

	function layerOpen(){
		$('#header2 .aside').animate( { left: '0' }, { queue: false, duration: 300 });
		$('#header2 .aside_dim').fadeIn('fast');
		$('body').css('overflow-y', 'hidden');
	}

	$('#header2 .btn_menu').click(function(){
		layerOpen();
	});

	$('#header2 .m_nav .btn_close, .aside_dim').click(function(){
		layerClose();
	});

	$('.m_menu > ul > li > a').click(function(){
		$('.m_menu > ul > li > a').removeClass();
		$(this).addClass('on');
		var mNavDepth = $(this).closest('.m_menu .depth1 li').children('.m_menu .depth2');

		if(mNavDepth.filter(':visible').length == 0)
		{
			mNavDepth.slideDown('fast');
		}else
		{
			mNavDepth.slideUp('fast');
			$(this).removeClass("on");
		}
		$('.m_menu .depth2').not(mNavDepth).slideUp('fast');
	});



});//End


