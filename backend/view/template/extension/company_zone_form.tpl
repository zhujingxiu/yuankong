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
      <h1><img src="view/image/order.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td>
              <input type="text" name="name" value="<?php echo $name ?>" />

              <?php if (isset($error_name)) { ?>
              <span class="error"><?php echo $error_name; ?></span><br />
              <?php } ?>
              </td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td>
              <select name="status">
                <?php if($status){ ?>
                <option value="1" selected><?php echo $text_enabled ?></option>
                <option value="0"><?php echo $text_disabled ?></option>
                <?php }else{ ?>
                <option value="0" selected><?php echo $text_disabled ?></option>
                <option value="1"><?php echo $text_enabled ?></option>
                <?php }?>
                <option>
              </select>  
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_show; ?></td>
            <td>
              <select name="show">
                <?php if($show){ ?>
                <option value="1" selected><?php echo $text_yes ?></option>
                <option value="0"><?php echo $text_no ?></option>
                <?php }else{ ?>
                <option value="0" selected><?php echo $text_no ?></option>
                <option value="1"><?php echo $text_yes ?></option>
                <?php }?>
                <option>
              </select>  
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>