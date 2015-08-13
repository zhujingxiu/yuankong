<div class="gc-boxl">
    <?php if($groups){?>
    <ul class="gc-table" id="tab">
        <?php $n=0;foreach ($groups as $item): ?>
        <li class="taboff <?php echo !$n ? 'tabon' : '' ?>"><span class="group-txt"><?php echo $item['name'] ?></span><i class="icon s-down"></i></li>
        <?php $n++; endforeach ?>
        
    </ul>
    
    <div class="ovh">
        <?php $n=0;foreach ($groups as $item): ?>
        <form method="post" id="project-apply-<?php echo $item['group_id'] ?>">
            <div class="gc-b-detail" style="display:<?php echo !$n ? 'block' : 'none' ?>">
                <p class="f_m c8"><?php echo $item['remark'] ?></p>
                <p class="f_m c8 validate"></p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="<?php echo $item['group_id'] ?>" />
                <input type="submit" class="gc-tab-sub mt15 apply-project" value="立即申请" />
            </div>
        </form>
        <?php $n++; endforeach ?>

        <div class="tel-phone">
            <i class="icon telphone"></i>服务热线:400-883-4119
        </div>
        <div class="gc-f-cn"></div>
    </div>
    <p class="e-cnuo">
        <em class="c46">郑重承诺:</em>所有与e站签约客户消防服务项目均实行先办理后付费，同时免费享有一年消防后续服务；若未在约定时间内办理，e站将双倍退款。
    </p>
    <style type="text/css">
        .group-txt{width: 38px;word-break:break-all;display: inline-block; }
    </style>
    <script type="text/javascript" src="<?php echo TPL_JS ?>validation/dist/jquery.validate.js"></script>
    <script type="text/javascript">
        o.moushov.init("#tab li",".gc-b-detail");
        $(function(){
            $.validator.setDefaults({      
                submitHandler: function(form) {   
                    //form.submit();   
                    $.ajax({
                        url:'<?php echo $action ?>',
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
                errorElement: "em",
                focusInvalid: true                
            }),
            <?php foreach ($groups as $item){ ?>
            $("#project-apply-<?php echo $item['group_id'] ?>").validate({
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
                        required:'请输入名字',
                        byteRangeLength:'姓名长度须在2到20个字符之间'
                    },
                    telephone:{
                        required:'请输入手机号码'
                    }
                },
                errorPlacement: function (error, element) {
                    $('#project-apply-<?php echo $item['group_id'] ?> p.f_m').hide()
                    $('#project-apply-<?php echo $item['group_id'] ?> p.validate').html(error).show(); 
                },
                success:function(e){
                    $('#project-apply-<?php echo $item['group_id'] ?> p.validate').html('申请后我们会及时与您联系');
                }
            });
            <?php }?>
            $.validator.addMethod("byteRangeLength", function(value, element, params) {
                var valueStripped = stripHtml(value);
                return this.optional(element) || valueStripped.length >= params[0] && valueStripped.length <= params[1];
            }, "字符长度须在 {0} 到 {1} 之间");

            $.validator.addMethod("nameCN", function(value, element) {
                namestr = value.replace(/\(|\)|\s+|-/g, "");
                return this.optional(element) || namestr.match(/^[\u4e00-\u9fa5]{2,6}$/);
            }, "请填入正确的联系人名字");

            $.validator.addMethod("isMobile", function(phone_number, element) {
                phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
                var isMobile = this.optional(element) || phone_number.length > 9 &&
                    phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
                return isMobile;
            }, "手机号码非法");
        });
    </script>

    <?php }?>
</div>