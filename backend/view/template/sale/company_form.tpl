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
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="htabs" class="htabs"><a href="#tab-general"><?php echo $tab_general; ?></a> 
        <?php if ($company_id) { ?>
        <a href="#tab-file"><?php echo $tab_file; ?></a>
        <a href="#tab-description"><?php echo $tab_description; ?></a>
        <a href="#tab-member"><?php echo $tab_member; ?></a>
        <a href="#tab-case"><?php echo $tab_case; ?></a>
        <?php } ?>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_title; ?></td>
              <td><input type="text" name="title" value="<?php echo $title; ?>" size="50"/></td>
            </tr>
            <tr>
              <td><?php echo $entry_logo; ?></td>
              <td>
                <div class="image">
                  <img src="<?php echo $logo; ?>"id="thumb-logo" />
                  <input type="hidden" name="logo" value="<?php echo $logo; ?>" id="logo" />
                  <br />
                  <a onclick="image_upload('logo', 'thumb-logo');">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-logo').attr('src', '<?php echo $no_image; ?>'); $('#logo').attr('value', '');"><?php echo $text_clear; ?></a>
                  </div>
                </td>
            </tr>
            <tr>
                <td class="left"><?php echo $text_group; ?></td>
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
                <input type="text" name="address" value="<?php echo $address; ?>" />
                <?php if ($error_address) { ?>
                <span class="error"><?php echo $error_address; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_postcode; ?></td>
              <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
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
              <td><?php echo $entry_email; ?></td>
              <td><input type="text" name="email" value="<?php echo $email; ?>" size="50"/></td>
            </tr> 
            <tr>
              <td><?php echo $entry_telephone; ?></td>
              <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_fax; ?></td>
              <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_code; ?></td>
              <td><input type="code" name="code" value="<?php echo $code; ?>"  /></td>
            </tr>

          </table>
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
                  <img src="<?php echo $no_image; ?>"id="thumb-file" />
                  <input type="hidden" name="file" value="" id="file" />
                  <br />
                  <a onclick="image_upload('file', 'thumb-file');">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-file').attr('src', '<?php echo $no_image; ?>'); $('#file').attr('value', '');"><?php echo $text_clear; ?></a>
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
        <div id="tab-description">
          <table class="form">
            <tr>
              <td><?php echo $entry_description; ?></td>
              <td><input type="text" name="dtitle" value="<?php echo $dtitle ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_text; ?></td>
              <td><textarea cols="80" rows="5" name="text"><?php echo $text ?></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_image; ?></td>
              <td>
                <div class="image">
                  <img src="<?php echo $image; ?>"id="thumb-image" />
                  <input type="hidden" name="image" value="<?php echo $image ?>" id="image" />
                  <br />
                  <a onclick="image_upload('image', 'thumb-image');">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-image').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
            </tr>
          </table>

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
                  <img src="<?php echo $no_image; ?>"id="thumb-avatar" />
                  <input type="hidden" name="avatar" value="" id="avatar" />
                  <br />
                  <a onclick="image_upload('avatar', 'thumb-avatar');">
                    <?php echo $text_browse; ?>
                  </a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb-avatar').attr('src', '<?php echo $no_image; ?>'); $('#avatar').attr('value', '');"><?php echo $text_clear; ?></a>
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
        <div id="tab-case"></div>
        <?php } ?>
      </form>
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
    data: 'path=' + encodeURIComponent($('#tab-file input[name=\'file\']').val()) + '&mode=' + encodeURIComponent($('#tab-file input[name=\'mode\']:checked').val())+ '&note=' + encodeURIComponent($('#tab-file textarea[name=\'note\']').val())+ '&sort=' + encodeURIComponent($('#tab-file input[name=\'sort\']').val()),
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
    }
  });
});

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
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 800,
    height: 400,
    resizable: false,
    modal: false
  });
};
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
<?php echo $footer; ?>