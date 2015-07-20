<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/feed.png" alt="" /> <?php echo $heading_title; ?></h1>
	  <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_submit; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
	 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
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
				<td class="left"><?php echo $text_title; ?></td>
				<td><input type="text" name="title" value="<?php echo $title; ?>" style="width:380px;"/></td>
			</tr>
			<tr>
				<td class="left"><?php echo $text_subtitle; ?></td>
				<td><input type="text" name="subtitle" value="<?php echo $subtitle ?>" style="width:380px;"/></td>
			</tr>
            <tr>
                <td class="left"><?php echo $text_from; ?></td>
                <td><input type="text" name="from" value="<?php echo $from ?>" style="width:380px;"/></td>
            </tr>
			<tr>
				<td><?php echo $text_text; ?></td>
				<td><textarea name="text" id="news-text"><?php echo $text; ?></textarea></td>
			</tr>

			<tr>
				<td><?php echo $text_sort_order; ?></td>
				<td><input type="text" value="<?php echo $sort_order; ?>" name="sort_order" /></td>
			</tr>
            <tr>
                <td><?php echo $text_top; ?></td>
                <td>
                    <select name="is_top">
                    <?php if($is_top){ ?>
                    <option value="1" selected><?php echo $text_yes ?></option>
                    <option value="0"><?php echo $text_no ?></option>
                    <?php }else{ ?>
                    <option value="0" selected><?php echo $text_no ?></option>
                    <option value="1"><?php echo $text_yes ?></option>
                    <?php }?>
                    <option>
                  </select> 
                </td>
            </tr>
			<tr>
				<td><?php echo $text_status; ?></td>
				<td>
                    <select name="status">
                    <?php if($status){ ?>
                    <option value="1" selected><?php echo $text_enabled ?></option>
                    <option value="0"><?php echo $text_disabled ?></option>
                    <?php }else{ ?>
                    <option value="0" selected><?php echo $text_disabled ?></option>
                    <option value="1"><?php echo $text_enabled ?></option>
                    <?php }?>
                    <option>
                  </select>            
                </td>
			</tr>
		</table>
	 </form>
    </div>
  </div>
</div>

<link type="text/css" href="<?php echo TPL_JS ?>umeditor/themes/default/css/umeditor.min.css" rel="stylesheet" />
<script type="text/javascript" src="<?php echo TPL_JS ?>umeditor/umeditor.config.js"></script> 
<script type="text/javascript" src="<?php echo TPL_JS ?>umeditor/umeditor.min.js"></script> 
<?php if(false){ ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<?php } ?>
<script type="text/javascript"><!--

  UM.getEditor('news-text');

<?php if(false){ ?>
CKEDITOR.replace('news-text', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});


$('#language a').tabs();
<?php } ?>
//--></script> 
<?php echo $footer; ?>