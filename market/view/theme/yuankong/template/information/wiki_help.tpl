<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">
<?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?>">
        <?php echo $column_left; ?>
    </div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?> askdetail l">
    <?php echo $content_top; ?>
    <div class="tiwen">
      <p class="nr_detail"><?php echo $text ?></p>
      <p class="tw_detail">
        <span class="tw_xian"><?php echo $text_account ?><?php echo $account ?></span>
        <span class="tw_xian"><?php echo $text_date_modified ?><?php echo $date_added ?></span>
      </p>
      
    </div>
    <div class="tiwen2 mt10">
        <h1 class="z_daan">消防e站</h1>
        <div class="nr_detail"><?php echo $reply ?></div>
    </div>
    <div class="xg_wenti mt10">
      <h3 class="xg_wenti1">相关问题</h3>
      <ul>
          <?php foreach ($relateds as $item): ?>
          <li><a href="<?php echo $item['link'] ?>"><span><?php echo truncate_string($item['text']) ?></span></a><span><?php echo $item['date_added'] ?></span></li>
          <?php endforeach ?>
      </ul>
    </div>
  
  <?php echo $content_bottom; ?>
</div> 
<?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div>
<?php echo $footer; ?>