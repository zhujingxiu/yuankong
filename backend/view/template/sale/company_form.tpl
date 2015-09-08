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
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="$('#form').submit();" class="button" style="display: block; position: fixed; bottom: 150px; right:40px; z-index: 99999;"><?php echo '保存后返回'; ?></a>
        <a onclick="$('#form').append('<input name=keep value=1 type=hidden >');$('#form').submit();" class="button" style="display: block; position: fixed; bottom: 200px; right:40px; z-index: 99999;"><?php echo '保存后继续'; ?></a>
        <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a> 
        <?php if ($company_id) { ?>
        <a href="#tab-file"><?php echo $tab_file; ?></a>
        <a href="#tab-certificate"><?php echo $tab_certificate; ?></a>
        <a href="#tab-module"><?php echo $tab_module; ?></a>
        <a href="#tab-member"><?php echo $tab_member; ?></a>
        <a href="#tab-case"><?php echo $tab_case; ?></a>
        <?php } ?>
      </div>
      
        <div id="tab-general">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_title; ?></td>
              <td><input type="text" name="title" value="<?php echo $title; ?>" size="50"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_logo; ?></td>
              <td>
                <div class="image">
                  <img src="<?php echo $thumb_logo; ?>"id="thumb-logo" width="150"/>
                  <input type="hidden" name="logo" value="<?php echo $logo; ?>" />
                  <br />
                  <a onclick="image_upload('logo', 'thumb-logo');" id="logo">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-logo').attr('src', '<?php echo $no_image; ?>'); $(input[name=\'logo\']).attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
            </tr>
            <tr>
              <td><?php echo $entry_cover; ?></td>
              <td>
                <div class="image">
                  <img src="<?php echo $thumb_cover; ?>"id="thumb-cover" width="205"/>
                  <input type="hidden" name="cover" value="<?php echo $cover; ?>"  />
                  <br />
                  <a id="cover" onclick="image_upload('cover', 'thumb-cover');">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-cover').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'cover\']').attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
            </tr>
            <tr>
                <td class="left"><?php echo $entry_group; ?></td>
                <td>
                    <?php foreach ($groups as $item): ?>
                    <input type="checkbox" name="group_id[]" value="<?php echo $item['group_id'] ?>" <?php echo in_array($item['group_id'], $group_id) ? 'checked' : '' ?> ><?php echo $item['name'] ?><br>
                    <?php endforeach ?>
                    <?php if ($error_group) { ?>
                    <span class="error"><?php echo $error_group; ?></span>
                    <?php } ?>
                </td>
            </tr>  
            <tr>
              <td><?php echo $entry_description; ?></td>
              <td><textarea cols="100" rows="6" name="description"><?php echo $description; ?></textarea></td>
            </tr>      
            <tr>
              <td><?php echo $entry_code; ?></td>
              <td><input type="code" name="code" value="<?php echo $code; ?>"  /></td>
            </tr>    
            <tr>
              <td><span class="required">*</span> <?php echo $entry_corporation; ?></td>
              <td><input type="text" name="corporation" value="<?php echo $corporation; ?>" />
                <?php if ($error_corporation) { ?>
                <span class="error"><?php echo $error_corporation; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_mobile_phone; ?></td>
              <td><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" />
                <?php if ($error_mobile_phone) { ?>
                <span class="error"><?php echo $error_mobile_phone; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_identity_number; ?></td>
              <td><input type="text" name="identity_number" value="<?php echo $identity_number; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_email; ?></td>
              <td><input type="text" name="email" value="<?php echo $email; ?>" /></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
              <td><select name="zone_id">
                  <?php foreach ($zones as $item): ?>
                    <option value="<?php echo $item['zone_id'] ?>" <?php echo $item['zone_id'] == $zone_id ? 'selected' : '' ?> ><?php echo $item['name'] ?></option>
                  <?php endforeach ?>
                </select>
              </td>
            </tr>

            <tr>
              <td><span class="required">*</span> <?php echo $entry_address; ?></td>
              <td><div class="item-adress" id="area"></div>
                <br>
                <?php echo $area_zone ?>
                <input type="text" name="address" value="<?php echo $address; ?>" size="33"/>
                <?php if ($error_address) { ?>
                <span class="error"><?php echo $error_address; ?></span>
                <?php  } ?></td>
            </tr>

            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="status">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
                    
            <tr>
              <td><?php echo $entry_password; ?></td>
              <td><input type="password" name="password" value="<?php echo $password; ?>"  />
                <?php if ($error_password) { ?>
                <span class="error"><?php echo $error_password; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_confirm; ?></td>
              <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                <?php if ($error_confirm) { ?>
                <span class="error"><?php echo $error_confirm; ?></span>
                <?php  } ?></td>
            </tr>
          </table>
          <?php if($company_id){?>
          <h4><a onclick="$('#company-more').toggle();">显示/隐藏更多数据</a></h4>
          <table class="form" id="company-more" style="display: none;">
            <tr>
              <td><?php echo $entry_recommend; ?></td>
              <td><select name="recommend">
                  <?php if ($recommend) { ?>
                  <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="0"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_yes; ?></option>
                  <option value="0" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_deposit; ?></td>
              <td><input type="text" name="deposit" value="<?php echo $deposit; ?>"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_viewed; ?></td>
              <td><input type="text" name="viewed" value="<?php echo $viewed; ?>"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_credit; ?></td>
              <td><input type="text" name="credit" value="<?php echo $credit; ?>"/></td>
            </tr>            
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="3" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_postcode; ?></td>
              <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
            </tr>   
            <tr>
              <td><?php echo $entry_email; ?></td>
              <td><input type="text" name="email" value="<?php echo $email; ?>" size="33"/></td>
            </tr> 
            <tr>
              <td><?php echo $entry_telephone; ?></td>
              <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_fax; ?></td>
              <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
            </tr> 
            
          </table>
          <?php }?>
          </form>
        </div>
        <?php if ($company_id) { ?>
        <div id="tab-file">
          <div id="files"></div>
          <table class="form">
            <tr>
              <td><?php echo $entry_mode; ?></td>
              <td>
                <input type="radio" name="mode" value="identity" checked/><?php echo $entry_identity ?>
                <input type="radio" name="mode" value="permit" /><?php echo $entry_permit ?>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_file; ?></td>
              <td>
                <div class="image">
                  <img src="<?php echo $no_image; ?>"id="thumb-path" width="205"/>
                  <input type="hidden" name="path" value=""  />
                  <br />
                  <a onclick="image_upload('path', 'thumb-path');" id="path">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-path').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'path\']').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_note; ?></td>
              <td><textarea cols="80" name="note"></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort; ?></td>
              <td><input type="text" name="sort" value="" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-files" class="button" ><span><?php echo $button_add_file; ?></span></a></td>
            </tr>
          </table>
          
        </div>
        <div id="tab-certificate">
          <div id="certificates"></div>
          <table class="form">
            <tr>
              <td><?php echo $entry_certificate_title; ?></td>
              <td><input type="text" name="title" value="" /></td>
            </tr>

            <tr>
              <td><?php echo $entry_image; ?></td>
              <td><div class="image">
                  <img src="<?php echo $no_image; ?>"id="thumb-picture" width="210"/>
                  <input type="hidden" name="picture" value=""  />
                  <br />
                  <a onclick="image_upload('picture', 'thumb-picture');" id="picture">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-picture').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'picture\']').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_sort; ?></td>
              <td><input type="text" name="sort" value="" size="3" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-certificate" class="button"><span><?php echo $button_add_certificate; ?></span></a></td>
            </tr>
          </table>
        </div>
        <div id="tab-module">
          <fieldset>
            <legend><?php echo $text_custom_1 ?></legend>
            <table class="form">
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td>
                    <?php if ($status_1) { ?>
                    <input type="radio" name="status_1" value="1" checked="checked"/><?php echo $text_enabled; ?>
                    <input type="radio" name="status_1" value="0"/><?php echo $text_disabled; ?>
                    <?php } else { ?>
                    <input type="radio" name="status_1" value="1"/><?php echo $text_enabled; ?>
                    <input type="radio" name="status_1" value="0" checked="checked"/><?php echo $text_disabled; ?>
                    <?php } ?>
                </td>
              </tr>
              <tr>
                <td><?php echo $entry_module_title; ?></td>
                <td><input type="text" name="title_1" value="<?php echo $title_1 ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_image; ?></td>
                <td>
                  <div class="image">
                    <img src="<?php echo $thumb_image_1; ?>"id="thumb-image-1" width="480"/>
                    <input type="hidden" name="image_1" value="<?php echo $image_1 ?>"  />
                    <input type="hidden" name="sort_1" value="1"  />
                    <br />
                    <a onclick="image_upload('image-1', 'thumb-image-1');" id="image_1">
                      <?php echo $text_browse; ?>
                    </a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb-image-1').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'image_1\']').attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
              </tr>
            </table>
          </fieldset>
          <fieldset>
            <legend><?php echo $text_custom_2 ?></legend>
            <table class="form">
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td>
                    <?php if ($status_2) { ?>
                    <input type="radio" name="status_2" value="1" checked="checked"/><?php echo $text_enabled; ?>
                    <input type="radio" name="status_2" value="0"/><?php echo $text_disabled; ?>
                    <?php } else { ?>
                    <input type="radio" name="status_2" value="1"/><?php echo $text_enabled; ?>
                    <input type="radio" name="status_2" value="0" checked="checked"/><?php echo $text_disabled; ?>
                    <?php } ?>
                </td>
              </tr>
              <tr>
                <td><?php echo $entry_module_title; ?></td>
                <td><input type="text" name="title_2" value="<?php echo $title_2 ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_image; ?></td>
                <td>
                  <div class="image">
                    <img src="<?php echo $thumb_image_2; ?>"id="thumb-image-2" width="480"/>
                    <input type="hidden" name="image_2" value="<?php echo $image_2 ?>" />
                    <input type="hidden" name="sort_2" value="2" />
                    <br />
                    <a onclick="image_upload('image_2', 'thumb-image-2');" id="image_2">
                      <?php echo $text_browse; ?>
                    </a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb-image-2').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'image_2\']').attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
              </tr>
            </table>
          </fieldset>
        </div>
        <div id="tab-member">
          <div id="members"></div>
          <table class="form">
            <tr>
              <td><?php echo $entry_member; ?></td>
              <td><input type="text" name="name" value="" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_position; ?></td>
              <td><input type="text" name="position" value="" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_avatar; ?></td>
              <td><div class="image">
                  <img src="<?php echo $no_image; ?>"id="thumb-avatar" width="150"/>
                  <input type="hidden" name="avatar" value=""  />
                  <br />
                  <a onclick="image_upload('avatar', 'thumb-avatar');" id="avatar">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-avatar').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'avatar\']').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_note; ?></td>
              <td><textarea cols="80"  name="note"></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort; ?></td>
              <td><input type="text" name="sort" value="" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-members" class="button"><span><?php echo $button_add_member; ?></span></a></td>
            </tr>
          </table>          
        </div>
        <div id="tab-case">
          <div id="cases"></div>
          <table class="form">
            <tr>
              <td><?php echo $entry_case_title; ?></td>
              <td><input type="text" name="case_title" value="" /></td>
            </tr>

            <tr>
              <td><?php echo $entry_image; ?></td>
              <td><div class="image">
                  <img src="<?php echo $no_image; ?>"id="thumb-photo" width="205"/>
                  <input type="hidden" name="photo" value=""  />
                  <br />
                  <a onclick="image_upload('photo', 'thumb-photo');" id="photo">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-photo').attr('src', '<?php echo $no_image; ?>'); $('input[name=\'photo\']').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_sort; ?></td>
              <td><input type="text" name="sort" value="" size="3" /></td>
            </tr>
            <tr>
              <td colspan="2" style="text-align: right;"><a id="button-case" class="button"><span><?php echo $button_add_case; ?></span></a></td>
            </tr>
          </table>
        </div>

        <?php } ?>
      
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#files').load('index.php?route=sale/company/file&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>');

$('#button-files').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/company/file&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>',
    type: 'post',
    dataType: 'html',
    data: 'path=' + encodeURIComponent($('#tab-file input[name=\'path\']').val()) + '&mode=' + encodeURIComponent($('#tab-file input[name=\'mode\']:checked').val())+ '&note=' + encodeURIComponent($('#tab-file textarea[name=\'note\']').val())+ '&sort=' + encodeURIComponent($('#tab-file input[name=\'sort\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-files').attr('disabled', true);
      $('#files').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-files').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(html) {
      $('#files').html(html);     
      $('#tab-files input').val('');
      $('#tab-files textarea').html('');
      $('#tab-files #thumb-path').attr('src','<?php echo $no_image ?>');
    }
  });
});
$('#members').load('index.php?route=sale/company/member&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>');

$('#button-members').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/company/member&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>',
    type: 'post',
    dataType: 'html',
    data: 'name=' + encodeURIComponent($('#tab-member input[name=\'name\']').val()) + '&position=' + encodeURIComponent($('#tab-member input[name=\'position\']').val())+ '&sort=' + encodeURIComponent($('#tab-member input[name=\'sort\']').val())+ '&avatar=' + encodeURIComponent($('#tab-member input[name=\'avatar\']').val())+ '&note=' + encodeURIComponent($('#tab-member textarea[name=\'note\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-members').attr('disabled', true);
      $('#members').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-members').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(html) {
      $('#members').html(html);     
      $('#tab-member input').val('');
      $('#tab-member textarea').html('');
      $('#tab-files #thumb-avatar').attr('src','<?php echo $no_image ?>');
    }
  });
});
$('#cases').load('index.php?route=sale/company/cases&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>');

$('#button-case').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/company/cases&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>',
    type: 'post',
    dataType: 'html',
    data: 'title=' + encodeURIComponent($('#tab-case input[name=\'case_title\']').val()) + '&photo=' + encodeURIComponent($('#tab-case input[name=\'photo\']').val())+ '&sort=' + encodeURIComponent($('#tab-case input[name=\'sort\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-case').attr('disabled', true);
      $('#cases').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-case').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(html) {
      $('#cases').html(html);     
      $('#tab-case input').val('');    
      $('#tab-case #thumb-photo').attr('src','<?php echo $no_image ?>');
    }
  });
});

$('#certificates').load('index.php?route=sale/company/certificate&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>');

$('#button-certificate').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/company/certificate&token=<?php echo $token; ?>&company_id=<?php echo $company_id; ?>',
    type: 'post',
    dataType: 'html',
    data: 'title=' + encodeURIComponent($('#tab-certificate input[name=\'title\']').val()) + '&image=' + encodeURIComponent($('#tab-certificate input[name=\'picture\']').val())+ '&sort=' + encodeURIComponent($('#tab-certificate input[name=\'sort\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-certificate').attr('disabled', true);
      $('#certificates').before('<div class="attention"><img src="view/image/loading.gif" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-certificate').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(html) {
      $('#certificates').html(html);     
      $('#tab-certificate input').val('');    
      $('#tab-certificate #thumb-picture').attr('src','<?php echo $no_image ?>');
    }
  });
});
//--></script> 
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  new AjaxUpload('#'+field, {
    action: 'index.php?route=common/filemanager/upload_custom&token=<?php echo $token;?>',
    name: 'file',
    autoSubmit: true,
    responseType: 'json',
    onSubmit: function(file, extension) {
        $('#'+field).after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    },
    onComplete: function(file, json) {
                    
        if (json['status']==1) {
            $('input[name="'+field+'"]').val(json['path']);
            $('#'+thumb).attr('src',json['file'])
        }else{
            alert(json['msg']);
            return false;
        }            
        
        $('.loading').remove(); 
    }
  });

};

$(function(){
  image_upload('logo','thumb-logo');
  image_upload('cover','thumb-cover');
  <?php if ($company_id) { ?>
  image_upload('path','thumb-path');
  image_upload('image_1','thumb-image-1');
  image_upload('image_2','thumb-image-2');
  image_upload('picture','thumb-picture');
  image_upload('photo','thumb-photo');
  image_upload('avatar','thumb-avatar');
  <?php }?>
})
//--></script> 
<script type="text/javascript"><!--
    $(function(){
        add_select(0);
        $('body').on('change', '#area select', function() {
            var $me = $(this);
            var $next = $me.next();

            if ($me.val() == $next.data('pid')) {
                return;
            }
            $me.nextAll().remove();
            add_select($me.val());
        });

        function add_select(pid) {
            var area_names = area['name'+pid];
            if (!area_names) {
                return false;
            }
            var area_codes = area['code'+pid];
            var $select = $('<select >');
            $select.attr('name', 'area[]');
            $select.attr('class', 'adress-sec');
            $select.data('pid', pid);
            if (area_codes[0] != -1) {
                area_names.unshift('请选择');
                area_codes.unshift(0);
            }
            for (var idx in area_codes) {
                var $option = $('<option>');
                $option.attr('value', area_codes[idx]);
                $option.text(area_names[idx]);
                $select.append($option);
            }
            $('#area').append($select);
        };
    });

$('.htabs a').tabs();
//--></script> 
<style type="text/css">
  fieldset{margin:5px;padding: 5px; }
</style>

<?php echo $footer; ?>