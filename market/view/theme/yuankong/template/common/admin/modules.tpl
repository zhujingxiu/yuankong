<?php 
	$d = array(
		'custom_top_module' => '
			<div class="item first">
				<div class="payment">
					<h3>secured payment</h3>
					<p>Proin gravida nibh vel</p>
					</div>
				</div>
				<div class="item col">
					<div class="return">
					<h3>free return</h3>
					<p>Aenean solltudin lorem</p>
				</div>
				</div>
				<div class="item last">
					<div class="shipping">
					<h3>free shipping</h3>
					<p>Quis bibendum auctor</p>
				</div>
			</div>
		'
	);
	$module = array_merge( $d, $module );
?>
<div class="inner-modules-wrap clearix">
	<div class="vtabs mytabs" id="my-tab-innermodules">
		<a onclick="return false;" href="#tab-imodule-footer" class="selected"><?php echo $this->language->get('Top Bar');?></a>
	 </div>
	 <div class="page-tabs-wrap clearfix">
		<table class="form">
				<tr>
					<td><?php echo $this->language->get('Delivery Widget');?></td>
					<td>
						<h4><label><b><?php echo $this->language->get('HTML Content');?></b></label></h4>
						<textarea name="themecontrol[custom_top_module]" id="custom_top_module" rows="5" cols="60"><?php echo $module['custom_top_module'];?></textarea>
						<p><i><?php echo $this->language->get('this module appear in header right position');?></i></p>
					</td>
				</tr>
		</table>
		<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
		<script type="text/javascript"><!--


		CKEDITOR.replace('custom_top_module', {
			filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
			filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
		});


		//--></script> 
	</div>	

</div>	
<div class="clearfix clear"></div>	