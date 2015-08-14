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
<title><?php echo $title; ?></title>
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
</head>
<body class="b_fa">
<?php echo $top ?>
<section id="columns">
  <div class="w mt20 pt20">
    <a class="pr10" href="<?php echo $home; ?>">
      <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <span class="pl20 logospan">帮助中心</span>
  </div>
  <div class="w mt20 pt20 fix">
    <div class="w210 l">
        <dl class="side-navlist">
            <dt>帮助中心</dt>            
            <?php foreach ($informations as $item): ?>
            <dd <?php echo $item['information_id'] == $information_id ? 'class="con"' : '' ?>>
              <a href="<?php echo $item['link'] ?>"><?php echo $item['title'] ?></a>
            </dd>
            <?php endforeach ?>
        </dl>
    </div>
    <div class="b_f w980 r">
      <div class="helpbox">
        <h3><?php echo $heading_title ?></h3>
        <div class="helptext"><?php echo $description; ?></div>
      </div>
    </div>
  </div>
<?php echo $footer; ?>

