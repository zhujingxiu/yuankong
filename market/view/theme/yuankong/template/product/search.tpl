<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">
<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?>">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
    <div class="<?php echo $SPAN[1];?>">
        <?php echo $content_top; ?>
        <div class="xfgs-chose-box">
            <div class="xfgs-ad">
                <?php echo $text_search; ?>
                <?php echo count($products) ? $text_totals : $text_empty ?>
            </div>

        </div>
        <div class="xg-style mt10">
            <div class="xfgs-px-box pr15">
                <div class="r gs-search">
                  <input type="text" class="gs-s-text" value="<?php echo $search; ?>"><i class="icon2 s-sbtn"></i>
                </div>
                <ul class="gs-px-list">
                    <li class="<?php echo $sort_on == 'sort_order' ? 'son' : ''?>" >
                      <a href="<?php echo $sort_order ?>"><?php echo $text_sort_default; ?></a>
                    </li>
                    <li class="<?php echo $sort_on == 'price' ? 'son' : ''?>">
                      <a href="<?php echo $sort_price ?>"><?php echo $text_sort_price; ?></a>
                    </li>
                    <li class="<?php echo $sort_on == 'sales' ? 'son' : ''?>">
                      <a href="<?php echo $sort_sales ?>"><?php echo $text_sort_sales; ?></a>
                    </li>
                </ul>
            </div>
            <div class="p10">
                <ul class="gongslist">
                    <?php foreach ($products as $item): ?>
                    <li class="item">
                        <p class="gspic"><a href="<?php echo $item['href']; ?>"><img src="<?php echo $item['thumb'] ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="<?php echo $item['href']; ?>" class="pname"><?php echo $item['name'] ?></a></h3>
                            <p class="lh30 c9 f_m">
                                <?php if ($item['sales']): ?>
                                <i class="tjian"><?php echo $item['sales'] ?></i>
                                <?php endif ?>
                            </p>
                            <p class="pt5">
                                <b class="f_xl c_red"><?php echo $item['price']; ?></b>
                                &nbsp; &nbsp;
                                <em class="">
                                <?php echo $text_sales ?>
                                <i class="c_red"><?php echo $item['sales'] ?></i>
                                </em>
                              
                            </p>
                            <p class="gsjj-t ptext" style="text-indent:0px;"><?php echo $item['description'] ?></p>
                        </div>
                        <p class="sqyuyue">
                            <a onclick="addToCart('<?php echo $item['product_id']; ?>');" class="yybtn">加入购物车</a>
                        </p>
                    </li>
                    <?php endforeach ?>
                </ul>
                <div class="pagebox mt10">
                    <?php echo $pagination; ?>
                </div>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<script type="text/javascript"><!--

<?php if($search){ ?>
    $('.gongslist .pname,.gongslist .ptext').textSearch('<?php echo $search ?>',{markColor: "#C30D23"});
<?php }?>
//--></script> 
<?php echo $footer; ?>