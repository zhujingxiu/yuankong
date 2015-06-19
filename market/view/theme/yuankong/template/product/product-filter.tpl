<div class="chose-style mt10 f_m">

    <p class="paix-chose">
      <span class="paix-li"><?php echo $text_sort_default; ?></span> 
      <span class="paix-li"><?php echo $text_sort_price; ?></span> 
  		<span class="paix-li"><?php echo $text_sort_sales; ?></span> 
  	</p>
    <p class="jg-shaix"><b><?php echo $text_limit; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
      <input type="button" value="<?php echo $button_submit ?>" class="price-sub">
    </p>
    <p class="top-page"><b><?php echo $text_sort; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </p>
</div>