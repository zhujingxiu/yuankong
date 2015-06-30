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
<style type="text/css">

.list input[type=text]{
	width:30px;
	padding:5px;
	border:1px #DDD solid;
}
.list input.t{
	width:96%;
}
.btn_prev{
	display: inline-block;
	width: 0;
	height: 0;
	border-width: 6px;
	border-style: dashed;
	border-color: transparent;
	border-left-width: 0;
	border-right-color: #919191;
	border-right-style: solid;
	text-indent:-99999px;
}
.btn_next{
	display: inline-block;
	width: 0;
	height: 0;
	border-width: 6px;
	border-style: dashed;
	border-color: transparent;
	border-right-width: 0;
	border-left-color: #919191;
	border-left-style: solid;
	text-indent:-99999px;
}
.pages .left{
	float:left;
	clear:left;
}
.pages .right{
	float:right;
	clear:right;
}
.page-btn, .page-jump{
	display:inline-block;
}
.page-btn .links a, .page-btn .links b{
	margin-left:5px;
}
.page-btn .links a{
	border: 1px solid #DDDDDD;
	padding: 4px 10px;
	font-size: 12px;
	text-decoration: none;
	color: #A3A3A3;
}
.page-btn .links b{
	border: 1px solid #269BC6;
	padding: 4px 10px;
	font-size: 12px;
	font-weight: normal;
	text-decoration: none;
	color: #269BC6;
	background: #FFFFFF;
}
.page-jump{
	margin-left:10px;
}
.page-jump input{
	width:35px;
	border: 1px solid #DDDDDD;
	padding: 4px;
	margin-left:5px;
	-webkit-border-radius: 3px 3px 3px 3px;
	-moz-border-radius: 3px 3px 3px 3px;
	-khtml-border-radius: 3px 3px 3px 3px;
	border-radius: 3px 3px 3px 3px;
	background:#FFF;
	color:#999;
	cursor:pointer;
}
.page-jump input[type=button]:hover{
	background:#DDD;
	color:#FFF;
}
.page-del .remove{
	border: 1px solid #CC3366;
	padding: 4px;
	margin-left:5px;
	-webkit-border-radius: 3px 3px 3px 3px;
	-moz-border-radius: 3px 3px 3px 3px;
	-khtml-border-radius: 3px 3px 3px 3px;
	border-radius: 3px 3px 3px 3px;
	background:#CC0066;
	color:#FFF;
	text-decoration:none;
	font-size:11px;
	cursor:pointer;
}
</style>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    <table class="list">
          <thead>
            <tr>
              <td class="left" width="20%"><?php echo $entry_name; ?></td>
              <td class="left" width="30%"><?php echo $entry_client_id; ?></td>
              <td class="left" width="30%"><?php echo $entry_client_secret; ?></td>
              <td class="left" width="30%"><?php echo $entry_img; ?></td>
              <td class="right" width="10%"><?php echo $entry_sort_order; ?></td>
              <td class="right" width="10%"><?php echo $entry_status; ?></td>
            </tr>
          </thead>
          <tbody>

            <tr>
              <td class="left">QQ</td>
              <td class="left"><input type="text" class="t" name="oauth[qq][client_id]" value="<?php echo isset($oauth['qq'])?$oauth['qq']['client_id']:''; ?>" /></td>
              <td class="left"><input type="text" class="t" name="oauth[qq][client_secret]" value="<?php echo isset($oauth['qq'])?$oauth['qq']['client_secret']:''; ?>" /></td>
              <td class="left">
                  <?php 
                  $qq_thumb = isset($oauth['qq']['img']) ? $this->model_tool_image->resize($oauth['qq']['img'], 18, 18) : $this->model_tool_image->resize("no_image.jpg", 18, 18);
                  $qq_image = isset($oauth['qq']['img']) ? $oauth['qq']['img'] : "";  
                     
                   ?> 
                <div class="image">
                    <img src="<?php echo $qq_thumb; ?>" alt="" id="thumb-qq" />
                    <input type="hidden" name="oauth[qq][img]" value="<?php echo $qq_image ?>" id="image-qq" /> &nbsp;&nbsp; 
                    <a onclick="image_upload('image-qq', 'thumb-qq');">
                        <?php echo $text_browse; ?></a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb-qq').attr('src', '<?php echo $qq_thumb; ?>'); $('#image-qq').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
              <td class="right"><input type="text" name="oauth[qq][sort]" value="<?php echo isset($oauth['qq'])?$oauth['qq']['sort']:'0'; ?>" /></td>
              <td class="right"><select name="oauth[qq][status]">
								  <?php if ($oauth && $oauth['qq']['status']) { ?>
								  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								  <option value="0"><?php echo $text_disabled; ?></option>
								  <?php } else { ?>
								  <option value="1"><?php echo $text_enabled; ?></option>
								  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								  <?php } ?>
								</select></td>
            </tr>
            <tr>
              <td class="left">新浪微博</td>
              <td class="left"><input type="text" class="t" name="oauth[weibo][client_id]" value="<?php echo isset($oauth['weibo'])?$oauth['weibo']['client_id']:''; ?>" /></td>
              <td class="left"><input type="text" class="t" name="oauth[weibo][client_secret]" value="<?php echo isset($oauth['weibo'])?$oauth['weibo']['client_secret']:''; ?>" /></td>
              <td class="left">
                <?php 
                  $weibo_thumb = isset($oauth['weibo']['img']) ? $this->model_tool_image->resize($oauth['weibo']['img'], 18, 18) : $this->model_tool_image->resize("no_image.jpg", 18, 18);
                  $weibo_image = isset($oauth['weibo']['img']) ? $oauth['weibo']['img'] : "";  
                     
                   ?> 
                <div class="image">
                    <img src="<?php echo $weibo_thumb; ?>" alt="" id="thumb-weibo" />
                    <input type="hidden" name="oauth[weibo][img]" value="<?php echo $weibo_image ?>" id="image-weibo" /> &nbsp;&nbsp; 
                    <a onclick="image_upload('image-weibo', 'thumb-weibo');">
                        <?php echo $text_browse; ?></a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb-weibo').attr('src', '<?php echo $weibo_thumb; ?>'); $('#image-weibo').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
            </td>
              <td class="right"><input type="text" name="oauth[weibo][sort]" value="<?php echo isset($oauth['weibo'])?$oauth['weibo']['sort']:'0'; ?>" /></td>
              <td class="right"><select name="oauth[weibo][status]">
								  <?php if ($oauth && $oauth['weibo']['status']) { ?>
								  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								  <option value="0"><?php echo $text_disabled; ?></option>
								  <?php } else { ?>
								  <option value="1"><?php echo $text_enabled; ?></option>
								  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								  <?php } ?>
								</select></td>
            </tr>
            <tr>
              <td class="left">百度登陆</td>
              <td class="left"><input type="text" class="t" name="oauth[baidu][client_id]" value="<?php echo isset($oauth['baidu'])?$oauth['baidu']['client_id']:''; ?>" /></td>
              <td class="left"><input type="text" class="t" name="oauth[baidu][client_secret]" value="<?php echo isset($oauth['baidu'])?$oauth['baidu']['client_secret']:''; ?>" /></td>
              <td class="left">
                <?php 
                  $baidu_thumb = isset($oauth['baidu']['img']) ? $this->model_tool_image->resize($oauth['baidu']['img'], 18, 18) : $this->model_tool_image->resize("no_image.jpg", 18, 18);
                  $baidu_image = isset($oauth['baidu']['img']) ? $oauth['baidu']['img'] : "";  
                     
                   ?> 
                <div class="image">
                    <img src="<?php echo $baidu_thumb; ?>" alt="" id="thumb-baidu" />
                    <input type="hidden" name="oauth[baidu][img]" value="<?php echo $baidu_image ?>" id="image-baidu" /> &nbsp;&nbsp; 
                    <a onclick="image_upload('image-baidu', 'thumb-baidu');">
                        <?php echo $text_browse; ?></a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb-baidu').attr('src', '<?php echo $baidu_thumb; ?>'); $('#image-baidu').attr('value', '');"><?php echo $text_clear; ?></a>
                </div>
              </td>
              <td class="right"><input type="text" name="oauth[baidu][sort]" value="<?php echo isset($oauth['baidu'])?$oauth['baidu']['sort']:'0'; ?>" /></td>
              <td class="right"><select name="oauth[baidu][status]">
								  <?php if ($oauth && $oauth['baidu']['status']) { ?>
								  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								  <option value="0"><?php echo $text_disabled; ?></option>
								  <?php } else { ?>
								  <option value="1"><?php echo $text_enabled; ?></option>
								  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								  <?php } ?>
								</select></td>
            </tr>
          </tbody>
        </table>
      </form>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="delete">
		<?php if ($oauth_list) { ?>
	  	<h2>Customer List</h2>
	    <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $entry_c_nickname; ?></td>
              <td class="left"><?php echo $entry_name; ?></td>
              <td class="left"><?php echo $entry_c_email; ?></td>
              <td class="left"><?php echo $entry_c_name; ?></td>
              <td class="right"><?php echo $entry_c_openid; ?></td>
              <td class="right"><?php echo $entry_c_date; ?></td>
            </tr>
          </thead>
          <tbody id="list">
		    <?php foreach ($oauth_list as $list) { ?>
            <tr>
              <td class="left"><input type="checkbox" name="selected[]" value="<?php echo $list['oauth_id']; ?>" /></td>
              <td class="left"><?php echo $list['name']; ?></td>
              <td class="left"><?php echo $list['type']; ?></td>
              <td class="left"><a href="<?php echo $list['href']; ?>"><?php echo $list['email']; ?></a></td>
              <td class="left"><?php echo $list['firstname'].' '.$list['lastname']; ?></td>
              <td class="right"><?php echo $list['openid']; ?></td>
              <td class="right"><?php echo $list['date_added']; ?></td>
            </tr>
			<?php } ?>
          </tbody>
        </table>
		<div class="pages">
			<div class="left">
				<div class="page-del"><a onclick="Remove();" class="remove"><?php echo $button_remove; ?></a></div>
			</div>
			<div class="right">
				<div class="page-btn"><?php echo $pagination; ?></div>
				<div class="page-jump"><input type="text" value="1" id="jump" /><input type="button" value="GO" onclick="Jump($('#jump').val());" /></div>
			</div>
		</div>
		<?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function Jump(page) {
	if (Number(page) <= <?php echo $maxpage; ?>) {
		show(page);
	} else {
		alert('<?php echo $error_jump; ?>');
	}
}

function Remove() {
	$.ajax({
		type: 'POST',
		url: '<?php echo $delete; ?>',
		data: $('#list input[type=\'checkbox\']:checked'),
		dataType: 'json',
		success: function(json) {
			if (!json['error']) {
				show(1);
			} else {
				alert(json['error']);
			}
		}
	});
}

function show(page) {
	$.ajax({
		type: 'GET',
		url: 'index.php?route=module/oauth/getlist&token=<?php echo $token; ?>',
		data: {'page':page},
		dataType: 'json',
		success: function(json) {
			if (!json['error']) {
				var html  = '';
				
				for (var i = 0; i < json['data'].length; i ++) {
					html += '<tr>';
					html += '  <td class="left"><input type="checkbox" name="selected[]" value="'+json['data'][i]['oauth_id']+'" /></td>';
					html += '  <td class="left">'+json['data'][i]['name']+'</td>';
					html += '  <td class="left">'+json['data'][i]['type']+'</td>';
					html += '  <td class="left"><a href="'+json['data'][i]['href']+'">'+json['data'][i]['email']+'</a></td>';
					html += '  <td class="left">'+json['data'][i]['firstname']+' '+json['data'][i]['lastname']+'</td>';
					html += '  <td class="right">'+json['data'][i]['openid']+'</td>';
					html += '  <td class="right">'+json['data'][i]['date_added']+'</td>';
					html += '</tr>';
				}
				
				$('#list').html(html);
				$('.page-btn').html(json['pagination']);
			} else {
				// 输出错误
				alert(json['error']);
			}
		}
	});
}
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
<?php echo $footer; ?>