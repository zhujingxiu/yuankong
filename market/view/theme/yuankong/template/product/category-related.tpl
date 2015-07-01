<div class="xg-style">
  	<h3 class="title f_m"><?php echo $text_category_related; ?></h3>
  	<div class="fix box-s p10">
		<?php foreach ($categories as $item) { ?>
		<a href="<?php echo $item['link']; ?>" class="txt-clip">
			<h5><?php echo $item['name']; ?></h5>
		</a>
		<?php } ?>
    </div>
</div>