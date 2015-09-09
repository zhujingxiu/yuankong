<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
  	<div class="<?php echo $SPAN[0];?> aside">
  		<?php echo $column_left; ?>
  	</div>
    <?php endif; ?> 
    <div class="<?php echo $SPAN[1];?> article">
        <div class="userbox3">
            <div class="userboxtop">
            <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
            </div>
            
            <div class="message">                          
              <h5><i class="title-btn"></i><?php echo $text_order; ?> # <?php echo $order_id; ?></h5>
              <ul class="orderstyle-ul">
                <li><label>下单时间：</label> <?php echo $date_ordered; ?></li>
                <li><label>联系人：</label> <?php echo $fullname; ?></li>
                <li><label>手机号码：</label> <?php echo $mobile_phone; ?></li>
                <?php if(!empty($email)){?>
                <li><label>Email：</label> <?php echo $email; ?></li>
                <?php }?>
              </ul>
            </div>
            <div class="message">
              <h5><i class="title-btn"></i>商品信息</h5>
              <table class="cart-table">
                <thead>
                  <tr>
                    <th class="shop-n">商品</th>
                    <th width="120">规格型号</th>
                    <th>数量</th>
                    <th>总价</th>
                  </tr>
                </thead>
                <tbody>                    
                  <tr>
                    <td>
                      <div class="ovh">
                        <a class="shop-pic" >
                            <img src="<?php echo $image ?>" />
                        </a>
                        <span class="shop-name"><?php echo $product; ?></span>
                      </div>
                    </td>
                    <td><p class="tc"><?php echo $model; ?></p></td>
                    <td><p class="tc f_m c_g"><?php echo $quantity; ?></p></td>
                    <td><p class="tc f_m c_g"><?php echo $total; ?></p></td>
                  </tr>                    
                </tbody>
              </table>
            </div>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
            <div class="dianpingxq martop20">
            <?php echo $text_description; ?>  
              <dl class="dpxq">
                <dt><?php echo $entry_reason; ?></dt>
                <dd>
                  <select name="return_reason_id" class="adress-sec" style="width: 150px">
                  <?php foreach ($return_reasons as $return_reason) { ?>
                  <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>                  
                    <option value="<?php echo $return_reason['return_reason_id']; ?>" selected="selected" ><?php echo $return_reason['name']; ?></option>
                  <?php } else { ?>
                    <option value="<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></option>
                  <?php  } ?>
                  <?php  } ?>
                  </select>
                </dd>
                <dt><?php echo $entry_opened; ?></dt>              
                <dd>
                  <?php if ($opened) { ?>
                  <input type="radio" name="opened" value="1" id="opened" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="opened" value="1" id="opened" />
                  <?php } ?>
                  <label for="opened"><?php echo $text_yes; ?></label>
                  <?php if (!$opened) { ?>
                  <input type="radio" name="opened" value="0" id="unopened" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="opened" value="0" id="unopened" />
                  <?php } ?>
                  <label for="unopened"><?php echo $text_no; ?></label>
                </dd>
            </dl>
            <div class="dpright" id="return-form">
              <dl class="dpxq dpw1">
                <dd><?php echo $entry_fault_detail; ?></dd>
                <dd><textarea name="comment" style="width: 305px;"><?php echo $comment; ?></textarea></dd>
                <dd><?php echo $entry_captcha; ?></dd>
                <dd class="captcha" style="margin: 1px 15px;">
                    <input type="text" name="captcha" value="<?php echo $captcha; ?>" class="input-t" size="8"/>       
                    <img src="<?php echo $captcha_link ?>"/>
                    <i class="pl10 c_g chg-img" style="cursor: pointer;">换一张</i>
                </dd>
                <?php if ($text_agree) { ?>
                <dd class="right"><?php echo $text_agree; ?>
                  <?php if ($agree) { ?>
                  <input type="checkbox" name="agree" value="1" checked="checked" />
                  <?php } else { ?>
                  <input type="checkbox" name="agree" value="1" />
                  <?php } ?>
                </dd>
                <?php } ?>
              </dl>
              <input type="hidden" name="order_id" value="<?php echo $order_id;?>" />
              <input type="hidden" name="product_id" value="<?php echo $product_id;?>" />
              <input type="button" id="btn-return" value="提交申请" />
            </div>
          </form>
        </div>
      </div>
  </div>
  <?php if( $SPAN[2] ): ?>
  <div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
  </div>
  <?php endif; ?>
</div>
<script type="text/javascript"><!--
  $(document).ready(function() {
    $('.captcha .chg-img').bind('click',function(e){
      e.preventDefault();
      $('.captcha img').attr('src',"<?php echo $captcha_link ?>&t="+(Math.round(Math.random()*999)+9999))
    });
  });
  $('#btn-return').bind('click',function(){
    if($('input[name="rating"]').val()<=0){
      alert('请为 服务满意度 选择一个星级');
      return false;
    }
    if($('input[name="shipping"]').val()<=0){
      alert('请为 物流服务 选择一个星级');
      return false;
    }
    if($('input[name="service"]').val()<=0){
      alert('请为 客服服务 选择一个星级');
      return false;
    }
    var txt = $('textarea[name="text"]').val();
    if(getStrActualLen(txt) <5 || getStrActualLen(txt) >=300){
      alert('评论内容须在5-300个字符之间');
      return false;
    }
    $.ajax({
      url:'index.php?route=account/return/write',
      type:'post',
      data:$('#return-form input,#return-form textarea'),
      dataType:'json',
      success:function(json){
        if(json.status==1){
            Alertbox({type:true,msg:json.msg,delay:5000});
            location.href='<?php echo $this->url->link('account/return') ?>';
        }
      }
    });
  })
//--></script> 
<?php echo $footer; ?>