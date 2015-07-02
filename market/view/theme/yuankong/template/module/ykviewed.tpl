<div class="<?php echo !empty($additional_class) ? $additional_class : 'w mt15' ?>">
	<div class="bd1 f_m mt10">
	  	<h3 class="title2 b_f6"><?php echo $heading_title; ?></h3>
	  	<div class="p15 ovh">
		    <div class="ovh">
		    	<ul class="zuij-look fix">
				<?php foreach ($products as $i => $product) {  ?>
					<li>
						<?php if ($product['thumb']) { ?>
						<a href="<?php echo $product['href']; ?>" >
							<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="tjpic"/>
							<h5 class="pt5"><?php echo $product['name']; ?></h5>
						</a>
						<?php } ?>
						<p class="tc pt5">
							
							<?php if ($product['price']) { ?>
							
							  <?php if (!$product['special']) { ?>
								<em class="f_l c_red">  <?php echo $product['price']; ?> </em>
							  <?php } else { ?>
							  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
							  <?php } ?>

							<?php } ?>
							<?php if (false): ?>
							<div class="cart">
								<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
							</div>
							<?php endif ?>
							
						</p>  
					</li>
				<?php } ?>
				</ul>
		    </div>
	  	</div>
	</div>
</div>