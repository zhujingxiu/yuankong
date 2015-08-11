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
            <td><span class="required">*</span> <?php echo $entry_account; ?></td>
            <td>
              <input type="text" name="account" value="<?php echo $account ?>" />
              <?php if (isset($error_account)) { ?>
              <span class="error"><?php echo $error_account; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_mobile_phone; ?></td>
            <td>
              <input type="text" name="mobile_phone" value="<?php echo $mobile_phone ?>" />
              <?php if (isset($error_mobile_phone)) { ?>
              <span class="error"><?php echo $error_mobile_phone; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_company; ?></td>
            <td>
              <select name="company_id">
                <option value="0"><?php echo $text_none ?></option>
                <?php foreach($companies as $item){ ?>
                  <option value="<?php echo $item['company_id'] ?>" <?php echo $item['company_id'] == $company_id ? 'selected' : '' ?> ><?php echo $item['title'] ?></option>
                <?php }?>                
              </select>  
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td>
              <select name="status">
                <?php if($status){ ?>
                <option value="1" selected><?php echo $text_completed ?></option>
                <option value="0"><?php echo $text_pending ?></option>
                <?php }else{ ?>
                <option value="0" selected><?php echo $text_pending ?></option>
                <option value="1"><?php echo $text_completed ?></option>
                <?php }?>
                <option>
              </select>  
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_note; ?></td>
            <td>
              <textarea name="note" cols="50" rows="3"><?php echo $note ?>  </textarea>
            </td>
          </tr>

        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>