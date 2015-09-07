<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?> aside">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?> article">
    <?php echo $content_top; ?>
    <div class="userbox3">
        <div class="userboxtop">
          <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
        </div>
        <div class="userboxcen">
            <ul class="userdd-zt martop">
                <li <?php echo $status=='all' ? 'class="userdd-zton"' : '' ?>>
                    <a href="<?php echo $all ?>">所有订单</a>
                </li>
                <li <?php echo $status=='processing' ? 'class="userdd-zton"' : '' ?>>
                    <a href="<?php echo $processing ?>">进行中的订单</a>
                </li>
                <li <?php echo $status=='success' ? 'class="userdd-zton"' : '' ?>>
                    <a href="<?php echo $success ?>">成功订单</a>
                </li>
                <li <?php echo $status=='cancel' ? 'class="userdd-zton"' : '' ?>>
                    <a href="<?php echo $cancel ?>">已取消订单</a>
                </li>
            </ul>
            <div class="userddnav">
                <table class="userddnav1" width="100%">
                    <tr>
                        <td width="40%">产品名称</td>
                        <td width="15%">规格型号</td>                        
                        <td width="10%">数量</td>
                        <td width="10%">商品操作</td>
                        <td width="15%">总价格</td>
                        <td width="10%">订单状态</td>
                        
                    </tr>
                </table>
            </div>
            <?php if ($orders) { ?>
            <?php foreach ($orders as $order) { ?>
            <table class="userxldd">              
                <tr>
                    <td class="xlddtop" colspan="6">
                        <input class="xlddcheck" type="checkbox" name="xldd" />
                        <span>订单编号：#<?php echo $order['order_id']; ?></span>
                        <span>下单时间：<?php echo $order['date_added']; ?></span>
                        <span><a class="detail-view" href="<?php echo $order['href']; ?>"><?php echo $button_view; ?></a></span>
                    </td>
                </tr>
                <?php if($order['products']){?>
                <?php foreach ($order['products'] as $key => $product): ?>               
                <tr class="jtuserdd">
                    <td style="text-align:left;" width="40%">
                        <div class="ovh">
                            <a class="shop-pic" href="<?php echo $product['link'] ?>">
                                <img src="<?php echo $product['thumb'] ?>" />
                            </a>
                            <span class="shop-name">
                                <a href="<?php echo $product['link'] ?>"><?php echo $product['name'] ?></a>
                            </span>
                        </div>
                    </td>
                    <td width="15%"><?php echo $product['model'] ?></td>
                    <td width="10%"><?php echo $product['quantity']; ?></td>
                    <td width="10%">
                      <a href="<?php echo $product['return'] ?>">退款/退货</a><br />
                      
                    </td>
                    <?php if(!$key){ ?>
                    <td width="15%" rowspan="<?php echo count($order['products']) ?>">
                        <strong><?php echo $order['total']; ?></strong>
                    </td>                    
                    <?php }?>                    
                    <?php if(!$key){ ?>
                    <td width="10%" rowspan="<?php echo count($order['products']) ?>">
                        <?php echo $order['status']; ?>
                    </td>
                    <?php }?>
                    
                </tr>
                <?php endforeach ?>
                <?php } ?>
            </table>
            <?php } ?>
            
            <?php } else { ?>
            <div style="text-align:center;padding:5px;"><h3><?php echo $text_empty; ?></h3></div>
            <?php } ?>
            <div class="fy">
                <?php echo $pagination; ?>
                <?php if ($orders) { ?>
                <input type="checkbox" id="selected">
                <label>全选</label>
                <input type="button" class="dingdan" value="删除订单">
                <?php }?>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div> 
<?php if( $SPAN[2] ): ?>
<div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>
<?php echo $footer; ?>