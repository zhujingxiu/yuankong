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
      <div class="buttons">
        <a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a>
      </div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs">
        <a style="display:inline;" href="<?php echo $all ?>" class="<?php echo (!$tab || $tab=='all') ? 'selected' : '' ?>"><?php echo $tab_all; ?></a>
        <a style="display:inline;" href="<?php echo $undo ?>" class="<?php echo $tab=='undo' ? 'selected' : '' ?>"><?php echo $tab_pending; ?></a>
        <a style="display:inline;" href="<?php echo $doing ?>" class="<?php echo $tab=='doing' ? 'selected' : '' ?>"><?php echo $tab_processing; ?></a>
        <a style="display:inline;" href="<?php echo $done ?>" class="<?php echo $tab=='done' ? 'selected' : '' ?>"><?php echo $tab_processed; ?></a>
      </div>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="list">
            <thead>
              <tr>
                <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                <td class="left"><?php if ($sort == 'p.project_sn') { ?>
                  <a href="<?php echo $sort_sn; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_project_sn; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_sn; ?>"><?php echo $column_project_sn; ?></a>
                  <?php } ?></td>
                <td class="left"><?php if ($sort == 'p.group') { ?>
                  <a href="<?php echo $sort_group; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_category; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_group; ?>"><?php echo $column_category; ?></a>
                  <?php } ?></td>
                <td class="left"><?php if ($sort == 'p.account') { ?>
                  <a href="<?php echo $sort_account; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_account; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_account; ?>"><?php echo $column_account; ?></a>
                  <?php } ?></td>
                <td class="left"><?php if ($sort == 'p.telephone') { ?>
                  <a href="<?php echo $sort_telephone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_phone; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_telephone; ?>"><?php echo $column_phone; ?></a>
                  <?php } ?></td>
                <td class="left"><?php if ($sort == 'p.date_applied') { ?>
                  <a href="<?php echo $sort_date_applied; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_applied; ?></a>
                  <?php } else { ?>
                  <a href="<?php echo $sort_date_applied; ?>"><?php echo $column_date_applied; ?></a>
                  <?php } ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($projects) { ?>
              <?php foreach ($projects as $item) { ?>
              <tr>
                <td style="text-align: center;"><?php if ($item['selected']) { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $item['project_id']; ?>" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $item['project_id']; ?>" />
                  <?php } ?></td>
                <td class="left"><?php echo $item['project_sn']; ?></td>
                <td class="left"><?php echo $item['group']; ?></td>
                <td class="left"><?php echo $item['account']; ?></td>
                <td class="left"><?php echo $item['telephone']; ?></td>
                <td class="left"><?php echo $item['date_applied']; ?></td>
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
          </div>
        </div>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<div id="status-dialog" style="display:none">
  <div class="do-result"></div>
  <table class="form">
    <tr>
      <td><?php echo $entry_status ?></td>
      <td>
        <select name="status">        
          <option value="1"><?php echo $tab_pending ?></option>
          <option value="2"><?php echo $tab_processing ?></option>
          <option value="3"><?php echo $tab_processed ?></option>
        </select>
      </td>
    </tr>
  </table>
</div>
<script type="text/javascript">
  function changeStatus(project_id,status){
    $('#status-dialog select[name="status"]').val(status);
    $('#status-dialog').dialog({
      width:400,
      title:'<?php echo $text_title ?>',
      buttons:{
        '<?php echo $button_close ?>':function(){
          $(this).dialog('close');
        },
        '<?php echo $button_save ?>':function(){
          
            $.ajax({
              url:'index.php?route=sale/project/edit&token=<?php echo $token ?>',
              type:'post',
              data:{project_id:project_id,status:$('#status-dialog select[name="status"]').val()},
              dataType:'json',
              success:function(json){
                $('.do-result').empty();
                if(json.status==0){
                  $('.do-result').html('<div class="alert success">'+json.msg+'</div>');
                }else{
                  $('.do-result').html('<div class="alert success">'+json.msg+'</div>');
                  setTimeout('location.reload();',2000);
                }
              }
            })
          
        }
      }
    });
  }
</script>
<?php echo $footer; ?>