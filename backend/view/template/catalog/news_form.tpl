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
      <h1><img src="view/image/log.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      	<div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
        </div>
        <?php foreach ($languages as $language) { ?>
        <div id="language<?php echo $language['language_id']; ?>">
	        <table class="form">
	          <tr>
	            <td><span class="required">*</span> <?php echo $entry_title; ?></td>
	            <td><input type="text" name="title[<?php echo $language['language_id']; ?>]" value="<?php echo $title[$language['language_id']]; ?>" style="width:500px" />
	              <?php if ($error_title[$language['language_id']]) { ?>
	              <span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
	              <?php } ?></td>
	          </tr>
	          <tr>
	            <td><span class="required">*</span> <?php echo $entry_text; ?></td>
	            
	            <td><a onclick="return checkTextArea('editor_<?php echo $language['language_id']; ?>');" style="text-align:right;display:block;text-decoration:underline;font-weight:100;font-size: 12px">Can't Write? Please Click Here!</a> 
	            <textarea name="text[<?php echo $language['language_id']; ?>]" cols="60" rows="8" style="width:600px" id="news-text-<?php echo $language['language_id']?>"><?php echo $text[$language['language_id']]; ?></textarea>
	              <?php if ($error_text[$language['language_id']]) { ?>
	              <span class="error"><?php echo $error_text[$language['language_id']]; ?></span>
	              <?php } ?></td>
	          </tr>
	          <tr>
	            <td><?php echo $entry_status; ?></td>
	            <td><select name="status[<?php echo $language['language_id']; ?>]">
	                <option value="1" <?php echo $status[$language['language_id']] ? ' selected="selected"' : ''?> ><?php echo $text_enabled; ?></option>
	                <option value="0" <?php echo !$status[$language['language_id']] ? ' selected="selected"' : ''?>><?php echo $text_disabled; ?></option>
	              </select></td>
	          </tr>
	          <tr>
	            <td>Date Added</td>
	            <td><input name="date_added[<?php echo $language['language_id']; ?>]" class="datetime" value="<?php echo $date_added[$language['language_id']]?>"></td>
	          </tr>
	          <tr>
	            <td> Sort Order</td>
	            <td><input type="text" name="sort_order[<?php echo $language['language_id']; ?>]" value="<?php echo $sort_order[$language['language_id']]; ?>" size="10"/></td>
	          </tr>
	        </table>
        </div>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m:s',
	changeYear: true,
	changeMonth : true
}

);
<?php foreach ($languages as $language) { ?>
var editor_<?php echo $language['language_id']; ?> = CKEDITOR.replace('news-text-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php }?>

function checkTextArea(editor_id){
	window[editor_id].focus();
}
//--></script> 
<script type="text/javascript"><!--
$('#languages a').tabs();
//--></script> 
<?php echo $footer; ?>