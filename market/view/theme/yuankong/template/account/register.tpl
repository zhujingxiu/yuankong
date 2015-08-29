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
<script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/jquery.validate.js"></script>
<script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/localization/messages_zh.js"></script>
<script type="text/javascript" src="market/view/theme/yuankong/javascript/passport.js"></script>
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
            <li class="regis-li"><?php echo $text_regs_company ?></li>
        </ul>
        <span class="r"></span>
    </div>

	<div class="regis-box fix">
	  	<div class="r">
            <p class="f_m c46"><?php echo $text_qr_code ?></p>
            <p><img src="asset/image/qrcode.jpg" alt="" width="250px" height="250px"/></p>
        </div>
	  	<form id="customer-signup" action="<?php echo $action; ?>" method="post" >
			<div class="regis">
			  	<table class="registable" id="customer-form">
					<tr>
					  <td class="tr" width="90" valign="top">
					  	<em class="c_r">*</em> <?php echo $entry_mobile_phone; ?>
					  </td>
					  <td>
					  	<div class="form-group">
					  		<input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="regis-text" placeholder="<?php echo $entry_mobile_phone ?>" data-rel="customer" id="customer-mobilephone"/>
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
			                		<img src="<?php echo $captcha_link ?>" />
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
		<form id="company-signup" action="<?php echo $action; ?>" method="post" >
			<div class="regis" style="display: none;">
	            <table class="registable" id="company-form">
	            	<tr>
	                    <td class="tr" width="96" valign="top">
	                    	<em class="c_r">*</em> <?php echo $entry_email ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" class="regis-text" name="email" placeholder="<?php echo $text_company_email ?>" />
		                    </div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_password ?>
	                    </td>
	                    <td>
							<div class="form-group">
		                    	<input type="password" class="regis-text" name="password" id="company-password" />
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
	                    	<em class="c_r">*</em> <?php echo $entry_company_name ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="title" placeholder="<?php echo $text_company_name ?>" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_company_group ?>
	                    </td>
	                    <td>
							<div class="form-group">
		                    	<div class="form-group">
									<?php foreach ($company_groups as $item): ?>
									<div class="w100"><input type="checkbox" name="group_id[]" value="<?php echo $item['group_id'] ?>" /> <?php echo $item['name'] ?></div>
									<?php endforeach ?>
			                    	
				                </div>
			                </div>
		                </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_company_address ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="address" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_company_customer ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
	                    		<input type="text" class="regis-text" name="corporation" />
	                    	</div>
	                    </td>
	                </tr>
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_company_telephone ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" class="regis-text" data-rel="company" name="mobile_phone" id="company-mobilephone" />
		                    </div>
	                    </td>
	                </tr>
	                
	                <tr>
	                    <td class="tr">
	                    	<em class="c_r">*</em> <?php echo $entry_captcha ?>
	                    </td>
	                    <td>
	                    	<div class="form-group">
		                    	<input type="text" name="captcha" class="regis-text w100" value="" id="company-captcha" />
		                    	<span class="pl10 captcha">
		                    		<img src="<?php echo $captcha_link ?>" />
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
		                    	<a href="javascript:void(0)" data-rel="company" class="hq-yzm"><?php echo $text_get_sms ?></a> 
		                    </div>
	                    </td>
	                </tr>
	                <tr>
		                <td>&nbsp;</td>
		                <td>
		                	<div class="form-group">
		                		<input type="checkbox" name="agree" checked="checked" value="1" id="company-agree"/>
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
    $('.captcha a.c_g').bind('click',function(e){
    	e.preventDefault();
    	$('.captcha img').attr('src',"<?php echo $captcha_link ?>&t="+(Math.round(Math.random()*999)+9999))
    });

	$(function(){
		$('input[name="agree"]').change(function(){			
			$(this).parent('.form-group').toggleClass('valid');
		});
		$('input[name="agree"]:checked').trigger('change');
	});
	var resetSMS,regedMobile,interval = 120;
	$('input[name="mobile_phone"]').bind("propertychange input",function(){
		if($(this).val() != regedMobile ){
			clearTimeout(resetSMS);
			$('a.hq-yzm[data-rel="'+$(this).attr('data-rel')+'"]')
				.removeAttr('disabled')
				.text('<?php echo $text_get_sms ?>');
		}
	});
	$('.hq-yzm').bind('click',function(){
		
		$('#'+$(this).attr('data-rel')+'-form').submit();
		var obj_mobile = $('#'+$(this).attr('data-rel')+'-form input[name="mobile_phone"]');
		var obj_captcha = $('#'+$(this).attr('data-rel')+'-form input[name="captcha"]');
		if(obj_mobile.parent('.form-group').hasClass('valid') && obj_captcha.parent('.form-group').hasClass('valid')){
			var $that = $(this);
			$.ajax({
				url:'index.php?route=common/tool/getSMS',
				data:{mobile_phone:obj_mobile.val(),captcha:obj_captcha.val()},
				type:'post',
				dataType:'json',
				success:function(json){
					if(json.success){
						$that.attr('disabled','disabled');
						regedMobile = obj_mobile.val();
						send_agin($('a.hq-yzm[data-rel="'+$that.attr('data-rel')+'"]'));
					}else{
						alert(json.error.sms)
					}
				}
			})
		}else{
			alert('请确认输入的数据合法')
		}
	});
	
	function send_agin(obj){
		interval--;
		
		if(interval>0){
			resetSMS = setTimeout(function(){send_agin(obj);},1000);			
			obj.text(interval+'<?php echo '秒后'.$text_get_sms ?>');
		}else{
			obj.removeAttr('disabled').text('<?php echo $text_get_sms ?>');			
			interval=120;
		}
	}
</script>
<?php echo $footer; ?>