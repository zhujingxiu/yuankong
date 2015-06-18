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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="yknavigation_module[0][layout_id]">
               <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_position; ?></td>
              <td><select name="yknavigation_module[0][position]">
                <?php foreach( $positions as $pos ) { ?>
                <?php if ($module['position'] == $pos) { ?>
                <option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
                <?php } else { ?>
                <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
                <?php } ?>
                <?php } ?> 
              </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="yknavigation_module[0][status]">
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
              <td><input type="text" name="yknavigation_module[0][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
        </table>
        <table id="module" class="list">
          <thead>
            <tr>            
              <td class="left"><?php echo $entry_title; ?></td>
              <td class="left"><?php echo $entry_route; ?></td>
              <td class="left"><?php echo $entry_param; ?></td>
              <td class="left"><?php echo $entry_additional_class; ?></td>
              <td class="left"><?php echo $entry_icon; ?></td>
              <td class="left"><?php echo $entry_status; ?></td>
              <td class="left"><?php echo $entry_selected; ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules[0]['navigator'] as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="left"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][title]" value="<?php echo $module['title']; ?>" /></td>
              <td class="left"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][route]" value="<?php echo $module['route']; ?>" /></td>
              <td class="left"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][param]" value="<?php echo $module['param']; ?>" /></td>
              <td class="left"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][additional_class]" value="<?php echo $module['additional_class']; ?>" /></td>
              <td class="left"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][icon]" value="<?php echo $module['icon']; ?>" /></td>
              <td class="left"><select name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][selected]">
                  <?php if ($module['selected']) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
              <td class="right"><input type="text" name="yknavigation_module[0][navigator][<?php echo $module_row; ?>][sort]" value="<?php echo $module['sort']; ?>" size="3" /></td>
              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="8"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {  
  html  = '<tbody id="module-row' + module_row + '">';
  html += '    <tr>';
  html += '    <td class="left"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][title]" value="" /></td>';
  html += '    <td class="left"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][route]" value="" /></td>';
  html += '    <td class="left"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][param]" value="" /></td>';
  html += '    <td class="left"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][additional_class]" value="" /></td>';
  html += '    <td class="left"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][icon]" value="" /></td>';
  html += '    <td class="left"><select name="yknavigation_module[0][navigator][' + module_row + '][status]">';
  html += '      <option value="1"><?php echo $text_enabled; ?></option>';
  html += '      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '    </select></td>';
  html += '    <td class="left"><select name="yknavigation_module[0][navigator][' + module_row + '][selected]">';
  html += '      <option value="1" selected="selected"><?php echo $text_yes; ?></option>';
  html += '      <option value="0"><?php echo $text_no; ?></option>';
  html += '    </select></td>';
  html += '    <td class="right"><input type="text" name="yknavigation_module[0][navigator][' + module_row + '][sort]" value="1" size="3" /></td>';
  html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#module tfoot').before(html);
  
  module_row++;
}
//--></script> 
<?php echo $footer; ?>