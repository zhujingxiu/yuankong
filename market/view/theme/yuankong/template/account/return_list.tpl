<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
  	<div class="<?php echo $SPAN[0];?> aside">
  		<?php echo $column_left; ?>
  	</div>
    <?php endif; ?> 
    <div class="<?php echo $SPAN[1];?> article">
        <?php echo $content_top; ?>
        <div id="content" class="userbox2">
            <div class="userboxtop">
                <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
            </div>
            <h1 class="page-title" ><?php echo $heading_title; ?></h1>
            <div class="page-content">
                <?php if ($returns) { ?>
                <?php foreach ($returns as $return) { ?>
                <div class="return-list">
                  <div class="return-id"><b><?php echo $text_return_id; ?></b> #<?php echo $return['return_id']; ?></div>
                  <div class="return-status"><b><?php echo $text_status; ?></b> <?php echo $return['status']; ?></div>
                  <div class="return-content">
                    <div><b><?php echo $text_date_added; ?></b> <?php echo $return['date_added']; ?><br />
                      <b><?php echo $text_order_id; ?></b> <?php echo $return['order_id']; ?></div>
                    <div><b><?php echo $text_customer; ?></b> <?php echo $return['name']; ?></div>
                    <div class="return-info"><a href="<?php echo $return['href']; ?>"><img src="market/view/theme/default/image/info.png" alt="<?php echo $button_view; ?>" title="<?php echo $button_view; ?>" /></a></div>
                  </div>
                </div>
                <?php } ?>
                <div class="pagination"><?php echo $pagination; ?></div>
                <?php } else { ?>
                <div class="content"><?php echo $text_empty; ?></div>
                <?php } ?>
                <div class="buttons">
                  <div class="right">
                      <a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a>
                  </div>
                </div>
            </div>
            <?php echo $content_bottom; ?>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="span<?php echo $SPAN[2];?>">	
    	<?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div>
<?php echo $footer; ?>