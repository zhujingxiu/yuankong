<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
  	<div class="span<?php echo $SPAN[0];?> aside">
  		  <?php echo $column_left; ?>
  	</div>
    <?php endif; ?> 
    <div class="<?php echo $SPAN[1];?> article">
        <?php echo $content_top; ?>
        <div id="content" class="userbox2">
            <h2><?php echo $text_my_account; ?></h2>
            <div class="content">
                <ul>
                  <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
                  <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
                  <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
                </ul>
            </div>
            <h2><?php echo $text_my_tracking; ?></h2>
            <div class="content">
                <ul>
                  <li><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
                </ul>
            </div>
            <h2><?php echo $text_my_transactions; ?></h2>
            <div class="content">
                <ul>
                  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                </ul>
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