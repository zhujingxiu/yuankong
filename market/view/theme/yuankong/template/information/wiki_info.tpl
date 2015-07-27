<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">
<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?>">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?>">

  <?php echo $content_top; ?>

  <div class="bkbox">
    <div class="bkbox-title c9">
      <h2><?php echo $heading_title; ?></h2>
      <p class="tc f_m">
        <span class="plr"><?php echo $text_date_modified ?><?php echo $date_added ?></span>
        <span class="plr"><?php echo $text_viewed ?><?php echo $viewed ?></span>
      </p>
    </div>
    <div class="newsdetail pt15"><?php echo $description; ?></div>
  </div>
  
  <?php echo $content_bottom; ?>
</div> 

</div>
<?php echo $footer; ?>