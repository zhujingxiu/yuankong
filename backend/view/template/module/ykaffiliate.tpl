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
    
      <div class="buttons">

      <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>

      <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>

        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="language-<?php echo $module_row; ?>" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_title; ?></td>
                <td><input name="ykaffiliate_module[<?php echo $module_row; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['title'][$language['language_id']]) ? $module['title'][$language['language_id']] : ''; ?>" /></td>
              </tr>
            </table>
          </div>
          <?php } ?>

      <div>
        <?php if (isset($error_dimension[$module_row])) { ?>
           <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
         <?php } ?>
      </div>
    <table class="form">

      <tr>
        <td><?php echo $entry_layout; ?></td>
        <td><select name="ykaffiliate_module[<?php echo $module_row; ?>][layout_id]">
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
        <td><select name="ykaffiliate_module[<?php echo $module_row; ?>][position]">
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
        <td><select name="ykaffiliate_module[<?php echo $module_row; ?>][status]">
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
        <td><?php echo $entry_lateast_limit; ?></td>
        <td><input type="text" name="ykaffiliate_module[<?php echo $module_row; ?>][lateast]" value="<?php echo $module['lateast']; ?>" size="3" /></td>
      </tr>
      <tr>
        <td><?php echo $entry_sort_order; ?></td>
        <td><input type="text" name="ykaffiliate_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
      </tr>
    </table>


    <div class="category-tabs">
       <?php if (isset($error_category_tabs[$module_row])) { ?>
      <span class="error"><?php echo $error_category_tabs[$module_row]; ?></span>
      <?php } ?>

      <div class="box-head">
        <a class="button" id="add-cattab" onclick="addCategoryTab('category-tabs<?php echo $module_row; ?>',<?php echo $module_row;?>)"><?php echo $this->language->get('text_add_category');?></a>
      </div>
      <div id='category-tabs<?php echo $module_row; ?>'>
        <?php if( isset($module['category_tabs']) && $module['category_tabs'] ) {  ?>

          <?php foreach( $module['category_tabs'] as $idx => $category ) { ?>
           <table class="form category-tab" id="category-tab-wrapper<?php echo $idx+1;?>">
              <tr>
                <td><?php echo $this->language->get('entry_category');?></td>
                <td colspan="2">

                  <select name="ykaffiliate_module[<?php echo $module_row;?>][category_tabs][]">
                   <?php foreach( $affiliate_groups as $item){ ?>
                   <option <?php if( $module['category_tabs'][$idx] == $item['group_id'] ) {?>selected="selected"<?php } ?> value="<?php echo $item['group_id'];?>"><?php echo addslashes($item['name']);?> [ID:<?php echo $item['group_id'];?>]</option>
                   <?php } ?>
                   </select>
                </td>
                <td><?php echo $this->language->get('entry_limit');?></td>
                <td>
                    <input type="text" name="ykaffiliate_module[<?php echo $module_row;?>][limit][]" value="<?php echo $module['limit'][$idx];?>" size="3">
                </td>
                <td><?php echo $this->language->get( 'entry_icon_class' );?></td>
                <td> 
                  <input type="text" name="ykaffiliate_module[<?php echo $module_row;?>][icon_class][]" value="<?php echo $module['icon_class'][$idx];?>">
                </td>   
                <td><?php echo $this->language->get('entry_sort_order');?></td>
                <td>
                    <input type="text" name="ykaffiliate_module[<?php echo $module_row;?>][sort][]" value="<?php echo $module['sort'][$idx];?>" size="3">
                </td>
                <td size="4"><img src="view/image/delete.png" alt="" onclick="$('#category-tab-wrapper<?php echo $idx+1;?>').remove(); return false;" /></td>             
              </tr>
            </table>  
           <?php }  ?> 
         <?php } ?>   
       </div> 
    </div>
  </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript">
  
  function addCategoryTab( wrapper,mid ){
    var index =  $("#"+wrapper+" table").length; 
    var _class= (index%2==0 ? "odd":"eve");
    var banner_row = mid+ '-'+index;
    var html  = '';
     html = '<table class="form category-tab '+_class+'" id="category-tab-wrapper'+index+'">';
     html +=     '<tr>';
     html +=      '<td><?php echo $this->language->get("entry_category");?></td>';
     html +=       ' <td colspan="2">';
     html += '<select name="ykaffiliate_module['+mid+'][category_tabs][]">';
     <?php foreach( $affiliate_groups as $item){ ?>
      html +='<option value="<?php echo $item['group_id'];?>"><?php echo addslashes($item['name']);?> [ID:<?php echo $item['group_id'];?>]</option>';
     <?php } ?>
     html += '</select>';
     html += '</td>';
     html += '<td><?php echo $this->language->get("entry_limit");?></td>';
     html += '<td><input type="text" name="ykaffiliate_module['+mid+'][limit][]" value="5" size="3"></td>';
     html += '<td><?php echo $this->language->get( 'entry_icon_class' );?> </td>';
     html += '<td><input type="text" name="ykaffiliate_module['+mid+'][icon_class][]"></td>'; 

     html += '<td><?php echo $this->language->get("entry_sort_order");?></td>';
     html += '<td><input type="text" name="ykaffiliate_module['+mid+'][sort][]" size="3"></td>';
     html += '<td size="4"><img src="view/image/delete.png" alt="" onclick="$(\'#category-tab-wrapper'+index+'\').remove(); return false;" /></td>'; 
     html +=     '</tr>'
     html +=    '</table> ';
    $('#'+wrapper).append( html );
  }

</script>

<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {  
  html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
  html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
    html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
  html += '  </div>';

  <?php foreach ($languages as $language) { ?>
  html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
  html += '      <table class="form">';
    html += '        <tr>';
  html += '          <td><?php echo $entry_title; ?></td>';
  html += '          <td><input name="ykaffiliate_module[' + module_row + '][title][<?php echo $language['language_id']; ?>]" /></td>';
  html += '        </tr>';
  html += '      </table>';
  html += '    </div>';
  <?php } ?>

  html += '  <table class="form">';
  html += '    <tr>';
  html += '      <td><?php echo $entry_layout; ?></td>';
  html += '      <td><select name="ykaffiliate_module[' + module_row + '][layout_id]">';
  <?php foreach ($layouts as $layout) { ?>
  html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_position; ?></td>';
  html += '      <td><select name="ykaffiliate_module[' + module_row + '][position]">';
  <?php foreach( $positions as $pos ) { ?>
  html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
  <?php } ?>    html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_status; ?></td>';
  html += '      <td><select name="ykaffiliate_module[' + module_row + '][status]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_lateast_limit; ?></td>';
  html += '      <td><input type="text" name="ykaffiliate_module[' + module_row + '][lateast]" value="" size="3" /></td>';
  html += '    </tr>';  
  html += '    <tr>';
  html += '      <td><?php echo $entry_sort_order; ?></td>';
  html += '      <td><input type="text" name="ykaffiliate_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
  html += '    </tr>';
  html += '  </table>'; 

  html += '<div class="category-tabs">';
  html +=   '<div class="box-head">';
  html +=       '<a class="button" id="add-cattab" onclick="addCategoryTab(\'category-tabs'+module_row+'\','+module_row+')"><?php echo $this->language->get('text_add_category');?></a>';
  html += '   </div>';
  html += ' <div id="category-tabs'+module_row+'"></div>'; 

  html += '</div>';

  html += '</div>';

  html += '</div>';
  
  $('#form').append(html);
  

  $('#language-' + module_row + ' a').tabs();
  $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();
  
  $('#module-' + module_row).trigger('click');
  
  module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 

<style type="text/css">
  .category-tab > tbody > tr > td:first-child {width:auto !important;}
</style>
<?php echo $footer; ?>