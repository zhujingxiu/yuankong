<?php echo $header; ?>
<div class="mt10 px-bannerbox">
    <div class="w fix">
        <div class="l">
            <img src="asset/image/project/zt-pic7.jpg" />
        </div>
        <div class="r">
            <div class="zt-gcsq-dj">
                <h2>免费登记预约项目</h2>
                <div class="gcsq-style">
                    <label>选择项目</label>
                    <?php if ($groups): ?>                   
                    <dl class="chose-xm">
                        <dt class="c-xm-dt"><span>消防培训</span></dt>
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
                    <input type="hidden" name="group_id" value="<?php echo $group_id ?>"/>
                    <input type="button" class="gc-tab-sub mt15" value="立即申请" onclick="applyProject(this);"/>
                </div>
                <div class="tel-phone mt15">
                    <i class="icon telphone"></i>服务热线:400-883-4119
                </div>
            </div>
        </div>
    </div>
</div>

<div class="b_f ptb">
    <div class="w ovh">
        <p><img src="asset/image/project/ztpic20.jpg" /></p>
    </div>
</div>

<div class="w1000">
    <div class="new-sq-khui">
        <div class="c2 f_xxl"><h3>最新申请消防服务</h3></div>
        <div class="fix title mt20">
            <span class="w200"><?php echo $column_group ?></span>
            <span class="w200"><?php echo $column_account ?></span>
            <span class="w200"><?php echo $column_telephone ?></span>
            <span class="w200"><?php echo $column_status ?></span>
            <span class="w200"><?php echo $column_date_applied ?></span>
        </div>
        <div class="ovh mt10 h250">
            <div class="scrolldiv h250 ovh" id="scrolldiv">
                <ul class="sc-begin ovh" id="sc-begin">
                    <?php foreach ($projects as $item): ?>
                    <li class="fix">
                        <span class="w200"><?php echo $item['group'] ?></span>
                        <span class="w200"><?php echo $item['account'] ?></span>
                        <span class="w200"><?php echo $item['telephone'] ?></span>
                        <span class="w200"><?php echo $item['status_text'] ?></span>
                        <span class="w200"><?php echo $item['date_applied'] ?></span>
                    </li>    
                    <?php endforeach ?>

                </ul>
                <ul class="sc-end ovh" id="sc-end"></ul>
            </div>
        </div>
    </div>
</div>
<div class="zt-secbox">
    <div class="w ovh">
        <p><img src="asset/image/project/ztpic21.jpg" /></p>
    </div>
</div>
<!--底部浮动申请框-->
<div class="zt-fix">
    <div class="w tr fix-gc project-form">
        <p class="dib"></p>
        <input type="text" class="gc-tab-text gcname" name="account" placeholder="您的姓名" />
        <input type="text" class="gc-tab-text gctel" name="telephone" placeholder="您的手机号" />
        <input type="hidden" name="group_id" value="<?php echo $group_id ?>"/>
        <input type="button" class="gc-tab-sub " value="立即申请" onclick="applyProject(this);"/>
    </div>
</div>
<script type="text/javascript">
    $(function(){
        o.dlist.init(".s-select",".search-dt",".search-dd");
        o.dlist.init(".chose-xm",".c-xm-dt",".c-xm-dd");
        <?php if(count($projects)>5){?>
        o.scroll.init("scrolldiv",{
            direc:"top",
            speed:150,
            scjl:1
        });
        <?php }?>
        valid.gcdj.gcvdation(".gc-b-detail");
        valid.gcdj.gcvdation(".fix-gc");
        o.scr.init(".zt-fix");
        $('.group-option').bind('click',function(){
            window.open('<?php echo $this->url->link("service/project") ?>'+'&group='+$(this).attr('data-val'));
        })
    });
</script>
<!--右侧定位9图标-->
<div class="fixed-btn">
    <ul class="btn-ul">
        <li>
            <a href="<?php echo $prefix['link'] ?>" class="btn-a">
                <span class="grp-txt"><?php echo $prefix['name'] ?></span>
            </a>
            <span class="iconlc"><img src="<?php echo $prefix['icon'] ?>" /></span>
        </li>
        <?php foreach ($groups as $item): ?>
        <li>
            <a href="<?php echo $item['link'] ?>" class="btn-a">
                <span class="grp-txt"><?php echo $item['name'] ?></span>
            </a>
            <span class="iconlc"><img src="<?php echo $item['icon'] ?>" /></span>
        </li>
        <?php endforeach ?>
        
    </ul>
    <script type="text/javascript">
        $(function(){
            o.mous.init(".btn-ul li","hover");
            window.onscroll=function(){
                var wstop=document.documentElement.scrollTop||document.body.scrollTop;
                if(wstop>=500){
                    $(".fixed-btn").show();
                }else{
                    $(".fixed-btn").hide();
                }
            }
        });

    </script>
</div>
<?php echo $footer; ?>