<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($error) { ?>
  <div class="warning"><?php echo $error; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/feed.png" alt="" /> <?php echo $heading_title; ?></h1>
	  <div class="buttons"><a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a><a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
	 <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="list">
	    <thead>
		<tr>
			<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
            <td class="left"><?php echo $text_title; ?></td>
            <td class="left"><?php echo $text_subtitle; ?></td>
			<td class="left"><?php echo $text_from; ?></td>
			<td class="left"><?php echo $text_date; ?></td>
			<td class="right"><?php echo $text_action; ?></td>
		</tr>
		</thead>
		<tbody>
		<?php if ($news) { ?>
			<?php foreach ($news as $item) { ?>
				<tr>
					<td width="1" style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $item['news_id']; ?>" /></td>
                    <td class="left"><?php echo $item['title']; ?></td>
                    <td class="left"><?php echo $item['subtitle']; ?></td>
					<td class="left"><?php echo $item['from']; ?></td>
					<td class="left"><?php echo $item['date_added']; ?></td>
					<td class="right">[ <a href="<?php echo $item['edit']; ?>"><?php echo $text_edit; ?></a> ]</td>
				</tr>
			<?php } ?>
		<?php } ?>
		</tbody>
	  </table>
	 </form>
	 <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>