<div class="gssqbox">
    <div class="zt-gcsq-dj">
        <h2>免费登记预约项目</h2>
        <div class="gcsq-style">
            <label>选择项目</label>
            <?php if ($groups): ?>                   
            <dl class="chose-xm">
                <dt class="c-xm-dt"><span>消防设计</span></dt>
                <dd class="c-xm-dd">
                    <?php foreach ($groups as $item): ?>
                    <span class="group-option" data-val="<?php echo $item['keyword'] ?>"><?php echo $item['name'] ?></span>   
                    <?php endforeach ?>
                </dd>
                
            </dl>
            <?php endif ?>
        </div>
        <div class="gc-b-detail project-form">
            <p class="f_s"></p>
            <input type="text" class="gc-tab-text gcname" name="account" placeholder="您的姓名" />
            <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
            <input type="button" class="gc-tab-sub mt15" value="立即申请" onclick="applyProject(this);">
        </div>
        <div class="tel-phone mt15">
            <i class="icon telphone"></i>服务热线:400-883-4119
        </div>
    </div>
</div>
<div class="mt10">
    <img src="market/view/theme/yuankong/yk_img/adimg/adpic3.jpg">
</div>
<div class="xg-style mt10">
    <h3 class="title f_l"><?php echo $zone_name ?>消防公司排行</h3>
    <div class="p10">
        <ul class="ovh">
            
            <?php $n = 1 ;foreach ($companies as $item) { ?>
                <li class="new-gs txt_clip">
                    <i class="r-bg-b"><?php echo $n ?></i>
                    <a href="<?php echo $item['link'] ?>"><?php echo $item['title'] ?></a>
                </li>
            <?php $n++; } ?>
        </ul>
    </div>
</div>
<script type="text/javascript">

    o.silbings.init(".gs-px-list li","son");
    o.dlist.init(".chose-xm",".c-xm-dt",".c-xm-dd");
    valid.gcdj.gcvdation(".gc-b-detail");

</script>