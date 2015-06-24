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
            <td><?php echo $entry_tag; ?></td>
            <td>
              <select name="tag">
                <?php if($tag==1){ ?>
                <option value="1" selected><?php echo $text_tag_information ?></option>
                <option value="2"><?php echo $text_tag_school ?></option>
                <?php }else{ ?>
                <option value="2" selected><?php echo $text_tag_school ?></option>
                <option value="1"><?php echo $text_tag_information ?></option>
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