<?php echo $header; ?>

<div class="b_f">
    <div class="w ovh">
        <img src="market/view/theme/yuankong/yk_img/adimg/ztpic25.jpg" />
    </div>
</div>
<div class="zt-secbox">
    <div class="w ovh">
        <img src="market/view/theme/yuankong/yk_img/adimg/ztpic26.jpg" />
    </div>
</div>
<div class="b_f">
    <div class="w ovh pt20">
        <div class="ovh mt20">
            <div class="tc">
                <h2 class="zt-title">消防常见问题</h2>
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

</script>
<?php echo $footer; ?>