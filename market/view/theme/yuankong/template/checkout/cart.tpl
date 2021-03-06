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
        <li><p class="process-num">2</p><p>填写/确认订单</p></li>
        <li><p class="process-num">3</p><p>付款</p></li>
        <li><p class="process-num">4</p><p>支付成功</p></li>
    </ul>
    <?php if ($logo) { ?>
    <a href="<?php echo $home; ?>" class="pr10">
      <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
    </a>
    <?php } ?>
    <span class="pl20 logospan"><?php echo $heading_title ?></span>
  </div>

  <?php if($this->cart->hasProducts() && !$this->customer->isLogged()){?>
  <div class="gwc-login-ts">
    <i class="icon2 gth-small"></i>您还没有登录！<a href="<?php echo $action ?>" class="c_g mini-login">登录</a>后购物车的商品将保存到您账号中
  </div>
  <?php } ?>
  <?php echo $content_top; ?>

  <div id="content" class="checkout-cart mt20">
    <?php if($this->cart->hasProducts()){?>
    <div class="f_xl c_red"><i class="l-h-b"></i>全部商品</div>
      <div class="mt10 fix" >
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <div class="cart-info">
        <table class="cart-table">
          <thead>
            <tr>
                <th class="cart-h">
                  <input type="checkbox" class="headcheck" checked="checked" name="all"/>
                  <label>全选</label>
                </th>
                <th class="shop-n"><?php echo $column_name; ?></th>
                <th class="price"><?php echo $column_price; ?></th>
                <th width="130" class="quantity"><?php echo $column_quantity; ?></th>
                <th class="total"><?php echo $column_total; ?></th>
                <th width="120">操作</th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr>
              <td class="t-indet">
                <input type="checkbox" class="headcheck" name="selected[]" checked="checked" value="<?php echo $product['key'] ?>">
              </td>
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
                  <span class="icon2 janbtn minus-qty"></span><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" class="jiajiantext"  /><span class="icon2 jabtn plus-qty"></span>
                  <input type="hidden" name="price[<?php echo $product['key']; ?>]" value="<?php echo $product['_price'] ?>"/>
                </div>
              </td>
              
              <td class="total"><p class="tc c_red"><b><?php echo $product['total']; ?></b></p></td>
              <td>
                <p class="tc">
                <a href="<?php echo $product['remove']; ?>" class="remove-item">
                  <img src="market/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" />
                </a></p>
              </td>
            </tr>
            <?php } ?>
            <?php if(false){?>
            <?php foreach ($vouchers as $vouchers) { ?>
            <tr>
              <td class="image"></td>
              <td class="name"><?php echo $vouchers['description']; ?></td>
              <td class="model"></td>
              <td class="quantity"><input type="text" name="" value="1" size="1" disabled="disabled" />
                &nbsp;<a href="<?php echo $vouchers['remove']; ?>"><img src="market/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
              <td class="price"><?php echo $vouchers['amount']; ?></td>
              <td class="total"><?php echo $vouchers['amount']; ?></td>
            </tr>
            <?php }} ?>
          </tbody>
        </table>
        <div class="tablefoot">
          <p class="l pl10">
            <input type="checkbox" class="headcheck" checked="checked" name="all"/><label>全选</label>
          </p>
          <p class="pl20 l">
            <a href="javascript:void(0);" class="c-blue plr" onclick="removeItem();">删除选中商品</a>
            <a href="javascript:void(0);" class="c-blue plr" onclick="clearCart();">清空购物车</a> 
          </p>
          <?php if(isset($totals['sub_total'])){?>
          <div class="r c2">
            <span class="plr">已选商品<em id="count-products"><?php echo $this->cart->countProducts() ?></em>件</span>
            <b class="plr">
              <?php echo $totals['sub_total']['title'] ?>
              <i id="cart-sub-total" class="c_red f_xl"><?php echo $totals['sub_total']['text'] ?></i>
            </b>
            <a href="javascript:void(0);" id="checkout-cart" class="js-sub"><?php echo $button_checkout; ?></a>
          </div>
          <?php }?>
        </div>
      </div>
    </form>
    
    </div>
    <?php }else{?>
    <div class="ovh">
        <div class="empty-gwc">
            <span class=" icon2 gwc-big-btn"></span>
            <span class="empty-card">
                <b>您的购物车还是空的
                  <?php if(!$this->customer->isLogged()){ ?>，
                  <a href="javascript:void(0);" class="c-blue mini-login">马上登录</a>可展示您之前加入购物车的商品
                  <?php }?>
                </b>
                <br>
                <a href="<?php echo $home ?>" class="c-blue mr15">商城首页</a>
                <a href="<?php echo $store ?>" class="c-blue">消防商城</a>
            </span>
        </div>
    </div>
    <?php }?>
    <?php echo $content_bottom; ?>
  </div>
</div> 

<script type="text/javascript">
  $('.headcheck[name="all"]').bind('click',function(){
    $('.headcheck[name^="selected"]').prop('checked', this.checked);
    $('.headcheck[name="all"]').prop('checked', this.checked);
    cart_list();
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
    cart_list();
  });
  var cart_list = function (){
    var amount = 0.00 ,countProducts = 0;
    $.each($('.headcheck[name^="selected"]'),function(){
      if($(this).is(":checked")){
        var _qty = parseInt($(this).parent().parent('tr').find('input[name^="quantity"]').val()),
        _price = parseFloat($(this).parent().parent('tr').find('input[name^="price"]').val()).toFixed(2);
        countProducts += _qty;
        amount += _qty*_price;
      }
    });
    $('#count-products').html(countProducts);
    $('#cart-sub-total').html(format_amount(amount));
  }
  var format_amount = function(amount){
    return '<?php echo $this->currency->getSymbolLeft() ?>'+parseFloat(amount).toFixed(2);
  }
  $('.mini-login').bind('click',function(){
    $('#tm-mask').show();
    $('.iframe-login').show().focus();
  });
  $(document).on('click','#tm-mask',function(){
    $('.iframe-login').hide();
    $('#tm-mask').hide();
  }).on('keydown',function(e){
    if(e.which === 27) {
      $('.iframe-login').hide();
      $('#tm-mask').hide();
    }
    if (e.keyCode == 13) {
      $('#mini-login').submit();
    }
  });

  $('#checkout-cart').bind('click',function(){
    <?php if(!$this->customer->isLogged()){?>
      $('#tm-mask').show();
      $('.iframe-login').show().focus();
    <?php }else{?>
      if($('.headcheck[name^="selected"]:checked').length){
        var selected = [];
        $.each($('.headcheck[name^="selected"]:checked'),function(){            
            selected.push({
              key:$(this).val(),
              qty:parseInt($(this).parent().parent('tr').find('input[name^="quantity"]').val())
            });
        });
        if(selected.length>0){
            selectedCheckout($.toJSON(selected));
        }
        
      }else{
        alert('没有选中商品');
      }

    <?php }?>
  });
  $('input[name^="quantity"]').change(function(){
    changeQty(this);
  })
  function changeQty(el){
    $.ajax({
      url:'index.php?route=checkout/cart',
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


<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<?php echo $footer; ?>
