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
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form-alipay').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-alipay" class="form-horizontal">
        <table class="form">  
          <tr>
            <td>
              <?php echo $entry_partner_id; ?>
              <span class="help"><?php echo $entry_partner_id_help; ?></span>
            </td>
            <td>
              <input type="text" name="alipay_direct_partner_id" value="<?php echo $alipay_direct_partner_id; ?>" placeholder="<?php echo $entry_partner_id_help; ?>" id="alipay_direct_partner_id" />
              <?php if ($error_alipay_direct_partner_id) { ?>
              	<div class="text-danger"><?php echo $error_alipay_direct_partner_id; ?></div>
              <?php } ?>
            </div>
          </div></tr>
          <tr>
            <td><?php echo $entry_account; ?></td>
            <td>
              <input type="text" name="alipay_direct_account" value="<?php echo $alipay_direct_account; ?>" placeholder="<?php echo $entry_account; ?>" id="alipay_direct_account" />
              <?php if ($error_alipay_direct_account) { ?>
              	<div class="text-danger"><?php echo $error_alipay_direct_account; ?></div>
              <?php } ?>
            </div>
          </tr>
          <tr>
            <td><?php echo $entry_cod; ?><span class="help"><?php echo $entry_cod_help; ?></span>
            </td>
            <td>
              <input type="text" name="alipay_direct_cod" value="<?php echo $alipay_direct_cod; ?>" placeholder="<?php echo $entry_cod_help; ?>" id="alipay_direct_cod" />
              <?php if ($error_alipay_direct_cod) { ?>
              	<div class="text-danger"><?php echo $error_alipay_direct_cod; ?></div>
              <?php } ?>
            </div>
          </tr>
          <tr>
            <td for="input-order-status"><?php echo $entry_order_status; ?></label>
            </td>
            <td>
              <select name="alipay_direct_order_status_id" id="input-order-status">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $alipay_direct_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>          
          </tr>
          <tr>
            <td for="input-status"><?php echo $entry_status; ?></label>
            </td>
            <td>
              <select name="alipay_direct_status" id="input-status">
                <?php if ($alipay_direct_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </tr>
          <tr>
            <td for="alipay_direct_note"><?php echo $entry_note; ?></label>
            </td>
            <td>
              <input type="text" name="alipay_direct_note" value="<?php echo $alipay_direct_note; ?>" placeholder="<?php echo $entry_note; ?>" id="alipay_direct_note" />
            </div>
          </tr>
          <tr>
            <td for="alipay_direct_sort_order"><?php echo $entry_sort_order; ?></label>
            </td>
            <td>
              <input type="text" name="alipay_direct_sort_order" value="<?php echo $alipay_direct_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="alipay_direct_sort_order" />
            </div>
          </tr>
        </table>  
      </form>
    </div>
  </div>
</div>
<style type="text/css">
  input[type="text"]{width: 330px}
</style>
<?php echo $footer; ?> 