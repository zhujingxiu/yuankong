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
      <h1><img src="view/image/log.png" alt="" width="22px" height="22px"/> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="javascript:detail(null)" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>                
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'l.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'l.url') { ?>
                <a href="<?php echo $sort_url; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_url; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_url; ?>"><?php echo $column_url; ?></a>
                <?php } ?></td>
              

              <td class="left"><?php if ($sort == 'l.sort_order') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'l.status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($links) { ?>
            <?php foreach ($links as $item) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($item['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['link_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['link_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo truncate_string($item['name']); ?></td>  
              <td class="left"><?php echo truncate_string($item['url']) ; ?></td>           
              <td class="left"><?php echo $item['sort_order']; ?></td>
              <td class="left"><?php echo $item['status']; ?></td>
              <td class="right"><?php foreach ($item['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<div id="detail-dialog" style="display:none">
  <div class="do-result"></div>
    <table class="form">
      <tr>
        <td><span class="required">*</span> <?php echo $entry_name; ?></td>
        <td><input type="text" name="name" value="" style="width:90%"/></td>
      </tr>
      <tr>
        <td><span class="required">*</span> <?php echo $entry_url; ?></td>
        <td><input type="text" name="url" value="" style="width:90%" /></td>
      </tr>

      <tr>
        <td><?php echo $entry_status; ?></td>
        <td><select name="status">
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
          </select></td>
      </tr>
      <tr>
        <td><?php echo $entry_sort_order; ?></td>
        <td><input type="text" name="sort_order" size="4"/><input type="hidden" name="link_id"/></td>
      </tr>
    </table>
</div>
<script type="text/javascript">
  function detail(link_id){
    if(link_id){
      $.get(
        'index.php?route=extension/link/getDetail&token=<?php echo $token?>',
        {link_id:link_id},
        function(json){
          var data = json.info;
          $('#detail-dialog input[name="name"]').val(data.name);
          $('#detail-dialog input[name="url"]').val(data.url);
          $('#detail-dialog input[name="sort_order"]').val(data.sort_order);
          $('#detail-dialog select[name="status"]').val(data.status);
          $('#detail-dialog input[name="link_id"]').val(data.link_id);
          $('#detail-dialog').dialog('open');
          $('#detail-dialog').dialog('option',{title:'编辑详情'});
        },'json');
    }else{
        $('#detail-dialog input[name="name"]').val('');
        $('#detail-dialog input[name="url"]').val('');
        $('#detail-dialog input[name="sort_order"]').val(1);
        $('#detail-dialog select[name="status"]').val(1);
        $('#detail-dialog input[name="link_id"]').val(0);
        $('#detail-dialog').dialog('open');
        $('#detail-dialog').dialog('option',{title:'添加链接'});
    }
    
  }

  $('#detail-dialog').dialog({
      width:600,
      autoOpen:false,
      modal:true,
      buttons:{
        '<?php echo $button_close ?>':function(){
          $(this).dialog('close');
        },
        '<?php echo $button_save ?>':function(){
          if($('#detail-dialog input[name="name"]').val()=='' ){
            alert('标题不得为空');
            $('#detail-dialog input[name="name"]').focus();
            return false;
          }
          if($('#detail-dialog input[name="url"]').val()=='' || !isURL($('#detail-dialog input[name="url"]').val())){
            alert('URL链接无效');
            $('#detail-dialog input[name="url"]').focus();
            return false;
          }
          $.ajax({
            url:'index.php?route=extension/link/save&token=<?php echo $token ?>',
            type:'post',
            data:$('#detail-dialog input,#detail-dialog select'),
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

  function isURL(str){
    var p = /^http[s]?:\/\/([\w-]+\.)+[\w-]+([\w-./?%&=]*)?$/i;
    return p.test(str);
  }
</script>
<?php echo $footer; ?>