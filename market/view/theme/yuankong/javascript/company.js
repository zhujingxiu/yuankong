function checkNewPhone() {
    console.info($('#new-phone').val())
    if ($('#new-phone').val() == '') {
        $('#new-phone').focus().next('.validate').addClass('error').html('请输入手机号！').css('display', 'inline-block');        
        return;
    }
    if ($('#new-phone').val() != '' && typeof ($('#new-phone').val()) != undefined) {
        $('#new-phone').next('.validate').css('display', 'none');
    }
    if(!isMoblieCN($('#new-phone').val())) {
        $('#new-phone').next('.validate').addClass('error').html('请输入正确的手机号！').css('display', 'inline-block');
        return;
    }
}

function isMoblieCN(phone){

    var reg = /^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
    if (phone.length == 11) {
        return reg.exec(phone);
    } else {
        return false;
    }
}