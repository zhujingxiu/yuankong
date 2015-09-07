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
    <div id="content" class="userbox3">
        <div class="userboxtop">
            <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
        </div>
        <div class="message">
            <h5><i class="title-btn"></i><?php echo $text_shipping_address; ?></h5>
            <ul class="orderstyle-ul">
                <li><label>收货人:</label><?php echo $shipping_fullname ?></li>
                <li><label>联系方式:</label><?php echo $shipping_telephone ?></li>
                <li><label>收货地址:</label><?php echo $shipping_area_zone ?> <?php echo $shipping_address ?>，<?php echo $shipping_postcode ?></li>
            </ul>
        </div>
        <div class="message">
            <h5><i class="title-btn"></i><?php echo '支付及配送信息'; ?></h5>
            <ul class="orderstyle-ul">
                <?php if ($invoice_no) { ?>
                <li><label><?php echo $text_invoice_no; ?></label> <?php echo $invoice_no; ?></li>
                <?php } ?>
                
                <li><label>订单状态:</label><?php echo !empty($order_status['name']) ? $order_status['name'] : '<b style="color:red">订单异常</b>' ?></li>
                <li><label>下单时间:</label><?php echo $date_added ?></li>
                <li><label>支付方式:</label><?php echo $payment_method; ?></li>                
                <?php if(isset($order_totals['shipping']))?>
                <li><label>运    费:</label>
                  <em class="fwr"><?php echo $order_totals['shipping']['text'] ?></em>
                </li>
                <?php ?>
                <?php if($shipment_date!==false){?>
                <li><label>送货日期:</label><?php echo $shipment_date ?></li>
                <?php }?>
                <?php foreach ($order_shipments as $item): ?>
                <li><label>物流公司:</label><?php echo $item['title'] ?></li>
                <li><label>快递单号:</label><?php echo $item['tracking_no'] ?></li>
                <?php endforeach ?>

                <?php if ($comment) { ?>
                <li>
                  <label><?php echo $text_comment; ?></label>
                  <?php echo $comment; ?>
                </li>
                <?php }?>
            </ul>
        </div>

        <div class="message">
            <h5><i class="title-btn"></i>商品信息</h5>
            <ul class="orderstyle-ul">
                <li><label><?php echo $text_order_id ?></label>#<?php echo $order_id ?></li>
            </ul>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th class="shop-n">商品</th>
                        <th width="120">规格型号</th>
                        <th>总价</th>
                        <th>数量</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($products as $product) { ?>
                    <tr>
                        <td>
                            <div class="ovh">
                              <a class="shop-pic" href="<?php echo $product['link'] ?>">
                                  <img src="<?php echo $product['thumb'] ?>" />
                              </a>
                              <a href="<?php echo $product['link'] ?>">
                                <span class="shop-name"><?php echo $product['name']; ?>
                                  <br>
                                  <?php foreach ($product['option'] as $option) { ?>                
                                  &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                  <?php } ?>
                                </span>
                              </a>
                            </div>
                        </td>
                        <td><p class="tc"><?php echo $product['model']; ?></p></td>
                        <td><p class="tc c_red f_m"><?php echo $product['total']; ?></p></td>
                        <td><p class="tc f_m c_g"><?php echo $product['quantity']; ?></p></td>      
                        <td>
                            <a href="<?php echo $product['return']; ?>"><?php echo $button_return; ?></a>
                        </td>
                    </tr>
                    <?php } ?>
                    <?php foreach ($vouchers as $voucher) { ?>
                    <tr>
                      <td class="left"><?php echo $voucher['description']; ?></td>
                      <td class="left"></td>
                      <td class="right">1</td>
                      <td class="right"><?php echo $voucher['amount']; ?></td>
                      <td class="right"><?php echo $voucher['amount']; ?></td>
                    </tr>
                    <?php } ?>
                </tbody>


            </table>
            <?php $total = end($totals);?>
            <div class="tr p15">
                实际付款:<b class="f_xl c_red fwr"><?php echo $total['text']; ?></b>
            </div>
          </div>

          <?php if ($histories && false) { ?>
          <div class="message">
            <h5><i class="title-btn"></i><?php echo '状态记录'; ?></h5>
            <table class="cart-table">
              <thead>
                <tr>
                  <th style="width:150px;"><?php echo '记录时间'; ?></th>
                  <th><?php echo $column_status; ?></th>
                  <th><?php echo $column_comment; ?></th>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($histories as $history) { ?>
                <tr>
                  <td><?php echo $history['date_added']; ?></td>
                  <td><p class="tc"><?php echo $history['status']; ?></p></td>
                  <td><?php echo $history['comment']; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
          <?php } ?>
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