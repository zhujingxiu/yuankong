<?php 
	/******************************************************
	 * @package Pav Megamenu module for Opencart 1.5.x
	 * @version 1.0
	 * @author http://www.pavothemes.com
	 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
	 * @license		GNU General Public License version 2
	*******************************************************/

	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
	$themeConfig = $this->config->get('themecontrol');
	$themeName =  $this->config->get('config_template');
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$LANGUAGE_ID = $this->config->get( 'config_language_id' );  

?>
</section>
<?php
	$modules = $helper->getModulesByPosition( 'mass_bottom' ); 
	if( count($modules) ) { ?>
		<?php foreach ($modules as $i =>  $module) {   ?>
		<div class="w mt15"><?php echo $module; ?></div>	
		<?php } ?>
	<?php } ?>
<?php

$modules = $helper->getModulesByPosition( 'footer_top' ); 
$ospans = array( 1=>5 );

if( count($modules) ){
$cols = isset($themeConfig['block_footer_top'])&& $themeConfig['block_footer_top']?(int)$themeConfig['block_footer_top']:count($modules);
$class = $helper->calculateSpans( $ospans, $cols );
?>
<div class="linkf mt20">

	<?php foreach ($modules as $i =>  $module):?>
		<?php echo $module; ?>
	<?php endforeach; ?>

</div>
<?php } ?>
<div class="w mt20">

	<?php

	$modules = $helper->getModulesByPosition( 'footer_center' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_center'])&& $themeConfig['block_footer_center']?(int)$themeConfig['block_footer_center']:count($modules);
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-center">
		<div class="container">
		<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
				<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row-fluid"><?php } ?>	
				<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
		<?php  $j++;  } ?>	
		</div>
	</div>

<?php  } ?>	
	<?php

	$modules = $helper->getModulesByPosition( 'footer_bottom' ); 
	$ospans = array();
	
	if( count($modules) ){
	$cols = isset($themeConfig['block_footer_bottom'])&& $themeConfig['block_footer_bottom']?(int)$themeConfig['block_footer_bottom']:count($modules);	
	$class = $helper->calculateSpans( $ospans, $cols );
	?>
	<div class="footer-bottom">
		
		<?php foreach ($modules as $i =>  $module) { $i=$i+1; ?>
				<?php if( $i%$cols == 1 || count($modules)==1 ){  ?><?php } ?>	
				<?php echo $module; ?>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?><?php } ?>	
		<?php } ?>	
		
	</div>
	<?php } ?>
</div>


</body></html>