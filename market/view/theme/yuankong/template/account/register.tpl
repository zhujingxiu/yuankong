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
	  	<form id="customer-signup" action="<?php echo $customer_action; ?>" method="post" enctype="multipart/form-data">
			<div class="regis">
			  	<table class="registable">
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_mobile_phone; ?></td>
					  <td><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="regis-text" placeholder="<?php echo $entry_mobile_phone ?>" id="customer-mobilephone"/>
						<?php if ($error_mobile_phone) { ?>
						<span class="error"><?php echo $error_mobile_phone; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="90"><em class="c_r">*</em> <?php echo $entry_password; ?></td>
					  <td><input type="password" name="password" value="<?php echo $password; ?>" class="regis-text" id="customer-password"/>
						<?php if ($error_password) { ?>
						<span class="error"><?php echo $error_password; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="96"><em class="c_r">*</em> <?php echo $entry_confirm; ?></td>
					  <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" class="regis-text" />
						<?php if ($error_confirm) { ?>
						<span class="error"><?php echo $error_confirm; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
		                <td class="tr"><em class="c_r">*</em> <?php echo $entry_input_sms ?></td>
		                <td><input type="text" class="regis-text w100" name="sms" />
		                	<a href="javascript:void(0)" data-rel="customer-mobilephone" class="hq-yzm"><?php echo $text_get_sms ?></a> </td>
		            </tr>
		            <tr>
		                <td class="tr"><em class="c_r">*</em> <?php echo $entry_captcha ?></td>
		                <td>
		                	<input type="text" name="captcha" class="regis-text w100" />
		                	<span class="pl10 captcha">
		                		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
		                		<a href="#" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
		                	</span>
		                </td>
		            </tr>
		            <tr>
		                <td>&nbsp;</td>
		                <td>
		                	<input type="checkbox" name="agree" checked="checked" id="customer-agree"/>
		                	<?php echo $text_agree; ?> 
		                </td>
		            </tr>
		            <tr>
		                <td>&nbsp;</td>
		                <td>
		                	<p class="w210">
		                		<input type="submit" class="gc-tab-sub" value="<?php echo $button_register; ?>" />
		                	</p>
		                </td>
		            </tr>
			  	</table>
			</div>
		</form>
		<form id="affiliate-signup" action="<?php echo $affiliate_action; ?>" method="post" enctype="multipart/form-data" >
			<div class="regis" style="display: none;">
	            <table class="registable">
	            	<tr>
	                    <td class="tr" width="96"><em class="c_r">*</em> <?php echo $entry_email ?></td>
	                    <td><input type="text" class="regis-text" name="email" placeholder="<?php echo $text_affiliate_email ?>" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_password ?></td>
	                    <td><input type="password" class="regis-text" name="password" id="affiliate-password" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_confirm ?></td>
	                    <td><input type="password" class="regis-text" name="confirm"  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_affiliate_name ?></td>
	                    <td><input type="text" class="regis-text" name="company" placeholder="<?php echo $text_affiliate_name ?>" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_affiliate_group ?></td>
	                    <td><select class="regis-text" name="group_id">
		                    	<option>设计公司</option>
		                    	<option>工程公司</option>
		                    	<option>检测公司</option>
		                    	<option>维保公司</option>
		                    </select>
		                </td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_affiliate_address ?></td>
	                    <td><input type="text" class="regis-text" name="address_1"  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_affiliate_customer ?></td>
	                    <td><input type="text" class="regis-text" name="nickname"  /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_affiliate_telephone ?></td>
	                    <td><input type="text" class="regis-text" name="mobile_phone" id="affiliate-mobilephone" /></td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_input_sms ?></td>
	                    <td>
	                    	<input type="password" class="regis-text w100" name="sms" />
	                    	<a href="javascript:void(0)"  data-rel="affiliate-mobilephone" class="hq-yzm"><?php echo $text_get_sms ?></a> 
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr"><em class="c_r">*</em> <?php echo $entry_captcha ?></td>
	                    <td>
	                    	<input type="text" name="captcha" class="regis-text w100" value=""  />
	                    	<span class="pl10 captcha">
	                    		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
	                    		<a href="javascript:void(0);" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
	                    	</span>
	                    </td>
	                </tr>
	                <tr>
		                <td>&nbsp;</td>
		                <td><input type="checkbox" name="agree" checked="checked" /><?php echo $text_agree; ?> </td>
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
    });
    $(function(){
    	$.validator.setDefaults({      
	        submitHandler: function(form) {   
	            form.submit();   
	       }
	    }),
	    $("#customer-signup").validate({
	    	rules:{
	    		password: {
	                required: true,
	                minlength: 5
	            },
	            confirm: {
	                required: true,
	                minlength: 5,
	                equalTo: "#customer-password"
	            },	            
	            mobile_phone: {
	            	required: true,
	                mobileCN: true
	            },
	            agree: "required"
	    	},
	    	messages:{
	    		password:"密码必填",
	    		mobile_phone:"手机号已注册或非法，请填写有效的手机号码",
	    		agree:{
	                required:"请先阅读注册协议"
	            },
	    	},
	    	errorElement: "span",
	    	errorPlacement: function (error, element) {
	            
	            if (element.is(':radio') || element.is(':checkbox')) {
	                error.appendTo(element.parent());
	            } else {
	                element.after(error);
	            }
	        },
	        focusInvalid: true,
	        success:function(e){
	        	e.html("&nbsp;").addClass("valid");
	        }
	    });
	    $('#affiliate-signup').validate({
	    	rules:{
	    		email:{
					required: true,
					email:true
	    		},
	    		company:{
	    			required: true,
	    			byteRangeLength:[4,15]
	    		},
	    		nickname:{
	    			required: true,
	    			byteRangeLength:[4,15]
	    		},
	    		address_1:{
	    			required: true,
	    			byteRangeLength:[4,15]
	    		},
	    		password: {
	                required: true,
	                minlength: 5
	            },
	            confirm: {
	                required: true,
	                minlength: 5,
	                equalTo: "#affiliate-password"
	            },	            
	            mobile_phone: {
	            	required: true,
	                mobileCN: true
	            },
	            agree: "required"
	    	},
	    	messages:{
	    		password:"密码必填",
	    		mobile_phone:"手机号已注册或非法，请填写有效的手机号码",
	    		agree:{
	                required:"请先阅读注册协议"
	            },
	    	},
	    	errorElement: "span",
	    	errorPlacement: function (error, element) {
	            
	            if (element.is(':radio') || element.is(':checkbox')) {
	                error.appendTo(element.parent());
	            } else {
	                element.after(error);
	            }
	        },
	        focusInvalid: true,
	        success:function(e){
	        	e.html("&nbsp;").addClass("valid");
	        }
	    });
		$.validator.addMethod("mobileCN", function(phone_number, element) {
			phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
			var isMobile = this.optional(element) || phone_number.length > 9 &&
				phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
			if(isMobile){
				var used = false;
				$.ajax({
					url:'index.php?route=account/register/validatePhone',
					data:{mobile_phone:phone_number},
					type:'post',
					async:false,
					dataType:'json',
					success:function(json){
						used = json.used==0 ? false : true;
					}
				});
				return used ? false : true;
			}
			return isMobile;
		}, "手机号码已注册");
    });

	$('.hq-yzm').bind('click',function(){
		if($('#'+$(this).attr('data-rel')).hasClass('valid')){
			$.ajax({
				url:'index.php?route=account/register/getSMS',
				data:{mobile_phone:$('#'+$(this).attr('data-rel')).val()},
				type:'post',
				dataType:'json',
				success:function(json){

				}
			})
		}else{
			alert('invalid');
		}
	})
</script>
<?php echo $footer; ?>