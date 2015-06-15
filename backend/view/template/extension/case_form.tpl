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
      <h1><img src="view/image/shipping.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
        <a href="#tab-general"><?php echo $tab_general; ?></a>
        <?php if(isset($this->request->get['case_id'])){?>
        <a href="#tab-images"><?php echo $tab_images; ?></a>
        <?php }?>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" onsubmit="return check_image();">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_name; ?></td>
              <td><input type="text" name="name" value="<?php echo $name; ?>" size="100" />
                <?php if ($error_name) { ?>
                <span class="error"><?php echo $error_name; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td> <?php echo $entry_desc; ?></td>
              <td><textarea type="text" name="desc" id="case-desc"><?php echo $desc; ?></textarea>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_keyword; ?></td>
              <td><input type="text" name="keyword" value="<?php echo $keyword; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_cover; ?></td>
              <td valign="top">
                <div class="image">
                  <?php if(isset($this->request->get['case_id'])){?>
                  <img src="<?php echo $thumb; ?>" alt="" />
                  <?php }else{?>
                  <img src="<?php echo $thumb; ?>" alt="" id="thumb" />
                  <input type="hidden" name="cover" value="<?php echo $cover; ?>" id="image" />
                  <br />
                  <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>
                  &nbsp;&nbsp;|&nbsp;&nbsp;
                  <a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a>
                  <?php }?>
                </div>
              </td>
            </tr>

            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
            </tr>
          </table>
        </div>
        <?php if(isset($this->request->get['case_id'])){?>
        <div id="tab-images">
          <table class="form">
            <tr>
              <td><?php echo $entry_cover; ?></td>
              <td valign="top"><div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" />
                <input type="hidden" name="cover" value="<?php echo $cover; ?>" id="image" />
                <br /><a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
            </tr>
            <tr>
              <td><a id="button-upload"><?php echo $entry_add_img ?></a></td>
              <td>
                <div id="uploads" class="uploads">
                <?php foreach ($case_images as $file): ?>
                  <div class="attach">
                    <a class="fancy-img" href="<?php echo $file['realpath'] ?>"></a>
                    <img src="<?php echo $file['image'] ?>" title="<?php echo $file['name'] ?>">
                    <a class="img-remove" onclick="$(this).parent().remove();"><?php echo $text_delete ?></a>
                  </div>
                <?php endforeach ?>
                </div>
              </td>
            </tr>
          </table>
        </div>
        <?php }?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
CKEDITOR.replace('case-desc',{height:100});
$(function(){
  $('a.fancy-img').fancybox({
      openEffect  : 'none',
      closeEffect : 'none',
      closeBtn   : false,
      helpers : {
          title   : {
              type: 'inside'
          },
          buttons : {},
          thumbs  : {
              width   : 50,
              height  : 50
          }
      }
  });
});
function check_image(){
  
  if($('#uploads img').length>0){
    var uploads = [];
    $.each($('#uploads img'),function(){
      uploads.push({name:$(this).attr('filename'),path:$(this).attr('filepath')});
    });
    $('#form input[name="attach"]').remove();
    $('#form').append('<input name="attach" type="hidden" value=\''+$.toJSON(uploads)+'\' />');
  }
  return true;
}

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

new AjaxUpload('#button-upload', {
  action: 'index.php?route=common/upload/upload&token=<?php echo $token; ?>',
    name: 'attach',
    autoSubmit: false,
    responseType: 'json',
    onChange: function(file, extension) {this.submit();},
    onComplete: function(file, json) {
      if(json.success) { 
          var html = '<div class="attach">';
          html +='<img title="'+file+'" filename="'+file+'" filepath="'+json.path+'" src="'+getImgURL(json.path)+'" class="img-thumbnail">';
          html +='<a class="img-remove" onclick="$(this).parent().remove();"><?php echo $text_delete ?></a>';
          html += '</div>';
          
          $("#uploads").append(html);
      }else{
          alert(json.error);
      }           
      $('.loading').remove(); 
    }
});

$('#tabs a').tabs(); 
//--></script> 
<?php echo $footer; ?>