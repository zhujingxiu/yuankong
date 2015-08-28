<div class="<?php echo $container_class ?> rel fix">
        <div class="l ovh">
            <ul class="nav fix">
                <?php foreach ($navgatiors as $item): ?>
                <li class="nav-li <?php echo $item['selected'] ? 'on' : '' ?>">
                    <a href="<?php echo $item['link'] ?>"><?php echo $item['title'] ?></a>
                    <?php if($item['icon']){ ?>
                    <i class="<?php echo $item['icon'] ?>"></i>
                    <?php } ?>
                </li>
                <?php endforeach ?>
            </ul>
        </div>
        <?php if($container_class=="w"){?>
        <div class="nav-adbox"><a href="<?php echo $commonweal ?>"><img src="<?php echo $nav_img ?>" /></a></div>
        <?php }?>
    </div>
<script type="text/javascript">
    o.mous.init(".nav-adbox","hov");
    $(function(){
        var keyword = '<?php echo $keyword ?>';
        if(keyword == ''){
            $('ul.nav > li.nav-li:first').removeClass('on').addClass('on');
        }else{
            
            $.each($('ul.nav > li.nav-li'),function(){
                if($(this).find('a').attr('href').indexOf(keyword)!=-1){
                    $('ul.nav > li.nav-li.on').removeClass('on');
                    $(this).addClass('on');
                }
            })
        }
    });
</script>