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

	<div class="fix">
        <ul class="l regis-tab">
            <li class="regis-li tabon"><?php echo $text_regs_customer ?></li>
            <li class="regis-li"><?php echo $text_regs_affiliate ?></li>
        </ul>
        <span class="r"></span>
    </div>

	<div class="regis-box fix">
	  	<div class="r">
            <p class="f_m c46"><?php echo $text_qr_code ?></p>
            <p><img src="asset/image/data/yuankong/ewm2.jpg" alt=""/></p>
        </div>
	  	<form action="<?php echo $customer_action; ?>" method="post" enctype="multipart/form-data">
			<div class="regis">
			  	<table class="registable">
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_mobile_phone; ?></td>
					  <td><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="regis-text" placeholder="<?php echo $entry_mobile_phone ?>"/>
						<?php if ($error_mobile_phone) { ?>
						<span class="error"><?php echo $error_mobile_phone; ?></span>
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
					  <td class="tr" width="96"><em class="c_r">*</em> <?php echo $entry_confirm; ?></td>
					  <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" class="regis-text"/>
						<?php if ($error_confirm) { ?>
						<span class="error"><?php echo $error_confirm; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
		                <td class="tr"><em class="c_r">*</em> <?php echo $entry_input_sms ?></td>
		                <td><input type="password" class="regis-text w100" value=""  /><a href="javascript:viod(0)" class="hq-yzm"><?php echo $text_get_sms ?></a> </td>
		            </tr>
		            <tr>
		                <td class="tr"><em class="c_r">*</em> <?php echo $entry_captcha ?></td>
		                <td>
		                	<input type="captcha" class="regis-text w100" value=""  />
		                	<span class="pl10 captcha">
		                		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
		                		<a href="#" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
		                	</span>
		                </td>
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
		<form action="<?php echo $affiliate_action; ?>" method="post" enctype="multipart/form-data">
			<div class="regis" style="display: none;">
	            <table class="registable">
	            	<tr>
	                    <td class="tr" width="96"><?php echo $entry_email ?></td>
	                    <td><input type="text" class="regis-text" value="" placeholder="<?php echo $text_affiliate_email ?>" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_password ?></td>
	                    <td><input type="password" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_confirm ?></td>
	                    <td><input type="password" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_affiliate_name ?></td>
	                    <td><input type="text" class="regis-text" value="" placeholder="<?php echo $text_affiliate_name ?>" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_affiliate_group ?></td>
	                    <td><select class="regis-text" name="group_id">
		                    	<option>设计公司</option>
		                    	<option>工程公司</option>
		                    	<option>检测公司</option>
		                    	<option>维保公司</option>
		                    </select>
		                </td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_affiliate_address ?></td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_affiliate_customer ?></td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_affiliate_telephone ?></td>
	                    <td><input type="text" class="regis-text" value=""  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><?php echo $entry_input_sms ?></td>
	                    <td><input type="password" class="regis-text w100" value=""  /><a href="javascript:viod(0)" class="hq-yzm"><?php echo $text_get_sms ?></a> </td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_captcha ?></td>
	                    <td>
	                    	<input type="captcha" class="regis-text w100" value=""  />
	                    	<span class="pl10 captcha">
	                    		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
	                    		<a href="#" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
	                    	</span>
	                    </td>
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
    $('.captcha a.chg-img').bind('click',function(e){
    	e.preventDefault();
    	$('.captcha img').attr('src',"<?php echo $this->url->link('account/register/captcha','','ssl') ?>")
    })
</script>
<?php echo $footer; ?>