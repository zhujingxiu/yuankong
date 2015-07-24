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
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <div class="page-content">
            		  <h4><?php echo $text_password; ?></h4>
                  <table class="form">
                      <tr>
                        <td><span class="required">*</span> <?php echo $entry_password; ?></td>
                        <td><input type="password" name="password" value="<?php echo $password; ?>" />
                          <?php if ($error_password) { ?>
                          <span class="error"><?php echo $error_password; ?></span>
                          <?php } ?></td>
                      </tr>
                      <tr>
                        <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
                        <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
                          <?php if ($error_confirm) { ?>
                          <span class="error"><?php echo $error_confirm; ?></span>
                          <?php } ?></td>
                      </tr>
                  </table>
              </div>
          </form>
          <?php echo $content_bottom; ?>
      </div>
  </div> 
  <?php if( $SPAN[2] ): ?>
  <div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
  </div>
  <?php endif; ?>
</div>
<?php echo $footer; ?>