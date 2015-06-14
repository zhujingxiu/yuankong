<div class="rel pb10">
    <h3 class="index-t">案列精选</h3>
</div>
<div class="bd2 rel anbox btb3">
    <span class="l-rline icon2"></span>
    <div class="ovh">
        <ul class="hzlogopic">
        <?php if( count($cases) ) { ?>
         <?php foreach ($cases as $item) {  ?>
            <li class="logopic">
                <a href="<?php echo $item['link']; ?>">
                    <img src="<?php echo $item['thumb']; ?>" />                    
                </a>
            </li>
        <?php } ?>
        <?php } ?>
        </ul>
    </div>
</div>
