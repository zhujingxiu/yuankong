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
        <p><img src="<?php echo TPL_IMG ?>data/yuankong/r-password-step1.jpg" alt="找回密码流程" /></p>
        <div class="r-password-text">
          <span class="texts text1">输入账号名</span>
          <span class="texts text2">验证身份</span>
          <span class="texts text3">重置密码</span>
          <span class="texts text4">完成</span>
        </div>
        <div class="inputesbox">
            <table class="registable">
                <tbody><tr>
                    <td class="tr" width="90"><em class="c_red">*</em> <?php echo $entry_mobile_phone ?></td>
                    <td><input type="text" class="regis-text" value="" placeholder="<?php echo $entry_mobile_phone ?>"></td>
                </tr>
                <tr>
                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_captcha ?></td>
                    <td>
                      <input type="text" class="regis-text w100" value="" name="captcha">
                      <span class="pl10">
                        <img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>"><a href="javascript:void(0);" class="pl10 c_g">换一张</a>
                      </span>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><p class="w150"><input type="submit" class="gc-tab-sub" value="下一步"></p></td>
                </tr>
            </tbody>
          </table>
        </div>

  
</div>  

<script type="text/javascript">
    o.moushov.init(".regis-tab li",".regis-box .regis");
    $('.captcha a.chg-img').bind('click',function(e){
      e.preventDefault();
      $('.captcha img').attr('src',"<?php echo $this->url->link('account/register/captcha','','ssl') ?>")
    });
    $(function(){


  })
</script>
<?php echo $footer; ?>