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
                        <input class="xlddcheck headcheck" type="checkbox" name="selected[]" value="<?php echo $order['order_id'] ?>"/>
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
                    <?php if($product['review']){ ?>
                        <a href="<?php echo $product['toreview'] ?>">评价</a><br />
                    <?php }?>
                    <?php if($product['rereview']){ ?>
                        <a href="<?php echo $product['toreview'] ?>">追加评价</a><br />
                    <?php }?>
                    <?php if($order['status_id'] <= $this->config->get('config_unshipped_status_id')){ ?>
                        <a href="<?php echo $product['return'] ?>">退款/退货</a><br />
                    <?php }?>
                    </td>
                    <?php if(!$key){ ?>
                    <td width="15%" rowspan="<?php echo count($order['products']) ?>">
                        <strong><?php echo $order['total']; ?></strong>
                    </td>                    
                    <?php }?>                    
                    <?php if(!$key){ ?>
                    <td width="10%" rowspan="<?php echo count($order['products']) ?>">
                        <?php echo $order['status']; ?>
                        <?php if($this->config->get('config_order_status_id')==$order['status_id']){ ?>
                        <input type="button" class="dingdan repay" value="去支付" data-val="<?php echo $order['order_id'] ?>">
                        <?php }?>
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
                <input type="checkbox" id="selected" class="headcheck" name="all">
                <label>全选</label>
                <input type="button" class="dingdan" value="删除订单" id="remove-orders"/>
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
<script type="text/javascript">
    $('.headcheck[name="all"]').bind('click',function(){
        $('.headcheck[name^="selected"]').prop('checked', this.checked);
        $('.headcheck[name="all"]').prop('checked', this.checked);        
    });
    $('.headcheck[name^="selected"]').bind('click',function(){
        $('.headcheck[name="all"]').removeAttr('checked');
        var checked = 0;
        $.each($('.headcheck[name^="selected"]'),function(){
            if($(this).is(":checked")){
                checked++;
            }
        });
        if(checked == $('.headcheck[name^="selected"]').length){
            $('.headcheck[name="all"]').prop('checked',this.checked);
        }
    });
    $('#remove-orders').bind('click',function(){
        var checked = 0;
        var selected = [];
        $.each($('.headcheck[name^="selected"]'),function(){
            if($(this).is(":checked")){
                checked++;
                selected.push($(this).val());
            }
        });
        if(checked > 0){
            if(confirm('确定删除订单吗？')){
                $.ajax({
                    url:'index.php?route=account/order/delete',
                    type:'post',
                    data:'selected='+selected.join(),
                    dataType:'json',
                    success:function(json){
                        if(json.status==1){
                            Alertbox({type:true,msg:json.msg,delay:5000});
                            location.reload();
                        }else{
                            Alertbox({type:false,msg:json.msg,delay:5000});
                        }
                    }
                });
            }
        }else{
            alert('请选择一个订单');
            return false;
        }
    });
    $('.repay').bind('click',function(){
        $.post('index.php?route=account/order/repay',{entity:$(this).attr('data-val')},function(json){
            if(json.redirect){
                location.href = json.redirect;
            }
        },'json');
    })
</script>
<style type="text/css">
    .repay{background: #66b6ff;}
</style>
<?php echo $footer; ?>