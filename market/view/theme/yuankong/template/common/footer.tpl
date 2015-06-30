<?php 
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

if( count($modules) ){ ?>
<div class="linkf mt20">
	<?php foreach ($modules as $i =>  $module):?>
	<div class="w">	<?php echo $module; ?></div>
	<?php endforeach; ?>
</div>
<?php } ?>
<div class="w mt20">

<?php
	$modules = $helper->getModulesByPosition( 'footer_center' ); 
	
	if( count($modules) ){ ?>
	<div class="footer-center">
		<div class="container">
		<?php foreach ($modules as $i =>  $module) {  ?>
			<?php echo $module; ?>	
		<?php } ?>	
		</div>
	</div>
<?php  } ?>	
<?php
	$modules = $helper->getModulesByPosition( 'footer_bottom' ); 
	if( count($modules) ){
		foreach ($modules as $i =>  $module) {  ?>
			<?php echo $module; ?>
		<?php } ?>
	<?php }else{ 
		echo $powered;
	} ?>
</div>
<script type="text/javascript">
	o.mous.init(".h-weix","hov");
    o.mous.init(".my-ezhan","hov");
    o.dlist.init(".s-select",".search-dt",".search-dd");
</script>
</body></html>