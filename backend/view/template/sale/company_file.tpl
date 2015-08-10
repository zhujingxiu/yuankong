<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr>
      <td class="left"><?php echo $column_date_added; ?></td>
      <td class="left"><?php echo $column_mode; ?></td>
      <td class="left"><?php echo $column_file; ?></td>
      <td class="left"><?php echo $column_sort; ?></td>
      <td class="left"><?php echo $column_status; ?></td>
      <td class="left"><?php echo $column_note; ?></td>
      <td class="right"><?php echo $column_action; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($files) { ?>
    <?php foreach ($files as $item) { ?>
    <tr>
      <td class="left"><?php echo $item['date_added']; ?></td>
      <td class="left"><?php echo $item['mode']; ?></td>
      <td class="left"><img src="<?php echo $item['file']; ?>"></td>
      <td class="left"><?php echo $item['sort']; ?></td>
      <td class="left"><?php echo $item['status']; ?></td>
      <td class="left"><?php echo $item['note']; ?></td>
      <td class="right">
        <?php foreach ($item['action'] as $action): ?>
          <a onclick="<?php echo $action['onclick'] ?>"><?php echo $action['text'] ?></a>
        <?php endforeach ?>
      </td>
    </tr>
    <?php } ?>

    <?php } else { ?>
    <tr>
      <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
<script type="text/javascript">
  function file_detail(file_id,company_id){
    $.get('index.php?route=sale/company/ajax_data&token=<?php echo $token ?>',
      {action:'get_file',file_id:file_id},
      function(json){
        $('#detail-dialog').remove();
        var html = '<form id="detail-form"><table class="form">';
        if(json.data.mode=='permit'){
          html += '<tr><td><?php echo $entry_mode ?></td><td><?php echo $entry_permit ?></td></tr>';
        }else{
          html += '<tr><td><?php echo $entry_mode ?></td><td><?php echo $entry_identity ?></td></tr>';
        }        
        html += '<tr><td><?php echo $entry_file ?></td><td><img src="'+json.data.src+'"></td></tr>';
        html += '<tr><td><?php echo $entry_file_status ?></td><td>';
        html += '<select name="status">';
        if(parseInt(json.data.status)==1){
          html += '<option value="1" selected><?php echo $text_approved ?></option>';
          html += '<option value="0"><?php echo $text_unapprove ?></option>';
        }else{
          html += '<option value="1"><?php echo $text_approved ?></option>';
          html += '<option value="0" selected><?php echo $text_unapprove ?></option>';
        }
        html += '</select></td></tr>';
        html += '<tr><td><?php echo $entry_sort ?></td><td><input type="text" name="sort" value="'+json.data.sort+'" size="3"></td></tr>';
        html += '<tr><td><?php echo $entry_note ?></td><td><textarea name="note" cols="40">'+json.data.note+'</textarea></td></tr>';
        html += '<input type="hidden" name="file_id" value="'+file_id+'"></table></form>';
        $('.content').append('<div id="detail-dialog">'+html+'</div>');
        $('#detail-dialog').dialog({
          width:580,
          title:'<?php echo $title ?>',
          autoOpen:true,
          buttons:{
            '<?php echo $button_save ?>':function(){
              $.ajax({
                url:'index.php?route=sale/company/ajax_data&token=<?php echo $token ?>&action=save_file',
                type:'post',
                data:$('#detail-form input,#detail-form textarea,#detail-form select'),
                dataType:'json',
                beforeSend: function() {
                  $('.success, .warning, .attention').remove();
                  $('#files').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
                },
                success:function(json){
                  if(json.status==1){
                    $('.success, .warning, .attention').remove();
                    $('#files').load('index.php?route=sale/company/file&token=<?php echo $token; ?>&company_id='+company_id);

                  }else{
                    alert('Error:'+json.msg);
                  }
                }
              });
              $(this).dialog('close');
            },
            '<?php echo $button_close ?>':function(){
              $(this).dialog('close');
            }
          }
        })
      },
    'json');
  }
  function file_delete(file_id,company_id){
    if(confirm('<?php echo $confirm_delete ?>')){
      $.ajax({
        url:'index.php?route=sale/company/ajax_data&token=<?php echo $token; ?>',
        type:'get',
        data:{action:'delete_file',file_id:file_id},
        dataType:'json',
        success:function(json){
          if(json.status==1){
            $('.success, .warning, .attention').remove();
            $('#files').load('index.php?route=sale/company/file&token=<?php echo $token; ?>&company_id='+company_id);

          }else{
            alert('Error:'+json.msg);
          }
        }
      })
    }
  }
</script>