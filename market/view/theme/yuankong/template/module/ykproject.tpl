<div class="gc-boxl">
    
    <ul class="gc-table" id="tab">
        <li class="taboff tabon">消防<br />设计<i class="icon s-down"></i></li>
        <li class="taboff">消防<br />检测<i class="icon s-down"></i></li>
        <li class="taboff">消防<br />工程<i class="icon s-down"></i></li>
        <li class="taboff">消防<br />维保<i class="icon s-down"></i></li>
    </ul>
    <div class="ovh">
        <form action="<?php echo $action ?>" method="post" id="design-form">
            <div class="gc-b-detail">
                <p class="f_m c8">十秒登记，免费获取专业消防设计案例</p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="1" />
                <input type="submit" class="gc-tab-sub mt15" value="立即申请" />
            </div>
        </form>
        <form action="<?php echo $action ?>" method="post" id="test-form">
            <div class="gc-b-detail" style="display: none;">
                <p class="f_m c8">十秒登记，免费获取专业消防检测</p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="2" />
                <input type="submit" class="gc-tab-sub mt15" value="立即申请" />
            </div>
        </form>
        <form action="<?php echo $action ?>" method="post" id="project-form">
            <div class="gc-b-detail" style="display: none;">
                <p class="f_m c8">十秒登记，免费获取专业消防工程案例</p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="3" />
                <input type="submit" class="gc-tab-sub mt15" value="立即申请" />
            </div>
        </form>
        <form action="<?php echo $action ?>" method="post" id="maintenance-form">
            <div class="gc-b-detail" style="display: none;">
                <p class="f_m c8">十秒登记，免费获取专业消防维保服务</p>
                <input type="text" class="gc-tab-text mt15 gcname" name="account" placeholder="您的姓名" />
                <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="您的手机号" />
                <input type="hidden" name="group_id" value="4" />
                <input type="submit" class="gc-tab-sub mt15" value="立即申请" />
            </div>
        </form>
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
</div>