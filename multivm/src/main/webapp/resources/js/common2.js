$(document).ready(function() {
    $('#company-select').select2();
    $('#group-select').select2();
    $('#terminal-select').select2();
    $('#vending-select').select2();

    $(document).on('select2:open', () => {
        document.querySelector('.select2-search__field').focus();
    });

    $('b[role="presentation"]').hide();/*셀렉트 화살표 숨김*/

    var now = new Date();
    var day = ("0" + now.getDate()).slice(-2);
    var month = ("0" + (now.getMonth() + 1)).slice(-2);
    var today = now.getFullYear() + "-" + (month) + "-" + (day);
    var today2 = now.getFullYear() + (month) + (day);

    $('#sDate').val(today);
    $('#eDate').val(today);
    $('#search_sDate').val(today2);
    $('#search_eDate').val(today2);

    $(".day_tab li").click(function () { //tab1
        $(".day_tab li.current").removeClass("current");
        $(this).addClass("current")
    })
});
$(function (){
    $('#company-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        if(companySeq==''){
            //$('#group-select').children().remove();
            //$('#terminal-select').children().remove();
            //$('#vending-select').children().remove();
            $('#group-select').empty();
            $('#terminal-select').empty();
            $('#vending-select').empty();
            /*html +='<tr><td colspan=5>소속/조직을 선택해주세요.</td></tr>';
            $('#Dash_Table_Body1').html(html);*/
            return false;
        }
        $.ajax({
            url:'/company/ajax/selectCompany.do',
            type : 'POST',
            data:'companySeq='+$(this).val(),
            datatype: 'JSON',
            success:function(response){
                var html ="";
                var html2 = "";
                var html3 = "";
                if(response.origList.length>0){
                    html +=" <option value=\"0\" selected>전체</option>";
                    for(var i=0; i<response.origList.length; i++){
                        html +="<option value='"+response.origList[i].seq+"'>"+response.origList[i].name+"</option>";
                    }
                }
                if(response.vmList.length>0){
                    html2 +=" <option value='전체' selected>전체</option>";
                    html3 +=" <option value='전체' selected>전체</option>";
                    for(var i=0; i<response.vmList.length; i++){
                        //html2 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].terminalId+"</option>";
                        //html3 +="<option value='"+response.vmList[i].seq+"'>"+response.vmList[i].vmId+"</option>";
                        html2 +='<option value="'+response.vmList[i].seq+'">'+response.vmList[i].terminalId+'/'+response.vmList[i].vmId+'</option>';
                        html3 +='<option value="'+response.vmList[i].seq+'">'+response.vmList[i].place+'</option>';
                    }
                }
                $('#group-select').empty();
                $("#group-select").append(html);
                $('#terminal-select').empty();
                $("#terminal-select").append(html2);
                $('#vending-select').empty();
                $("#vending-select").append(html3);

                //$("#group-select").html(html);
                //$('#terminal-select').html(html2);
                //$('#vending-select').html(html3);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });


    $('#group-select').change(changeCompanySelect=function(){
        var companySeq = $("#company-select option:selected").val();
        var organizationSeq = $("#group-select option:selected").val();
        var organizationText = $("#group-select option:selected").text();
        //var organizationText = $("#group-select option[value='+organizationSeq+']").text();
        if(organizationSeq==''){
            //$("#terminal-select").children().remove();
            //$('#vending-select').children().remove();
            $('#terminal-select').empty();
            $('#vending-select').empty();

            return false;
        }
        $.ajax({
            url:'/company/ajax/selectOrig.do',
            type : 'POST',
            data:{ companySeq : companySeq,
                organizationSeq : organizationSeq
            },
            datatype: 'JSON',
            success:function(response){
                var html ="";//단말기ID
                var html2 =""; //자판기ID
                if(response.length>0){
                    html +=" <option value='전체' selected>전체</option>";
                    html2 +=" <option value='전체' selected>전체</option>";
                    for(var i=0; i<response.length; i++){
                        html +='<option value="'+response[i].seq+'">'+response[i].terminalId+'/'+response[i].vmId+'</option>';
                        html2 +='<option value="'+response[i].seq+'">'+response[i].place+'</option>';
                    }
                }
                //$('#terminal-select').html(html);
                //$('#vending-select').html(html2);

                $('#terminal-select').empty();
                $("#terminal-select").append(html);
                $('#vending-select').empty();
                $("#vending-select").append(html2);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    });

    $('#terminal-select').change(changeCompanySelect2=function(){
        var vmSeq = $("#terminal-select option:selected").val();
        $('#vending-select').val(vmSeq).attr('selected',"selected");
        var vmText = $("#vending-select option:selected").text();
        $('#select2-vending-select-container').text(vmText);

    });
    $('#vending-select').change(function(){
        var vmSeq = $("#vending-select option:selected").val();
        $('#terminal-select').val(vmSeq).attr('selected',"selected");
        var vmText = $("#terminal-select option:selected").text();
        $('#select2-terminal-select-container').text(vmText);
    });

});


function setDate(select){
    var date = new Date();
    var sDate;
    var eDate;

    if(select=='today'){
        sDate = new Date();
        eDate = new Date();
    }
    else if(select=='yesterday'){
        sDate = new Date(date.getFullYear(), date.getMonth(), date.getDate()-1);
        eDate = new Date(date.getFullYear(), date.getMonth(), date.getDate()-1);
    }
    else if(select=='last_week'){
        sDate = new Date(date.getFullYear(), date.getMonth(), date.getDate()-7);
        eDate = new Date();
    }
    else if(select=='this_month'){
        sDate = new Date(date.getFullYear(),date.getMonth(),1);
        eDate = new Date(date.getFullYear(),date.getMonth()+1,0);
    }
    else if(select=='last_month'){
        sDate = new Date(date.getFullYear(), date.getMonth()-1, 1);
        eDate = new Date(date.getFullYear(), (date.getMonth()-1)+1, 0);
    }

    $('#sDate').val(getDateStr(sDate));
    $('#eDate').val(getDateStr(eDate));
    $("#dateSelect li.current").removeClass("current");
    //$(this).addClass("current");
    $("#dateSelect li[value="+select+"]").addClass('current');
}

function getDateStr(myDate){
    return myDate.getFullYear() + "-" + ("0" + (myDate.getMonth()+1)).slice(-2) + "-" + ("0" + myDate.getDate()).slice(-2);
}

function closeModal(){
    $('#shadow_bg').stop().fadeOut();
    $('#modal_pop').stop().fadeOut();
    $('#modal_pop').hide();
}

function saveExcelFile(){
    //searchData();
    var companySeq = $("#company-select option:selected").val();
    var organizationSeq = $('#search_orgSeq').val();
    //var vmSeq = $("#terminal-select option:selected").val();
    var vmId = $('#search_vmId').val();
    //var terminalId = $("#terminal-select option:selected").text();
    //var productName = $('#product-name').val();
    var sDate = $('#search_sDate').val();
    var eDate = $('#search_eDate').val();

    /*if(vmSeq!='전체'){
        vmId = vmId.split('/')[1];
    }*/

    if(companySeq==''){alert("소속을 선택해주세요");return false;}

    $.ajax({
        url:'/sales/ajax/getDeadlineSalesData.do',
        type : 'POST',
        data:{ companySeq : companySeq,
            organizationSeq : organizationSeq,
            organizationName : $("#search_orgName").val(),
            place : $("#search_place").val(),
            vmId : vmId,
            sDate : sDate,
            eDate : eDate},
        datatype: 'JSON',
        xhrFields:{
            responseType: 'blob'
        },
        success:function(response){
            //console.log(response);
            var blob = response;
            var downloadUrl = URL.createObjectURL(blob);
            var a = document.createElement("a");
            a.href = downloadUrl;
            a.download = "멀티자판기_거래내역.xlsx";
            document.body.appendChild(a);
            a.click();



        },
        error: function (xhr, status, error) {
            console.log(error);
        }
    });
}

window.onload = function(){
    pagination($('#Dash_Table_Body1 tr'),"#pagination_ys", $('#nowpage'));
}

//천단위 (,) 생성
function numberWithCommas(number) {

    if(isNaN(number)){
        number = parseInt(number);
    }
    //if(!number) return 0;
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


