<?php 
  $themeConfig = $this->config->get( 'themecontrol' );
  $themeName =  $this->config->get('config_template');
  require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
  $helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head> 
<meta name="viewport" content="width=device-width">
<meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
<meta charset="UTF-8" />
<title><?php echo $heading_title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/yuankong/stylesheet/yk_basic.css" />

<script type="text/javascript" src="market/view/theme/yuankong/javascript/lib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="market/view/theme/yuankong/javascript/common.js"></script>
<!--[if lt IE 9]>
<script src="market/view/javascript/html5.js"></script>
<![endif]-->

<!--[if IE ]>
<script type="text/javascript" src="market/view/theme/yuankong/javascript/lib/jquery.placeholder.js"></script>
<script type="text/javascript">
$(function(){ $('input, textarea').placeholder(); });
</script>
<style type="text/css">
  .placeholder{color:#999999;}
</style>
<![endif]-->
<script type="text/javascript" src="market/view/theme/yuankong/javascript/index.js"></script>
<script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/jquery.validate.js"></script>
<script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/additional-methods.js"></script>
<script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/localization/messages_zh.js"></script>
<link rel="stylesheet" type="text/css" href="market/view/theme/yuankong/stylesheet/yk_validate.css" />
</head>
<body class="b_fa">
<?php echo $top ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<section id="columns">
  <div class="login-logo register-w">
    <a class="pr10" href="<?php echo $home; ?>">
      <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <span class="pl20 logospan"><?php echo $heading_title ?></span>
    <div class="retrieve-password">
        <p >
          <img id="step-img" src="<?php echo TPL_IMG ?>data/yuankong/r-password-step1.jpg" alt="找回密码流程"/>
        </p>
        <div class="r-password-text">
          <span class="texts text1">输入账号名</span>
          <span class="texts text2">验证身份</span>
          <span class="texts text3">重置密码</span>
          <span class="texts text4">完成</span>
        </div>
        <div class="inputesbox">
          <form method="post" id="step-mobilephone">
            <table class="registable">
              <tbody>
                <tr>
                    <td class="tr" width="90">
                      <em class="c_red">*</em> <?php echo $entry_mobile_phone ?>
                    </td>
                    <td>
                      <div class="form-group">
                        <input type="text" id="mobilephone" name="mobile_phone" class="regis-text" placeholder="<?php echo $entry_mobile_phone ?>">
                      </div>
                    </td>
                </tr>
                <tr>
                    <td class="tr">
                      <em class="c_r">*</em> <?php echo $entry_captcha ?>
                    </td>
                    <td>
                      <div class="form-group">
                        <input type="text" class="regis-text w100" name="captcha">
                        <span class="pl10 captcha">
                          <img src="<?php echo $captcha ?>">
                          <a href="javascript:void(0);" class="pl10 c_g">换一张</a>
                        </span>
                      </div>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><p class="w150"><input type="submit" class="gc-tab-sub" value="下一步"></p></td>
                </tr>
              </tbody>
            </table>
            <input type="hidden" id="mobile-img" value="<?php echo TPL_IMG ?>data/yuankong/r-password-step1.jpg"/>
          </form>
          <form id="step-sms" method="post" style="display:none;">
            <table class="registable">
              <tbody>
                  <tr>
                      <td class="tr"><em class="c_r">*</em> 短信验证码:</td>
                      <td>
                        <div class="form-group">
                          <input type="text" class="regis-text w100" name="sms" value="">
                          <a href="javascript:void(0)" class="hq-yzm">获取验证码</a> 
                        </div>
                      </td>
                  </tr>
                  <tr>
                      <td>&nbsp;</td>
                      <td><p class="w150"><input type="submit" class="gc-tab-sub" value="下一步"></p></td>
                  </tr>
              </tbody>
            </table>
            <input type="hidden" id="sms-img" value="<?php echo TPL_IMG ?>data/yuankong/r-password-step2.jpg"/>
          </form>
          <form id="step-password" method="post" style="display:none;" action="<?php echo $action ?>">
            <table class="registable">
                <tbody>
                  <tr>
                    <td class="tr"><em class="c_r">*</em> 设置密码:</td>
                    <td>
                      <div class="form-group">
                        <input type="password" name="password" class="regis-text" id="password">
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td class="tr"><em class="c_r">*</em> 确认密码:</td>
                    <td>
                      <div class="form-group">
                        <input type="password" name="confirm" class="regis-text" value="">
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td><p class="w150"><input type="submit" class="gc-tab-sub" value="下一步"></p></td>
                  </tr>
                </tbody>
              </table>
            <input type="hidden" id="password-img" value="<?php echo TPL_IMG ?>data/yuankong/r-password-step3.jpg"/>
            <input type="hidden" name="mobile_phone" value=""/>
          </form>
        </div>
  </div>  

<script type="text/javascript">
    o.moushov.init(".regis-tab li",".regis-box .regis");
    $('.captcha a.c_g').bind('click',function(e){
      $('.captcha img').attr('src',"<?php echo $captcha ?>&t="+(Math.round(Math.random()*999)+9999))
    });
    $(function(){
      $.validator.setDefaults({      
        errorElement: "span",
        focusInvalid: true,
        errorPlacement: function (error, element) {
          element.parent('.form-group').removeClass('valid').after(error); 
        },        
        success:function(e){
          e.prev('.form-group').addClass("valid").next('.error').remove();
        },
      }),
      $("#step-mobilephone").validate({
        rules:{
            mobile_phone: {
              required: true,
              isMobile: true,
              validPhone: true
            },
            captcha:{
              required:true,
              validCaptcha:true
            },
        },
        messages:{
          mobile_phone:{
            required:"手机号必填",
            isMobile:"手机号非法，请填写有效的手机号码",
            validPhone:"没有该手机号码注册的账号",
          }
        },
        debug:true,        
        submitHandler: function(form) {
          $(form).hide();
          $('#step-sms').show();
          $('#step-img').attr('src',$('#mobile-img').val());
        }
      });
      $("#step-sms").validate({
        rules:{
          sms:{
            validSMS:"#mobilephone"
          },
        },
        messages:{
          sms:{
            validSMS:"短信验证码无效"
          },
        },
        debug:true,    
        submitHandler: function(form) {
          $(form).hide();
          $('#step-password').show();
          $('#step-img').attr('src',$('#password-img').val());
        }    
      });
      $("#step-password").validate({
        rules:{
          password: {
              required: true,
              byteRangeLength:[6,20]
          },
          confirm: {
              required: true,
              equalTo: "#password"
          },
        },
        messages:{
          password:{
            required:"密码必填",
            byteRangeLength:"密码长度须在6到20个字符",
          },
        },
        debug:true,    
        submitHandler: function(form) {
          $('#step-password input[name="mobile_phone"]').val($('#step-mobilephone input[name="mobile_phone"]').val())
          form.submit();
        }    
      });
      $.validator.addMethod("byteRangeLength", function(value, element, params) {
        var valueStripped = stripHtml(value);
        return this.optional(element) || valueStripped.length >= params[0] && valueStripped.length <= params[1];
      }, "字符长度须在 {0} 到 {1} 之间");
      $.validator.addMethod("isMobile", function(phone_number, element) {
        phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
        var isMobile = this.optional(element) || phone_number.length > 9 &&
          phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
        return isMobile;
      }, "手机号码非法");
      $.validator.addMethod("validPhone", function(phone_number, element) {
        phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
        var isMobile = this.optional(element) || phone_number.length > 9 &&
        phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
        if(isMobile){
          var used = false;
          $.ajax({
            url:'index.php?route=account/forgotten/validatePhone',
            data:{mobile_phone:phone_number},
            type:'post',
            async:false,
            dataType:'json',
            success:function(json){
              used = json.used==0 ? true : false;
            }
          });
          return used ? false : true;
        }
        return isMobile;
      }, "没有该手机号码注册的账号");
      $.validator.addMethod("validCaptcha", function(captcha, element) {
        captcha = captcha.replace(/\(|\)|\s+|-/g, "");
        var validCaptcha = this.optional(element) || captcha.length == 4 ;
        if(validCaptcha){
          var valide = false;
          $.ajax({
            url:'index.php?route=account/forgotten/validateCaptcha',
            data:{captcha:captcha},
            type:'post',
            dataType:'json',
            async:false,
            success:function(json){
              valide = json.status==0 ? false : true;
            }
          });
          return valide ? true : false;
        }
        return validCaptcha;
      }, "验证码错误");
      $.validator.addMethod("validSMS", function(sms, element,param) {
        sms = sms.replace(/\(|\)|\s+|-/g, "");
        var target = $( param );
        var validSMS = this.optional(element) || sms.length == 6 ;
        if(validSMS){
          var valide = false;
          $.ajax({
            url:'index.php?route=account/forgotten/validateSMS',
            data:{sms:sms,mobile_phone:target.val()},
            type:'post',
            dataType:'json',
            async:false,
            success:function(json){
              valide = json.status==0 ? false : true;
            }
          });
          return valide ? true : false;
        }
        return validSMS;
      }, "短信验证码错误");

    });
  $('.hq-yzm').bind('click',function(){
    var send = true;
    var $that = $(this);
    var items = $('#step-mobilephone .form-group').length,
    valids = $('#step-mobilephone .form-group.valid').length;
    if(items == valids){
      $.ajax({
        url:'index.php?route=account/forgotten/getSMS',
        data:{mobile_phone:$('#step-mobilephone input[name="mobile_phone"]').val()},
        type:'post',
        dataType:'json',
        success:function(json){
          if(json.success){
            $that.html(json.success).attr('disabled');
          }else{
            alert(json.error.sms)
          }
        }
      })
    }else{
      alert('请确认输入的数据合法')
    }
  });
</script>
<?php echo $footer; ?>