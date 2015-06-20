<div class="xg-style mt10">
  <h3 class="title f_l"><?php echo $heading_title; ?></h3>
  <div class="fix p10">
    <ul class="others">
			<?php foreach ($products as $i => $product) { ?>

			<li>
				<?php if ($product['thumb']) { ?>
				<a href="<?php echo $product['href']; ?>" class="tjpic">
					<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
					<h5><?php echo $product['name']; ?></h5>
				</a>
				<?php } ?>
				<p class="tc pt5">
					<?php if ($product['price']) { ?>
					
					  <?php if (!$product['special']) { ?>
					  <em class="f_l c_red"><?php echo $product['price']; ?></em>
					  <?php } else { ?>
					  <span class="price-old"><?php echo $product['price']; ?></span> 
					  <span class="price-new"><?php echo $product['special']; ?></span>
					  <?php } ?>
					
					<?php } ?>

				</p>  
				
			</li>
			  
				
		<?php } ?>

    </div>

</div>
