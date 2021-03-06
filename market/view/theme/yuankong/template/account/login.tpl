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
<body>

<div class="login-logo w">
    <a class="pr10" href="<?php echo $home; ?>">
    	<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <span class="pl20 logospan"><?php echo $heading_title ?></span>
</div>
<section id="columns">
	<div class="loginbg ovh mt20">
<div class="w">
  	<div class="loginbox fix">
  		<div class="loginbox-l l"><img src="asset/image/loginpic.jpg" /></div>
		<div class="loginbox-r r">
			<div class="login-b-top">
			  <a class="l-zhuce" href="<?php echo $register ?>"><?php echo $text_register; ?></a>
			  <span class="f_xl c2"><?php echo $text_customer; ?></span>
			</div>
			<?php if(!empty($error_warning)){ ?>
			<div class="msg-error"><?php echo $error_warning ?></div>
			<?php }?>
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
				<div class="logintext">
	                <i class="icon2 person"></i><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="login-t" placeholder="<?php echo $entry_mobile_phone; ?>"/>
	            </div>
	            <div class="logintext">
	                <i class="icon2 passwd"></i><input type="password" name="password" value="<?php echo $password; ?>" class="login-t" placeholder="<?php echo $entry_password; ?>"/>
	            </div>
	            <div class="loginb-yz">
	                <a href="<?php echo $forgotten; ?>" class="r"><?php echo $text_forgotten; ?></a>
	                <input type="checkbox" name="remember" value="1"/><em class="pl5"><?php echo $text_auto ?></em>
	            </div>
	            <div class="mt15">
	                <input type="submit" class="gc-tab-sub" value="<?php echo $button_login; ?>" />
	            </div>
	            <?php if($oauth_html){ ?>
	            <div class="mt15">
	                <?php echo $oauth_html ?>
	            </div>
	            <?php }?>
	            <?php if ($redirect) { ?>
				  <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
				<?php } ?>
			</form>
			</div>
		</div>
	</div>
</div>
</div> 
<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
<style type="text/css">
	.loginbox .msg-error {
	  position: relative;
	  background: #ffebeb;
	  color: #e4393c;
	  border: 1px solid #e4393c;
	  padding: 3px 8px ;
	  font-size: 14px;
	  line-height: 18px;
	  min-height: 18px;
	  _height: 18px;
	}
</style>
<?php echo $footer; ?>