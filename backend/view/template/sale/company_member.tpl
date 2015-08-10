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
      <td class="left"><?php echo $column_member; ?></td>
      <td class="left"><?php echo $column_avatar; ?></td>
      <td class="left"><?php echo $column_position; ?></td>
      <td class="left"><?php echo $column_sort; ?></td>
      <td class="left"><?php echo $column_note; ?></td>
      <td class="right"><?php echo $column_action; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($members) { ?>
    <?php foreach ($members as $item) { ?>
    <tr>
      <td class="left"><?php echo $item['date_added']; ?></td>
      <td class="left"><?php echo $item['name']; ?></td>
      <td class="left"><img src="<?php echo $item['avatar']; ?>"></td>
      <td class="left"><?php echo $item['position']; ?></td>
      <td class="left"><?php echo $item['sort']; ?></td>
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
  function member_detail(member_id,company_id){
    $.get('index.php?route=sale/company/ajax_data&token=<?php echo $token ?>',
      {action:'get_member',member_id:member_id},
      function(json){
        $('#detail-dialog').remove();
        var html = '<form id="detail-form"><table class="form">';

        html += '<tr><td><?php echo $entry_member ?></td><td><input name="name" value="'+json.data.name+'" /></td></tr>';      
        html += '<tr><td><?php echo $entry_avatar ?></td><td><img src="'+json.data.src+'"></td></tr>';
        html += '<tr><td><?php echo $entry_position ?></td><td><input name="position" value="'+json.data.position+'"></td></tr>';

        html += '</select></td></tr>';
        html += '<tr><td><?php echo $entry_sort ?></td><td><input type="text" name="sort" value="'+json.data.sort+'" size="3"></td></tr>';
        html += '<tr><td><?php echo $entry_note ?></td><td><textarea name="note" cols="40">'+json.data.note+'</textarea></td></tr>';
        html += '<input type="hidden" name="member_id" value="'+member_id+'"></table></form>';
        $('.content').append('<div id="detail-dialog">'+html+'</div>');
        $('#detail-dialog').dialog({
          width:580,
          title:'<?php echo $title ?>',
          autoOpen:true,
          buttons:{
            '<?php echo $button_save ?>':function(){
              $.ajax({
                url:'index.php?route=sale/company/ajax_data&token=<?php echo $token ?>&action=save_member',
                type:'post',
                data:$('#detail-form input,#detail-form textarea,#detail-form select'),
                dataType:'json',
                beforeSend: function() {
                  $('.success, .warning, .attention').remove();
                  $('#members').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
                },
                success:function(json){
                  if(json.status==1){
                    $('.success, .warning, .attention').remove();
                    $('#members').load('index.php?route=sale/company/member&token=<?php echo $token; ?>&company_id='+company_id);
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
  function member_delete(member_id,company_id){
    if(confirm('<?php echo $confirm_delete ?>')){
      $.ajax({
        url:'index.php?route=sale/company/ajax_data&token=<?php echo $token; ?>',
        type:'get',
        data:{action:'delete_member',member_id:member_id},
        dataType:'json',
        success:function(json){
          if(json.status==1){
            $('.success, .warning, .attention').remove();
            $('#members').load('index.php?route=sale/company/member&token=<?php echo $token; ?>&company_id='+company_id);
          }else{
            alert('Error:'+json.msg);
          }
        }
      })
    }
  }
</script>