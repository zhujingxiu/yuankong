<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
	<style type="text/css">
	.text_oauth{
		display:block;
		color:#666;
		border-bottom:1px #DDD dotted;
		padding:0px 0px 20px 10px;
		margin-bottom:20px;
		font-family: "Hiragino Sans GB","Microsoft YaHei","微软雅黑",tahoma,arial,simsun,"宋体";
	}
	.oauth_list{
		color:#666;
		list-style:none;
		padding:0px 10px;
		margin:0px;
		font-family: "Hiragino Sans GB","Microsoft YaHei","微软雅黑",tahoma,arial,simsun,"宋体";
	}
	.oauth_list li{
		display:inline-block;
		margin-right:20px;
	}
	.oauth_list li a{
		cursor:pointer;
		text-decoration:none;
		font-size:11px;
	}
	.oauth_list li a.bind{
		color:#3366FF;
	}
	.oauth_list li a.remove{
		color:#999;
	}
	.oauth_list li .name{
		margin-right:5px;
	}
	.oauth_error{
		font-family: "Hiragino Sans GB","Microsoft YaHei","微软雅黑",tahoma,arial,simsun,"宋体";
		padding:10px;
		color:#FF3366;
	}
	</style>
    <div class="content" style="padding:20px;">
	  <p class="text_oauth"><?php echo $text_welcome; ?></p>
	  <?php if ($oauth_lists) { ?>
      <ul class="oauth_list">
		<?php foreach ($oauth_lists as $oauth_list) { ?>
		<?php if ($oauth_list['status']) { ?>
		<?php if ($oauth_list['binded']) { ?>
	  	  <li><span class="name"><?php echo $oauth_list['name']; ?></span><span class="action">(<a id="<?php echo $oauth_list['tag']; ?>" class="remove"><?php echo $button_remove; ?></a>)</span></li>
		<?php } else { ?>
	  	  <li><span class="name"><?php echo $oauth_list['tag']; ?></span><span class="action">(<a id="<?php echo $oauth_list['tag']; ?>" class="bind"><?php echo $button_bind; ?></a>)</span></li>
		<?php } ?>
		<?php } ?>
		<?php } ?>
	  </ul>
	  <?php } ?>
	  <div class="oauth_error"></div>
    </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
$('.oauth_list li .action a').each(function(){
	$(this).click(function(){
		if ($(this).attr('class') == 'bind') {
			btnBind($(this).attr('id'));
		}
		
		if ($(this).attr('class') == 'remove') {
			btnRemove($(this).attr('id'));
		}
	});
});

// AJAX绑定账户
function btnBind(tag){
	// 弹框新页面
	window.open('<?php echo $action; ?>&tag='+tag, tag, 'height=600,width=900,top=20,left=50,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
}

// 取消绑定
function btnRemove(tag){
	if (!confirm('<?php echo $text_confirm; ?>')) {
		return false;
	}
	
	$.ajax({
		url: 'index.php?route=account/oauth/remove',
		type: 'GET',
		data: {'tag':tag},
		dataType: 'html',
		success: function(html) {
			$('#'+tag).parent().parent().find('.name').html(tag);
			$('#'+tag).attr('class', 'bind');
			$('#'+tag).html('<?php echo $button_bind; ?>');
		}
	});	
}

// 获取弹窗返回值
function getResponse(success, tag, msg, face, nick) {
	if (success == '1') {
		$('#'+tag).parent().parent().find('.name').html(nick);
		$('#'+tag).attr('class', 'remove');
		$('#'+tag).html('<?php echo $button_remove; ?>');
	} else {
		$('.oauth_error').html('Error: '+msg);
	}
};
//--></script> 