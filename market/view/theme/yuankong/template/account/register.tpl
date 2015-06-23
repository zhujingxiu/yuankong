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
<div class="header f_s">
	<div class="w">

		<div class="l">
			<?php if( isset($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')]) )  { 
				echo html_entity_decode($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'); 
			} ?>
		</div>
		<div class="r">
			<ul class="head-ul">
				<li>
					<?php if (!$logged) { ?>
					<a class="plr" href="<?php echo $login ?>"><?php echo $text_login; ?></a>
					|
					<a class="plr" href="<?php echo $register ?>"><?php echo $text_register; ?></a>
					<?php } else { ?>
					<?php echo $text_logged; ?>
					<?php } ?>
				</li>
				<li class="my-ezhan rel">
					<div class="hd">
						<a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
						<em class="icon2 h-down"></em>
					</div>
					<div class="bd">
						<a href="<?php echo $order ?>"><?php echo $text_order ?></a>
						<a href="<?php echo $profile ?>"><?php echo $text_profile ?></a>
						<a href="<?php echo $message ?>"><?php echo $text_message ?></a>
					</div>
				</li>
				<li>|</li>
				<li class="my-ezhan rel">
					<div class="hd">
						<a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a>
						<em class="icon2 h-down"></em>
					</div>
					<div class="bd">
						<a href="<?php echo $upload ?>"><?php echo $text_upload ?></a>
						<a href="<?php echo $perfact ?>"><?php echo $text_perfact ?></a>
					</div>
				</li>
				<li>|</li>
				<li class="plr"><a href="<?php echo $help ?>"><?php echo $text_help ?></a></li>
				<li>|</li>
				<li class="pl10 cff"><?php echo $text_hotline ?></li>
				<?php if(false){?>
				<li class="top-links">
				<a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
				
				<a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
				<!--a href="<?php //echo $checkout; ?>"><?php //echo $text_checkout; ?></a-->
				<?php //echo $currency; ?>
				<?php //echo $language; ?>					
				<?php } ?>					
				</li>
			</ul>
		</div>
	</div>
</div>
<?php if( isset($themeConfig['custom_top_module']) )  { 
	echo html_entity_decode($themeConfig['custom_top_module'], ENT_QUOTES, 'UTF-8'); 
}?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<section id="columns">
<div class="login-logo register-w">
    <a class="pr10" href="<?php echo $home; ?>">
    	<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <span class="pl20 logospan"><?php echo $heading_title ?></span>

	<div class="fix">
        <ul class="l regis-tab">
            <li class="regis-li tabon">个人用户</li>
            <li class="regis-li">企业用户</li>
        </ul>
        <span class="r"></span>
    </div>

	<div class="regis-box fix">
	  	<div class="r">
            <p class="f_m c46">手机微信扫描二维码，关注e站</p>
            <p><img src="asset/image/data/yuankong/ewm2.jpg" alt=""/></p>
        </div>
	  	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
			<div class="regis">
			  	<table class="registable">
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_telephone; ?></td>
					  <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" class="regis-text"/>
						<?php if ($error_telephone) { ?>
						<span class="error"><?php echo $error_telephone; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_password; ?></td>
					  <td><input type="password" name="password" value="<?php echo $password; ?>" class="regis-text"/>
						<?php if ($error_password) { ?>
						<span class="error"><?php echo $error_password; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_confirm; ?></td>
					  <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" class="regis-text"/>
						<?php if ($error_confirm) { ?>
						<span class="error"><?php echo $error_confirm; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
		                <td class="tr"><em class="c_r">*</em> 短信验证码:</td>
		                <td><input type="password" class="regis-text w100" value=""  /><a href="javascript:viod(0)" class="hq-yzm">获取验证码</a> </td>
		            </tr>
		            <tr>
		                <td class="tr"><em class="c_r">*</em> 验证码:</td>
		                <td><input type="password" class="regis-text w100" value=""  /><span class="pl10"><img src="imgs/adimg/yzm.jpg" /><a href="#" class="pl10 c_g">换一张</a></span></td>
		            </tr>
		            <tr>
		                <td>&nbsp;</td>
		                <td><input type="checkbox" name="c" checked="checked" /><?php echo $text_agree; ?> </td>
		            </tr>
		            <tr>
		                <td>&nbsp;</td>
		                <td><p class="w210"><input type="submit" class="gc-tab-sub" value="<?php echo $button_register; ?>" /></p></td>
		            </tr>
			  	</table>
			</div>
			<div class="regis" style="display: none;">
	            <table class="registable">
	            	<tr>
	                    <td class="tr" width="90">注册邮箱:</td>
	                    <td><input type="text" class="regis-text" value="" placeholder="填写企业邮箱" /></td>
	                </tr>
	                <tr>
	                    <td class="tr">设置密码:</td>
	                    <td><input type="password" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr">确认密码:</td>
	                    <td><input type="password" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr">单位名称:</td>
	                    <td><input type="text" class="regis-text" value="" placeholder="请填写营业执照上的单位名称" /></td>
	                </tr>
	                <tr>
	                    <td class="tr">公司项目:</td>
	                    <td><select class="regis-text"><option>设计公司</option><option>工程公司</option><option>检测公司</option><option>维保公司</option></select></td>
	                </tr>
	                <tr>
	                    <td class="tr">单位地址:</td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr">联系人姓名:</td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr">手机号码:</td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr">短信验证码:</td>
	                    <td><input type="password" class="regis-text w100" value=""  /><a href="javascript:viod(0)" class="hq-yzm">获取验证码</a> </td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> 验证码:</td>
	                    <td><input type="password" class="regis-text w100" value=""  /><span class="pl10"><img src="imgs/adimg/yzm.jpg" /><a href="#" class="pl10 c_g">换一张</a></span></td>
	                </tr>
	                <tr>
		                <td>&nbsp;</td>
		                <td><input type="checkbox" name="c" checked="checked" /><?php echo $text_agree; ?> </td>
		            </tr>
	                <tr>
	                    <td>&nbsp;</td>
	                    <td><p class="w210"><input type="submit" class="gc-tab-sub" value="<?php echo $button_register; ?>" /></p></td>
	                </tr>
	            </table>
	        </div>
	  	</form>
	</div>
</div>	

<script type="text/javascript">
    o.moushov.init(".regis-tab li",".regis-box .regis");
</script>
<?php echo $footer; ?>