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
        <div class="userboxcen">
            <ul class="xiaoxi martop20"  id="list0">
                <li <?php echo $tab=='unreview' ? 'class="yes"' : 'class="no"' ?>>
                    <a href="<?php echo $unreview ?>">待点评订单</a>
                </li>
                <li <?php echo $tab=='reviewed' ? 'class="yes"' : 'class="no"' ?>>
                    <a href="<?php echo $reviewed ?>">已点评订单</a>
                </li>
            </ul>
            <div class="xinei clearfix"  id="list0_c_0" style="display:block;">
                <?php if($products){ ?>
                <ul class="dianping martop">
                    <?php foreach ($products as $item): ?>
                    <li>
                        <a href="<?php echo $item['link'] ?>"><input type="button" value="立即点评" class="lijidp"/></a>
                        <a href="<?php echo $item['link'] ?>"><?php echo '【#'.$item['order_id'].'】'.truncate_string($item['name'],40) ?></a>
                        (<?php echo $item['date'] ?>)
                    </li>
                    <?php endforeach ?>
                </ul>
                <?php }?>
                <?php if($reviews){ ?>
                <ul class="dianping martop">
                    <?php foreach ($reviews as $item): ?>
                    <li>     

                        <span><?php echo $item['status'] ?><a onclick="removeReview(<?php echo $item['review_id'] ?>)">删除</a></span>
                        <a href="<?php echo $item['link'] ?>" title="追加评论"><?php echo '【#'.$item['order_id'].'】'.truncate_string($item['text'],40) ?></a>
                        (<?php echo $item['date'] ?>)
                    </li>
                    </li>
                    <?php endforeach ?>
                </ul>
                <?php }?>
                <?php if(($tab=='unreview' && !$products) || ($tab=='reviewed' && !$reviews) ){ ?>
                <div style="margin:10px;padding:5px;"><h3><?php echo $text_empty; ?></h3></div>
                <?php } ?>
                <div class="pagebox mt10"><?php echo $pagination; ?></div>
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
    function removeReview(id){
        if(confirm("确认删除吗？")){
            $.ajax({
                url:'index.php?route=account/review/delete',
                data:'review_id='+id,
                type:'get',
                dataType:'json',
                success:function(json){
                    if(json.status==1){
                        Alertbox({type:true,msg:json.msg,delay:5000});
                        location.reload();
                    }
                }
            });
        }
    }
</script>
<?php echo $footer; ?>