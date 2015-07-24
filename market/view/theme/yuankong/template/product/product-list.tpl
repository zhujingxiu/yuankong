
<div class="shopall-list">
	<ul class="shoplist fix">
	<?php foreach ($products as $i => $product) { ?>

		<li class="s-item">

			<?php if ($product['thumb']) { ?>
			<a class="db" href="<?php echo $product['href']; ?>">
				<p class="p5">
					<img class="spic" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				</p>
				<p class="s-name"><?php echo $product['name']; ?></p>
			</a>
			<?php } ?>
			<p class="lh30 plr">
				<em class="r">
					<?php echo $text_sales ?>
					<i class="c_red"><?php echo $product['sales'] ?></i>
				</em>
			  <?php if ($product['price']) { ?>
				<?php if (!$product['special']) { ?>
				<b class="f_xl c_red"><?php echo $product['price']; ?></b>
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
<div class="pagebox mt10"><?php echo $pagination; ?></div>

