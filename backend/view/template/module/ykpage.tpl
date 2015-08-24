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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" id="form">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
            <?php echo $module['title'] ; ?>
            &nbsp;
            <img src="view/image/delete.png" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" />
          </a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" onclick="addModule();" /></span> </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <table class="form">
            <tr>
              <td><?php echo $entry_title; ?></td>
              <td><input name="ykpage[<?php echo $module_row; ?>][title]" value="<?php echo $module['title'] ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_route; ?></td>
              <td><input name="ykpage[<?php echo $module_row; ?>][route]" value="<?php echo $module['route'] ?>" /></td>
            </tr>            
            <tr>
              <td><?php echo $entry_text; ?></td>
              <td><textarea name="ykpage[<?php echo $module_row; ?>][text]" id="text-<?php echo $module_row; ?>" style="width:990px;height:330px;"><?php echo isset($module['text']) ? $module['text'] : ''; ?></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="ykpage[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="ykpage[<?php echo $module_row; ?>][sort]" value="<?php echo $module['sort']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<link type="text/css" href="<?php echo TPL_JS ?>umeditor/themes/default/css/umeditor.min.css" rel="stylesheet" />
<script type="text/javascript" src="<?php echo TPL_JS ?>umeditor/umeditor.config.js"></script> 
<script type="text/javascript" src="<?php echo TPL_JS ?>umeditor/umeditor.min.js"></script> 
<script type="text/javascript"><!--

<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
UM.getEditor('text-<?php echo $module_row; ?>');
<?php $module_row++; ?>
<?php } ?>

var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
  html += '  <table class="form">';
  html += '    <tr>';
  html += '      <td><?php echo $entry_title; ?></td>';
  html += '      <td><input name="ykpage[' + module_row + '][title]"></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_route; ?></td>';
  html += '      <td><input name="ykpage[' + module_row + '][route]"></td>';
  html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_text; ?></td>';
	html += '      <td><textarea name="ykpage[' + module_row + '][text]" id="text-' + module_row + '" style="width:990px;height:330px"></textarea></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="ykpage[' + module_row + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="ykpage[' + module_row + '][sort]" size="3" value="1"/></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);
	UM.getEditor('text-'+ module_row); 
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}

$('.vtabs a').tabs();
//--></script> 

<?php echo $footer; ?>