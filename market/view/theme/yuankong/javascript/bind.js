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

