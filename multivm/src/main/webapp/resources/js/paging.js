/*
function pagination(tr, paging){ //.page 클래스이름 or id로하자
    var req_num_row=10;
    var $tr=tr //$('tbody tr');
    var total_num_row=$tr.length;
    var num_pages=0;
    var limit_num_pages = 10;
    //var pre_img = '/resources/images/ic_left.png';
    //var next_img = '${root}/resources/images/ic_right.png';
    var pre_img = '/multivm/resources/images/ic_left.png';
    var next_img = '/multivm/resources/images/ic_right.png';
    if(total_num_row % req_num_row ==0){
        num_pages=total_num_row / req_num_row;
    }
    if(total_num_row % req_num_row >=1){
        num_pages=total_num_row / req_num_row;
        num_pages++;
        num_pages=Math.floor(num_pages++);
    }

    jQuery(paging).append("<li><a class=\"prev\"> <img src=\"/resources/images/ic_left.png\" alt=\"이전\"> </a></li>");

    for(var i=1; i<=num_pages; i++){
        jQuery(paging).append("<li><a>"+i+"</a></li>");
        jQuery(paging+' li:nth-child(2)').addClass("active");
        jQuery(paging+' a').addClass("pagination-link");


    }

    if(num_pages>limit_num_pages){
        jQuery(paging+' li:nth-child(n+12)').hide();
    }

    jQuery(paging).append("<li><a class=\"next\"> <img src=\"/resources/images/ic_right.png\" alt=\"다음\"> </a></li>");

    $tr.each(function(i){
        jQuery(this).hide();
        if(i+1 <= req_num_row){
            $tr.eq(i).show();
        }
    });

    jQuery(paging+' a').click('.pagination-link', function(e){
        e.preventDefault();
        $tr.hide();
        var page=jQuery(this).text();
        var temp=page-1;
        var start=temp*req_num_row;
        var current_link = temp;
        var next_num = start+1;
        var prev_num = start-1;

        jQuery(paging+' li').removeClass("active");
        jQuery(this).parent().addClass("active");

        for(var i=0; i< req_num_row; i++){
            $tr.eq(start+i).show();
        }

        if(temp >= 1){
            jQuery(paging+' li:first-child').removeClass("disabled");
        }
        else {
            jQuery(paging+' li:first-child').addClass("disabled");
        }

    });

    jQuery('.prev').click(function(e){
        e.preventDefault();
        jQuery(paging+'li:first-child').removeClass("active");
    });

    jQuery('.next').click(function(e){
        e.preventDefault();
        jQuery(paging+' li:last-child').removeClass("active");
    });

}*/



/*
var current_page = 0;
var next_num = 0;
var prev_num = 0;

function pagination(tr, paging){ //.page 클래스이름 or id로하자
    var req_num_row=10;
    var $tr=tr //$('tbody tr');
    var total_num_row=$tr.length;
    var num_pages=0;
    var limit_num_pages = 10;
    var start_v = 0;
    var total_page=Math.ceil(total_num_row / req_num_row);

    if(total_num_row % req_num_row ==0){
        num_pages=total_num_row / req_num_row;
    }
    if(total_num_row % req_num_row >=1){
        num_pages=total_num_row / req_num_row;
        num_pages++;
        num_pages=Math.floor(num_pages++);
    }
    jQuery(paging).append("<li><a class=\"prev\"><</a></li>");
    for(var i=1; i<=num_pages; i++){
        jQuery(paging).append("<li><a>"+i+"</a></li>");
        jQuery(paging+' li:nth-child(2)').addClass("active");
        jQuery(paging+' a').addClass("pagination-link");
    }

    if(num_pages>limit_num_pages){
        jQuery(paging+' li:nth-child(n+12)').hide();
    }

    jQuery(paging).append("<li><a class=\"next\">></a></li>");

    $tr.each(function(i){
        //console.log($(this).text());//내용
        jQuery(this).hide();
        if(i+1 <= req_num_row){ //한페이지에 8개게시글
            $tr.eq(i).show();
        }



    });
    var ttt = '';
    jQuery(paging+' a').click('.pagination-link', function(e){
        e.preventDefault();
        $tr.hide();

        var page=jQuery(this).text();

        var temp=page-1;
        var start=temp*req_num_row;
        start_v = start;
        var current_link = temp;
        next_num = page+1;
        prev_num = page-1;
        var prev_active = '';
        current_page = page;
        prev_active = ttt;//jQuery(paging+' li').hasClass("active").children('a').text();


        jQuery(paging+' li').removeClass("active");
        jQuery(this).parent().addClass("active");
        //console.log("현재 :"+page+" ,temp: "+temp+", start: "+start+", current_link: "+current_link+", req_num_row: "+req_num_row+", prev_active: "+prev_active+", ttt: "+ttt, " total_page: "+total_page);

        for(var i=0; i< req_num_row; i++){
            $tr.eq(start+i).show(); //내용
        }

        if(prev_active%10==1&&prev_active>9){
            if(page=='>'){
                jQuery(paging+' li').hide();
                jQuery(paging+' li:first-child').show();
                jQuery(paging+' li:last-child').show();
                jQuery(paging+' li:nth-child(n+'+ (parseInt(prev_active)+1) +'):nth-child(-n+'+ (parseInt(prev_active)+10) +')').show();
            }
        }
        if(prev_active%10==1&&prev_active>9){
            if(page=='<'){
                jQuery(paging+' li').hide();
                jQuery(paging+' li:first-child').show();
                jQuery(paging+' li:last-child').show();
                jQuery(paging+' li:nth-child(n+'+ (parseInt(prev_active)-9) +'):nth-child(-n+'+ (parseInt(prev_active)) +')').show();	}
        }


        if(temp >= 1){
            jQuery(paging+' li:first-child').removeClass("disabled");
        }
        else {
            jQuery(paging+' li:first-child').addClass("disabled");
        }
        if(total_num_row*req_num_row%temp<10){ //다음 해제
            jQuery(paging+' li:last-child').addClass("disabled");
        }
        else {
            jQuery(paging+' li:last-child').removeClass("disabled");
        }

        if(page=='<'){//전
            if(!jQuery(this).hasClass('disabled')&&prev_active!=1&&prev_active!='<'&&prev_active!=''){
                jQuery(paging+' li:nth-child('+ prev_active +') a').click();
                ttt=prev_active-1;
                return false;
            }
            else if(prev_active==1||prev_active=='') jQuery(paging+' li:nth-child(2) a').click();
            else jQuery(paging+' li:nth-child(2) a').click();
        }
        if(page=='>'){
            if(jQuery(this).hasClass('disabled')||prev_active==total_page||ttt==total_page||prev_active=='>'){
                jQuery(paging+' li:nth-last-child(2) a').click();return false;
            }
            else if(!jQuery(this).hasClass('disabled')&&prev_active!=''&&prev_active!=total_page&&prev_active!='>'){
                jQuery(paging+' li:nth-child('+ (parseInt(prev_active)+1) +') a').click();
                ttt=parseInt(prev_active)+1;
                return false;
            }
            else if(prev_active==''){
                jQuery(paging+' li:nth-child(3) a').click(); ttt=3; return false;
            }
            else {jQuery(paging+' li:nth-last-child(2) a').click();return false;}


        }
        ttt = page;
        if(page!='>'&&page!='<'){

            ttt=parseInt(ttt)+1;
        }

    });

    jQuery('.prev').click(function(e){
        //e.preventDefault();
        //jQuery(paging+'li:first-child').removeClass("active");
        //alert(jQuery(paging+'li').children('a').hasClass("active").text());


    });

    jQuery('.next').click(function(e){
        e.preventDefault();
        //jQuery(paging+' li:last-child').addClass("active");
        current_page = jQuery(this).text();
        start_v = current_page-1*req_num_row;
        for(var i=0; i< req_num_row; i++){
            $tr.eq(start_v+i).show();
            //console.log('이거왜안돼 '+start_v+", current_page:"+current_page);
        }
    });

}
*/

function pagination(tr, paging, input_name){ //.page 클래스이름 or id로하자
    var req_num_row=10;
    var $tr=tr //$('tbody tr');
    var total_num_row=$tr.length;
    var num_pages=0;
    var limit_num_pages = 10;
    var start_v = 0;
    var total_page=Math.ceil(total_num_row / req_num_row);
    var current_page = input_name.val();//$("#nowpage").val();

    if(total_num_row % req_num_row ==0){
        num_pages=total_num_row / req_num_row;
    }
    if(total_num_row % req_num_row >=1){
        num_pages=total_num_row / req_num_row;
        num_pages++;
        num_pages=Math.floor(num_pages++);
    }
    jQuery(paging).append("<li><a class=\"prev\"><</a></li>");
    for(var i=1; i<=num_pages; i++){
        jQuery(paging).append("<li><a>"+i+"</a></li>");
        jQuery(paging+' li:nth-child(2)').addClass("active");
        jQuery(paging+' a').addClass("pagination-link");
    }

    if(num_pages>limit_num_pages){
        jQuery(paging+' li:nth-child(n+12)').hide();
    }
    jQuery(paging).append("<li><a class=\"next\">></a></li>");

    $tr.each(function(i){
        //console.log($(this).text());//내용
        jQuery(this).hide();
        if(i+1 <= req_num_row){ //한페이지에 10개게시글
            $tr.eq(i).show();
        }
    });
    //console.log("total_page: "+total_page);
    ////////////////////////////////////

    jQuery(paging+' a').click('.pagination-link', function(e){
        e.preventDefault();
        $tr.hide();
        current_page = input_name.val();
        var page=jQuery(this).text();
        //var page=$("#nowpage").val();
        var temp=page-1;
        var start=temp*req_num_row;
        start_v = start;
        var current_link = temp;
        var p1,p2,setStart,setLast,curNum;
        p2 = (total_page%10==0?parseInt(total_page)-1:total_page);
        //jQuery(paging+' li').hasClass("active").children('a').text();
        //console.log("p2: "+p2);
        jQuery(paging+' li').removeClass("active");
        jQuery(this).parent().addClass("active");
        //console.log("현재 :"+page+" ,temp: "+temp+", start: "+start+", current_link: "+current_link+", req_num_row: "+req_num_row+", ttt: "+ttt, " total_page: "+total_page);


        for(var i=0; i< req_num_row; i++){
            $tr.eq(start+i).show(); //내용
        }
        ////////////////////////////////////////////////
        if(page=='<'){
            current_page.toString();
            if(current_page == 1){//초기
                jQuery(paging+' li:nth-child(2) a').click();
            }else if(current_page.length < 2||current_page==10){
                jQuery(paging+' li:nth-child('+ parseInt(current_page) +') a').click();
            }else{
                //console.log("11보다 클때");
                p1 = parseInt(current_page[0]);
                if(current_page%10==0){
                    p1=p1-1;
                }

                jQuery(paging+' li').hide();
                jQuery(paging+' li:first-child').show();
                jQuery(paging+' li:last-child').show();
                jQuery(paging+' li:nth-child(n+'+ ((p1-1)*10+2) +'):nth-child(-n+'+ ((p1-1)*10+11) +')').show();
                jQuery(paging+' li:nth-child('+ ((p1-1)*10+11) +') a').click();
            }
        }


        /////////////////////////////////////////////
        else if(page=='>'){
            current_page.toString();
            //console.log('1.current_page: '+current_page.toString());
            //console.log('2.total_page: '+total_page);
            if(current_page==total_page){
                jQuery(paging+' li:nth-last-child(2) a').click();
                return false;
            }else if(current_page.length < 2||current_page==10){//일의 자리
                if(total_page<11){
                    jQuery(paging+' li:nth-child('+ (parseInt(current_page)+2) +') a').click();return false;
                }
                jQuery(paging+' li').hide();
                jQuery(paging+' li:first-child').show();
                jQuery(paging+' li:last-child').show();
                if(total_page>10&&total_page<20){
                    jQuery(paging+' li:nth-child(n+'+ 12 +'):nth-child(-n+'+ (parseInt(total_page)+1) +')').show();
                }else{ // 십의 자리 숫자*10+1 , 위에 20과 묶이게
                    jQuery(paging+' li:nth-child(n+'+ 12 +'):nth-child(-n+'+ 21 +')').show();
                    //jQuery(paging+' li:nth-child(n+'+ 12 +'):nth-child(-n+'+ (parseInt()+1) +')').show();
                }
                jQuery(paging+' li:nth-child(12) a').click();
            }
            else if(current_page[0]==total_page.toString()[0]){
                //console.log("전체가 지금셋에 있을때");
                jQuery(paging+' li:nth-child('+ (parseInt(current_page)+2) +') a').click();
            }
            else{ //11부터
                p1 = parseInt(current_page[0]); // =current_page.charAt(0)
                curNum = parseInt(current_page);
                //console.log('3.p1: '+p1+' = '+parseInt(current_page.charAt(0)));
                if(current_page%10==0){
                    p1=p1-1;
                    //console.log("10의배수 일땐 p1-1: "+current_page+"//"+p1);
                }
                //console.log("3-2. p1 = "+p1);
                //console.log('3-3. 현재: '+curNum+' 곱하기수(p1 * 0N):'+p1+' * '+multiplyByPowerOfTen(curNum));
                setStart = (p1+1)*multiplyByPowerOfTen(curNum)+2;
                setLast = (p1+1)*multiplyByPowerOfTen(curNum)+11;
                //console.log('4. 다음셋:'+setStart+' ~ '+setLast+' , 마지막셋:'+total_page);
                jQuery(paging+' li').hide();
                jQuery(paging+' li:first-child').show(); //'<'
                jQuery(paging+' li:last-child').show(); //'>'
                //if((parseInt(current_page[0]))*10<=total_page){
                if(setLast<=total_page){
                    //console.log("다음셋에서 전체보다 적을때 "+ current_page+'/'+total_page);
                    jQuery(paging+' li:nth-child(n+'+ setStart +'):nth-child(-n+'+ setLast +')').show();
                }else{
                    //console.log("다음셋이 끝일때 "+ current_page+'/'+total_page);
                    jQuery(paging+' li:nth-child(n+'+ setStart +'):nth-child(-n+'+ (total_page+1) +')').show();
                }
                jQuery(paging+' li:nth-child('+ setStart +') a').click();
            }
            //}else{ current_page.val(page);console.log("현재bb: "+current_page.val()); }
        }else{ input_name.val(page);}

        ///////////////////////////////////
        if(temp >= 1){
            jQuery(paging+' li:first-child').removeClass("disabled");
        }
        else {
            jQuery(paging+' li:first-child').addClass("disabled");
        }
        if(total_num_row*req_num_row%temp<10){ //다음 해제//노필요
            jQuery(paging+' li:last-child').addClass("disabled");
        }
        else {
            jQuery(paging+' li:last-child').removeClass("disabled");
        }
        //console.log("current_page_end: "+input_name.val());

    });

}

function multiplyByPowerOfTen(number) { //number는 원래숫자
    return Math.pow(10, Math.floor(Math.log10(number)));
}