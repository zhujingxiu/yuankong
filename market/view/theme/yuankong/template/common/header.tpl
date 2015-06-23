<?php 
	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
 
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
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/common.js"></script>

<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<!--[if lt IE 9]>
<script src="market/view/javascript/html5.js"></script>
<![endif]-->

<!--[if IE ]>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery.placeholder.js"></script>
<script type="text/javascript">
$(function(){ $('input, textarea').placeholder(); });
</script>
<style type="text/css">
	.placeholder{color:#999999;}
</style>
<![endif]-->
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
				<li>
					<?php if (!$logged) { ?>
					<a class="plr" href="<?php echo $login ?>"><?php echo $text_login; ?></a>
					|
					<a class="plr" href="<?php echo $register ?>"><?php echo $text_register; ?></a>
					<?php } else { ?>
					<?php echo $text_logged; ?>
					<?php } ?>
				</li>
				<li class="my-ezhan rel">
					<div class="hd">
						<a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
						<em class="icon2 h-down"></em>
					</div>
					<div class="bd">
						<a href="<?php echo $order ?>"><?php echo $text_order ?></a>
						<a href="<?php echo $profile ?>"><?php echo $text_profile ?></a>
						<a href="<?php echo $message ?>"><?php echo $text_message ?></a>
					</div>
				</li>
				<li>|</li>
				<li class="my-ezhan rel">
					<div class="hd">
						<a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a>
						<em class="icon2 h-down"></em>
					</div>
					<div class="bd">
						<a href="<?php echo $upload ?>"><?php echo $text_upload ?></a>
						<a href="<?php echo $perfact ?>"><?php echo $text_perfact ?></a>
					</div>
				</li>
				<li>|</li>
				<li class="plr"><a href="<?php echo $help ?>"><?php echo $text_help ?></a></li>
				<li>|</li>
				<li class="pl10 cff"><?php echo $text_hotline ?></li>
				<?php if(false){?>
				<li class="top-links">
				<a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
				
				<a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
				<!--a href="<?php //echo $checkout; ?>"><?php //echo $text_checkout; ?></a-->
				<?php //echo $currency; ?>
				<?php //echo $language; ?>					
				<?php } ?>					
				</li>
			</ul>
		</div>
	</div>
</div>
<?php if( isset($themeConfig['custom_top_module']) )  { 
	echo html_entity_decode($themeConfig['custom_top_module'], ENT_QUOTES, 'UTF-8'); 
}?>
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
					<?php if (isset($themeConfig['search']['option'][0])): ?>
					<dt class="search-dt">
                    	<span>
                    		<?php echo $this->language->get('text_search_'.strtolower($themeConfig['search']['option'][0])) ?>
                    	</span>
                    	<input type="hidden" name="search_model" value="<?php echo $themeConfig['search']['option'][0] ?>">
                    	<em class="icon2 h-down"></em>
                    </dt>	
					<?php endif ?>
                    <?php if (isset($themeConfig['search']['option']) && is_array($themeConfig['search']['option'])): ?>
                    <dd class="search-dd">
						<?php foreach ($themeConfig['search']['option'] as $key => $search_option): ?>
						<span class="db" val="<?php echo $search_option ?>"><?php echo $this->language->get('text_search_'.strtolower($search_option)) ?></span>
						<?php endforeach ?>
                    </dd>	
                    <?php endif ?>
                    
                </dl>
				<input type="text" name="search" placeholder="<?php echo isset($themeConfig['search']['placeholder']) ? trim($themeConfig['search']['placeholder']) : $text_search; ?>" value="<?php echo $search ?>" class="l s-text"/>
				<input type="submit" class="l s-sub" value="<?php echo $text_search; ?>" />
			</div>
			<?php if (isset($themeConfig['search']['keyword']) && is_array($themeConfig['search']['keyword'])): ?>
			<p class="pt5 f_s">
				<?php foreach ($themeConfig['search']['keyword'] as $item): ?>
				<a href="<?php echo $item['link'] ?>" class="plr c8 <?php echo empty($item['additional_class']) ? '' : trim($item['additional_class']) ?>">
					<?php echo $item['title'] ?>
				</a>
				<?php endforeach ?>
			</p>	
			<?php endif ?>
			
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
<?php if (false): ?>
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
<?php endif ?>


<?php

$modules = $helper->getModulesByPosition( 'slideshow' ); 

if( $modules ){ ?>

<div id="slideshow" class="w fix mt10">
	
	<?php foreach ($modules as $module) { ?>

		<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'promotion' ); 

if( $modules ){ ?>

<div id="promotion" class="w mt10" >

	<?php foreach ($modules as $module) {  ?>

	<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'showcase' ); 

if( $modules ){ ?>

<div id="showcase" class="w mt15 ovh">

	<?php foreach ($modules as $module) {  ?>

	<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<section id="columns">