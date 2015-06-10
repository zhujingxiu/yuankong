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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/log.png" alt="" width="22px" height="22px"/> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>            	
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'h.account') { ?>
                <a href="<?php echo $sort_account; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_account; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_account; ?>"><?php echo $column_account; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'h.telephone') { ?>
                <a href="<?php echo $sort_telephone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_telephone; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_telephone; ?>"><?php echo $column_telephone; ?></a>
                <?php } ?></td>
              <td class="left"><?php echo $column_text; ?></td>
              <td class="left"><?php if ($sort == 'h.date_replied') { ?>
                <a href="<?php echo $sort_date_replied; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_reply; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_replied; ?>"><?php echo $column_reply; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'h.is_top') { ?>
                <a href="<?php echo $sort_top; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_top; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_top; ?>"><?php echo $column_top; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'h.date_added') { ?>
                <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($helps) { ?>
            <?php foreach ($helps as $item) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($item['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['help_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $item['help_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo truncate_string($item['account']); ?></td>  
              <td class="left"><?php echo $item['telephone'] ; ?></td>           
              <td class="left"><?php echo truncate_string($item['text'],50) ; ?></td>           
              <td class="left"><?php echo $item['reply']; ?></td>
              <td class="left"><?php echo $item['top']; ?></td>
              <td class="left"><?php echo $item['date_added']; ?></td>
              <td class="right"><?php foreach ($item['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>