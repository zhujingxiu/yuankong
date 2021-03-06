

<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_id; ?></td>
            <td><input type="text" name="chinapay_id" value="<?php echo $chinapay_id; ?>" size="50" />
            <?php if ($error_id) { ?>
              <span class="error"><?php echo $error_id; ?></span>
            <?php } ?>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_key; ?></td>
            <td><input type="text" name="chinapay_key" value="<?php echo $chinapay_key; ?>" size="50"/>
            <?php if ($error_key) { ?>
              <span class="error"><?php echo $error_key; ?></span>
            <?php } ?>  
          </tr>
          <tr>
            <td><?php echo $entry_callback; ?></td>
            <td><textarea cols="100" rows="2"><?php echo $callback; ?></textarea></td>
          </tr>          
             
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td><input type="text" name="chinapay_total" value="<?php echo $chinapay_total; ?>" /></td>
          </tr>          
          <tr>
            <td><?php echo $entry_area_geo; ?></td>
            <td><select name="chinapay_area_geo_id">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($area_geos as $area_geo) { ?>
                <?php if ($area_geo['area_geo_id'] == $chinapay_area_geo_id) { ?>
                <option value="<?php echo $area_geo['area_geo_id']; ?>" selected="selected"><?php echo $area_geo['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $area_geo['area_geo_id']; ?>"><?php echo $area_geo['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="chinapay_status">
                <?php if ($chinapay_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="chinapay_sort_order" value="<?php echo $chinapay_sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>