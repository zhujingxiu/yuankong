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
      <td class="left"><?php echo $column_title; ?></td>
      <td class="left"><?php echo $column_photo; ?></td>      
      <td class="left"><?php echo $column_sort; ?></td>      
      <td class="right"><?php echo $column_action; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($cases) { ?>
    <?php foreach ($cases as $item) { ?>
    <tr>
      <td class="left"><?php echo $item['date_added']; ?></td>
      <td class="left"><?php echo $item['title']; ?></td>
      <td class="left"><img src="<?php echo $item['photo']; ?>"></td>
      
      <td class="left"><?php echo $item['sort']; ?></td>
      
      <td class="right">
        <?php foreach ($item['action'] as $action): ?>
          <a onclick="<?php echo $action['onclick'] ?>"><?php echo $action['text'] ?></a>
        <?php endforeach ?>
      </td>
    </tr>
    <?php } ?>

    <?php } else { ?>
    <tr>
      <td class="center" colspan="5"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
<script type="text/javascript">
  function case_detail(case_id,company_id){
    $.get('index.php?route=sale/company/ajax_data&token=<?php echo $token ?>',
      {action:'get_case',case_id:case_id},
      function(json){
        $('#detail-dialog').remove();
        var html = '<form id="detail-form"><table class="form">';
        html += '<tr><td><?php echo $entry_title ?></td><td><input name="title" value="'+json.data.title+'" /></td></tr>';      
        html += '<tr><td><?php echo $entry_photo ?></td><td><img src="'+json.data.src+'"/><input name="photo" value="'+json.data.photo+'" type="hidden"/></td></tr>';
        html += '</select></td></tr>';
        html += '<tr><td><?php echo $entry_sort ?></td><td><input type="text" name="sort" value="'+json.data.sort+'" size="3"></td></tr>';
        html += '<input type="hidden" name="case_id" value="'+case_id+'"></table></form>';
        $('.content').append('<div id="detail-dialog">'+html+'</div>');
        $('#detail-dialog').dialog({
          width:580,
          title:'<?php echo $title ?>',
          autoOpen:true,
          buttons:{
            '<?php echo $button_save ?>':function(){
              $.ajax({
                url:'index.php?route=sale/company/ajax_data&token=<?php echo $token ?>&action=save_case',
                type:'post',
                data:$('#detail-form input,#detail-form textarea,#detail-form select'),
                dataType:'json',
                beforeSend: function() {
                  $('.success, .warning, .attention').remove();
                  $('#cases').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
                },
                success:function(json){
                  if(json.status==1){
                    $('.success, .warning, .attention').remove();
                    $('#cases').load('index.php?route=sale/company/cases&token=<?php echo $token; ?>&company_id='+company_id);
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
  function case_delete(case_id,company_id){
    if(confirm('<?php echo $confirm_delete ?>')){
      $.ajax({
        url:'index.php?route=sale/company/ajax_data&token=<?php echo $token; ?>',
        type:'get',
        data:{action:'delete_case',case_id:case_id},
        dataType:'json',
        success:function(json){
          if(json.status==1){
            $('.success, .warning, .attention').remove();
            $('#cases').load('index.php?route=sale/company/cases&token=<?php echo $token; ?>&company_id='+company_id);
          }else{
            alert('Error:'+json.msg);
          }
        }
      })
    }
  }
</script>