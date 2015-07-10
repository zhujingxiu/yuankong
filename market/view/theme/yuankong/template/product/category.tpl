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
    <?php if(false){?>
	<div class="title">
		<h1 class="category-title">
            <?php echo $heading_title; ?>
            <span><?php echo ' | There are '.count($products).' products'; ?></span>
        </h1>
		<div class="product-compare">
            <a href="<?php echo $compare; ?>" id="compare-total">
                <?php echo $text_compare; ?>
            </a>
        </div>
	</div>
	<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/category-info.tpl" ); ?>
    <?php }?>
    <div class="ovh">
        <a href="#"><img src="<?php echo TPL_IMG ?>data/banner/adpic2.jpg" /></a>
    </div>
    <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/product/product-filter.tpl" ); ?>
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
<?php echo $footer; ?>