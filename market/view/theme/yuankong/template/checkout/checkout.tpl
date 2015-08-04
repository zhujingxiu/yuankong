<?php 
  $themeConfig = $this->config->get( 'themecontrol' );
  $themeName =  $this->config->get('config_template');
  require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
  $helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
<title><?php echo $heading_title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="market/view/theme/<?php echo $themeName;?>/stylesheet/yk_basic.css" />


<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/common.js"></script>

<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>

<!--[if lt IE 9]>
<script src="market/view/javascript/html5.js"></script>
<![endif]-->

<!--[if IE ]>
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/lib/jquery.placeholder.js"></script>
<script type="text/javascript">
$(function(){ $('input, textarea').placeholder(); });
</script>
<style type="text/css">
  .placeholder{color:#999999;}
</style>
<![endif]-->
<script type="text/javascript" src="market/view/theme/<?php echo $themeName;?>/javascript/index.js"></script>

</head>
<body>
<!--Top-->

<?php echo $top ?>

<!--Top-->
<section id="columns">
<div class="w w980 mt20">
	<div class="ovh">
    <ul class="gw-process">
        <li class="online-s"><p class="process-num">1</p><p class="">我的购物车</p></li>
        <li class="online-s"><p class="process-num">2</p><p>填写/确认订单</p></li>
        <li><p class="process-num">3</p><p>付款</p></li>
        <li><p class="process-num">4</p><p>支付成功</p></li>
    </ul>
    <?php if ($logo) { ?>
    <a href="<?php echo $home; ?>" class="pr10">
      <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <?php } ?>
  </div>
<div id="content" class="mt20">
    <form id="checkout-form" method="post" >
    <div class="order-w">
        <h3><b><?php echo $text_checkout_shipping ?></b></h3>
        <ul class="order-ul">
            <?php $n=0; foreach ($addresses as $key => $item) { ?>
            <?php 
                $checked = false;
                if(isset($this->session->data['shipping_address_id'])){                    
                    if($this->session->data['shipping_address_id'] == $item['address_id']){
                       $checked = true; 
                    }
                }else if(!$n){
                    $checked = true;
                }
            ?>
             <li class="order-li-adess fix <?php echo $checked ? 'adress-show' : '' ?>">
                <i class="dw-btn icon2"></i>
                <label>寄送至</label>
                <div class="adress-new">
                    <input type="radio" class="adress-radio" name="shipping_address_id" value="<?php echo $item['address_id'] ?>" <?php echo $checked ? 'checked="checked"' : '' ?>/>
                    <?php echo $item['area_zone'] ?> <?php echo $item['address'] ?>
                    <em class="pl10 c8"><?php echo $item['telephone'] ?></em>
                    <em class="pl10 c8"><?php echo $item['fullname'] ?></em>
                </div>
            </li>
            <?php $n++;}?>
        </ul>
        <div class="new-adress <?php echo count($addresses) ? '' : 'adressbox' ?>">            
            <div class="ovh">
                <input type="radio" name="shipping_address_id" value="0" class="adress-radio" <?php echo count($addresses) ? '' : 'checked="checked"' ?> />
                <label><?php echo $text_address_new ?></label>
            </div>
            <div class="newadress-box">
                <ul>
                    <li class="item-adress" id="area">
                        <label>收货地址：</label>                        
                    </li>
                    <li class="item-adress">
                        <label>详细地址：</label>
                        <input type="text" class="text-box w350" value="" name="address" />
                    </li>
                    <li class="item-adress">
                        <label>收货人姓名：</label>
                        <input type="text" class="text-box w210" name="fullname" value="" />
                    </li>
                    <li class="item-adress">
                        <label>手机号码：</label>
                        <input type="text" class="text-box w210" name="telephone" value="<?php echo $this->customer->getMobilePhone() ?>" />
                    </li>
                </ul>
            </div>
        </div>
    </div>
	<div class="order-w">
        <h3><b><?php echo $text_checkout_product ?></b></h3>
        <div class="ovh p15">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th class="shop-n">商品</th>
                        <th>单价(元)</th>
                        <th width="130">数量</th>
                        <th>小计(元)</th>
                        <th width="120">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($products as $product) { ?>
                    <tr>
                        <td class="name">
                            <div class="ovh">
                                <?php if ($product['thumb']) { ?>
                                <a class="shop-pic" href="<?php echo $product['href']; ?>">
                                    <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
                                </a>
                                <?php } ?>
                                <span class="shop-name">
                                    <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                              
                                    <?php foreach ($product['option'] as $option) { ?>
                                    <br />
                                    - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>

                                    <?php } ?>
                                    <?php if ($product['reward']) { ?>
                                    <small><?php echo $product['reward']; ?></small>
                                    <?php } ?>
                                </span>
                            </div>
                        </td>
                        <td class="price"><p class="tc"><?php echo $product['price']; ?></p></td>
                        <td class="quantity">
                            <div class="tc ovh">
                                <span class="icon2 janbtn minus-qty"></span><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" class="jiajiantext"  /><span class="icon2 jabtn plus-qty"></span>                                
                                <input type="hidden" name="price[<?php echo $product['key']; ?>]" value="<?php echo $product['_price'] ?>"/>
                            </div>
                        </td>
                        <td class="total">
                            <p class="tc c_red"><b><?php echo $product['total']; ?></b></p>
                        </td>
                        <td>
                            <p class="tc">
                            <a href="<?php echo $product['remove']; ?>" class="remove-item">
                                <img src="market/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" />
                            </a></p>
                        </td>
                    </tr>
                    <?php }?>
                </tbody>
            </table>
            <div class="mt10">
                <h5 class="c3 f_m"><?php echo $text_comments ?></h5>
                <textarea class="liuy-tarea" name="comment"></textarea>
            </div>
        </div>
        <div class="order-w">
            <h3><b><?php echo $text_checkout_confirm ?></b></h3>
            <div class="ovh p15">
                <ul class="order-item-ul">
                    <li class="all-money">
                        <strong><?php echo $checkout_total['title'] ?></strong>
                        <b><?php echo $checkout_total['text'] ?></b>
                        =
                        <?php $n = 0;foreach ($other_totals as $key => $item): ?>
                        <?php if($key!='total'){ ?>
                        <b><?php echo $item['text'] ?></b>
                        <span>(<?php echo $item['title'] ?>)</span>
                        <?php }?>
                        <?php if(count($other_totals) > $n+1){?>
                        +
                        <?php } ?>
                        <?php $n++; endforeach ?>
                    </li>
                    <li class="all-money">
                        <strong><?php echo $text_checkout_payment ?></strong>
                        <?php $n = 0;foreach ($payment_methods as $payment): ?>

                        <input type="radio" name="payment_method" value="<?php echo $payment['code'] ?>" <?php echo !$n ? 'checked="checked"' : '' ?> />
                        <?php echo $payment['title'] ?>
                        <?php if(isset($payment['note'])){ ?>
                        <span class="pl10"><?php echo $payment['note'] ?></span>
                        <?php }?>
                        <?php $n++; endforeach ?>
                        
                    </li>
                    <li><?php echo $text_finished_payment ?></li>
                    <li class="mt10">
                        <div class="w210">
                            <input type="button" class="gc-tab-sub" value="提交订单" id="button-confirm"/>
                        </div> 
                    </li>
                </ul>
            </div>
        </div>
    </div>
    </form>
</div> 

<script type="text/javascript">
    o.dbclicked.init(".order-li-adess .adress-radio","adress-show");
    $(".new-adress .adress-radio").bind("click",function(){
        $(this).parent().parent().prev().find(".order-li-adess").removeClass("adress-show");
        $(this).parent().parent().addClass("adressbox");
    });
    $(".order-li-adess .adress-radio").bind("click",function(){
        $(this).parent().parent().parent().next(".new-adress").removeClass("adressbox");
        $(this).parent().parent().siblings().removeClass("adress-show");
        $(this).parent().parent().addClass("adress-show");
    });
    $(function(){
        add_select(0);
        $('body').on('change', '#area select', function() {
            var $me = $(this);
            var $next = $me.next();

            if ($me.val() == $next.data('pid')) {
                return;
            }
            $me.nextAll().remove();
            add_select($me.val());
        });

        function add_select(pid) {
            var area_names = area['name'+pid];
            if (!area_names) {
                return false;
            }
            var area_codes = area['code'+pid];
            var $select = $('<select >');
            $select.attr('name', 'area[]');
            $select.attr('class', 'adress-sec');
            $select.data('pid', pid);
            if (area_codes[0] != -1) {
                area_names.unshift('请选择');
                area_codes.unshift(0);
            }
            for (var idx in area_codes) {
                var $option = $('<option>');
                $option.attr('value', area_codes[idx]);
                $option.text(area_names[idx]);
                $select.append($option);
            }
            $('#area').append($select);
        };
    });
    $('input[name^="quantity"]').change(function(){changeQty(this);})
    function changeQty(el){
        $.ajax({
            url:'index.php?route=checkout/checkout',
            type:'post',
            data:$(el),
            success:function(){
                location.reload();
            }
        });
    }
    $('.plus-qty').click(function(){
        var obj = $(this).parent('.tc').find('input[name^=quantity]');
        obj.val(parseInt(obj.val())+1);
        changeQty(obj);
    });
    $('.minus-qty').click(function(){
        var obj = $(this).parent('.tc').find('input[name^=quantity]');
        obj.val(parseInt(obj.val())-1 ? parseInt(obj.val())-1 : 1);
        changeQty(obj);
    });
</script>
<script type="text/javascript"><!--
$('#button-confirm').bind('click', function() {
    $.ajax({ 
        type: 'post',
        url: 'index.php?route=checkout/confirm',
        data:$('#checkout-form input[type="radio"]:checked,#checkout-form select,#checkout-form textarea,#checkout-form input[type="hidden"],#checkout-form input[type="text"]'),
        dataType:'json',
        success: function(json) {
            if(json.status==1){
                location.href = json.redirect;
            }else{
                $('.invalid').remove();
                if(json['error_shipping']){
                    if(json['error_shipping']['address']){
                        $('input[name="address"]').after('<div class="invalid">'+json['error_shipping']['address']+'</div>');
                    }
                    if(json['error_shipping']['fullname']){
                        $('input[name="fullname"]').after('<div class="invalid">'+json['error_shipping']['fullname']+'</div>');
                    }
                    if(json['error_shipping']['mobile_phone']){
                        $('input[name="mobile_phone"]').after('<div class="invalid">'+json['error_shipping']['mobile_phone']+'</div>');
                    }
                    if(json['error_shipping']['area']){
                        $('select[name^="area"]').after('<div class="invalid">'+json['error_shipping']['area']+'</div>');
                    }
                    if($('.order-w').find('.invalid').length){
                        $('html, body').animate({ scrollTop: 10 }, 'slow'); 
                    }                    
                }
            }
            
        }       
    });
});
//--></script> 
<style type="text/css">
    .invalid{float:right;color:red;margin-left:20px; }
</style>
<?php echo $footer; ?>