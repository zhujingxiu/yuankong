<?php echo $header; ?>
<div id="content">
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="sform">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box"  id="themepanel">
    <div class="heading">
      	<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      	<div class="buttons">
	  		<a class="button button-action btn-save" rel=""><?php echo $button_save; ?></a>
	  		<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
	  	</div>
    </div>
    <div class="content">
		<div class="entry-theme">
			<b class="label"> <?php echo $this->getLang("text_default_theme");?></b>
			<select name="themecontrol[default_theme]">
				<?php foreach( $templates as $template ): ?>
				<?php  $selected= $template == $module['default_theme']?'selected="selected"':'';	?>
				<option value="<?php echo $template;?>" <?php echo $selected; ?>><?php echo $template; ?></option>
				<?php endforeach; ?>
			</select>
	  	</div>
		<div class="ibox">
		 	<div id="tabs" class="htabs">
				<a href="#tab-pages-layout"><?php echo $this->language->get('tab_modules_pages');?></a>
				<a href="#tab-modules"><?php echo $this->language->get('tab_modules_layouts');?></a>
			</div>
		 	<input type="hidden" name="themecontrol[layout_id]" value="1">
		  	<input type="hidden" name="themecontrol[position]" value="1">
			<div id="tab-contents">
				<div id="tab-pages-layout">
  				 	<div id="my-tab-pageslayout" class="vtabs">
	  					<a href="#tab-pcategory" onclick="return false;"><?php echo $this->getLang("text_page_category");?></a>
	  					<a href="#tab-pproduct" onclick="return false;"><?php echo $this->getLang("text_page_product");?></a>
	  					<a href="#tab-psearch" onclick="return false;"><?php echo $this->getLang("text_page_search");?></a>
	  					<a href="#tab-pcopyright" onclick="return false;"><?php echo $this->getLang("text_page_copyright");?></a>
	  					<a href="#tab-ptopleft" onclick="return false;"><?php echo $this->getLang("text_page_topleft");?></a>
	  					<a href="#tab-pcontact" onclick="return false;"><?php echo $this->getLang("text_page_contact");?></a>
  				 	</div> 
  				 	<div class="page-tabs-wrap">
		  			 	<div class="clearfix" id="tab-pcategory">
		  			 		<div class="tab-inner">
		  			 		<table class="form">
		  			 			<tr>
		  			 				<td><?php echo $this->language->get('text_product_display_mode'); ?></td>
		  			 				<td>
		  			 					<select name="themecontrol[cateogry_display_mode]">
		  			 						<?php foreach( $cateogry_display_modes as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['cateogry_display_mode']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  			 					</select>
		  			 				</td>
		  			 			</tr>	
		  			 			<tr>
		  			 				<td><?php echo $this->language->get('text_max_product_row'); ?></td>
		  			 				<td>

		  			 					<select name="themecontrol[cateogry_product_row]">
		  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['cateogry_product_row']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  			 					</select>
		  			 				</td>
		  			 			</tr>	
		  			 			<tr>
		  			 				<td><?php echo $this->language->get('text_show_product_zoom');?></td>
		  			 				<td>
		  			 					<select name="themecontrol[category_pzoom]">
		  			 						<?php foreach( $yesno  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['category_pzoom']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  			 					</select>
		  			 				</td>
		  			 			</tr>	 
		  			 		</table>
		  			 		</div>
		  			 	</div>
		  			  	<div class="clearfix" id="tab-pproduct">
		  					<div class="tab-inner">
		  					<table class="form">
		  						<tr>
		  							<td><?php echo $this->language->get('text_enable_productzoom'); ?></td>
		  							<td>
		  								<select name="themecontrol[product_enablezoom]">
		  									<?php foreach( $yesno  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_enablezoom']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  								</select>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td><?php echo $this->language->get('text_product_zoomgallery'); ?></td>
		  							<td>
		  								<select name="themecontrol[product_zoomgallery]">
		  									<?php foreach( $product_zoomgallery  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomgallery']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  								</select>
		  							</td>
		  						</tr>	
		  						<tr>
		  							<td><?php echo $this->language->get('text_product_zoommode'); ?></td>
		  							<td>
		  								<select name="themecontrol[product_zoommode]">
		  									<?php foreach( $product_zoom_modes  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoommode']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  								</select>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td><?php echo $this->language->get('text_product_zoomlenssize'); ?></td>
		  							<td>
		  								<input value=<?php echo $module['product_zoomlenssize'];?> name="themecontrol[product_zoomlenssize]"/> 
		  							</td>
		  						</tr>
		  						<tr>
		  							<td><?php echo $this->language->get('text_product_zoomeasing'); ?></td>
		  							<td>
		  								<select name="themecontrol[product_zoomeasing]">
		  									<?php foreach( $yesno  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomeasing']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  								</select>
		  							</td>
		  						</tr>
		  						<tr>
		  							<td><?php echo $this->language->get('text_product_zoomlensshapes'); ?></td>
		  							<td>
		  								<select name="themecontrol[product_zoomlensshape]">
		  									<?php foreach( $product_zoomlensshapes  as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_zoomlensshape']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  								</select>
		  							</td>
		  						</tr>

		  						<tr>
		  			 				<td><?php echo $this->language->get('text_product_related_column'); ?></td>
		  			 				<td>
		  			 					<select name="themecontrol[product_related_column]">
		  			 						<?php foreach( $product_rows as $k=>$v ) { ?>
		  			 					 	<option value="<?php echo $k;?>"  <?php if( $k==$module['product_related_column']){ ?> selected="selected" <?php } ?>><?php echo $v;?></option>
		  			 						<?php }  ?>	
		  			 					</select>
		  			 				</td>
		  			 			</tr>	
		  					</table>
		  					</div>
		  			 	</div>
		  			 	<div class="clearfix" id="tab-psearch">
		  					<div class="tab-inner">
		  					<table class="form">
		  						<tr>
		  							<td><?php echo $this->language->get('text_search_option'); ?></td>
		  							<td>
		  								<?php foreach( $search_option  as $k => $v ) { ?>
		  								<label>
		  									<input type="checkbox" name="themecontrol[search][option][]" value="<?php echo strtolower(trim($k)) ?>" <?php echo in_array($k, $module['search']['option']) ? 'checked' : '' ?>>
		  			 					 	<?php echo $v;?>
		  			 					</label>
		  								<?php }  ?>	
		  							</td>
		  						</tr>
		  						<tr>
		  							<td><?php echo $this->language->get('text_search_placeholder'); ?></td>
		  							<td>
		  								<input value="<?php echo $module['search']['placeholder'];?>" name="themecontrol[search][placeholder]"/> 
		  							</td>
		  						</tr>
		  					</table>
		  					<h3><?php echo $this->language->get('text_search_keywords'); ?></h3>
		  					<table id="search-keywords" class="list">	
		  						<thead>
						            <tr>            
						              <td class="left"><?php echo $entry_title; ?></td>
						              <td class="left"><?php echo $entry_link; ?></td>
						              <td class="left"><?php echo $entry_additional_class; ?></td>
						              <td class="right"><?php echo $entry_sort_order; ?></td>
						              <td></td>
						            </tr>
						          </thead>
						          <?php $keyword_row = 0; ?>
						          <?php foreach ($module['search']['keyword'] as $item) { ?>
						          <tbody id="keyword-row<?php echo $keyword_row; ?>">
						            <tr>
						              <td class="left"><input type="text" name="themecontrol[search][keyword][<?php echo $keyword_row; ?>][title]" value="<?php echo $item['title']; ?>" /></td>
						              <td class="left"><input type="text" name="themecontrol[search][keyword][<?php echo $keyword_row; ?>][link]" value="<?php echo $item['link']; ?>" /></td>
						              <td class="left"><input type="text" name="themecontrol[search][keyword][<?php echo $keyword_row; ?>][additional_class]" value="<?php echo $item['additional_class']; ?>" /></td>
						              <td class="right"><input type="text" name="themecontrol[search][keyword][<?php echo $keyword_row; ?>][sort]" value="<?php echo $item['sort']; ?>" size="3" /></td>
						              <td class="left"><button type="button" onclick="$('#keyword-row<?php echo $keyword_row; ?>').remove();" class="button"><?php echo $this->language->get('button_remove'); ?></button></td>
						            </tr>
						          </tbody>
						          <?php $keyword_row++; ?>
						          <?php } ?>
						          <tfoot>
						            <tr>
						              <td colspan="4"></td>
						              <td class="left"><button type="button" onclick="addKeyword();" class="button btn-save"><?php echo $this->getLang('text_keyword_add'); ?></button></td>
						            </tr>
						          </tfoot>
		  					</table>
		  					</div>
		  			 	</div>
		  			 	<div id="tab-pcopyright">
			  			 	<div class="tab-inner">
			  			 		<table class="form">
			  			 			<tr>
			  			 				<td class="" colspan="2"><h4><?php echo $this->language->get('text_copyright_html'); ?></h4></td>
			  			 			</tr>
			  			 			<?php foreach( $languages as $language ) {  ?>
			  			 			<tr>
			  			 				<td>
			  			 					<?php 
			  			 						$copyright_customhtml = isset($module['copyright_customhtml'][$language['language_id']])?
			  			 						$module['copyright_customhtml'][$language['language_id']]:""; 
			  			 					 ?>
			  			 					 <img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
			  			 					 <?php echo $language['name'];?> 
			  			 				</td>
			  			 				<td>
			  			 					<textarea id="copyright-<?php echo $language['language_id'];?>" name="themecontrol[copyright_customhtml][<?php echo $language['language_id'];?>]"><?php echo $copyright_customhtml;?></textarea>
			  			 				</td>
			  			 			<tr>
			  			 			<?php } ?>	
			  			 		</table>	
			  			 	</div>	
			  			</div>
		  			 	<div id="tab-ptopleft">
			  			 	<div class="tab-inner">
			  			 		<table class="form">
			  			 			<tr>
			  			 				<td class="" colspan="2"><h4><?php echo $this->language->get('text_topleft_html'); ?></h4></td>
			  			 			</tr>
			  			 			<?php foreach( $languages as $language ) {  ?>
			  			 			<tr>
			  			 				<td>
			  			 					<?php 
			  			 						$topleft_customhtml = isset($module['topleft_customhtml'][$language['language_id']])?
			  			 						$module['topleft_customhtml'][$language['language_id']]:""; 
			  			 					 ?>
			  			 					 <img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
			  			 					 <?php echo $language['name'];?> 
			  			 				</td>
			  			 				<td>
			  			 					<textarea id="topleft-<?php echo $language['language_id'];?>" name="themecontrol[topleft_customhtml][<?php echo $language['language_id'];?>]"><?php echo $topleft_customhtml;?></textarea>
			  			 				</td>
			  			 			<tr>
			  			 			<?php } ?>	
			  			 		</table>	
			  			 	</div>	
			  			</div>
		  			 	<div id="tab-pcontact">
			  			 	<div class="tab-inner">
			  			 		<table class="form">
			  			 			<tr>
			  			 				<td class="" colspan="2"><h4><?php echo $this->language->get('text_contact_html'); ?></h4></td>
			  			 			</tr>
			  			 			<?php foreach( $languages as $language ) {  ?>
			  			 			<tr>
			  			 				<td>
			  			 					<?php 
			  			 						$contact_customhtml = isset($module['contact_customhtml'][$language['language_id']])?
			  			 						$module['contact_customhtml'][$language['language_id']]:""; 
			  			 					 ?>
			  			 					 <img src="<?php echo TPL_IMG ?>flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
			  			 					 <?php echo $language['name'];?> 
			  			 				</td>
			  			 				<td>
			  			 					<textarea id="contact-<?php echo $language['language_id'];?>" name="themecontrol[contact_customhtml][<?php echo $language['language_id'];?>]"><?php echo $contact_customhtml;?></textarea>
			  			 				</td>
			  			 			<tr>
			  			 			<?php } ?>	
			  			 		</table>	
			  			 	</div>	
			  			</div>
		  			</div>  
		  			<div class="clear clearfix"></div>
				</div>  				
				<div id="tab-modules">
					<?php include( "layout.tpl" ); ?>
				</div>
				
				<input type="hidden" name="action_type" id="action_type" value="new">

	   		</div>
    	</div>
    </div>
</div>
  
  
</form>

</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript"><!--
<?php foreach( $languages as $language ) {  ?>
CKEDITOR.replace('copyright-<?php echo $language['language_id'];?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
CKEDITOR.replace('topleft-<?php echo $language['language_id'];?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
CKEDITOR.replace('contact-<?php echo $language['language_id'];?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
var keyword_row = <?php echo $keyword_row; ?>;

function addKeyword() {  
  html  = '<tbody id="keyword-row' + keyword_row + '">';
  html += '    <tr>';
  html += '    <td class="left"><input type="text" name="themecontrol[search][keyword][' + keyword_row + '][title]" value="" /></td>';
  html += '    <td class="left"><input type="text" name="themecontrol[search][keyword][' + keyword_row + '][link]" value="" /></td>';

  html += '    <td class="left"><input type="text" name="themecontrol[search][keyword][' + keyword_row + '][additional_class]" value="" /></td>';
  html += '    <td class="right"><input type="text" name="themecontrol[search][keyword][' + keyword_row + '][sort]" value="1" size="3" /></td>';
  html += '    <td class="left"><button type="button" onclick="$(\'#keyword-row' + keyword_row + '\').remove();" class="button"><?php echo $button_remove; ?></button></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#search-keywords tfoot').before(html);
  
  keyword_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
$('.mytabs a').tabs();
$('#languages a').tabs();
 $('#tab-pages-layout a').tabs();
$('#tabs a').click( function(){
	$.cookie("actived_tab", $(this).attr("href") );
} );

if( $.cookie("actived_tab") !="undefined" ){
	$('#tabs a').each( function(){
		if( $(this).attr("href") ==  $.cookie("actived_tab") ){
			$(this).click();
			return ;
		}
	} );
	
}
$(document).ready( function(){		
	$(".button-action").click( function(){
		$('#action_type').val( $(this).attr("rel") );
		var string = 'rand='+Math.random();
		var hook = '';
		$(".ui-sortable").each( function(){
			if( $(this).attr("data-position") && $(".module-pos",this).length>0) {
				var position = $(this).attr("data-position");
				$(".module-pos",this).each( function(){
					if( $(this).attr("data-id") != "" ){
						hook += "modules["+position+"][]="+$(this).attr("data-id")+"&";
					}				
				} );
				string = string.replace(/\,$/,"");
				hook = hook.replace(/\,$/,"");
			}	
		});
		var unhook = '';

		$.ajax({
		  	type: 'POST',
		  	url: '<?php echo str_replace("&amp;","&",$ajax_modules_position);?>',
		  	data: string+"&"+hook+unhook,
		  	success: function(){
				$('#sform').submit();
			// 	window.location.reload(true);
		  	}
		});
		return false; 
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
<style type="text/css">
	.tab-inner{padding: 15px;}
</style>
<?php echo $footer; ?>
