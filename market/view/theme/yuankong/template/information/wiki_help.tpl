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
        <span class="tw_xian"><?php echo $text_account ?><b><?php echo $account ?></b></span>
        <span class="tw_xian"><?php echo $text_date_modified ?><?php echo $date_added ?></span>
      </p>
      
    </div>
    <div class="tiwen2 mt10">
        <h1 class="z_daan">E站在线</h1>
        <div class="nr_detail"><?php echo $reply ?></div>
    </div>
    <div class="xg_wenti mt10">
      <h3 class="xg_wenti1">相关问题</h3>
      <ul>
          <li><a href="#">西安赛格电脑城配了PSP充电器，走的时候给我说7天包换，但是没给我开发票</a><span>2011-12-13</span></li>
          <li><a href="#">金湖天地一共有多少栋建筑啊？哪一个位置比较好点？</a><span>2011-2-1</span></li>
          <li><a href="#">大家觉得湖东的房子除了金湖湾，最好的普通住它小区是？</a><span>2011-1-3</span></li>
          <li><a href="#">.0回答天津有像西安赛格，轻工和康复路这样的地方吗？具体地址啥，请告诉我</a><span>2011-7-10</span></li>
          <li><a href="#">.3回答请知道的朋友介绍几家西安钟楼到赛格电脑商城附近的好的酒吧</a><span>2011-8-13</span></li>
          <li><a href="#">西安赛格电脑城配了PSP充电器，走的时候给我说7天包换，但是没给我开发票</a><span>2011-10-13</span></li>
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