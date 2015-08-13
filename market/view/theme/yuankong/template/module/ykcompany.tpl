    <div class="rel pb10">
        <h3 class="index-t l-products"><?php echo $title ?></h3>
    </div>
    <div class="ovh fix b_f">
        <div class="l-gs-list btb3">
            <div class="w900 fix">
                <?php foreach ($companies as $item): ?>
                <dl class="gslist-dl">
                    <dt class="gs-list-dt">
                        <i class="<?php echo $item['icon_class'] ?>"></i>
                        <?php echo $item['title'] ?>
                    </dt>
                    <?php if(isset($item['data']) && is_array($item['data'])){?>
                    <?php  foreach ($item['data'] as $info): ?>
                    <dd class="gs-l-dd">
                        <a href="<?php echo $info['link'] ?>">
                            <?php if(!empty($info['title'])){
                                echo truncate_string($info['title'],30);
                            }?>
                        </a>
                    </dd>
                    <?php endforeach ?>
                    <?php }?>
                </dl>
                <?php endforeach ?>                
            </div>
        </div>
        <div class="r-gs-list btb3">
            <ul class="r-gs-ul" id="taber">
                <li class="taboff tabon"><?php echo $text_find ?><i class="icon s-down"></i></li>
                <li class="taboff"><?php echo $text_lateast ?><i class="icon s-down"></i></li>
            </ul>
            <div class="plr ovh">
                <form action="<?php echo $action ?>" method="post" id="company-index-form">
                    <div class="gsbox" style="display: block;">
                        <p class="f_m c8 pt5"><?php echo $text_remark ?></p>
                        <p class="f_m c8 validate"></p>
                        <input type="text" class="gc-tab-text mt5 gcname" name="account" placeholder="<?php echo $entry_name ?>">
                        <input type="text" class="gc-tab-text mt15 gctel" name="mobile_phone" placeholder="<?php echo $entry_telephone ?>">
                        <input type="submit" class="gc-tab-sub mt15" value="<?php echo $button_apply ?>">
                    </div>
                </form>
                <div class="gsbox" style="display: none;">
                    <ul class="ovh mt5">
                        <?php foreach ($lateast as $key => $item): ?>
                        <li class="new-gs txt_clip">
                            <i class="r-bg-b"><?php echo $key+1 ?></i>
                            <a href="<?php echo $item['link'] ?>"><?php echo truncate_string($item['title'],30) ?></a></li>    
                        <?php endforeach ?>
                    </ul>
                    <?php if(count($lateast) > 5){ ?>
                    <p class="tr"><a href="<?php echo $more ?>" class="more"><?php echo $text_more ?></a></p>
                    <?php }?>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/jquery.validate.js"></script>
    <script type="text/javascript">
        o.moushov.init("#taber li",".gsbox");
        $(function(){
            $("#company-index-form").validate({
                rules:{
                    account: {
                        required: true,                        
                        byteRangeLength: [2,20],
                        nameCN:true,
                    },
                    telephone: {
                        required: true,
                        isMobile: true
                    }
                },
                messages:{
                    account:{
                        required:'请输入名字'
                    },
                    telephone:{
                        required:'请输入联系电话'
                    }
                },
                submitHandler: function(form) {   
                    //form.submit();   
                    $.ajax({
                        url:form.action,
                        method:'post',
                        data:$(form).serialize(), 
                        dataType:'json',
                        success:function(json){
                            if(json.status==1){
                                Alertbox({type:true,msg:json.msg,delay:5000});
                            }else{
                                Alertbox({type:false,msg:json.error,delay:5000});
                            }
                        }
                    })
                },
                errorPlacement: function (error, element) {
                    $('#company-index-form p.f_m').hide()
                    $('#company-index-form p.validate').html(error).show(); 
                },
                success:function(e){
                    $('#company-index-form p.validate').html('<?php echo $text_remark ?>');
                }

            });
        })
    </script>