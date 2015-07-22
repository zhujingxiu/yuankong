<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
  	<div class="<?php echo $SPAN[0];?> aside">
  		<?php echo $column_left; ?>
  	</div>
    <?php endif; ?> 
    <?php echo $content_top; ?>
    <div class="<?php echo $SPAN[1];?> article">
        <div class="userboxtop">
            <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
        </div>
        <div id="content" class="userbox2">
            <h4><?php echo $text_address_book; ?></h4>
            <?php foreach ($addresses as $result) { ?>
            <div class="page-content">
                <table style="width: 100%;">
                    <tr>
                      <td><?php echo $result['address']; ?></td>
                      <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button"><?php echo $button_edit; ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button"><?php echo $button_delete; ?></a></td>
                    </tr>
                </table>
            </div>
            <?php } ?>
            <div class="buttons">
                <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
                <div class="right"><a href="<?php echo $insert; ?>" class="button"><?php echo $button_new_address; ?></a></div>
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