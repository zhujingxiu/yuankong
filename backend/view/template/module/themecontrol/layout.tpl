<?php // 	echo '<pre>'.print_r($module,1); die; ?>
<div id="ajaxloading" class="hide">
	<div class="warning"><b>processing request...</b></div>
</div>
  
<div class="clearfix">
	<table class="form">
		<tr>
			<td><b>Show modules on Layout</b></td>
			<td>
				<select name="elayout_id" onchange="window.location.href='<?php echo preg_replace("#elayout_id\s*=\s*\d+#","",$action); ?>&elayout_id='+this.value">
					<?php foreach( $layouts as $layout ) { 
					$selected = $layout['layout_id'] == $elayout_default ? 'selected="selected"' : "";
					?>
					<option value="<?php echo $layout['layout_id'];?>" <?php echo $selected;?>>
						<?php echo $layout['name'];?>
					</option>
				<?php } ?>
				</select>
			</td>
		</tr>
	</table>		
</div>

<p><i><?php echo $this->getLang("text_explain_modules_function");?></i></p>
<div class="theme-layout clearfix">
			
	<div class="header clearfix"><div class="pos">Header</div></div>
	<div class="slideshow  edit-container clearfix" data-position="mainmenu">
		<div class="explain"><?php echo $this->language->get('text_explain_mainmenu');?></div>
		<div class="pos">Main Menu</div>
		<?php if( isset($layout_modules['mainmenu']) ){  
		foreach( $layout_modules['mainmenu'] as $modulepos ) { ?>
		<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="mainmenu" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
			<div class="edit-module">
				<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
					<b><?php echo $modulepos['title']; ?></b>
				</a>
				<i>[[index:<?php echo $modulepos['index'];?>]</i>
			</div>
		</div>
		<?php } ?>
		<?php } ?>
	</div>
	<div class="slideshow  edit-container clearfix"  data-position="slideshow">
		<div class="pos">Slideshow</div>
		<?php if( isset($layout_modules['slideshow']) ){  
		foreach( $layout_modules['slideshow'] as $modulepos ) {?>
		<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="slideshow" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
			<div class="edit-module">
				<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
					<b><?php echo $modulepos['title']; ?></b>
				</a>
				<i>[[index:<?php echo $modulepos['index'];?>]</i>
			</div>
		</div>
		<?php } ?>
		<?php } ?>
	</div>
	
	<div class="promotion  edit-container" data-position="showcase" >
		<div class="explain">
			<?php echo $this->getLang('text_entry_columns_first') ;	?> 
			<select name="themecontrol[block_showcase]">
				<option value="">Default</option>
				<?php for( $i=1; $i<=6; $i++ )  {?>
					<option value="<?php echo $i;?>" <?php if( $i==$module['block_showcase']) { ?> selected="selected" <?php }?>><?php echo $i; ?></option>
				<?php } ?>
			</select> 
			<?php echo $this->getLang('text_entry_columns_last') ;?> 
		</div>
		<div class="pos">Showcase</div>
		<?php if( isset($layout_modules['showcase']) ){  
		foreach( $layout_modules['showcase'] as $modulepos ) { ?>
		<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="showcase" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
			<div class="edit-module">
				<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>"><b><?php echo $modulepos['title']; ?></b></a><i>[[index:<?php echo $modulepos['index'];?>]</i>
			</div>
		</div>
		<?php } }?>
	</div>
	<div class="promotion  edit-container" data-position="promotion" >
		<div class="explain">
			<?php echo $this->getLang('text_entry_columns_first') ;	?> 
			<select name="themecontrol[block_promotion]">
				<option value="">Default</option>
				<?php for( $i=1; $i<=6; $i++ )  {?>
					<option value="<?php echo $i;?>" <?php if( $i==$module['block_promotion']) { ?> selected="selected" <?php }?>><?php echo $i; ?></option>
				<?php } ?>
			</select> 
			<?php echo $this->getLang('text_entry_columns_last') ;?> 
		</div>
		
		<div class="pos">Promotion</div>
		<?php if( isset($layout_modules['promotion']) ){  
		foreach( $layout_modules['promotion'] as $modulepos ) { ?>
		<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="promotion" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
			<div class="edit-module">
				<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
					<b><?php echo $modulepos['title']; ?></b>
				</a>
				<i>[[index:<?php echo $modulepos['index'];?>]</i>
			</div>
		</div>
		<?php } ?>
		<?php } ?>
	</div>
	
	<div class="columns clearfix">
		<div class="column-left edit-container" data-position="column_left">
			<div class="pos">Column Left</div>
			<?php if( isset($layout_modules['column_left']) ){  
			foreach( $layout_modules['column_left'] as $modulepos ) {?>
			<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="column_left" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
				<div class="edit-module">
					<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
						<b><?php echo $modulepos['title']; ?></b>
					</a>
					<i>[[index:<?php echo $modulepos['index'];?>]</i>
				</div>
			</div>
			<?php } ?>
			<?php } ?>
		</div>
		<div class="column-center">
			<div class="content-top edit-container" data-position="content_top">
				<div class="pos">Content Top</div>
				<?php if( isset($layout_modules['content_top']) ){  
				foreach( $layout_modules['content_top'] as $modulepos ) { ?>
				<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="content_top" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
					<div class="edit-module">
						<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
							<b><?php echo $modulepos['title']; ?></b>
						</a>
						<i>[[index:<?php echo $modulepos['index'];?>]</i>
					</div>
				</div>
				<?php } ?>
				<?php } ?>
			</div>
			
			<div class="content-bottom edit-container" data-position="content_bottom">
				<div class="pos">Content Bottom</div>
				<?php if( isset($layout_modules['content_bottom']) ){  
				foreach( $layout_modules['content_bottom'] as $modulepos ) { ?>
				<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="content_bottom" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
					<div class="edit-module">
						<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
							<b><?php echo $modulepos['title']; ?></b>
						</a>
						<i>[[index:<?php echo $modulepos['index'];?>]</i>
					</div>
				</div>
				<?php } ?>
				<?php } ?>
			</div>
		</div>
		<div class="column-right edit-container" data-position="column_right">
			<div class="pos">Column Right</div>
			<?php if( isset($layout_modules['column_right']) ){  
			foreach( $layout_modules['column_right'] as $modulepos ) {?>
			<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="column_right" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
					<div class="edit-module">
						<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
							<b><?php echo $modulepos['title']; ?></b>
						</a>
						<i>[[index:<?php echo $modulepos['index'];?>]</i>
					</div>
				</div>
			<?php } ?>
			<?php } ?>
		</div>
	</div>

	<div class="massbottom  edit-container clearfix"  data-position="mass_bottom">
		<div class="pos">Massbottom</div>
		<?php if( isset($layout_modules['mass_bottom']) ){  
		foreach( $layout_modules['mass_bottom'] as $modulepos ) {?>
		<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="mass_bottom" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
			<div class="edit-module">
				<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
					<b><?php echo $modulepos['title']; ?></b>
				</a>
				<i>[[index:<?php echo $modulepos['index'];?>]</i>
			</div>
		</div>
		<?php } ?>
		<?php } ?>
	</div>

	<div class="layout-footer">
		<div class="footer-top edit-container" data-position="footer_top">
			<div class="explain">
				<?php echo $this->getLang('text_entry_columns_first') ;	?> 
				<select name="themecontrol[block_footer_top]">
					<option value="">Default</option>
					<?php for( $i=1; $i<=6; $i++ )  {?>
						<option value="<?php echo $i;?>" <?php if( $i==$module['block_footer_top']) { ?> selected="selected" <?php }?>><?php echo $i; ?></option>
					<?php } ?>
				</select> 
				<?php echo $this->getLang('text_entry_columns_last') ;?> 
			</div>
			<div class="pos">Footer Top</div>
	
			<?php if( isset($layout_modules['footer_top']) ){  
				foreach( $layout_modules['footer_top'] as $modulepos ) {?>
			<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="footer_top" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
				<div class="edit-module">
					<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>">
						<b><?php echo $modulepos['title']; ?></b>
					</a>
					<i>[[index:<?php echo $modulepos['index'];?>]</i>
				</div>
			</div>
			<?php } ?>
			<?php } ?>
		</div>
		<div class="footer-center edit-container" data-position="footer_center">
			<div class="explain">
				<?php echo $this->getLang('text_entry_columns_first') ;?> 
				<select name="themecontrol[block_footer_center]">
					<option value="">Default</option>
					<?php for( $i=1; $i<=6; $i++ )  {?>
					<option value="<?php echo $i;?>" <?php if( $i==$module['block_footer_center']) { ?> selected="selected" <?php }?>><?php echo $i; ?></option>
					<?php } ?>
				</select> 
				<?php echo $this->getLang('text_entry_columns_last') ;?> 
			</div>
		
			
			<div class="pos">Footer Center</div>
			<?php if( isset($layout_modules['footer_center']) ){  
			foreach( $layout_modules['footer_center'] as $modulepos ) {	?>
			<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="footer_center" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
				<div class="edit-module">
					<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>"><b><?php echo $modulepos['title']; ?></b></a><i>[[index:<?php echo $modulepos['index'];?>]</i>
				</div>
			</div>
			<?php } ?>
			<?php } ?>
		</div>
		<div class="footer-bottom edit-container" data-position="footer_bottom">
			<div class="explain">
				<?php echo $this->getLang('text_entry_columns_first') ;	?> 
				<select name="themecontrol[block_footer_bottom]">
					<option value="">Default</option>
					<?php for( $i=1; $i<=6; $i++ )  {?>
					<option value="<?php echo $i;?>" <?php if( $i==$module['block_footer_bottom']) { ?> selected="selected" <?php }?>><?php echo $i; ?></option>
					<?php } ?>
				</select> 
				<?php echo $this->getLang('text_entry_columns_last') ;?> 
			</div>
			<div class="pos">Footer Bottom</div>
			<?php if( isset($layout_modules['footer_bottom']) ){  
			foreach( $layout_modules['footer_bottom'] as $modulepos ) {?>
			<div class="module-pos <?php if( !$modulepos['status']){ ?>mod-disable<?php } ?>" data-position="footer_bottom" data-id="<?php echo $modulepos['code']."-".$modulepos['index'];?>">
				<div class="edit-module">
					<a target="_blank" href="<?php echo $this->url->link('module/'.$modulepos['code'],'token='.$token);?>"><b><?php echo $modulepos['title']; ?></b></a><i>[[index:<?php echo $modulepos['index'];?>]</i>
				</div>
			</div>
			<?php } ?>
			<?php } ?>
		</div>
	</div>
	<p>
		<i>* Note: update position and sort orders of modules could not work smoothly for modules having more than 2 instances in same page layout</i>
	</p>
</div>
<script type="text/javascript">
$('.theme-layout .edit-container').sortable( {
	connectWith: '.theme-layout .edit-container',
	containment: '.theme-layout',
	forceHelperSize: true,
	forcePlaceholderSize: true,
	placeholder: 'placeholder',
	handle:".edit-module"
});
		
$(document).ajaxSend(function() {
	$("#ajaxloading").show();
});
$(document).ajaxComplete(function() {
	$("#ajaxloading").hide();
});	
</script>