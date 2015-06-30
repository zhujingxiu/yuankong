<?php echo $header; ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<style type="text/css">
	.oauth_login, .oauth_info{
		border:1px #DDD solid; padding:15px; margin-bottom:20px;
		color:#666;
		font-family:"Hiragino Sans GB","Hiragino Sans GB W3","Microsoft YaHei","微软雅黑",tahoma,arial,simhei,"黑体";
		overflow:hidden;
	}
	.oauth_login h2, .oauth_info h2{
		font-size:12px;
		color:#666;
		padding:0px;
		margin:0px;
		margin-bottom:10px;
	}
	.oauth_info h2{
		margin-bottom:5px;
	}
	.oauth_login input[type='text'], .oauth_login input[type='password'], .oauth_login select{
		font-family:"Hiragino Sans GB","Hiragino Sans GB W3","Microsoft YaHei","微软雅黑",tahoma,arial,simhei,"黑体";
		width:150px;
		border:1px #DDD solid;
		padding:5px;
	}
	.oauth_login select{
		width:160px;
		border:1px #DDD solid;
		padding:5px;
	}
	
	/* oauth info */
	.oauth_info .face{
		float:left;
		width:64px;
		height:64px;
	}
	.oauth_info .face img{
		width:64px;
		height:auto;
		-webkit-border-radius: 7px 7px 7px 7px;
		-moz-border-radius: 7px 7px 7px 7px;
		-khtml-border-radius: 7px 7px 7px 7px;
		border-radius: 7px 7px 7px 7px;
	}
	.oauth_info .info{
		margin-left:84px;
	}
	.oauth_info .info span{
		display:inline-block;
		margin-bottom:5px;
	}
	
	/* oauth login */
	.oauth_login input[type='radio'], .oauth_login input[type='checkbox']{
		padding:0px;
		margin:0px;
	}
	.oauth_login .left{
		float:left;
		width:48%;
		border-right:1px #EEE solid;
		padding-right:15px;
	}
	.oauth_login .right{
		float:right;
		width:48%;
	}
	.oauth_login ul{
		padding:0px;
		margin:0px;
		margin-bottom:20px;
		list-style:none;
	}
	.bt{
		padding:5px 0px;
		border-bottom:1px #DDD dotted;
	}
	.pt{
		padding:7px 0px;
		border-top:1px #DDD dotted;
		border-bottom:1px #DDD dotted;
	}
	.rt{
		text-align:right;
	}
	.oauth_login ul li{
		margin-bottom:6px;
	}
	.oauth_login ul li a{
		font-size:12px;
		color:#999;
		text-decoration:none;
	}
	.oauth_login ul li .error{
		display:inline-block;
	}
	.oauth_login .t{
		display:inline-block;
		width:100px;
		margin-right:10px;
		text-align:right;
		text-transform:capitalize;
	}
</style>
  <h1><?php echo $heading_title; ?></h1>
  <div class="oauth_info">
	<div class="face"><img src="<?php echo $info['face']; ?>" /></div>
	<div class="info">
		<h2><?php echo $text_user_hello; ?></h2>
		<span><?php echo $text_user_tip; ?></span><br />
		<span><?php echo $entry_type; ?> <?php echo $info['tag']; ?></span>
	</div>
  </div>
  
  <div class="oauth_login">
    <div class="left spr">
    <form action="<?php echo $action_register; ?>" method="post" enctype="multipart/form-data">
      <h2><?php echo $text_bind_info1; ?></h2>
	  <ul>
	    <!-- Details -->
		<li class="bt"><?php echo $text_your_details; ?></li>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_firstname; ?></span><span class="i"><input type="text" name="firstname" /></span></li>
		<?php if ($error_firstname) { ?>
        <li class="rt"><span class="error"><?php echo $error_firstname; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_lastname; ?></span><span class="i"><input type="text" name="lastname" /></span></li>
		<?php if ($error_lastname) { ?>
        <li class="rt"><span class="error"><?php echo $error_lastname; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_email; ?></span><span class="i"><input type="text" name="email" /></span></li>
		<?php if ($error_email) { ?>
        <li class="rt"><span class="error"><?php echo $error_email; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_telephone; ?></span><span class="i"><input type="text" name="telephone" /></span></li>
		<?php if ($error_telephone) { ?>
        <li class="rt"><span class="error"><?php echo $error_telephone; ?></span></li>
        <?php } ?>
		<li><span class="t"><?php echo $entry_fax; ?></span><span class="i"><input type="text" name="fax" /></span></li>
		
	    <!-- Address -->
		<li class="bt"><?php echo $text_your_address; ?></li>
		<li><span class="t"><?php echo $entry_company; ?></span><span class="i"><input type="text" name="company" /></span></li>
		<li style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;"><span class="t"><?php echo $entry_customer_group; ?></span><span class="i">
		
			<?php foreach ($customer_groups as $customer_group) { ?>
            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } else { ?>
            <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" id="customer_group_id<?php echo $customer_group['customer_group_id']; ?>" />
            <label for="customer_group_id<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></label>
            <br />
            <?php } ?>
            <?php } ?>
			
			</span></li>
		<li id="company-id-display"><span class="t"><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></span><span class="i"><input type="text" name="company_id" /></span></li>
		<?php if ($error_company_id) { ?>
        <li class="rt"><span class="error"><?php echo $error_company_id; ?></span></li>
        <?php } ?>
		<li id="tax-id-display"><span class="t"><?php echo $entry_tax_id; ?></span><span class="i"><input type="text" name="tax_id" /></span></li>
		<?php if ($error_tax_id) { ?>
        <li class="rt"><span class="error"><?php echo $error_tax_id; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_address_1; ?></span><span class="i"><input type="text" name="address_1" /></span></li>
		<?php if ($error_address_1) { ?>
        <li class="rt"><span class="error"><?php echo $error_address_1; ?></span></li>
        <?php } ?>
		<li><span class="t"><?php echo $entry_address_2; ?></span><span class="i"><input type="text" name="address_2" /></span></li>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_city; ?></span><span class="i"><input type="text" name="city" /></span></li>
		<?php if ($error_city) { ?>
        <li class="rt"><span class="error"><?php echo $error_city; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_postcode; ?></span><span class="i"><input type="text" name="postcode" /></span></li>
		<?php if ($error_postcode) { ?>
        <li class="rt"><span class="error"><?php echo $error_postcode; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_country; ?></span><span class="i"><select name="country_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
			</span></li>
		<?php if ($error_country) { ?>
        <li class="rt"><span class="error"><?php echo $error_country; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_zone; ?></span><span class="i"><select name="zone_id"></select></span></li>
		<?php if ($error_zone) { ?>
        <li class="rt"><span class="error"><?php echo $error_zone; ?></span></li>
        <?php } ?>
		
		<!-- Password -->
		<li class="bt"><?php echo $text_your_password; ?></li>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_password; ?></span><span class="i"><input type="password" name="password" /></span></li>
		<?php if ($error_password) { ?>
        <li class="rt"><span class="error"><?php echo $error_password; ?></span></li>
        <?php } ?>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_confirm; ?></span><span class="i"><input type="password" name="confirm" /></span></li>
		<?php if ($error_confirm) { ?>
        <li class="rt"><span class="error"><?php echo $error_confirm; ?></span></li>
        <?php } ?>
		
		<!-- Password -->
        <li class="pt rt"><?php echo $text_agree; ?> &nbsp;
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?></li>
		<?php if ($error_agree) { ?>
        <li class="rt"><span class="error"><?php echo $error_agree; ?></span></li>
        <?php } ?>
		<li class="rt"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></li>
	  </ul>
	</form>
	</div>
    <div class="right">
    <form action="<?php echo $action_login; ?>" method="post" enctype="multipart/form-data">
      <h2><?php echo $text_bind_info2; ?></h2>
	  <ul>
		<li class="bt"><?php echo $text_your_login; ?></li>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_email; ?></span><span class="i"><input type="text" name="email" /></span></li>
		<li><span class="t"><span class="required">*</span> <?php echo $entry_password; ?></span><span class="i"><input type="password" name="password" /></span></li>
		<?php if ($error_login) { ?>
        <li class="rt"><span class="error"><?php echo $error_login; ?></span></li>
        <?php } ?>
		<li><span class="t"></span><span class="i"><a href="<?php echo $forgotten; ?>" target="_blank"><?php echo $text_forgotten; ?></a></span></li>
		<li><span class="t"></span><span class="i"><input type="submit" value="Login" class="button" /></span></li>
	  </ul>
	</form>
	</div>
  </div>
  <?php echo $content_bottom; ?></div>

<?php if (!$this->customer->isLogged()) { ?>
<script type="text/javascript"><!--
$('input[name=\'customer_group_id\']:checked').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=account/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		width: 640,
		height: 480
	});
});
//--></script>
<?php } ?>
<?php echo $footer; ?> 