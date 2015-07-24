<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
	  <div class="<?php echo $SPAN[0];?> aside">
		<?php echo $column_left; ?>
	  </div>
    <?php endif; ?>
    <div class="<?php echo $SPAN[1];?> article">
        <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        <?php echo $content_top; ?>
        <div id="content" class="userbox2">
            <div class="userboxtop">
              <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
            </div>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">    
            <div class="page-content">
	              <h4><?php echo $text_your_details; ?></h4>
                <table class="form">
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_fullname; ?></td>
                        <td><input type="text" name="fullname" value="<?php echo $fullname; ?>" />
                          <?php if ($error_fullname) { ?>
                          <span class="error"><?php echo $error_fullname; ?></span>
                          <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_email; ?></td>
                        <td><input type="text" name="email" value="<?php echo $email; ?>" />
                          <?php if ($error_email) { ?>
                          <span class="error"><?php echo $error_email; ?></span>
                          <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                        <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                          <?php if ($error_telephone) { ?>
                          <span class="error"><?php echo $error_telephone; ?></span>
                          <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_fax; ?></td>
                        <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
                    </tr>
                </table>
            </div>
            <div class="buttons">
                <div class="right">
                    <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
                </div>
            </div>
        </div>
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