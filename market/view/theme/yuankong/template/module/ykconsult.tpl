<div class="xg-style">
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
    <h3 class="title f_l">客户咨询    </h3>
    <?php }?>
    <div class="p15">
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
        <ul class="ovh">
            <?php foreach ($helps as $item): ?>
            <li class="gs-l-dd">
                <a href="#"><?php echo truncate_string($item['text'],18) ?></a>
            </li>
            <?php endforeach ?>
        </ul>
        <div class="mt15">
    <?php }?>
            <h4 class="f_m c3">没有想要的回答试试这里</h4>
            <div class="ovh pt10">
                <textarea class="ask-textarea" name="ask_text" placeholder="请输入您要咨询的内容"></textarea>
            </div>
            <p class="ovh tc pt10"><input type="button" class="gc-tab-sub db ask-for" value="立即提交" /></p>
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
        </div>
    <?php }?>
    </div>
    
</div>
<script type="text/javascript">
    $('.ask-for').bind('click',function(){
        <?php if(!$this->customer->isLogged()){?>
            $('#tm-mask').show();
            $('.iframe-login').show().focus();
        <?php }else{?>                
            var text = $('textarea[name="ask_text"]').val();
            if(text!=''){
                $.ajax({
                    url:'index.php?route=information/wiki/ask',
                    type:'post',
                    data:{text:text},
                    dataType:'json',
                    success:function(json){
                        if(json.status==1){
                            Alertbox({type:true,msg:json.msg,delay:5000});
                            setTimeout("location.reload();",5000);                
                        }else{
                            Alertbox({type:false,msg:json.error,delay:5000});
                        }
                    }
                })
            }else{
                $('textarea[name="ask_text"]').focus();
            }
        <?php }?>
    });
</script>
