
//index.js
$(document).ready(function(){

    //배경 클릭시 팝업 닫힘
    $('#black_bg').click(function(){
        $(this).stop().fadeOut('fast');
        $('#modal_pop').stop().fadeOut('fast');
    });
    
    //팝업 X클릭시 팝업 닫힘
    $('.btn_pop_close').click(function(){
        $('#black_bg').stop().fadeOut('fast');
        $('#modal_pop').stop().fadeOut('fast');
    });
    
    //    
    $('.btn_cancel').click(function(){
        $('#black_bg').stop().fadeOut('fast');
        $('#modal_pop').stop().fadeOut('fast');
    });

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

function getCompanyOrigList(companySeq){
    $.ajax({
        url:'/company/ajax/selectCompany.do',
        type : 'POST',
        data:'companySeq='+ companySeq,
        datatype: 'JSON',
        success:function(response){
            var html3 = "";
            for(var i=0; i<response.origList.length; i++){
                html3 +="<option value='"+response.origList[i].seq+"' label='"+response.origList[i].name+"'/>";
            }
            $('#mag_group').html(html3);
        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

function editClick(){
    var sizeCheck = $('#Dash_Table_Body1 input[type="checkbox"]:checked');
    var seq;
    if(sizeCheck.length > 1){
        alert("하나의 데이터만 선택할 수 있습니다.");
    }else if(sizeCheck.length == 0){
        alert("수정할 데이터를 선택하세요.");
    }
    else {
        $.each(sizeCheck,function(idex,entry){
            seq = entry.closest('tr').id;
        });
        editDataModal(seq);
    }
}


