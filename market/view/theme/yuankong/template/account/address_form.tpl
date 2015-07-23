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
      <div class="userboxtop">
      <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
      </div>
      <h1 class="page-title"><?php echo $heading_title; ?></h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <div class="page-content">
		          <h4><?php echo $text_edit_address; ?></h4>
                  <table class="form">
                    <tr>
                      <td><span class="required">*</span> <?php echo $entry_area_zone; ?></td>
                      <td><span id="area-zone"><?php echo $area_zone ?></span>
                        <div id="area"> </div></td>
                    </tr>
                    <tr>
                      <td><span class="required">*</span> <?php echo $entry_address; ?></td>
                      <td><input type="text" name="address" value="<?php echo $address; ?>" />
                        <?php if ($error_address) { ?>
                        <span class="error"><?php echo $error_address; ?></span>
                        <?php } ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $entry_company; ?></td>
                      <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
                    </tr>
                    <tr>
                      <td><span class="required">*</span> <?php echo $entry_fullname; ?></td>
                      <td><input type="text" name="fullname" value="<?php echo $fullname; ?>" />
                        <?php if ($error_fullname) { ?>
                        <span class="error"><?php echo $error_fullname; ?></span>
                        <?php } ?></td>
                    </tr>
                    <tr>
                      <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                      <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                        <?php if ($error_telephone) { ?>
                        <span class="error"><?php echo $error_telephone; ?></span>
                        <?php } ?></td>
                    </tr>          
                    <tr>
                      <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
                      <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
                        <?php if ($error_postcode) { ?>
                        <span class="error"><?php echo $error_postcode; ?></span>
                        <?php } ?></td>
                    </tr>
                    <tr>
                      <td><?php echo $entry_default; ?></td>
                      <td><?php if ($default) { ?>
                        <input type="radio" name="default" value="1" checked="checked" />
                        <?php echo $text_yes; ?>
                        <input type="radio" name="default" value="0" />
                        <?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="default" value="1" />
                        <?php echo $text_yes; ?>
                        <input type="radio" name="default" value="0" checked="checked" />
                        <?php echo $text_no; ?>
                        <?php } ?></td>
                    </tr>
                  </table>
              </div>
          <div class="buttons">
              <div class="left">
                  <a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a>
              </div>
              <div class="right">
                  <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
              </div>
          </div>
      </form>
      <?php echo $content_bottom; ?>
  </div>
    <?php if( $SPAN[2] ): ?>
		<div class="span<?php echo $SPAN[2];?>">	
			  <?php echo $column_right; ?>
		</div>
    <?php endif; ?>
</div>
<script type="text/javascript">

    $(function(){
        add_select(0);
        $('body').on('change', '#area select', function() {
            var $me = $(this);
            var $next = $me.next();

            if ($me.val() == $next.data('pid')) {
                return;
            }
            $me.nextAll().remove();
            add_select($me.val());
        });

        function add_select(pid) {
            var area_names = area['name'+pid];
            if (!area_names) {
                return false;
            }
            var area_codes = area['code'+pid];
            var $select = $('<select >');
            $select.attr('name', 'area[]');
            $select.attr('class', 'adress-sec');
            $select.data('pid', pid);
            if (area_codes[0] != -1) {
                area_names.unshift('请选择');
                area_codes.unshift(0);
            }
            for (var idx in area_codes) {
                var $option = $('<option>');
                $option.attr('value', area_codes[idx]);
                $option.text(area_names[idx]);
                $select.append($option);
            }
            $('#area').append($select);
        };
    });
</script>
<?php echo $footer; ?>