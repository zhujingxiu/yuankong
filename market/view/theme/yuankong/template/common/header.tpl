<?php 
	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
 
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
<meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/yk_basic.css" />


<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>


<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<!--[if lt IE 9]>
<script src="market/view/javascript/html5.js"></script>
<![endif]-->
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/index.js"></script>

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php //echo $google_analytics; ?>
</head>
<body class="b_fa">

<div class="header f_s">
	<div class="w">

		<div class="l">
			<?php if( isset($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')]) )  { 
				echo html_entity_decode($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'); 
			} ?>
		</div>
		<div class="r">
			<ul class="head-ul">
				<li id="welcome">
					<?php if (!$logged) { ?>
					<?php echo $text_welcome; ?>
					<?php } else { ?>
					<?php echo $text_logged; ?>
					<?php } ?>
				</li>
				<li class="top-links">
				<a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
				<a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
				<a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
				<!--a href="<?php //echo $checkout; ?>"><?php //echo $text_checkout; ?></a-->
				<?php //echo $currency; ?>
				<?php //echo $language; ?>					
				</li>
			</ul>
		</div>
	</div>
</div>
<?php if( isset($themeConfig['custom_top_module']) )  { 
	echo html_entity_decode($themeConfig['custom_top_module'], ENT_QUOTES, 'UTF-8'); 
} ?>
<div class="w">
	<div class="logobox fix">
		<?php if ($logo) { ?>
			<a href="<?php echo $home; ?>" class="l">
				<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
			</a>
		<?php } ?>
		<div class="logo-search">

			<div class="rel l-s-box b_f">
				<dl class="s-select">
                    <dt class="search-dt"><span>消防产品</span><em class="icon2 h-down"></em></dt>
                    <dd class="search-dd">
                        <span class="db" val="1">消防产品</span>
                        <span class="db" val="2">消防资讯</span>
                    </dd>
                </dl>
				<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search ?>" class="l s-text"/>
				<input type="submit" class="l s-sub" value="<?php echo $text_search; ?>" />
			</div>
			<p class="pt5 f_s"></p>
		</div>
		<?php echo $cart; ?>
	</div>
</div>
<div class="navbox">
<?php 
/**
 * Main Menu modules
 */
$modules = $helper->getModulesByPosition( 'mainmenu' ); 
if( count($modules) ){ ?>
<?php foreach ($modules as $module) { ?>
	<?php echo $module; ?>
<?php } ?>

<?php } elseif ($categories) { ?>
	<div class="w rel fix">
		<div class="l ovh">	
		<ul class="nav">
			<?php foreach ($categories as $category) { ?>
			
			<?php if ($category['children']) { ?>			
			<li class="parent dropdown deeper ">
				<a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
				<b class="caret"></b>
			</a>
			<?php } else { ?>
			<li ><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
			<?php } ?>
			<?php if ($category['children']) { ?>
			 
				<?php for ($i = 0; $i < count($category['children']);) { ?>
				 <ul class="dropdown-menu">
				  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
				  <?php for (; $i < $j; $i++) { ?>
				  <?php if (isset($category['children'][$i])) { ?>
				  <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
				  <?php } ?>
				  <?php } ?>
				</ul>
				<?php } ?>
		
			  <?php } ?>
			</li>
			<?php } ?>
		</ul>
		</div>
	</div>	  

<?php } ?>
</div>
<section id="sys-notification">
	<div class="container">
		<?php if ($error) { ?>    
	    <div class="warning"><?php echo $error ?>
	    	<img src="market/view/theme/default/image/close.png" class="close" />
	    </div>    
		<?php } ?>
		<div id="notification"></div>
	</div>
</section>
<?php

$modules = $helper->getModulesByPosition( 'promotion' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<div class="pav-promotion w fix mt10" id="pav-promotion">

	<?php foreach ($modules as $i =>  $module) {  ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){ ?><?php } ?>	
			<?php echo $module; ?>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?><?php } ?>	
	<?php } ?>	

</div>
<?php } ?>
<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' ); 
if( $modules ){
?>
<div id="slideshow" class="pav-slideshow w mt10">
	
	<?php foreach ($modules as $module) { ?>
		<?php echo $module; ?>
	<?php } ?>
	
</div>
<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'showcase' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_showcase'])&& $config['block_showcase']?(int)$config['block_showcase']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<div class="pav-showcase w mt15 ovh" id="pavo-showcase">

	<?php foreach ($modules as $i =>  $module) {  ?>
	<?php if( $i++%$cols == 0 || count($modules)==1  ){  ?><?php } ?>	
	<?php echo $module; ?>
	<?php if( $i%$cols == 0 || $i==count($modules) ){ ?><?php } ?>
	<?php } ?>
</div>
<?php } ?>

<section id="columns">