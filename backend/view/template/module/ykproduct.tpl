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
        <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
            <?php echo $tab_module . ' ' . $module_row; ?>&nbsp;
            <img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" />
          </a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;
            <img src="view/image/add.png" alt="" onclick="addModule();" />
          </span> 
        </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="language-<?php echo $module_row; ?>" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
              <img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> 
              <?php echo $language['name']; ?>
            </a>
            <?php } ?>
          </div>
          <?php foreach ($languages as $language) { ?>
          <div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_title; ?></td>
                <td><input name="ykproduct_module[<?php echo $module_row; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['title'][$language['language_id']]) ? $module['title'][$language['language_id']] : ''; ?>" /></td>
              </tr>
            </table>
          </div>
          <?php } ?>
          <table class="form">
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="ykproduct_module[<?php echo $module_row; ?>][layout_id]">
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
              <td><select name="ykproduct_module[<?php echo $module_row; ?>][position]">
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
              <td><select name="ykproduct_module[<?php echo $module_row; ?>][status]">
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
              <td><?php echo $entry_title_class; ?></td>
              <td><input type="text" name="ykproduct_module[<?php echo $module_row; ?>][title_class]" value="<?php echo $module['title_class']; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_additional_class; ?></td>
              <td><input type="text" name="ykproduct_module[<?php echo $module_row; ?>][additional_class]" value="<?php echo $module['additional_class']; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="ykproduct_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
          <div class="category-tabs module-block">
             <?php if (isset($error_category_tabs[$module_row])) { ?>
            <span class="error"><?php echo $error_category_tabs[$module_row]; ?></span>
            <?php } ?>
            <table class="box-head">
              <tr>
                <td class="header-title"><h3><?php echo $text_add_category;?></h3></td>
                <td class="header-body">

                  <div class="selection-category">
                    <?php echo $entry_category ?> &nbsp; &nbsp; 
                    <select id="top-category-<?php echo $module_row ?>" for-category="second-category-<?php echo $module_row ?>">
                      <option value="0"><?php echo $text_none ?></option>
                      <?php foreach ($top_categories as $item): ?>
                      <option value="<?php echo $item['category_id'] ?>"><?php echo $item['name'] ?></option>
                      <?php endforeach ?>
                    </select>
                  </div>
                  <div class="selection-category" style="display:none">
                    <select id="second-category-<?php echo $module_row ?>" for-category="third-category-<?php echo $module_row ?>"></select>
                  </div>
                  <div class="selection-category" style="display:none">
                    <select id="third-category-<?php echo $module_row ?>" for-category="fourth-category-<?php echo $module_row ?>"></select>
                  </div>
                  <div class="selection-category" style="display:none">
                    <select id="fourth-category-<?php echo $module_row ?>"></select>
                  </div>
                </td>
                <td class="header-action">
                  <a class="btn" onclick="addCategoryTab('category-tabs<?php echo $module_row; ?>',<?php echo $module_row;?>)"><?php echo $button_add ?></a>
                </td>
              </tr>
            </table>
            <script type="text/javascript">
              $('#top-category-<?php echo $module_row;?>').trigger('change');
            </script>
            <div id='category-tabs<?php echo $module_row; ?>'>
              <?php if( isset($module['category_tabs']['data']) && $module['category_tabs']['data'] ) {  ?>

                <?php foreach( $module['category_tabs']['data'] as $idx => $category ) { ?>
                
                 <table class="form category-tab" id="category-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>">
                    <tr>
                      <td></td>
                      <td style="width:36%;">
                         <b><?php echo $category['name'] ?>[<?php echo $category['category_id'] ?>]</b>
                         <input type="hidden" name="ykproduct_module[<?php echo $module_row;?>][category_tabs][category][]" value="<?php echo $category['category_id'] ?>">
                      </td>
                      <td><?php echo $entry_limit;?></td>
                      <td>
                          <input type="text" name="ykproduct_module[<?php echo $module_row;?>][category_tabs][limit][]" value="<?php echo $category['limit']?>" size="3">
                      </td>
                      <td><?php echo $entry_sort_order;?></td>
                      <td>
                          <input type="text" name="ykproduct_module[<?php echo $module_row;?>][category_tabs][sort][]" value="<?php echo $category['sort'];?>" size="3">
                      </td>
                      <td size="4"><img src="view/image/delete.png" alt="" onclick="$('#category-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>').remove(); return false;" /></td>             
                    </tr>
                  </table>  
                  
                 <?php }  ?> 
               <?php } ?>   
             </div> 
          </div>
          <!--Product-->
          <div class="product-tabs module-block">
             <?php if (isset($error_product_tabs[$module_row])) { ?>
            <span class="error"><?php echo $error_product_tabs[$module_row]; ?></span>
            <?php } ?>
            <table class="box-head">
              <tr>
                <td class="header-title"><h3><?php echo $text_add_product;?></h3></td>
                <td class="header-body">
                  <div class="_clearfix" >
                    <div class="selection-product">
                      <?php echo $entry_category ?> &nbsp; &nbsp;
                      <select id="top-product-<?php echo $module_row ?>" for-category="second-product-<?php echo $module_row ?>" for-product="selection-product-<?php echo $module_row ?>">
                        <option value="0"><?php echo $text_none ?></option>
                        <?php foreach ($top_categories as $item): ?>
                        <option value="<?php echo $item['category_id'] ?>"><?php echo $item['name'] ?></option>
                        <?php endforeach ?>
                      </select>
                    </div>
                    <div class="selection-product" style="display:none">
                      <select id="second-product-<?php echo $module_row ?>" for-category="third-product-<?php echo $module_row ?>" for-product="selection-product-<?php echo $module_row ?>"></select>
                    </div>
                    <div class="selection-product" style="display:none">
                      <select id="third-product-<?php echo $module_row ?>" for-category="fourth-product-<?php echo $module_row ?>" for-product="selection-product-<?php echo $module_row ?>"></select>
                    </div>
                    <div class="selection-product" style="display:none">
                      <select id="fourth-product-<?php echo $module_row ?>" for-product="selection-product-<?php echo $module_row ?>"></select>
                    </div>
                  </div>
                  <br><br>
                  <div class="_clearfix">
                   &nbsp;<?php echo $entry_product ?> &nbsp; &nbsp;
                  <select id="selection-product-<?php echo $module_row ?>" ></select>
                  </div>
                </td>
                <td class="header-action"><a class="btn" onclick="addProductTab('product-tabs<?php echo $module_row; ?>',<?php echo $module_row;?>)"><?php echo $button_add ?></a></td>
              </tr>
            </table>
            <script type="text/javascript">
              $('#top-product-<?php echo $module_row;?>').trigger('change');
            </script>
            <div id='product-tabs<?php echo $module_row; ?>'>
              <?php if( isset($module['product_tabs']['data']) && $module['product_tabs']['data'] ) {  ?>

                <?php foreach( $module['product_tabs']['data'] as $idx => $product ) { ?>
                
                 <table class="form product-tab" id="product-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>">
                    <tr>
                      <td></td>
                      <td style="width:36%;">
                         <b><?php echo $product['name'] ?>[<?php echo $product['product_id'] ?>]</b>
                         <input type="hidden" name="ykproduct_module[<?php echo $module_row;?>][product_tabs][product][]" value="<?php echo $product['product_id'] ?>">
                      </td>
                      <td> 
                        <div class="image">
                           <?php 
                            $imgidx = "product-".$module_row."-".$idx;
                          $thumb = isset( $product['image']) ?  $this->model_tool_image->resize( $product['image'], 100, 100) :"";
                          $image = isset($product['image'])?$product['image']:"";  
                             
                           ?> 
                        <img src="<?php echo $thumb; ?>" alt="" id="thumb<?php echo $imgidx; ?>" />
                        <input type="hidden" name="ykproduct_module[<?php echo $module_row; ?>][product_tabs][image][]" value="<?php echo $image; ?>" id="image<?php echo $imgidx; ?>"  />
                        <br />

                        <a onclick="image_upload('image<?php echo $imgidx; ?>', 'thumb<?php echo $imgidx; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $imgidx; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $imgidx; ?>').attr('value', '');"><?php echo $text_clear; ?></a>
                      </div>
                      </td> 
                      <td><?php echo $entry_price;?> &nbsp; <span><?php echo $product['price']?></span>
                      </td>
                      <td><?php echo $entry_subtitle;?> &nbsp; <span><?php echo truncate_string($product['subtitle'],20)?></span>
                      </td>
                      <td><?php echo $entry_sort_order;?></td>
                      <td>
                          <input type="text" name="ykproduct_module[<?php echo $module_row;?>][product_tabs][sort][]" value="<?php echo $product['sort'];?>" size="3">
                      </td>
                      <td size="4"><img src="view/image/delete.png" alt="" onclick="$('#product-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>').remove(); return false;" /></td>             
                    </tr>
                  </table>  
                  
                 <?php }  ?> 
               <?php } ?>   
             </div> 
          </div>

          <!--Banner -->
            <div class="banner-tabs module-block">
             <?php if (isset($error_banner_tabs[$module_row])) { ?>
            <span class="error"><?php echo $error_banner_tabs[$module_row]; ?></span>
            <?php } ?>
            <table class="box-head">
              <tr>
                <td class="header-title"><h3><?php echo $text_add_banner;?></h3></td>
                <td class="header-body"></td>
                <td class="header-action"><a class="btn" onclick="addBannerTab('banner-tabs<?php echo $module_row;?>',<?php echo $module_row;?>)"><?php echo $button_add ?></a></td>
              </tr>
            </table>

            <div id='banner-tabs<?php echo $module_row; ?>'>
              <?php if( isset($module['banner_tabs']['data']) && $module['banner_tabs']['data'] ) {  ?>

                <?php foreach( $module['banner_tabs']['data'] as $idx => $banner ) { ?>
                
                 <table class="form banner-tab" id="banner-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>">
                    <tr>
                      <td><?php echo $entry_banner ?></td>
                      <td colspan="2"> 
                        <div class="image">
                           <?php 
                            $imgidx = "banner-".$module_row."-".$idx;
                          $thumb = isset( $banner['image']) ?  $this->model_tool_image->resize( $banner['image'], 100, 100) :"";
                          $image = isset($banner['image'])?$banner['image']:"";  
                             
                           ?> 
                        <img src="<?php echo $thumb; ?>" alt="" id="thumb<?php echo $imgidx; ?>" />
                        <input type="hidden" name="ykproduct_module[<?php echo $module_row; ?>][banner_tabs][image][]" value="<?php echo $image; ?>" id="image<?php echo $imgidx; ?>"  />
                        <br />

                        <a onclick="image_upload('image<?php echo $imgidx; ?>', 'thumb<?php echo $imgidx; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $imgidx; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $imgidx; ?>').attr('value', '');"><?php echo $text_clear; ?></a>
                      </div>
                      </td> 
                      <td colspan="2"><?php echo $entry_link;?> &nbsp; <input name="ykproduct_module[<?php echo $module_row;?>][banner_tabs][link][]" value="<?php echo $banner['link']?>" size="50">
                      </td>

                      <td><?php echo $entry_sort_order;?></td>
                      <td>
                          <input type="text" name="ykproduct_module[<?php echo $module_row;?>][banner_tabs][sort][]" value="<?php echo $banner['sort'];?>" size="3">
                      </td>
                      <td size="4"><img src="view/image/delete.png" alt="" onclick="$('#banner-tab<?php echo $module_row; ?>-wrapper<?php echo $idx+1;?>').remove(); return false;" /></td>             
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
  var TPL_IMG = '<?php echo TPL_IMG ?>';
  function addCategoryTab( wrapper,mid ){
    var index =  $("#"+wrapper+" table").length; 
    var _class= (index%2==0 ? "odd":"eve");
    
    var _category_id = 0,_name = [];
    $.each($('#tab-module-'+mid+' .selection-category select'),function(){
      if($.isNumeric($(this).val()) && $(this).val() > 0){
        _category_id = $(this).val();
        _name.push($(this).find("option:selected").text()); 
      }
    });
    if(_category_id > 0){

      var html  = '';
       html = '<table class="form category-tab '+_class+'" id="category-tab'+mid+'-wrapper'+index+'">';
       html +=     '<tr><td></td>';
       html +=       ' <td style="width:36%;">';
       html += '<b>' + _name.join(' &gt; ')+'['+ _category_id +']' + '</b><input type="hidden" name="ykproduct_module['+mid+'][category_tabs][category][]" value="' + _category_id + '" />';
       html += '</td>';
       html += '<td><?php echo $entry_limit;?></td>';
       html += '<td><input type="text" name="ykproduct_module['+mid+'][category_tabs][limit][]" size="3" value="5"></td>';
       html += '<td><?php echo $entry_sort_order;?></td>';
       html += '<td><input type="text" name="ykproduct_module['+mid+'][category_tabs][sort][]" size="3" value="0"></td>';
       html += '<td size="4"><img src="view/image/delete.png" alt="" onclick="$(\'#category-tab'+mid+'-wrapper'+index+'\').remove(); return false;" /></td>'; 
       html +=     '</tr>'
       html +=    '</table> ';
      $('#'+wrapper).append( html );
    }
  }

</script>

<script type="text/javascript">
  
  function addProductTab( wrapper,mid ){
    var index =  $("#"+wrapper+" table").length; 
    var _class= (index%2==0 ? "odd":"eve");
    var banner_row = 'product-'+mid+ '-'+index;
    var _category_id = 0,_catname = [];
    $.each($('#tab-module-'+mid+' .selection-product select'),function(){
      if($.isNumeric($(this).val()) && $(this).val() > 0){
        _category_id = $(this).val();
        _catname.push($(this).find("option:selected").text()); 
      }
    });
    var _product_id = $('#tab-module-'+mid+' #selection-product-'+mid).val(),
    _name = $('#tab-module-'+mid+' #selection-product-'+mid).find("option:selected").text(),
    _price = $('#tab-module-'+mid+' #selection-product-'+mid).find("option:selected").attr('data-price'),
    _image = $('#tab-module-'+mid+' #selection-product-'+mid).find("option:selected").attr('data-img'),
    _subtitle = $('#tab-module-'+mid+' #selection-product-'+mid).find("option:selected").attr('data-subtitle');
    
    if(_product_id > 0){
      var html  = '';
       html = '<table class="form product-tab '+_class+'" id="product-tab'+mid+'-wrapper'+index+'">';
       html +=     '<tr>';
       html +=      '<td></td>';
       html +=      '<td style="width:36%">';
       html += '<b>' + _catname.join(' &gt; ')+'<br>'+_name+'['+_product_id+']' + '</b><input type="hidden" name="ykproduct_module['+mid+'][product_tabs][product][]" value="' + _product_id + '" />';
       html += '</td>';       
       html += '<td> ';
       html += '<div class="image"><img src="'+TPL_IMG+_image+'" alt="" id="thumb' + banner_row + '" /><input type="hidden" name="ykproduct_module[' + mid + '][product_tabs][image][]" value="'+_image+'" id="image' + banner_row + '" /><br /><a onclick="image_upload(\'image' + banner_row + '\', \'thumb' + banner_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + banner_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + banner_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div>';
       html += ' </td>'; 
       html += '<td>  <?php echo $entry_price;?> <span>'+_price+'</span></td>';      
        html += '<td>  <?php echo $entry_subtitle;?> <span>'+_subtitle+'</span></td>';  
       html += '<td><?php echo $entry_sort_order;?></td>';
       html += '<td><input type="text" name="ykproduct_module['+mid+'][product_tabs][sort][]" size="3" value="0"></td>';
       html += '<td size="4"><img src="view/image/delete.png" alt="" onclick="$(\'#product-tab'+mid+'-wrapper'+index+'\').remove(); return false;" /></td>'; 
       html +=     '</tr>'
       html +=    '</table> ';
      $('#'+wrapper).append( html );
    }
  }

</script>
<script type="text/javascript">
  
  function addBannerTab( wrapper,mid ){
    var index =  $("#"+wrapper+" table").length; 
    var _class= (index%2==0 ? "odd":"eve");
    var banner_row = 'banner-'+ mid+ '-'+index;
    var html  = '';
     html = '<table class="form banner-tab '+_class+'" id="banner-tab'+mid+'-wrapper'+index+'">';
     html += '<tr>';
     html += '<td><?php echo $entry_banner;?> </td>';
     html += '<td colspan="3"> ';
     html += '<div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + banner_row + '" /><input type="hidden" name="ykproduct_module[' + mid + '][banner_tabs][image][]" value="" id="image' + banner_row + '" /><br /><a onclick="image_upload(\'image' + banner_row + '\', \'thumb' + banner_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + banner_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + banner_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div>';
    
     html += ' </td>'; 
     html += '<td><?php echo $entry_link;?></td>';
     html += '<td colspan="2"><input type="text" name="ykproduct_module['+mid+'][banner_tabs][link][]"></td>';
     html += '<td><?php echo $entry_sort_order;?></td>';
     html += '<td><input type="text" name="ykproduct_module['+mid+'][banner_tabs][sort][]" size="3"></td>';
     html += '<td size="4"><img src="view/image/delete.png" alt="" onclick="$(\'#product-tab'+mid+'-wrapper'+index+'\').remove(); return false;" /></td>'; 
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
  html += '          <td><input name="ykproduct_module[' + module_row + '][title][<?php echo $language['language_id']; ?>]" /></td>';
  html += '        </tr>';
  html += '      </table>';
  html += '    </div>';
  <?php } ?>

  html += '  <table class="form">';
  html += '    <tr>';
  html += '      <td><?php echo $entry_layout; ?></td>';
  html += '      <td><select name="ykproduct_module[' + module_row + '][layout_id]">';
  <?php foreach ($layouts as $layout) { ?>
  html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_position; ?></td>';
  html += '      <td><select name="ykproduct_module[' + module_row + '][position]">';
  <?php foreach( $positions as $pos ) { ?>
  html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
  <?php } ?>    
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_status; ?></td>';
  html += '      <td><select name="ykproduct_module[' + module_row + '][status]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_title_class; ?></td>';
  html += '      <td><input type="text" name="ykproduct_module[' + module_row + '][title_class]" value="" /></td>';
  html += '    </tr>';  
  html += '    <tr>';
  html += '      <td><?php echo $entry_additional_class; ?></td>';
  html += '      <td><input type="text" name="ykproduct_module[' + module_row + '][additional_class]" value="" /></td>';
  html += '    </tr>';    
  html += '    <tr>';
  html += '      <td><?php echo $entry_sort_order; ?></td>';
  html += '      <td><input type="text" name="ykproduct_module[' + module_row + '][sort_order]" value="0" size="3" /></td>';
  html += '    </tr>';
  html += '  </table>'; 
  html += '<div class="category-tabs module-block">';
  html += ' <table class="box-head"><tr>'
  html +='    <td class="header-title"><h3><?php echo $text_add_category;?></h3></td>';
  html += '   <td class="header-body">';
  html += '     <div class="selection-category"> <?php echo $entry_category ?> &nbsp; &nbsp; ';
  html += '       <select id="top-category-' + module_row + '" for-category="second-category-' + module_row + '">';
  html += '         <option><?php echo $text_none ?></option>';
  <?php foreach ($top_categories as $item) { ?>
  html += '         <option value="<?php echo $item['category_id'] ?>"> <?php echo $item['name'] ?></option>';
  <?php }?>
  html +='        </select>';
  html +='      </div>';
  html += '     <div class="selection-category"><select id="second-category-' + module_row + '" for-category="third-category-' + module_row + '"></select></div>';
  html += '     <div class="selection-category"><select id="third-category-' + module_row + '" for-category="fourth-category-' + module_row + '"></select></div>';
  html += '     <div class="selection-category"><select id="fourth-category-' + module_row + '"></select></div>';
  html +='    </td><td class="header-action">';
  html +='      <a class="btn" onclick="addCategoryTab(\'category-tabs'+module_row+'\','+module_row+')"><?php echo $button_add ?></a>';
  html += '   </td>';
  html += ' </tr></table>';
  html += ' <div id="category-tabs'+module_row+'"></div>'; 

  html += '</div>';

  html += '<div class="product-tabs module-block">';
  html += ' <table class="box-head"><tr>'
  html +='    <td class="header-title"><h3><?php echo $text_add_product;?></h3></td>';
  html += '   <td class="header-body">';
  html += '     <div class="_clearfix">';
  html += '     <div class="selection-product"><?php echo $entry_category ?> &nbsp; &nbsp;';
  html += '       <select id="top-product-' + module_row + '" for-category="second-product-' + module_row + '" for-product="selection-product-'+module_row+'">';
  html += '         <option><?php echo $text_none ?></option>';
  <?php foreach ($top_categories as $item) { ?>
  html += '         <option value="<?php echo $item['category_id'] ?>"> <?php echo $item['name'] ?></option>';
  <?php }?>
  html +='        </select>';
  html +='      </div>';
  html += '     <div class="selection-product"><select id="second-product-' + module_row + '" for-category="third-product-' + module_row + '" for-product="selection-product-'+module_row+'"></select></div>';
  html += '     <div class="selection-product"><select id="third-product-' + module_row + '" for-category="fourth-product-' + module_row + '" for-product="selection-product-'+module_row+'"></select></div>';
  html += '     <div class="selection-product"><select id="fourth-product-' + module_row + '" for-product="selection-product-'+module_row+'"></select></div></div>';
  html += '<div class="_clearfix">&nbsp;<?php echo $entry_product ?> &nbsp; &nbsp;';
  html += '   <select id="selection-product-'+module_row+'"></select></div>';
  html +='    </td><td class="header-action">';
  html +='      <a class="btn" onclick="addProductTab(\'product-tabs'+module_row+'\','+module_row+')"><?php echo $button_add ?></a>';
  html += '   </td>';
  html += ' </tr></table>';
  html += ' <div id="product-tabs'+module_row+'"></div>'; 

  html += '</div>';

  html += '<div class="banner-tabs module-block">';
  html += ' <table class="box-head"><tr>'
  html +='    <td class="header-title"><h3><?php echo $text_add_banner;?></h3></td>';
  html += '   <td class="header-body"></td>';
  html +='    <td class="header-action">';
  html +='      <a class="btn" onclick="addBannerTab(\'banner-tabs'+module_row+'\','+module_row+')"><?php echo $button_add ?></a>';
  html += '   </td>';
  html += ' </tr></table>';
  html += ' <div id="banner-tabs'+module_row+'"></div>'; 

  html += '</div>';

  html += '</div>';

  html += '</div>';
  
  $('#form').append(html);

  
  $('#language-' + module_row + ' a').tabs();
  
  $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();
  
  $('#module-' + module_row).trigger('click');


  $('#top-category-'+ module_row).trigger('change');
  $('#top-product-'+ module_row).trigger('change');
  
  module_row++;
}

  $(document).delegate('.selection-category select','change',function(){

    var $cid = $(this).val(), $obj = $('.selection-category #'+$(this).attr('for-category'));

    $(this).parent().nextAll('.selection-category').hide().children('select').empty();

    if($cid > 0 ){

      $.get('index.php?route=catalog/category/selection_category&token=<?php echo $token ?>&cid='+$cid ,{},function(json){

        if(json.status==1){
          $obj.append($("<option value='*'><?php echo $text_none ?></option>"));

          for(var i in json.data){
            $obj.append($("<option value='" + json.data[i].category_id + "'>" + json.data[i].name + "</option>"));
          }

          $obj.parent().show();

        }
      },'json');

    }
  });
  $(document).delegate('.selection-product select','change',function(){
    var $cid = $(this).val(), $obj_category = $('.selection-product #'+$(this).attr('for-category')),$obj_product =  $('#'+$(this).attr('for-product'));

    $(this).parent().nextAll('.selection-product').hide().children('select').empty();

    if($cid > 0 ){

      $.get('index.php?route=module/ykproduct/selections&token=<?php echo $token ?>&cid='+$cid ,{},function(json){
        $obj_product.empty();
        if(json.status==1){
          
          if(json.category.length>0){
            $obj_category.append($("<option value='*'><?php echo $text_none ?></option>"));

            for(var i in json.category){
              $obj_category.append($("<option value='" + json.category[i].category_id + "'>" + json.category[i].name + "</option>"));
            }

            $obj_category.parent().show();
          }

          if(json.product.length>0){
            $obj_product.append($("<option value='*'><?php echo $text_none ?></option>"));

            for(var i in json.product){
              $obj_product.append($("<option value='" + json.product[i].product_id + "' data-name='" + json.product[i].name +"' data-subtitle='" + (json.product[i].subtitle ? json.product[i].subtitle : '' )+"' data-img='" + json.product[i].image +"' data-price='" + json.product[i].price +"'>" + json.product[i].name + "</option>"));
            }
          }
        }
      },'json');

    }

  })


$('.vtabs a').tabs();

<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};
//--></script> 
<style type="text/css">
  .form.category-tab td,.form.product-tab td,.form.banner-tab td{padding: 1px;}
  .category-tab > tbody > tr > td:first-child ,.product-tab > tbody > tr > td:first-child,
  .banner-tab > tbody > tr > td:first-child {width:auto !important;}
  .box-head{clear: both;width: 100%;background: #eeeeee;}
  .box-head .header-title{width: 32%}
  .box-head .header-body {width: 62%;}
  .box-head .header-action {width: 5%;}
  .module-block{border-bottom: 1px solid #999;}
  .product-tabs .image img{width: 100px;height: 100px;}
  .selection-category,.selection-product{float: left;margin: 0 5px;}
</style>
<?php echo $footer; ?>