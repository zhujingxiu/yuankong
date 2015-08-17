<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>


<div class="w mt10">

  	<h3 class="f_xl c3"><?php echo $heading_title; ?></h3>
  	<table class="bj-table mt15">
		<tr>
			<td class="label-td">商品分类</td>
			<td>
				<?php foreach ($categories as $category_1) { ?>
				<label style="clear:both">
					<a href="<?php echo $category_1['href']; ?>">
						<?php echo $category_1['name']; ?>
					</a>
				</label>
				  	<?php if ($category_1['children']) { ?>
				  
					<?php foreach ($category_1['children'] as $category_2) { ?>
					<label>
						<a href="<?php echo $category_2['href']; ?>" title="<?php echo $category_2['name'] ?>">
							<?php echo truncate_string($category_2['name'],6); ?>
						</a>
					</label>
					  <?php if ($category_2['children']) { ?>
					  
						<?php foreach ($category_2['children'] as $category_3) { ?>
						<label>
							<a href="<?php echo $category_3['href']; ?>" title="<?php echo $category_3['name'] ?>">
								<?php echo truncate_string($category_3['name'],6); ?>
							</a>
						</label>
						<?php } ?>

					  <?php } ?>

					<?php } ?>

				  <?php } ?>

				<?php } ?>
			</td>
		</tr>
		<tr>
			<td class="label-td">用户中心</td>
			<td>
				<label><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></label>
				<label><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></label>
				<label><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></label>
				<label><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></label>
				<label><a href="<?php echo $history; ?>"><?php echo $text_history; ?></a></label>
			</td>
		<tr>
			<td class="label-td">消防e站</td>
			<td>
				<label><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></label>
				<label><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></label>
				<label><a href="<?php echo $search; ?>"><?php echo $text_search; ?></a></label>

				<?php foreach ($informations as $information) { ?>
				<label><a href="<?php echo $information['href']; ?>" title="<?php echo $information['title']; ?>"><?php echo truncate_string($information['title'],6); ?></a></label>
				<?php } ?>
				<label><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></label>
			</td>	
		</tr>	
  	</table>
</div> 


<?php echo $footer; ?>