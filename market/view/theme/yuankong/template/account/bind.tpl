<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?> aside">
    <?php echo $column_left; ?>
    </div>
    <?php endif; ?>

    <div class="article">
        <div class="userbox4">
            <div class="p30">
                <h3 class="index-t"><b class="f_l">绑定手机</b></h3>
                <div class="bind_content mt20">
                    <div class="email_bind mobile border_bottom">
                        <span class="img"></span>
                        <span class="mid"><em>手机号绑定</em><br><?php echo $mobile_phone ?></span>
                        
                    </div>
                    <?php if($step=='pwd'){?>
                    <div class="reset_line">
                        <ul>
                            <li class="first cur"><em>1</em><b></b><span>身份验证</span></li>
                            <li><em>2</em><b></b><span>修改手机号</span></li>
                            <li class="last"><em>3</em><span>完成</span></li>
                        </ul>
                    </div>
                    <form id="pwd-form" action="<?php echo $action ?>" method="post" onsubmit="return checkPwd();">                        
                        <div style="display:block;" class="reset_content_mobile mobile_step1">                  
                            <div class="mobile_code">
                                <span>输入登陆密码</span>
                                <input type="password" class="user_txt" id="pwd" name="pwd">
                                <div id="pwdmsg" class="message"></div>
                            </div>
                            <div class="mobile_code">
                                <span>请输入验证码</span>
                                <input type="text" id="yzm" name="captcha" class="code">
                                <img src="<?php echo $captcha ?>" class="c_img">
                                <a href="javascript:void(0);" class="pl10 c_g">换一张</a>
                                <div id="yzmmsg" class="message"></div>
                            </div>
                            <input type="submit" class="next_bit" value="提交">
                        </div>
                    </form>
                    <?php }else if($step=='sms'){ ?>
                    <div class="reset_line">
                        <ul>
                            <li><em>1</em><b></b><span>身份验证</span></li>
                            <li class="first cur"><em>2</em><b></b><span>修改手机号</span></li>
                            <li class="last"><em>3</em><span>完成</span></li>
                        </ul>
                    </div>
                    <form id="sms-form" action="<?php echo $action ?>" method="post" onsubmit="return checkSMS()">
                        <div class="reset_content_mobile mobile_step2" style="display:block;">              
                            <div class="mobile_code">
                                <span>手机号</span>
                                <input type="text" name="phone" id="phone" class="user_txt" onblur="checkPhone()">
                                <div class="message" id="phonemsg"></div>
                            </div>
                            <div class="mobile_code">
                                <span>验证码</span>
                                <input type="text" class="code" name="sms" id="sms">
                                <div class="message" id="smsmsg"></div>
                                <input type="button" value="获取短信验证码" class="hq_yzm" id="hqyzm">
                            </div>
                            <input type="submit" value="提交" class="next_bit">
                        </div>
                    </form>
                    <?php }else if($step=='success'){?>
                    <div class="reset_line">
                        <ul>
                            <li><em>1</em><b></b><span>身份验证</span></li>
                            <li><em>2</em><b></b><span>修改手机号</span></li>
                            <li class="last cur"><em>3</em><span>完成</span></li>
                        </ul>
                    </div>
                    <div class="reset_content_mobile mobile_step3" style="display:block;">
                        <div class="msg-success">手机号码修改成功！</div>                        
                    </div>
                    <?php }?>
                </div>
                
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
        <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div> 

<script type="text/javascript">
    $('a.c_g').bind('click',function(e){
        $('.c_img').attr('src',"<?php echo $captcha ?>&t="+(Math.round(Math.random()*999)+9999))
    });
    
    function checkPwd() {
        if (!$("#pwd").val() || typeof ($("#pwd").val()) == undefined) {
            $('#pwdmsg').html('请输入登陆密码').addClass('msg_error').css('display', 'block');
            return false;
        }
        var flag = 0;
        $.ajax({
            type:'post',
            url:'index.php?route=common/tool/validatePwd',
            data:{'pwd':$("#pwd").val()},
            async:false,
            dataType:'json',
            success:function(json){
                if(json.status ==0){
                    $('#pwdmsg').html('登陆密码错误').addClass('msg_error').css('display', 'block');
                    return false;
                }else if(json.status ==1){
                    flag = 1;
                    $('#pwdmsg').empty().removeClass('msg_error').css('display', 'none');
                }
            }
        });
        if(flag != 1){
            return false;
        }
        if (!$("#yzm").val() || typeof ($("#yzm").val()) == undefined) {
            $('#yzmmsg').html('请输入验证码').addClass('msg_error').css('display', 'block');
            return false;
        }
        var flag = '';
        $.ajax({
            type:'post',
            url:'index.php?route=common/tool/validateCaptcha',
            data:{'captcha':$("#yzm").val()},
            async:false,
            dataType:'json',
            success:function(json){
                if(json.status ==0){
                    $('#yzmmsg').addClass('msg_error').css('display', 'block').html('验证码错误！');
                    return false;
                }else if(json.status ==1){
                    flag = 1;
                    $('#yzmmsg').empty().removeClass('msg_error').css('display', 'none');
                }
            }
        });
        if(flag != 1){
            return false;
        }
    }

    function checkPhone() {
        if ($('#phone').val() == '') {
            $('#phone').focus().next('.message').addClass('msg_error').html('请输入手机号').css('display', 'block');
            return;
        }
        if ($('#phone').val() != '' && typeof ($('#phone').val()) != undefined) {
            $('#phone').next('.message').css('display', 'none');
        }
        if(!isMoblieCN($('#phone').val())) {
            $('#phone').next('.message').addClass('msg_error').html('输入的手机号无效').css('display', 'block');
        }
    }
    function checkSMS() {
        var sms = $('#sms').val();
        if (sms == '') {
            $('#sms').focus();
        } else {
            var mobile = $('#phone').val();
            $.ajax({
                type: "post",
                url: "index.php?route=common/tool/validateSMS",
                data: {sms: sms,mobile_phone:mobile},
                success: function (json) {
                    if (json.status == 1) {
                        $('#sms').next('.message').css('display', 'none');
                    } else {                        
                        $('#sms').focus().next('.message').addClass('msg_error').html('请输入正确的短信验证码！').css('display', 'block');
                        return false;
                    }
                }
            });
        }
        if ($('#sms').val() != '' && typeof ($('#sms').val()) != undefined) {
            $('#sms').next('.message').css('display', 'none');
        }
    }
    var resetSMS,appliedMobile,interval = 120;
    $('#phone').bind("propertychange input",function(){  
        if($(this).val() != appliedMobile ){      
            clearTimeout(resetSMS);
            $('#hqyzm').removeAttr('disabled').val('获取短信验证码');
        }
    });

    $('#hqyzm').bind('click',function(){
        if($(this).attr('disabled')=='disabled'){
            alert('短信验证码申请太过于频繁，请稍后再试！');
            return false;
        }      
        if($('#phone').val()=='')  {
            $('#phone').focus().next('.message').addClass('msg_error').css('display', 'block').html('请输入手机号');;
            return false;
        }else if (!isMoblieCN($('#phone').val())) {            
            $('#phone').focus().next('.message').addClass('msg_error').css('display', 'block').html('输入的手机号无效');
            return false;
        } else {            
            $('#phone').next('.message').css('display', 'none');
        }
        var mobile = $('#phone').val();
        $.ajax({
            url:'index.php?route=common/tool/getSMS',
            data:{mobile_phone:mobile},
            type:'post',
            dataType:'json',
            success:function(json){
                if(json.success){
                    $('#hqyzm').attr('disabled','disabled');   
                    appliedMobile = mobile;                     
                    send_agin($('#hqyzm'));
                }else{
                    if(json.error.mobile_phone){
                        $('#phone').focus().next('.message').addClass('msg_error').css('display', 'block').html(json.error.mobile_phone);
                    }
                    if(json.error.sms)
                    alert(json.error.sms)
                }
            }
        });

    });
    
    function send_agin(obj){
        interval--;     
        if(interval>0){
            resetSMS = setTimeout(function(){send_agin(obj);},1000);            
            obj.val(interval+'秒后获取验证码');
        }else{
            obj.removeAttr('disabled').val('获取验证码');         
            interval=120;
        }
    }
</script>
<?php echo $footer; ?> 