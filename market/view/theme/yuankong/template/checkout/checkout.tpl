<?php 
  $themeConfig = $this->config->get( 'themecontrol' );
  $themeName =  $this->config->get('config_template');
  require_once( DIR_TEMPLATE.$this->config->get('config_template')."/template/libs/module.php" );
  $helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
 
<meta name="viewport" content="width=device-width">
<meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
<meta charset="UTF-8" />
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

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php //echo $google_analytics; ?>
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
    <div class="order-w">
        <h3><b>确认收货地址</b></h3>
        <ul class="order-ul">
            <?php $n=0; foreach ($addresses as $key => $item) { ?>
             <li class="order-li-adess fix <?php echo !$n ? 'adress-show' : '' ?>">
                <i class="dw-btn icon2"></i>
                <label>寄送至</label>
                <div class="adress-new">
                    <input type="radio" class="adress-radio" name="shipping_address_id" value="<?php echo $item['address_id'] ?>" <?php echo !$n ? 'checked="checked"' : '' ?>/>
                    江苏省 南京市 玄武区 <?php echo $item['address_1'] ?>
                    <em class="pl10 c8"><?php echo $item['mobile_phone'] ?></em>
                    <em class="pl10 c8"><?php echo $item['nickname'] ?></em>
                </div>
            </li>
            <?php $n++;}?>
        </ul>
        <div class="new-adress">
            <div class="ovh">
                <input type="radio" class="adress-radio" name="shipping_address_id" value="0" />
                <label>新增新地址</label>
            </div>
            <div class="newadress-box">
                <ul>
                    <li class="item-adress">
                        <label>收货地址：</label>
                        <select class="adress-sec">
                            <option>-- 省 --</option>
                        </select>
                        <select class="adress-sec">
                            <option>-- 市 --</option>
                        </select>
                        <select class="adress-sec">
                            <option>-- 区 --</option>
                        </select>
                    </li>
                    <li class="item-adress">
                        <label>详细地址：</label>
                        <input type="text" class="text-box w350" value="" />
                    </li>
                    <li class="item-adress">
                        <label>收货人姓名：</label>
                        <input type="text" class="text-box w210" value="" />
                    </li>
                    <li class="item-adress">
                        <label>手机号码：</label>
                        <input type="text" class="text-box w210" value="" />
                    </li>
                </ul>
            </div>
        </div>
    </div>
	<div class="order-w">
        <h3><b>核对产品信息</b></h3>
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
                                <a class="shop-pic" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
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
                          </td>
                        <td class="price"><p class="tc"><?php echo $product['price']; ?></p></td>
                        <td class="quantity">
                            <div class="tc ovh">
                                <span class="icon2 janbtn"></span>
                                <input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" class="jiajiantext"  />
                                <span class="icon2 jabtn"></span>
                                
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
                <h5 class="c3 f_m">给卖家留言</h5>
                <textarea class="liuy-tarea" name="comment"></textarea>
            </div>
            </div>
        </div>
        <div class="order-w">
            <h3><b>费用确认并支付</b></h3>
            <div class="ovh p15">
                <ul class="order-item-ul">
                    <li class="all-money">
                        <strong><?php echo $checkout_total['title'] ?></strong>
                        <b><?php echo $checkout_total['text'] ?></b>=
                        <?php foreach ($other_totals as $key => $item): ?>
                            <?php if($key!='total'){ ?>
                            <b><?php echo $item['text'] ?></b>
                            <span>(<?php echo $item['title'] ?>)</span>
                            <?php }?>
                            <?php if(count($other_totals) != $key+1){?>
                            +
                            <?php } ?>
                        <?php endforeach ?>
                        
                        
                        
                    </li>
                    <li class="all-money">
                        <strong>支付方式：</strong>
                        <input type="radio" name="a-pay" checked="checked" />支付宝
                        <span class="pl10">（支持全国85家银行、信用卡、网银在线支付）</span>
                    </li>
                    <li>
                        <em class="c_r l">*</em>支付成功后，我们会在7个工作日内发货。
                    </li>
                    <li class="mt10">
                        <div class="w210"><input type="submit" class="gc-tab-sub" value="提交订单" /></div> 
                    </li>
                </ul>
            </div>
        </div>
    </div>

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
</script>
<?php echo $footer; ?>