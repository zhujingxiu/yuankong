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
      <h1><img src="view/image/log.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form"> 
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td><input type="text" name="name" value="<?php echo $name; ?>" style="width:500px" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_url; ?></td>
            <td><input type="text" name="url" value="<?php echo $url; ?>" style="width:500px" />
              <?php if ($error_url) { ?>
              <span class="error"><?php echo $error_url; ?></span>
              <?php } ?></td>
          </tr>

          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="status">
                <option value="1" <?php echo $status ? ' selected="selected"' : ''?> ><?php echo $text_enabled; ?></option>
                <option value="0" <?php echo !$status ? ' selected="selected"' : ''?>><?php echo $text_disabled; ?></option>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="10"/></td>
          </tr>
        </table>

      </form>
    </div>
  </div>
</div>

<?php echo $footer; ?>