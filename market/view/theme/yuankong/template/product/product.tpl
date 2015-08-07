<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 product-info" id="product">
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
                    	<li class="on"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"></li>
                    	<?php if ($images): ?>
                    	<?php foreach ($images as $key => $item): ?>
                    	<li >
                            <img src="<?php echo $item['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" <?php echo isset($item['rel']) ? 'data-rel="'.$item['rel'].'"' : ''; ?>/>
                        </li>		
                    	<?php endforeach ?>
                    	<?php endif ?>
                    </ul>
                </div>
            </div>
        </div>
        <div class="shopd-news c3" id="price-block">
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
			    <p><?php echo $text_price; ?>
                    <b id="price-now" class="price c_red pl10"><?php echo $price; ?></b> 
                </p>
				<?php } else { ?>
				<p id="price-old" class="price-old"><?php echo $price; ?></p> 
				<p id="price-special" class="price-new"><?php echo $special; ?></p>
				<?php } ?>
                <p class="pt5"><?php echo $text_market ?><em class="pl10 c8"><?php echo $market ?></em> </p>
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
                <?php if ($options) { ?>
				<li class="fix">					
					<?php foreach ($options as $option) { ?>
					<?php if ($option['required'] && false) { ?>
					<span class="required">*</span>
					<?php } ?>
					<label class="label-n"><?php echo $option['name']; ?>:</label>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="xh-style">
					<?php if ($option['type'] == 'select') { ?>		
						<select name="option[<?php echo $option['product_option_id']; ?>]" class="option-fix-price">
							<option value=""><?php echo $text_select; ?></option>
							<?php foreach ($option['option_value'] as $option_value) { ?>
							<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
							<?php if ($option_value['price']) { ?>
							(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
							<?php } ?>
							</option>
							<?php } ?>
						</select>
					<?php } ?>
					<?php if ($option['type'] == 'radio') { ?>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" class="option-fix-price"/>
						<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
							(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</label>
						<br />
						<?php } ?>
					<?php } ?>
					<?php if ($option['type'] == 'checkbox') { ?>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" class="option-fix-price"/>
						<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</label>
						<br />
						<?php } ?>
					<?php } ?>
					<?php if ($option['type'] == 'image') { ?>
						<?php foreach ($option['option_value'] as $ovkey => $option_value) { ?>
						<span class="xh-pic <?php echo $ovkey ? '' : 'hov'; ?>" title="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>">
							<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>">
								<img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" />
							</label>
							<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" style="display:none" class="option-fix-price" <?php echo $ovkey ? '' : 'checked="checked"'; ?>/>
						</span>
						<?php } ?>
					<?php } ?>
					
					<?php if ($option['type'] == 'text') { ?>						
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
					<?php } ?>
					
					<?php if ($option['type'] == 'textarea') { ?>
						<textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
					<?php } ?>
					
					<?php if ($option['type'] == 'file') { ?>
						<input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
						<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
					<?php } ?>
					
					<?php if ($option['type'] == 'date') { ?>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
					<?php } ?>
				
					<?php if ($option['type'] == 'datetime') { ?>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
					<?php } ?>
					
					<?php if ($option['type'] == 'time') { ?>
						<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
					
					<?php } ?>
					</div>
		        <?php } ?>
				</li>
				<?php } ?>
                <li class="fix">
                    <span class="label-n"><?php echo $text_qty; ?></span>
                    <div class="s-buy-num">
                        <a href="javascript:void(0)" class="addnum">+</a>
                        <a href="javascript:void(0)" class="jiannum">-</a>
                        <input type="text" name="quantity" value="1" class="snum">
						<input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                    </div>
                </li>
                <li class="fix">
                    <span class="label-n">配送至:</span>
                    <div class="rel l" id="location-delivery">
                        <div class="defalt-adtree area-text">
                        	<span class="adtress-text">江苏省-苏州市</span><b></b>
                        </div>
                        <div class="area-content"></div>
                        <div onclick="$('#location-delivery').removeClass('hover')" class="close"></div>
                        <div id="location-prompt"></div>
                    </div>
                    <span class="l pl20 mt5">
                    	<img style="CURSOR: pointer" onclick="javascript:window.open('http://b.qq.com/webc.htm?new=0&sid=3197104626&o=yk119.cn&q=7', '_blank', 'height=502, width=644,toolbar=no,scrollbars=no,menubar=no,status=no');" border="0" src="<?php echo TPL_IMG ?>data/yuankong/qq.png" alt="点击这里给我发消息">
                    </span>
                </li>
                <li class="fix">
                    <input type="button" id="button-cart"  class="gc-tab-sub w150"value="<?php echo $button_cart; ?>">
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
		<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/category-related.tpl" ); ?>
		<?php echo $column_left; ?>
	</div>
	<?php endif; ?> 
	<div class="<?php echo $SPAN[1];?>"><?php echo $content_top; ?>

		<ul class="detail-n-title fix">
            <li class="taboff tabon"><?php echo $tab_description; ?></li>
            <li class="taboff">成交记录</li>
		    <?php if ($review_status) { ?>
		    <li class="taboff"><?php echo $tab_review; ?></li>
		    <?php } ?>
		    <?php if ($tags) { ?>
		    <li class="taboff"><?php echo $text_tags; ?></li>
		    <?php } ?>
        </ul>

  		<div class="ovh detailbox">
			<div id="tab-description" class="d-boxes">
				<?php echo $description; ?>
			</div>
			<div id="tab-records" class="d-boxes" style="display:none;"></div>
			<?php if ($review_status) { ?>
		    <div id="tab-reviews" class="d-boxes" style="display:none;"></div>
		    <?php } ?>	
		  	<?php if ($tags) { ?>
		  	<div id="tab-tags" class="d-boxes" style="display:none;">
		  		<b><?php echo $text_tags; ?></b>
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
	$('#button-buynow').bind('click',function(){
		$.ajax({
			url: 'index.php?route=checkout/checkout/add',
			type: 'post',
			data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
			dataType: 'json',
			success: function(json) {
				$('.msg-success, .warning, .attention, information, .error').remove();
				
				if (json['error']) {
					if (json['error']['option']) {
						for (i in json['error']['option']) {
							$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
						}
					}
				} 
                if(json['redirect']){
                <?php if(!$this->customer->isLogged()){?>
			        $('#tm-mask').show();
                    $('.iframe-login').show().focus();
                    $('#mini-login input[name="redirect"]').val(json['redirect'])
                <?php }else{?>                
                    location.href = json['redirect'];                
                <?php }?>
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
				} 
				
				if (json['success']) {
					$('#notification').html('<div class="msg-success" style="display: none;">' + json['success'] + '<img src="market/view/theme/default/image/close.png" alt="" class="close" /></div>');
						
					$('.msg-success').fadeIn('slow');
						
					$('#cart-total').html(json['total']);
					
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
			}
		});
	});
    $('#tab-records').load('index.php?route=product/product/transaction&product_id=<?php echo $product_id ?>');
    <?php if ($review_status) { ?>
    $('#tab-reviews').load('index.php?route=product/product/review&product_id=<?php echo $product_id ?>');
    <?php }?>
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
        o.lrclick.init("#spec-n5");
        live_price();
    });

//--></script>
<?php if( $SPAN[2] ): ?>
<div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>

<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<script type="text/javascript">
$(document).on('click','#tm-mask',function(){
    $('.iframe-login').hide();
    $('#tm-mask').hide();
  }).on('keydown',function(e){
    if(e.which === 27) {
      $('.iframe-login').hide();
      $('#tm-mask').hide();
    }
    if (e.keyCode == 13) {
      $('#mini-login').submit();
    }
  });
</script>
<?php echo $footer; ?>
