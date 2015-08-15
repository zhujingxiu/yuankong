<?php 
  $themeConfig = $this->config->get( 'themecontrol' );
  $themeName =  $this->config->get('config_template');
  require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
  $helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
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
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/yk_basic.css" />


<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/common.js"></script>

<!--[if lt IE 9]>
<script src="market/view/javascript/html5.js"></script>
<![endif]-->

<!--[if IE ]>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery.placeholder.js"></script>
<script type="text/javascript">
$(function(){ $('input, textarea').placeholder(); });
</script>
<style type="text/css">
  .placeholder{color:#999999;}
</style>
<![endif]-->
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/index.js"></script>
</head>
<body>
<!--Top-->
<?php echo $top ?>
<!--Top-->

<section id="columns">
<div class="w w980 mt20">
    <div class="ovh">
        <ul class="gw-process">
            <li class="online-s"><p class="process-num">1</p><p class="">我的购物车</p></li>
            <li class="online-s"><p class="process-num">2</p><p>填写/确认订单</p></li>
            <li class="online-s"><p class="process-num">3</p><p>付款</p></li>
            <li class="online-s"><p class="process-num">4</p><p>支付成功</p></li>
        </ul>
        <?php if ($logo) { ?>
        <a href="<?php echo $home; ?>" class="pr10">
            <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
        </a>
        <?php } ?>
    </div>

    <?php echo $content_top; ?>
    <div id="content" class="mt20 paysucess">
        <dl class="fix">
            <dt class="l"><i class="icon2 sucessbtn"></i> </dt>
            <dd class="pl20 c3 f_m">
                <p class="f_xl b">支付成功！</p>
                <p>我们将尽快确认资源，以手机短信的形式通知到您，请耐心等待。 您可以在<a href="#" class="c-blue">我的订单</a>中查看您的订单状态。</p>
            </dd>
        </dl>
        <div class="pay-news-box">
            <b>支付信息</b>
            <ul >
                <li>支付账号:liu417288184@126.com</li>
                <li>支付金额:1268.0元</li>
                <li>支付日期:2015-10-13</li>
                <li>支付状态:支付成功</li>
            </ul>
        </div>
    </div>
    <?php echo $content_bottom; ?>
</div> 

<?php echo $footer; ?>
