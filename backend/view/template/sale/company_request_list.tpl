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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a>
        <a onclick="$('form').attr('action', '<?php echo $delete; ?>'); $('form').submit();" class="button"><?php echo $button_delete; ?></a>
      </div>
    </div>

    <div class="content">
      <form action="" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'cr.account') { ?>
                <a href="<?php echo $sort_account; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_account; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_account; ?>"><?php echo $column_account; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'cr.mobile_phone') { ?>
                <a href="<?php echo $sort_mobile_phone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_mobile_phone; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_mobile_phone; ?>"><?php echo $column_mobile_phone; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'cr.company_id') { ?>
                <a href="<?php echo $sort_company; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_company; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_company; ?>"><?php echo $column_company; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'cr.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'cr.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr class="filter">
              <td></td>
              <td><input type="text" name="filter_account" value="<?php echo $filter_account; ?>" /></td>
              <td><input type="text" name="filter_mobile_phone" value="<?php echo $filter_mobile_phone; ?>" /></td>
              <td><input type="text" name="filter_company" value="<?php echo $filter_company; ?>" /></td>
              <td><select name="filter_status">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_completed; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_completed; ?></option>
                  <?php } ?>
                  <?php if (!is_null($filter_status) && !$filter_status) { ?>
                  <option value="0" selected="selected"><?php echo $text_pending; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_pending; ?></option>
                  <?php } ?>
                </select></td>
              <td><input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" size="12" id="date" /></td>
              <td align="right"><a onclick="filter();" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
            <?php if ($requests) { ?>
            <?php foreach ($requests as $item) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($item['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['request_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['request_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $item['account']; ?></td>
              <td class="left"><?php echo $item['mobile_phone']; ?></td>
              <td class="left"><?php echo $item['company']; ?></td>
              <td class="left"><?php echo $item['status_text']; ?></td>
              <td class="left"><?php echo $item['date_added']; ?></td>
              <td class="right"><?php foreach ($item['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=sale/company_request&token=<?php echo $token; ?>';
	var paramArr=[];
  $("tr.filter input[name],tr.filter select[name]").each(function(){
    if($(this).val()&&$(this).val()!='*'){
      paramArr.push($(this).attr("name")+"="+encodeURIComponent($(this).val()))
    }
  });
  if(paramArr.length>0){
    url+="&"+paramArr.join("&");
  }
	location = url;
}
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<script type="text/javascript"><!--
$('input[name=\'filter_name\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/company/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.company_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'filter_name\']').val(ui.item.label);
						
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
//--></script> 
<?php echo $footer; ?>