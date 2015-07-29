<div class="gc-boxl">
    <?php if($groups){?>
    <ul class="gc-table" id="tab">
        <?php $n=0;foreach ($groups as $item): ?>
        <li class="taboff <?php echo !$n ? 'tabon' : '' ?>"><?php echo $item['name'] ?><i class="icon s-down"></i></li>
        <?php $n++; endforeach ?>
        
    </ul>
    
    <div class="ovh">
        <?php $n=0;foreach ($groups as $item): ?>
        <form action="<?php echo $action ?>" method="post" id="design-form">
            <div class="gc-b-detail">
                <p class="f_m c8"><?php echo $item['remark'] ?></p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="1" />
                <input type="submit" class="gc-tab-sub mt15" value="立即申请" />
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

    <script type="text/javascript">
        o.moushov.init("#tab li",".gc-b-detail");
    </script>
    <?php }?>
</div>