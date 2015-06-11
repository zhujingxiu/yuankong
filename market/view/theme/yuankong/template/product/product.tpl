<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

  $themeConfig = $this->config->get('themecontrol');
  $productConfig = array(
      'product_enablezoom'=>1,
      'product_zoommode'  => 'basic',
      'product_zoomeasing' => 1,
      'product_zoomlensshape' => "round",
      'product_zoomlenssize' => "150",
      'product_zoomgallery'  => 0,
        
  );
  $productConfig = array_merge( $productConfig, $themeConfig );
	$listConfig = array( 
		
		'category_pzoom' => 0
	); 

	$listConfig = array_merge( $listConfig, $themeConfig );	
	$categoryPzoom = $listConfig['category_pzoom'];  
?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="row-fluid">
<?php if( $SPAN[0] ): ?>
	<div class="span<?php echo $SPAN[0];?>">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="span<?php echo $SPAN[1];?>">

<div id="content"><?php echo $content_top; ?>

<div class="wrap-product"> 
  <div class="product-info"><div class="row-fluid">
    <?php if ($thumb || $images) { ?>
    <div class="span6 product-img-box image-container">
 	<?php if( $special )  { ?>
          <div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
        <?php } ?>
        <?php if ($thumb) { ?>
        <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox">
          <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image"  data-zoom-image="<?php echo $popup; ?>" class="product-image-zoom"/></a></div>
        <?php } ?>
        <?php if ($images) { ?>
        <div class="image-additional slide carousel" id="image-additional"><div class="carousel-inner">
				<?php 
				if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
					$eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
					$images = array_merge( $eimages, $images );
				}
				$icols = 3; $i= 0;
				foreach ($images as  $image) { ?>
					<?php if( (++$i)%$icols == 1 ) { ?>
					<div class="item">
					<?php } ?>

				      <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox" data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
				        <img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $this->config->get('config_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom" />
				      </a>
					  <?php if( $i%$icols == 0 || $i==count($images) ) { ?>
					  	</div>
				  <?php } ?>
				<?php } ?>
			</div>
         		<div class="carousel-control left" href="#image-additional" data-slide="prev">&lsaquo;</div>
				<div class="carousel-control right" href="#image-additional" data-slide="next">&rsaquo;</div>
        </div>
        	

        	<script type="text/javascript">
        		$('#image-additional .item:first').addClass('active');
        		$('#image-additional').carousel({interval:false})
        	</script>

        <?php } ?>
     
         </div>
    <?php } ?>
    <div class="span6 product-shop">
		<h1><?php echo $heading_title; ?></h1>
		<?php if ($review_status) { ?>
		<div class="review">
			<div><img src="market/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
		</div>
		
		<?php } ?>
		<div class="description">
			<?php if ($manufacturer) { ?>
			<span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
			<?php } ?>
			<span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
			<?php if ($reward) { ?>
			<span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
			<?php } ?>
			<span><?php echo $text_stock; ?></span> <?php echo $stock; ?>
		</div>
		
		<?php if ($price) { ?>
		<div class="price"><?php echo $text_price; ?>
			<?php if (!$special) { ?>
			<?php echo $price; ?>
			<?php } else { ?>
			<span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
			<?php } ?>
			<br />
			<?php if ($tax) { ?>
			<span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
			<?php } ?>
			<?php if ($points) { ?>
			<span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
			<?php } ?>
			<?php if ($discounts) { ?>
			<br />
			<div class="discount">
			  <?php foreach ($discounts as $discount) { ?>
			  <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
			  <?php } ?>
			</div>
			<?php } ?>
		</div>
		<?php } ?>



		<?php if ($profiles): ?>
		<div class="option">
		<h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
		<br />
		<select name="profile_id">
		  <option value=""><?php echo $text_select; ?></option>
		  <?php foreach ($profiles as $profile): ?>
		  <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
		  <?php endforeach; ?>
		</select>
		<br />
		<br />
		<span id="profile-description"></span>
		<br />
		<br />
		</div>
		<?php endif; ?>


		
		<?php if ($options) { ?>
		<div class="options">
			<h2><?php echo $text_option; ?></h2>
			<?php foreach ($options as $option) { ?>
			<?php if ($option['type'] == 'select') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b>
					<select name="option[<?php echo $option['product_option_id']; ?>]">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</option>
						<?php } ?>
					</select>
				</div>
			<br />
			<?php } ?>
			<?php if ($option['type'] == 'radio') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
					<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<?php foreach ($option['option_value'] as $option_value) { ?>
				<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
				<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
				<?php if ($option_value['price']) { ?>
					(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
				<?php } ?>
				</label>
				<br />
				<?php } ?>
			</div>
		
			<br />
			<?php } ?>
			<?php if ($option['type'] == 'checkbox') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<?php foreach ($option['option_value'] as $option_value) { ?>
				<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
				<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
				<?php if ($option_value['price']) { ?>
				(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
				<?php } ?>
				</label>
				<br />
				<?php } ?>
			</div>
			<br />
			<?php } ?>
			<?php if ($option['type'] == 'image') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<table class="option-image">
				<?php foreach ($option['option_value'] as $option_value) { ?>
					<tr>
						<td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
						<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
						<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
							<?php if ($option_value['price']) { ?>
							(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
							<?php } ?>
							</label>
						</td>
					</tr>
				<?php } ?>
				</table>
			</div>
			<br />
			<?php } ?>
			
			<?php if ($option['type'] == 'text') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
			</div>
			<br />
			<?php } ?>
			
			<?php if ($option['type'] == 'textarea') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
			</div>
			<br />
			<?php } ?>
			
			<?php if ($option['type'] == 'file') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
				<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
			</div>
			<br />
			<?php } ?>
			
			<?php if ($option['type'] == 'date') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
			</div>
			<br />
			<?php } ?>
		
			<?php if ($option['type'] == 'datetime') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
			</div>
			<br />
			<?php } ?>
			
			<?php if ($option['type'] == 'time') { ?>
			<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
				<?php if ($option['required']) { ?>
				<span class="required">*</span>
				<?php } ?>
				<b><?php echo $option['name']; ?>:</b>
				<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
			</div>
			<br />
			<?php } ?>
        <?php } ?>
		</div>
		<?php } ?>
		
		<div class="cart">
			<div class="quantity-adder pull-left"><?php echo $text_qty; ?>
				<input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" class="qty" />
				<input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
				&nbsp;
			
				<span class="add-up add-action"><span class="icon-caret-up"></span></span>
				<span class="add-down add-action"><span class="icon-caret-down"></span></span>
			</div>
			<input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />	
			<?php if ($minimum > 1) { ?>
			<div class="minimum clearfix"><?php echo $text_minimum; ?></div>
			<?php } ?>
		</div>
		<div class="links button_wishlist"><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a></div>
        <div class="links button_compare"><a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></div>
		<div class="links share">
			<div class="wrap-share"> <!-- AddThis Button BEGIN -->
				<div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
				<script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
				<!-- AddThis Button END --> 
			</div>	
		</div>
		
	  
    </div>
	

	
	</div>
  </div>
<div class="wrap-tabs">	
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content  product-grid">
    <div class="box-product">
		<?php	$max_related_column = 4; 
	if( isset($productConfig['product_related_column']) && $productConfig['product_related_column'] ){
		$max_related_column = $productConfig['product_related_column'];
	}
  $cols = $max_related_column;
	$ispan = 12/$cols; ?>
		<?php foreach ($products as $i => $product) { ?>
			<?php if( ($i+1)%$cols == 1 ) {  ?>
			<div class="row-fluid box-product">
			<?php } ?>
			<div class="span<?php echo $ispan;?> product_block <?php if($i % $cols == 0) { echo "first";} ?>">
				<div class="product-inner">
				<?php if ($product['thumb']) { ?>
				<div class="image"> <?php if( $product['special'] ) {   ?>
    	<span class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></span>
    	<?php } ?>
		<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
		<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
			<a href="<?php echo $zimage;?>" class="colorbox product-zoom" rel="colorbox" title="<?php echo $product['name']; ?>"><span class="icon-zoom-in"></span></a>
			<?php } ?></div>
				<?php } ?>
				<div class="wrap-infor">
					<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
					<?php if ($product['price']) { ?>
					<div class="price">
					  <?php if (!$product['special']) { ?>
					  <?php echo $product['price']; ?>
					  <?php } else { ?>
					  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
					  <?php } ?>
					</div>
					<?php } ?>
					<?php if ($product['rating']) { ?>
					<div class="rating"><img src="market/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
					<?php } ?>
					<div class="action">
						<div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $this->language->get("button_wishlist"); ?></a></div>
						<div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $this->language->get("button_compare"); ?></a></div>
					</div>
					<div class="cart">
						<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
					</div>
				</div>  
				</div>
			</div>
		<?php $i=$i+1; if( $i % $cols == 0 || $i == count($products) ) { ?>
			</div>
		<?php } ?>		
		
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  </div>
 </div> 
 
  <?php echo $content_bottom; ?></div>
  <?php if( $productConfig['product_enablezoom'] ) { ?>

<script type="text/javascript" src=" market/view/theme/<?php echo $this->config->get('config_template'); ?>/javascript/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
 <?php if( $productConfig['product_zoomgallery'] == 'slider' ) {  ?>
  $("#image").elevateZoom({gallery:'image-additional', cursor: 'pointer', galleryActiveClass: 'active'}); 
  <?php } else { ?>
  var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
   $( zoomCollection ).elevateZoom({
      <?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
      zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
      <?php } ?>
      lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
      lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
  
   });
  <?php } ?> 
</script>
<?php } ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script> 


<script type="text/javascript"><!--

	$('select[name="profile_id"], input[name="quantity"]').change(function(){
	    $.ajax({
			url: 'index.php?route=product/product/getRecurringDescription',
			type: 'post',
			data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
			dataType: 'json',
	        beforeSend: function() {
	            $('#profile-description').html('');
	        },
			success: function(json) {
				$('.success, .warning, .attention, information, .error').remove();
	            
				if (json['success']) {
	                $('#profile-description').html(json['success']);
				}	
			}
		});
	});
	    
	$('#button-cart').bind('click', function() {
		$.ajax({
			url: 'index.php?route=checkout/cart/add',
			type: 'post',
			data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
			dataType: 'json',
			success: function(json) {
				$('.success, .warning, .attention, information, .error').remove();
				
				if (json['error']) {
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
						}
					}
	                
	                if (json['error']['profile']) {
	                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
	                }
				} 
				
				if (json['success']) {
					$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="market/view/theme/default/image/close.png" alt="" class="close" /></div>');
						
					$('.success').fadeIn('slow');
						
					$('#cart-total').html(json['total']);
					
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
			}
		});
	});

//--></script>


<?php if ($options) { ?>
<script type="text/javascript" src="market/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="market/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="market/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 

</div> 
<?php if( $SPAN[2] ): ?>
<div class="span<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>
<?php echo $footer; ?>
