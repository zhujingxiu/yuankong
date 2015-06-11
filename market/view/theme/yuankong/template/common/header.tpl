<?php 
	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );

	/* Add scripts files */
	$helper->addScript( 'market/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'market/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	$helper->addScript( 'market/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'market/view/javascript/common.js' );
	$helper->addScript( 'market/view/theme/'.$themeName.'/javascript/common.js' );
	$helper->addScript( 'market/view/javascript/jquery/bootstrap/bootstrap.min.js' );

?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
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
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/stylesheet.css" />

<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<?php if( $helper->getParam('skin') &&  $helper->getParam('skin') != 'default' ){ ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/skins/<?php echo  $helper->getParam('skin');?>/stylesheet/stylesheet.css" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/font-awesome.min.css" />

<?php if( $direction == 'rtl' ) { ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/bootstrap-rtl.css" />
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/theme-rtl.css" />
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


<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body class="fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?>">
<section id="page-container">
<section id="header">
	<div class="header-top">
		<div class="container">
			<div class="row-fluid">
				<div class="span5">
					<div id="welcome">
						<?php if (!$logged) { ?>
						<?php echo $text_welcome; ?>
						<?php } else { ?>
						<?php echo $text_logged; ?>
						<?php } ?>
					</div>
					<div class="top-links">
					<a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
					<a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
					<a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
					<!--a href="<?php //echo $checkout; ?>"><?php //echo $text_checkout; ?></a-->
					<?php echo $currency; ?>
					<?php echo $language; ?>					
					</div>
					
				</div>
				<div class="span7 custom-top">
				<?php if( isset($themeConfig['custom_top_module']) )  { ?>
					echo html_entity_decode($themeConfig['custom_top_module'], ENT_QUOTES, 'UTF-8'); 
				<?php } ?>	
				</div>
			</div>
		</div>
	</div>

	<div class="header">
	<div class="container">
		<div class="row-fluid">
			<div class="span3">
				<?php if ($logo) { ?>
				<div id="logo">
					<a href="<?php echo $home; ?>">
						<img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
					</a>
				</div>
				<?php } ?>
			</div>
			<div class="span9 pull-right">
				<div id="search">
					<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
					<div class="button-search"></div>
				</div>	
				<?php echo $cart; ?> 
			</div>
		</div>
	</div>
	</div>
</section>

<section id="mainnav">
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
<nav id="mainmenu"><div class="container navbar">
	<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	  <span class="icon-bar"></span>
	</a>
	<div class="navbar-inner">

	<div class="nav-collapse collapse">
			
		  <ul class="nav">
			<?php foreach ($categories as $category) { ?>
			
			<?php if ($category['children']) { ?>			
			<li class="parent dropdown deeper "><a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
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
	</div>	</div>		  
</div></nav>
<?php } ?>
</section>
<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' ); 
if( $modules ){
?>
<section id="slideshow" class="pav-slideshow">
	<div class="container">
		<?php foreach ($modules as $module) { ?>
			<?php echo $module; ?>
		<?php } ?>
	</div>
</section>
<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'showcase' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_showcase'])&& $config['block_showcase']?(int)$config['block_showcase']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-showcase" id="pavo-showcase">
			<div class="container">
				<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if( $i++%$cols == 0 || count($modules)==1  ){  $j=1;?><div class="row-fluid"><?php } ?>	
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
				<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>
				<?php  $j++;  } ?>
			</div>
		</section>
<?php } ?>
<?php

$modules = $helper->getModulesByPosition( 'promotion' ); 
$ospans = array();

if( count($modules) ){
$cols = isset($config['block_promotion'])&& $config['block_promotion']?(int)$config['block_promotion']:count($modules);	
$class = $helper->calculateSpans( $ospans, $cols );
?>
<section class="pav-promotion" id="pav-promotion">
	<div class="container">
	<?php $j=1;foreach ($modules as $i =>  $module) {  ?>
			<?php if( $i++%$cols == 0 || count($modules)==1 ){  $j=1;?><div class="row-fluid"><?php } ?>	
			<div class="<?php echo $class[$j];?>"><?php echo $module; ?></div>
			<?php if( $i%$cols == 0 || $i==count($modules) ){ ?></div><?php } ?>	
	<?php  $j++;  } ?>	
		</div>
</section>
<?php } ?>
<section id="sys-notification"><div class="container">

	<?php if ($error) { ?>    
    <div class="warning"><?php echo $error ?><img src="market/view/theme/default/image/close.png" alt="" class="close" /></div>    
	<?php } ?>


	<div id="notification"></div>
</div></section>
<section id="columns">
<div class="container">

<div class="row-fluid">