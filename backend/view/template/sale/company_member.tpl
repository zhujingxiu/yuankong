<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<table class="list">
  <thead>
    <tr>
      <td class="left"><?php echo $column_date_added; ?></td>
      <td class="left"><?php echo $column_member; ?></td>
      <td class="left"><?php echo $column_avatar; ?></td>
      <td class="left"><?php echo $column_position; ?></td>
      <td class="left"><?php echo $column_sort; ?></td>
      <td class="left"><?php echo $column_note; ?></td>
      <td class="right"><?php echo $column_action; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if ($members) { ?>
    <?php foreach ($members as $item) { ?>
    <tr>
      <td class="left"><?php echo $item['date_added']; ?></td>
      <td class="left"><?php echo $item['name']; ?></td>
      <td class="left"><img src="<?php echo $item['avatar']; ?>"></td>
      <td class="left"><?php echo $item['position']; ?></td>
      <td class="left"><?php echo $item['sort']; ?></td>
      <td class="left"><?php echo $item['note']; ?></td>
      <td class="right"></td>
    </tr>
    <?php } ?>

    <?php } else { ?>
    <tr>
      <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
<div class="pagination"><?php echo $pagination; ?></div>
