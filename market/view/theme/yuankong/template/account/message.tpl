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
                <div class="xinxi znnew">
                    <?php if($messages){ ?>
                    <?php foreach ($messages as $item): ?>                
                    <dl>
                        <dt <?php echo $item['read'] ? 'class="looked"' : '' ?>>

                            <span class="fr"><a onclick="delMsg(<?php echo $item['message_id'] ?>)">删除</a></span>
                            <span class="fr"><?php echo $item['date_added'] ?>&nbsp; &nbsp;</span>
                            <a onclick="detail(<?php echo $item['message_id'] ?>,this);" title="<?php echo $item['subject'] ?>">
                                <?php echo truncate_string($item['subject']) ?>
                            </a>
                        </dt>
                        <dd class="znnews">
                            <?php echo $item['text'] ?>
                        </dd>
                    </dl>
                    <?php endforeach ?>
                    <?php }else{ ?>
                    <dl>
                        <dd class="znnews" style="display:block;">
                            <?php echo $text_empty ?>
                        </dd>
                    </dl>
                    <?php }?>
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
    function detail(message_id,el){        
        if($(el).parent().next('.znnews').css('display')=='none'){
            $('.znnews').hide();
            $(el).parent().removeClass('looked').addClass('looked').next('.znnews').show();
            $.get('index.php?route=account/message/setRead',{message_id:message_id});
        }else{
            $('.znnews').hide();
            $(el).parent().removeClass('looked').addClass('looked').next('.znnews').hide();
        }        
    }
    function delMsg(message_id){
        if(confirm('确认删除吗？')){
            $.get('index.php?route=account/message/delete',{message_id:message_id},function(){location.reload();});
        }
    }
</script>
<?php echo $footer; ?>