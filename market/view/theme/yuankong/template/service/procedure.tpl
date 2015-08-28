
<?php echo $header; ?>
<?php echo $page_content ?>
<?php if ($quick_project): ?>
	
<div class="zt-fix">
    
    <div class="w tr fix-gc project-form">
        <p class="dib"></p>
        <input type="text" class="gc-tab-text gcname" name="account" placeholder="您的姓名" />
        <input type="text" class="gc-tab-text gctel" name="telephone" placeholder="您的手机号" />
        <input type="hidden" name="group_id" value="<?php echo $group_id ?>"/>
        <input type="button" class="gc-tab-sub" onclick="applyProject(this);" value="立即申请" />
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
<?php endif ?>
<div class="fixed-btn" style="display:block;">
    <ul class="btn-ul">
        <li <?php echo !$group_id ? 'class="hover"' : '' ?>>
            <a href="<?php echo $prefix['link'] ?>" class="btn-a">
                <span class="grp-txt"><?php echo $prefix['name'] ?></span>
            </a>
            <span class="iconlc"><img src="<?php echo $prefix['icon'] ?>" /></span>
        </li>
        <?php foreach ($groups as $item): ?>
        <li<?php echo $item['group_id'] == $group_id ? ' class="hover"' : '' ?>>
            <a href="<?php echo $item['link'] ?>" class="btn-a">
                <span class="grp-txt"><?php echo $item['name'] ?></span>
            </a>
            <span class="iconlc"><img src="<?php echo $item['icon'] ?>" /></span>
        </li>
        <?php endforeach ?>
    </ul>
</div>
<script type="text/javascript">
    $(function(){
        o.mous.init(".btn-ul li","hover");
    });
</script>
<?php echo $footer; ?>