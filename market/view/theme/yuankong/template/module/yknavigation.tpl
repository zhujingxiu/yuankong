<div class="w rel fix">
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
        
        <div class="nav-adbox"><img src="<?php echo $nav_img ?>" /></div>
        
    </div>
<script type="text/javascript">
    o.mous.init(".nav-adbox","hov");
</script>