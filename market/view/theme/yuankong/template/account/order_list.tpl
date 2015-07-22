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
                <li class="userdd-zton">所有订单</li>
                <li>进行中的订单</li>
                <li>成功订单</li>
                <li>已取消订单</li>
            </ul>
            <div class="userddnav">
                <table class="userddnav1" width="100%">
                    <tr>
                        <td width="40%">产品名称</td>
                        <td width="15%">规格型号</td>
                        <td width="15%">总价格</td>
                        <td width="10%">数量</td>
                        <td width="10%">订单状态</td>
                        <td width="10%">操作</td>
                    </tr>
                </table>
            </div>
            <?php if ($orders) { ?>
            <table class="userxldd">
              <?php foreach ($orders as $order) { ?>
                <tr>
                    <td class="xlddtop" colspan="6">
                        <input class="xlddcheck" type="checkbox" name="xldd" />
                        <span>订单编号：#<?php echo $order['order_id']; ?></span>
                        <span>下单时间：<?php echo $order['date_added']; ?></span>
                    </td>
                </tr>
                <tr class="jtuserdd">
                    <td style="text-align:left;" width="40%">
                        <div class="ovh">
                            <a class="shop-pic" href="#">
                                <img src="imgs/adimg/shoppic7.jpg" />
                            </a>
                            <span class="shop-name">
                                <a href="#">【果郡王】海南妃子笑荔枝3斤装 新鲜荔枝 国产水果</a>
                            </span>
                        </div>
                    </td>
                    <td width="15%">T2250<br />红色</td>
                    <td width="15%"><strong><?php echo $order['total']; ?></strong></td>
                    <td width="10%">2</td>
                    <td width="10%"><?php echo $order['status']; ?></td>
                    <td width="10%">
                      <a href="#">取消</a><br />
                      <a href="<?php echo $order['href']; ?>"><?php echo $button_view; ?></a>
                    </td>
                </tr>

              <?php } ?>
              <div class="pagination"><?php echo $pagination; ?></div>
            </table>
            <?php } else { ?>
            <div class="content"><?php echo $text_empty; ?></div>
            <?php } ?>
            <div class="buttons">
                <div class="right">
                    <a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a>
                </div>
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