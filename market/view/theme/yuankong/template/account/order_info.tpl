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
            <h5><i class="title-btn"></i><?php echo $text_payment_method; ?></h5>
            <ul class="orderstyle-ul">
                <li><label>支付方式:</label><?php echo $payment_method; ?></li>
                <li><label>运    费:</label><em class="fwr">￥0.00</em></li>
                <li><label>送货日期:</label>2015-03-19</li>
                <li><label>物流公司:</label>申通快递</li>
                <li><label>快递单号:</label>st12345678</li>
                <?php if ($comment) { ?>
                <li>
                  <label><?php echo $text_comment; ?></label>
                  <?php echo $comment; ?>
                </li>
                <?php }?>
            </ul>
        </div>
        <div class="message">
            <h5><i class="title-btn"></i>状态信息</h5>
            <ul class="orderstyle-ul">
                <?php if ($invoice_no) { ?>
                <li><label><?php echo $text_invoice_no; ?></label> <?php echo $invoice_no; ?></li>
                <?php } ?>
                <li><label>订单状态:</label>已发货</li>
                <li><label>运    费:</label><em class="fwr">￥0.00</em></li>
                <li><label><?php echo $text_date_added; ?>:</label><?php echo $date_added; ?></li>
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
                              <a class="shop-pic" href="#">
                                  <img src="<?php echo $product['thumb'] ?>" />
                              </a>
                              <span class="shop-name"><?php echo $product['name']; ?>
                                <br>
                                <?php foreach ($product['option'] as $option) { ?>                
                                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                <?php } ?>
                              </span>
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

          <?php if ($histories) { ?>
          <div class="message">
            <h5><i class="title-btn"></i><?php echo $text_history; ?></h5>
            <table class="cart-table">
              <thead>
                <tr>
                  <td class="left"><?php echo $column_date_added; ?></td>
                  <td class="left"><?php echo $column_status; ?></td>
                  <td class="left"><?php echo $column_comment; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($histories as $history) { ?>
                <tr>
                  <td class="left"><?php echo $history['date_added']; ?></td>
                  <td class="left"><?php echo $history['status']; ?></td>
                  <td class="left"><?php echo $history['comment']; ?></td>
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