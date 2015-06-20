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
<div class="w mt10">
	<div class="shopdetail-box fix">
        <div class="l shoppic-box">
            <div class="jqzoom" id="spec-n1">
                <img class="sdetail-pic" src="<?php echo $thumb; ?>" jqimg="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>">
            </div>
            <div id="spec-n5" class="spec-n5 mt15">
                <span class="icon2 oncl"></span>
                <span class="icon2 oncr"></span>
                <div id="spec-list">
                    <ul class="list-h">
                    	<?php if ($images): ?>
                    	<?php foreach ($images as $key => $item): ?>
                    	<li><img src="<?php echo $item['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"></li>		
                    	<?php endforeach ?>
                    	<?php endif ?>
                    </ul>
                </div>
            </div>
        </div>
        <div class="shopd-news c3">
            <div class="shopd-name">
                <h2><b><?php echo $heading_title; ?></b></h2>
                <p><?php echo $subtitle ?></p>
            </div>
            <?php if ($price) { ?>
            <div class="shopd-price f_m mt10">
            	<?php if ($tax) { ?>
				<p class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></p>
				<?php } ?>
				<?php if ($points) { ?>
				<p class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></p>
				<?php } ?>
				<?php if (!$special) { ?>
			    <p><?php echo $text_price; ?><b class="price c_red pl10"><?php echo $price; ?></b> </p>
                <p class="pt5">市场价:<em class="pl10 c8">￥123456.00</em> </p>
				<?php } else { ?>
				<p class="price-old"><?php echo $price; ?></p> 
				<p class="price-new"><?php echo $special; ?></p>
				<?php } ?>
				<?php if ($discounts) { ?>

				<p class="discount">
				  <?php foreach ($discounts as $discount) { ?>
				  <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?>
				  <?php } ?>
				</p>
				<?php } ?>
            </div>
            <?php }?>
            <ul class="shop-other-news mt20">
				<?php if ($manufacturer) { ?>
				<li class="fix">
					<span><?php echo $text_manufacturer; ?></span> 
					<a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a>
				</li>
				<?php } ?>
				<li class="fix">
					<span><?php echo $text_model; ?></span> <?php echo $model; ?>
				</li>
				<li class="fix">
					<span><?php echo $text_stock; ?></span> <?php echo $stock; ?>
				</li>
                <?php if ($options) { ?>
				<li class="fix">
					<span class="label-n"><?php echo $text_option; ?></span>
					<?php foreach ($options as $option) { ?>
					<?php if ($option['type'] == 'select') { ?>
						<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
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
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
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
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
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
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<img src="imgs/adimg/sdetail1.jpg"></span>
								<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
								<span class="xh-pic hov" title="<?php if ($option_value['price']) { ?>
									(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
									<?php } ?>"><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></span>
								
						<?php } ?>
					</div>
					<br />
					<?php } ?>
					
					<?php if ($option['type'] == 'text') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
					</div>
					<br />
					<?php } ?>
					
					<?php if ($option['type'] == 'textarea') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
					</div>
					<br />
					<?php } ?>
					
					<?php if ($option['type'] == 'file') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
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
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
					</div>
					<br />
					<?php } ?>
				
					<?php if ($option['type'] == 'datetime') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
					</div>
					<br />
					<?php } ?>
					
					<?php if ($option['type'] == 'time') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
					</div>
					<br />
					<?php } ?>
		        <?php } ?>
				</li>
				<?php } ?>
                <li class="fix">
                    <span class="label-n"><?php echo $text_qty; ?></span>
                    <div class="s-buy-num">
                        <a href="javascript:void(0)" class="addnum">+</a>
                        <a href="javascript:void(0)" class="jiannum">-</a>
                        <input type="text" name="quantity" value="1" class="snum">
						<input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
                    </div>
                </li>
                <li class="fix">
                    <span class="label-n">配送至:</span>
                    <div class="rel l">
                        <div class="defalt-adtree">
                        	<span class="adtress-text">江苏省-苏州市</span><i class="icon2 h-down"></i>
                        </div>
                    </div>
                    <span class="l pl20 mt5">
                    	<img style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&amp;sid=3197104626&amp;o=yk119.cn&amp;q=7', '_blank', 'height=502, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" border="0" src="<?php echo TPL_IMG ?>data/yuankong/qq.png" alt="点击这里给我发消息">
                    </span>
                </li>
                <li class="fix">
                    <input type="button" id="button-cart"  class="gc-tab-sub w150"value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');">
                    <input type="button" id="button-buynow" class="gc-tab-sub2 w150 ml20" value="<?php echo $button_buynow ?>">
                    <?php if ($minimum > 1) { ?>
					<div class="minimum clearfix"><?php echo $text_minimum; ?></div>
					<?php } ?>
                </li>
                <?php if (false): ?>
                <li class="fix">
					<?php if ($review_status) { ?>
					<div class="review">
						<div><img src="market/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
					</div>
					<?php } ?>
					<div class="links button_wishlist">
						<a onclick="addToWishList('<?php echo $product_id ?>');"><?php echo $button_wishlist ?></a>
					</div>
			        <div class="links button_compare">
			        	<a onclick="addToCompare('<?php echo $product_id ?>');"><?php echo $button_compare ?></a>
			        </div>
				</li>
                <?php endif ?>
            </ul>
        </div>
    </div>
</div>
<div class="w mt10 fix">
	<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?>">
		<?php echo $column_left; ?>
	</div>
	<?php endif; ?> 
	<div class="<?php echo $SPAN[1];?>"><?php echo $content_top; ?>

		<ul class="detail-n-title fix">
            <li class="taboff tabon"><?php echo $tab_description; ?></li>
            <li class="taboff">成交记录</li>
            <?php if ($attribute_groups) { ?>
		    <li class="taboff"><?php echo $tab_attribute; ?></li>
		    <?php } ?>
		    <?php if ($review_status) { ?>
		    <li class="taboff"><?php echo $tab_review; ?></li>
		    <?php } ?>
        </ul>

  		<div class="ovh detailbox">
			<div id="tab-description" class="d-boxes">
				<?php echo $description; ?>
			</div>
			<div id="tab-records" class="d-boxes"></div>
			<?php if ($attribute_groups) { ?>
		  	<div id="tab-attribute" class="d-boxes">
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
		    <div id="tab-review" class="d-boxes"></div>
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
  		<?php echo $content_bottom; ?>
	</div>
</div>
<script type="text/javascript"><!--
	
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

<script type="text/javascript"><!--
	
    $(function(){
        o.moushov.init(".detail-n-title li",".d-boxes");
        o.add.init(".s-buy-num");
        $(".jqzoom").jqueryzoom({
            xzoom:508,
            yzoom:508,
            offset:0,
            position:"right",
            preload:1,
            lens:1
        });
        $("#spec-list li img").hover(function(){
            var src=$(this).attr("src");
            $("#spec-n1 img").eq(0).attr({
                src:src.replace("\/n5\/","\/n1\/"),
                jqimg:src.replace("\/n5\/","\/n0\/")
            });
            $(this).parent().addClass("on");
        },function(){
            $(this).parent().removeClass("on");
        });
        o.lrclick.init("#spec-n5")
    });

//--></script>
<?php if( $SPAN[2] ): ?>
<div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>
<?php echo $footer; ?>
