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
<meta property="qc:admins" content="3557373151613111636" />
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

<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/yk.css" />
</head>
<body class="b_fa">
<!--Top-->

<?php echo $top ?>

<!--Top-->
<div class="<?php echo $container_class ?>">
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
		<?php if($container_class=="w"){?>
		<?php echo $cart; ?>
		<?php }?>
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
	<div class="notification w mt10">
		<?php if (!empty($error)){ ?>    
	    <div class="msg-warning"><?php echo $error ?>
	    	<img src="market/view/theme/default/image/close.png" class="close" />
	    </div>    
		<?php } ?>
		<?php if (!empty($success)) { ?>    
	    <div class="msg-success"><?php echo $success ?>
	    	<img src="market/view/theme/default/image/close.png" class="close" />
	    </div>    
		<?php } ?>
		<div id="notification"></div>
	</div>
</section>

<?php

$modules = $helper->getModulesByPosition( 'slideshow' ); 

if( $modules ){ ?>

<div id="slideshow" class="<?php echo $container_class ?> fix mt10">
	
	<?php foreach ($modules as $module) { ?>

		<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'promotion' ); 

if( $modules ){ ?>

<div id="promotion" class="<?php echo $container_class ?> mt10" >

	<?php foreach ($modules as $module) {  ?>

	<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<?php

$modules = $helper->getModulesByPosition( 'showcase' ); 

if( $modules ){ ?>

<div id="showcase" class="<?php echo $container_class ?> mt15 ovh">

	<?php foreach ($modules as $module) {  ?>

	<?php echo $module; ?>

	<?php } ?>

</div>

<?php } ?>

<section id="columns">