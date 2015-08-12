<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">

<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?>">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?> category ">
	
	<div class="ovh"><?php echo $content_top; ?></div>

  <div class="chose-style mt10 f_m">
  
    <p class="paix-chose">
      <a href="<?php echo $sort_order ?>">
        <span class="paix-li <?php echo $sort_on == 'sort_order' ? 'pon' : ''?>">
        <?php echo $text_sort_default; ?>
        </span> 
      </a>
      <a href="<?php echo $sort_price ?>">
        <span class="paix-li <?php echo $sort_on == 'price' ? 'pon' : ''?>">
        <?php echo $text_sort_price; ?>
        </span> 
      </a>
      <a href="<?php echo $sort_sales ?>">
        <span class="paix-li <?php echo $sort_on == 'sales' ? 'pon' : ''?>">
        <?php echo $text_sort_sales; ?>
        </span> 
      </a>
    </p>

    <p class="jg-shaix"><b><?php echo $text_limit; ?></b>
        <?php if(false){ ?>
        <select onchange="location = this.value;" style="display:none">
          <?php foreach ($limits as $limits) { ?>
          <?php if ($limits['value'] == $limit) { ?>
          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
        <?php }?>
        <input type="text" class="price-text" name="min_price" value="<?php echo $min_price ?>" placeholder="￥">
        <em class="pl10 pr10">-</em>
        <input type="text" class="price-text" name="max_price" value="<?php echo $max_price ?>" placeholder="￥">

        <button onclick="price_filter();" class="price-sub"><?php echo $button_submit ?></button>
    </p>
    <?php if($total_page){?>
    <p class="top-page">
        <a href="<?php echo $prev_link ?>" class="icon2 page-l"></a>
        <span class="pl10 pr10">
          <em class="cff"><?php echo $page ?></em>/<em class="cff"><?php echo $total_page ?></em>
        </span>
        <a href="<?php echo $next_link ?>" class="icon2 page-r"></a>
    </p>
    <?php }?>
  </div>
	<?php if ($products) { ?>
		
		<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/product-list.tpl" ); ?>
	<?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>

</div> 
<?php if( $SPAN[2] ): ?>
<div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>
<script type="text/javascript">
  function price_filter(){
    var url = '<?php echo $filter_action ?>';
    var min_price = $('.jg-shaix input[name="min_price"]').val();
    var max_price = $('.jg-shaix input[name="max_price"]').val();
    if(min_price>0){
      url += '&min_price='+min_price;
    }
    if(max_price>0){
      url += '&max_price='+max_price;
    }
    location = url;
  }
</script>
<?php echo $footer; ?>