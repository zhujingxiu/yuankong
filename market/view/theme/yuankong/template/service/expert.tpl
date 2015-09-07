<?php echo $header; ?>

<div class="b_f">
    <div class="w ovh rel">
        <div class="zjia-ask">
            <div class="zt-gcsq-dj">
                <h2>预约解答</h2>
                <div class="gc-b-detail">
                    <textarea class="ask-textarea" name="ask_text" placeholder="请输入您要咨询的内容"></textarea>
                    <input type="submit" class="gc-tab-sub mt15 ask-for" value="立即申请" />
                </div>
                <div class="tel-phone mt15">
                    <i class="icon telphone"></i>服务热线:400-883-4119
                </div>
            </div>
        </div>
        <p class="tr pt5"><img src="market/view/theme/yuankong/yk_img/adimg/ztpic27.jpg" /></p>
    </div>
</div>
<div class="zt-secbox" style="display: none;">
    <div class="w ovh">
        <ul class="jslist mt15">
            <li class="itemli fix">
                <p class="l"><img src="asset/image/data/preson1.jpg" width="250" height="165"/></p>
                <div class="r preson-p">
                    <h4>马云<em>(高级码钻)</em></h4>
                    <p class="t-indet">马云，男，1964年10月15日生于浙江省杭州市，祖籍浙江省嵊州市（原嵊县）谷来镇， 阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、TNC（大自然保护协会）中国理事会主席兼全球董事会成员</p>
                </div>
            </li>
            <li class="itemli fix">
                <p class="l"><img src="asset/image/data/preson1.jpg" width="250" height="165"/></p>
                <div class="r preson-p">
                    <h4>马云<em>(高级码钻)</em></h4>
                    <p class="t-indet">马云，男，1964年10月15日生于浙江省杭州市，祖籍浙江省嵊州市（原嵊县）谷来镇， 阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、TNC（大自然保护协会）中国理事会主席兼全球董事会成员</p>
                </div>
            </li>
            <li class="itemli fix">
                <p class="l"><img src="asset/image/data/preson1.jpg" width="250" height="165"/></p>
                <div class="r preson-p">
                    <h4>马云<em>(高级码钻)</em></h4>
                    <p class="t-indet">马云，男，1964年10月15日生于浙江省杭州市，祖籍浙江省嵊州市（原嵊县）谷来镇， 阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、TNC（大自然保护协会）中国理事会主席兼全球董事会成员</p>
                </div>
            </li>
            <li class="itemli fix">
                <p class="l"><img src="asset/image/data/preson1.jpg" width="250" height="165"/></p>
                <div class="r preson-p">
                    <h4>马云<em>(高级码钻)</em></h4>
                    <p class="t-indet">马云，男，1964年10月15日生于浙江省杭州市，祖籍浙江省嵊州市（原嵊县）谷来镇， 阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、TNC（大自然保护协会）中国理事会主席兼全球董事会成员</p>
                </div>
            </li>
        </ul>
    </div>
</div>
<div class="b_f">
    <div class="w ovh pt20">
        <div class="ovh mt20">
            <div class="tc">
                <h2 class="zt-title">专家解惑</h2>
            </div>
            <div class="scrolldiv h400 ovh mt15" id="scrolldiv">
                <ul class="sc-begin ask-scroll ovh" id="sc-begin">
                    <?php $n = 1;foreach ($helps as $item): ?>
                    <li>
                        <h4><?php echo $n ?>.<?php echo $item['text'] ?></h4>
                        <p>答：<?php echo $item['reply'];?></p>
                    </li>    
                    <?php $n++;endforeach ?>                    
                </ul>
                <ul class="sc-end ask-scroll ovh" id="sc-end"></ul>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        o.scroll.init("scrolldiv",{
            direc:"top",
            speed:150,
            scjl:1
        });
    });
    $('.ask-for').bind('click',function(){
        <?php if(!$this->customer->isLogged()){?>
            $('#tm-mask').show();
            $('.iframe-login').show().focus();
            $('#mini-login input[name="redirect"]').val('<?php echo $this->url->link('service/assistant/expert')?>');
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
<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<?php echo $footer; ?>