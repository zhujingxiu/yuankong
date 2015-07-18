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

<section id="columns">
  <div class="login-logo register-w">
    <a class="pr10" href="<?php echo $home; ?>">
      <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <span class="pl20 logospan"><?php echo $heading_title ?></span>
    <div class="retrieve-password">
        <p >
          <img id="step-img" src="<?php echo TPL_IMG ?>data/yuankong/r-password-step4.jpg" alt="找回密码流程"/>
        </p>
        <div class="r-password-text">
          <span class="texts text1">输入账号名</span>
          <span class="texts text2">验证身份</span>
          <span class="texts text3">重置密码</span>
          <span class="texts text4">完成</span>
        </div>
        <div class="inputesbox">
            <dl class="fix">
                <dt class="l"><i class="icon2 sucessbtn"></i> </dt>
                <dd class="pl20 c3 f_m">
                    <p class="f_xl b">新密码设置成功！</p>
                    <p>您可以返回重新<a href="<?php echo $login ?>" class="c-blue">登录</a>。</p>
                </dd>
            </dl>
        </div>
  </div>  

<script type="text/javascript">
    o.moushov.init(".regis-tab li",".regis-box .regis");
</script>
<?php echo $footer; ?>