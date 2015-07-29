<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a> <a href="#tab-payment"><?php echo $tab_payment; ?></a>
        <?php if ($affiliate_id) { ?>
        <a href="#tab-transaction"><?php echo $tab_transaction; ?></a>
        <?php } ?>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
                <td class="left"><?php echo $text_group; ?></td>
                <td>
                    <select name="group_id">
                        <?php foreach ($groups as $item): ?>
                        <option value="<?php echo $item['group_id'] ?>" <?php echo $group_id == $item['group_id'] ? 'selected' : '' ?>><?php echo $item['name'] ?></option>
                        <?php endforeach ?>
                    </select>
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_company; ?></td>
              <td><input type="text" name="company" value="<?php echo $company; ?>" size="50"/></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_fullname; ?></td>
              <td><input type="text" name="fullname" value="<?php echo $fullname; ?>" />
                <?php if ($error_fullname) { ?>
                <span class="error"><?php echo $error_fullname; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_mobile_phone; ?></td>
              <td><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" />
                <?php if ($error_mobile_phone) { ?>
                <span class="error"><?php echo $error_mobile_phone; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_email; ?></td>
              <td><input type="text" name="email" value="<?php echo $email; ?>" size="50"/>
                <?php if ($error_email) { ?>
                <span class="error"><?php echo $error_email; ?></span>
                <?php  } ?></td>
            </tr>

            
            <tr>
              <td><span class="required">*</span> <?php echo $entry_address; ?></td>
              <td><input type="text" name="address" value="<?php echo $address; ?>" />
                <?php if ($error_address) { ?>
                <span class="error"><?php echo $error_address; ?></span>
                <?php  } ?></td>
            </tr>
            
            <tr>
              <td><span class="required">*</span> <?php echo $entry_province; ?></td>
              <td><div id="area-zone"><?php echo $area_zone ?></div><div class="item-adress" id="area"></div><?php if ($error_area) { ?>
                <span class="error"><?php echo $error_area; ?></span>
                <?php  } ?></td>
            </tr>

            <tr>
              <td><?php echo $entry_password; ?></td>
              <td><input type="password" name="password" value="<?php echo $password; ?>"  />
                <?php if ($error_password) { ?>
                <span class="error"><?php echo $error_password; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_confirm; ?></td>
              <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                <?php if ($error_confirm) { ?>
                <span class="error"><?php echo $error_confirm; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_telephone; ?></td>
              <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_fax; ?></td>
              <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_postcode; ?></td>
              <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_code; ?></td>
              <td><input type="code" name="code" value="<?php echo $code; ?>"  /></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-payment">
          <table class="form">
            <tbody>
              <tr>
                <td><?php echo $entry_commission; ?></td>
                <td><input type="text" name="commission" value="<?php echo $commission; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_tax; ?></td>
                <td><input type="text" name="tax" value="<?php echo $tax; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_payment; ?></td>
                <td><?php if ($payment == 'cheque') { ?>
                  <input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="payment" value="cheque" id="cheque" />
                  <?php } ?>
                  <label for="cheque"><?php echo $text_cheque; ?></label>

                  <?php if ($payment == 'bank') { ?>
                  <input type="radio" name="payment" value="bank" id="bank" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="payment" value="bank" id="bank" />
                  <?php } ?>
                  <label for="bank"><?php echo $text_bank; ?></label></td>
              </tr>
            </tbody>
            <tbody id="payment-cheque" class="payment">
              <tr>
                <td><?php echo $entry_cheque; ?></td>
                <td><input type="text" name="cheque" value="<?php echo $cheque; ?>" /></td>
              </tr>
            </tbody>

            <tbody id="payment-bank" class="payment">
              <tr>
                <td><?php echo $entry_bank_name; ?></td>
                <td><input type="text" name="bank_name" value="<?php echo $bank_name; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_bank_branch_number; ?></td>
                <td><input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_bank_swift_code; ?></td>
                <td><input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" /></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_bank_account_name; ?></td>
                <td><input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" /></td>
              </tr>
              <tr>
                <td><span class="required">*</span> <?php echo $entry_bank_account_number; ?></td>
                <td><input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" /></td>
              </tr>
            </tbody>
          </table>
        </div>
        <?php if ($affiliate_id) { ?>
        <div id="tab-transaction">
          <table class="form">
            <tr>
              <td><?php echo $entry_description; ?></td>
              <td><input type="text" name="description" value="" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_amount; ?></td>
              <td><input type="text" name="amount" value="" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-reward" class="button" onclick="addTransaction();"><span><?php echo $button_add_transaction; ?></span></a></td>
            </tr>
          </table>
          <div id="transaction"></div>
        </div>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
    $(function(){
        add_select(0);
        $('body').on('change', '#area select', function() {
            var $me = $(this);
            var $next = $me.next();

            if ($me.val() == $next.data('pid')) {
                return;
            }
            $me.nextAll().remove();
            add_select($me.val());
        });

        function add_select(pid) {
            var area_names = area['name'+pid];
            if (!area_names) {
                return false;
            }
            var area_codes = area['code'+pid];
            var $select = $('<select >');
            $select.attr('name', 'area[]');
            $select.attr('class', 'adress-sec');
            $select.data('pid', pid);
            if (area_codes[0] != -1) {
                area_names.unshift('请选择');
                area_codes.unshift(0);
            }
            for (var idx in area_codes) {
                var $option = $('<option>');
                $option.attr('value', area_codes[idx]);
                $option.text(area_names[idx]);
                $select.append($option);
            }
            $('#area').append($select);
        };
    });
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$('#transaction .pagination a').live('click', function() {
	$('#transaction').load(this.href);
	
	return false;
});			

$('#transaction').load('index.php?route=sale/affiliate/transaction&token=<?php echo $token; ?>&affiliate_id=<?php echo $affiliate_id; ?>');

function addTransaction() {
	$.ajax({
		url: 'index.php?route=sale/affiliate/transaction&token=<?php echo $token; ?>&affiliate_id=<?php echo $affiliate_id; ?>',
		type: 'post',
		dataType: 'html',
		data: 'description=' + encodeURIComponent($('#tab-transaction input[name=\'description\']').val()) + '&amount=' + encodeURIComponent($('#tab-transaction input[name=\'amount\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-transaction').attr('disabled', true);
			$('#transaction').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-transaction').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(html) {
			$('#transaction').html(html);
			
			$('#tab-transaction input[name=\'amount\']').val('');
			$('#tab-transaction input[name=\'description\']').val('');
		}
	});
}
$('.htabs a').tabs();
//--></script> 
<?php echo $footer; ?>