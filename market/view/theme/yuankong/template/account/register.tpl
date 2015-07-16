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
	  	<form id="customer-signup" action="<?php echo $customer_action; ?>" method="post" >
			<div class="regis">
			  	<table class="registable" id="customer-form">
					<tr>
					  <td class="tr" width="90">
					  	<em class="c_r">*</em> <?php echo $entry_mobile_phone; ?>
					  </td>
					  <td>
					  	<div class="form-group">
					  		<input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="regis-text" placeholder="<?php echo $entry_mobile_phone ?>" id="customer-mobilephone"/>
					  	</div>
						<?php if ($error_mobile_phone) { ?>
						<span class="error"><?php echo $error_mobile_phone; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="90">
					  	<em class="c_r">*</em> <?php echo $entry_password; ?>
					  </td>
					  <td>
					  	<div class="form-group">
					  		<input type="password" name="password" value="<?php echo $password; ?>" class="regis-text" id="customer-password"/>
					  	</div>
						<?php if ($error_password) { ?>
						<span class="error"><?php echo $error_password; ?></span>
						<?php } ?></td>
					</tr>
					<tr>
					  <td class="tr" width="96">
					  	<em class="c_r">*</em> <?php echo $entry_confirm; ?>
					  </td>
					  <td>
					  	<div class="form-group">
					  		<input type="password" name="confirm" value="<?php echo $confirm; ?>" class="regis-text" />
					  	</div>
						<?php if ($error_confirm) { ?>
						<span class="error"><?php echo $error_confirm; ?></span>
						<?php } ?></td>
					</tr>
					
		            <tr>
		                <td class="tr">
		                	<em class="c_r">*</em> <?php echo $entry_captcha ?>
		                </td>
		                <td>
		                	<div class="form-group">
			                	<input type="text" name="captcha" class="regis-text w100" id="customer-captcha"/>
			                	<span class="pl10 captcha">
			                		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
			                		<a href="javascript:;" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
			                	</span>
			                </div>
		                </td>
		            </tr>
		            <tr>
		                <td class="tr">
		                	<em class="c_r">*</em> <?php echo $entry_input_sms ?>
		                </td>
		                <td>
		                	<div class="form-group">
			                	<input type="text" class="regis-text w100" name="sms" />
			                	<a href="javascript:void(0)" data-rel="customer" class="hq-yzm"><?php echo $text_get_sms ?></a>
			                </div>
		                </td>
		            </tr>
		            <tr>
		                <td>&nbsp;</td>
		                <td>
		                	<div class="form-group">
			                	<input type="checkbox" name="agree" checked="checked" value="1" id="customer-agree"/>
			                	<?php echo $text_agree; ?> 
			                </div>
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
		<form id="affiliate-signup" action="<?php echo $affiliate_action; ?>" method="post" >
			<div class="regis" style="display: none;">
	            <table class="registable" id="affiliate-form">
	            	<tr>
	                    <td class="tr" width="96">
	                    	<em class="c_r">*</em> <?php echo $entry_email ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" class="regis-text" name="email" placeholder="<?php echo $text_affiliate_email ?>" />
		                    </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_password ?>
	                    </td>
	                    <td>
							<div class="form-group">
		                    	<input type="password" class="regis-text" name="password" id="affiliate-password" />
		                    </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_confirm ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="password" class="regis-text" name="confirm"  />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_affiliate_name ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="company" placeholder="<?php echo $text_affiliate_name ?>" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_affiliate_group ?>
	                    </td>
	                    <td>
							<div class="form-group">
		                    	<select class="regis-text" name="group_id">
			                    	<option>设计公司</option>
			                    	<option>工程公司</option>
			                    	<option>检测公司</option>
			                    	<option>维保公司</option>
			                    </select>
			                </div>
		                </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_affiliate_address ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="address_1" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_affiliate_customer ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="nickname" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_affiliate_telephone ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" class="regis-text" name="mobile_phone" id="affiliate-mobilephone" />
		                    </div>
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_captcha ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" name="captcha" class="regis-text w100" value="" id="affiliate-captcha" />
		                    	<span class="pl10 captcha">
		                    		<img src="<?php echo $this->url->link('account/register/captcha','','ssl') ?>" />
		                    		<a href="javascript:void(0);" class="pl10 c_g chg-img"><?php echo $text_captcha_change ?></a>
		                    	</span>
		                    </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_input_sms ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="password" class="regis-text w100" name="sms" />
		                    	<a href="javascript:void(0)" class="hq-yzm"><?php echo $text_get_sms ?></a> 
		                    </div>
	                    </td>
	                </tr>
	                <tr>
		                <td>&nbsp;</td>
		                <td>
		                	<div class="form-group">
		                		<input type="checkbox" name="agree" checked="checked" value="1" id="affiliate-agree"/>
		                		<?php echo $text_agree; ?> 
							</div>
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
	                byteRangeLength: [6,20]
	            },
	            confirm: {
	                required: true,
	                equalTo: "#customer-password"
	            },	            
	            mobile_phone: {
	            	required: true,
	            	isMobile: true,
	                mobileCN: true
	            },
	            captcha:{
	            	required:true,
	            	validCaptcha:true
	            },
	            sms:{
	            	validSMS:"#customer-mobilephone"
	            },
	            agree:{
	            	required:true
	            }
	    	},
	    	messages:{
	    		password:{
	    			required:"密码必填",
	    			byteRangeLength:"密码长度须在6到20个字符",
	    		},
	    		mobile_phone:{
	    			required:"手机号必填",
	    			isMobile:"手机号非法，请填写有效的手机号码",
	    			mobileCN:"手机号码已注册",
	    		},
	    		sms:{
	    			validSMS:"短信验证码无效"
	    		},
	    		agree:{
	    			required:"请先阅读注册协议"
	    		}
	    	},
	    	errorElement: "span",
	    	errorPlacement: function (error, element) {	 
	    		element.parent('.form-group').removeClass('valid').after(error);         
	        },
	        focusInvalid: true,
	        success:function(e){
	        	e.prev('.form-group').addClass("valid").next('.error').remove();
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
	    			byteRangeLength:[4,32]
	    		},
	    		nickname:{
	    			required: true,
	    			byteRangeLength:[2,6]
	    		},
	    		address_1:{
	    			required: true,
	    			byteRangeLength:[4,32]
	    		},
	    		password: {
	                required: true,
	                byteRangeLength:[6,20]
	            },
	            confirm: {
	                required: true,
	                equalTo: "#affiliate-password"
	            },	            
	            mobile_phone: {
	            	required: true,
	            	isMobile: true,
	                mobileCN: true
	            },
	            captcha:{
	            	required:true,
	            	validCaptcha:true
	            },
	            agree: "required"
	    	},
	    	messages:{
	    		password:{
	    			required:"密码必填",
	    			byteRangeLength:"密码长度须在6到20个字符",
	    		},
	    		mobile_phone:{
	    			required:"手机号必填",
	    			isMobile:"手机号非法，请填写有效的手机号码",
	    			mobileCN:"手机号码已注册"
	    		},
	    		agree:{
	                required:"请先阅读注册协议"
	            },
	    	},
	    	errorElement: "span",
	    	errorPlacement: function (error, element) {
	            element.parent('.form-group').removeClass('valid').after(error); 
	        },
	        focusInvalid: true,
	        success:function(e){
	        	e.prev('.form-group').addClass("valid").next('.error').remove();
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
		$.validator.addMethod("validCaptcha", function(captcha, element) {
			captcha = captcha.replace(/\(|\)|\s+|-/g, "");
			var validCaptcha = this.optional(element) || captcha.length == 4 ;
			if(validCaptcha){
				var valide = false;
				$.ajax({
					url:'index.php?route=account/register/validateCaptcha',
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
					url:'index.php?route=account/register/validateSMS',
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

	$(function(){
		$('input[name="agree"]').change(function(){			
			$(this).parent('.form-group').toggleClass('valid');
		});
		$('input[name="agree"]:checked').trigger('change');
	});

	$('.hq-yzm').bind('click',function(){
		var send = true;
		var $that = $(this);
		var items = $('#'+$(this).attr('data-rel')+'-form .form-group').length,
		valids = $('#'+$(this).attr('data-rel')+'-form .form-group.valid').length;
		if(items - valids == 1){
			$.ajax({
				url:'index.php?route=account/register/getSMS',
				data:{mobile_phone:$('#'+$(this).attr('data-rel')+'-form input[name="mobile_phone"]').val(),captcha:$('#'+$(this).attr('data-rel')+'-form input[name="captcha"]').val()},
				type:'post',
				dataType:'json',
				success:function(json){
					if(json.success){
						$that.html(json.success).attr('disabled');
					}
				}
			})
		}else{
			alert('请确认输入的数据合法')
		}
	})
</script>
<?php echo $footer; ?>