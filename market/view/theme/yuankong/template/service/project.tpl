
<?php echo $header; ?>
<div class="mt10 qz-bannerbox">
    <div class="w fix ovh">
        <img src="asset/image/project/zt-pic3.jpg" />
    </div>
</div>
<div class="zt-secbox">
    <div class="w ovh">
        <img src="asset/image/project/ztpic4.jpg" />
    </div>
</div>
<div class="b_f ptb">
    <div class="w ovh">
        <img src="asset/image/project/ztpic5.jpg" />
    </div>
</div>
<div class="zt-secbox">
    <div class="w ovh">
        <img src="asset/image/project/ztpic6.jpg" />
    </div>
</div>
<div class="b_f ptb">
    <div class="w ovh">
        <img src="asset/image/project/ztpic7.jpg" />
    </div>
</div>
<div class="zt-secbox">
    <div class="w ovh">
        <img src="asset/image/project/ztpic8.jpg" />
    </div>
</div>

<div class="fixed-btn" style="display:block;">
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
</div>

<script type="text/javascript">
    $(function(){
        o.dlist.init(".s-select",".search-dt",".search-dd");
        o.dlist.init(".chose-xm",".c-xm-dt",".c-xm-dd");
        valid.gcdj.gcvdation(".gc-b-detail");
        valid.gcdj.gcvdation(".fix-gc");
        o.mous.init(".btn-ul li","hover");
    });
</script>
<?php echo $footer; ?>