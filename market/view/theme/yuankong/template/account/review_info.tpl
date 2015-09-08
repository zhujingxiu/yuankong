<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

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
            <div class="dianpingxq martop20">
                <dl class="dpxq">
                    <dt>订单信息：</dt>
                    <dd><a href="#"><?php echo $product ?></a></dd>
                    <dd>规格型号:<?php echo $model ?>
                    <?php if($options){?>
                    <?php foreach ($options as $item): ?>
                        ，<?php echo $item['value'] ?>
                    <?php endforeach ?>
                    <?php }?>
                    </dd>
                    <dd>数量:<?php echo $quantity ?></dd>
                </dl>
                <div class="dpright" id="review-form">
                    <dl class="dpxq dpw1">
                        <dt>我来点评：</dt>
                        <dd><span class="rating"> 服务满意度：</span>
                            <a class="item" data-val="1" title="差"></a>
                            <a class="item" data-val="2" title="一般"></a>
                            <a class="item" data-val="3" title="满意"></a>
                            <a class="item" data-val="4" title="很满意"></a>
                            <a class="item" data-val="5" title="非常满意"></a>
                            <input name="rating" value="0" type="hidden"/>
                        </dd>
                        <dd><span class="shipping"> &nbsp;物流服务：</span>
                            <a class="item" data-val="1" title="差"></a>
                            <a class="item" data-val="2" title="一般"></a>
                            <a class="item" data-val="3" title="满意"></a>
                            <a class="item" data-val="4" title="很满意"></a>
                            <a class="item" data-val="5" title="非常满意"></a>
                            <input name="shipping" value="0" type="hidden"/>
                        </dd>
                        <dd><span class="service"> &nbsp;客服服务：</span>
                            <a class="item" data-val="1" title="差"></a>
                            <a class="item" data-val="2" title="一般"></a>
                            <a class="item" data-val="3" title="满意"></a>
                            <a class="item" data-val="4" title="很满意"></a>
                            <a class="item" data-val="5" title="非常满意"></a>
                            <input name="service" value="0" type="hidden"/>
                        </dd>
                    </dl>
                    <textarea name="text"></textarea>
                    <input name="order_id" value="<?php echo $order_id ?>" type="hidden"/>
                    <input name="product_id" value="<?php echo $product_id ?>" type="hidden"/>
                    <input type="button" id="btn-review" value="提交点评" />
                </div>
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div>
<script type="text/javascript">
    $('a.item').bind('click',function(){
        var obj = $(this).parent('dd'),val = $(this).attr('data-val');
        obj.find('a.item').removeClass('hov');
        $.each(obj.find('a.item'),function(){
            if($(this).attr('data-val')<=val){
                $(this).addClass('hov');
            }
        })
        obj.find('input[type="hidden"]').val(val);
    });
    $('#btn-review').bind('click',function(){
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
            url:'index.php?route=account/review/write',
            type:'post',
            data:$('#review-form input,#review-form textarea'),
            dataType:'json',
            success:function(json){
                if(json.status==1){
                    Alertbox({type:true,msg:json.msg,delay:5000});
                    location.href='<?php echo $this->url->link('account/review') ?>';
                }
            }
        });
    })
</script>
<style type="text/css">    
    .dpw1 dd a.hov { background-position: -105px -271px;}
</style>
<?php echo $footer; ?>