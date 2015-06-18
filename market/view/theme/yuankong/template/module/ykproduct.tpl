
    <div class="rel pb10">
        <h3 class="<?php echo $title_class ?>"><?php echo $title ?></h3>
    </div>
    <div class="bd2 indexshop fix btb3 b_f">
        <!-- categories -->
        <div class="indexs-l <?php echo $additional_class ?>">
            <?php foreach ($category as $key => $item) { ?>
            <dl class="shop-style <?php echo (count($category) == ($key+1)) ? 'bornone' : '' ?>">
                <dt class="slist-dt">
                    <div class="h">
                        <span class="r slist-jt">&gt;</span>
                        <h3 class="c3 f_m"><?php echo $item['name'] ?></h3>
                        <p>
                            <?php foreach ($item['show'] as $k => $show) { ?>   
                            <a href="<?php echo $show['link'] ?>"><?php echo $show['name'] ?></a>
                            <?php if(($k+1)%3==0){ ?> </p> <p><?php }?> 
                            <?php }?>
                        </p>
                    </div>
                </dt>
                <dd class="slist-dd">
                    <h5 class="c3 f_m"><?php echo $item['name'] ?></h5>
                    <?php foreach ($item['sub_categories'] as $category) { ?>  
                    <a href="<?php echo $category['link'] ?>"><?php echo $category['name'] ?></a>
                    <?php }?>
                </dd>
            </dl>
            <?php }?>
        </div>
        <!-- products -->
        <div class="shop-box">
            <div class="ovh">
                <ul class="shop-box-ul ovh">
                    <?php foreach ($product as $key => $item) { ?>                    
                    <li class="box-ul-li">
                        <a href="<?php echo $item['link'] ?>" class="db rel">
                            <div class="rel z-i">
                                <h5 class="f_m c46"><?php echo $item['name'] ?></h5>
                                <p><?php echo $item['subtitle'] ?></p>
                                <p><em class="c_r f_l"><?php echo $item['price'] ?></em> </p>
                            </div>
                            <img src="<?php echo $item['image'] ?>" class="shoppic">
                        </a>
                    </li>
                    <?php }?>
                </ul>
            </div>
        </div>
        <!-- AD-->
        <?php $rand = rand(0, time())?>
        <div class="r" style="width: 198px;">
            <div class="inslider inslider-<?php echo $rand  ?>">
                <div class="bd">
                    <ul class="fix" style="margin-left: 0px;">
                        <?php foreach ($banner as $key => $item) { ?>   
                        <li style="width: 198px;"><a href="<?php echo $item['link'] ?>"><img src="<?php echo $item['image'] ?>"></a> </li>
                        <?php }?>
                    </ul>
                </div>
                <div class="hd">
                    <ul>
                        <li class="on"></li>
                        <li class=""></li>
                        <li class=""></li>
                    </ul>
                </div>
                <a class="prev icon2" href="javascript:void(0)"></a>
                <a class="next icon2" href="javascript:void(0)"></a>

            </div>
        </div>
    </div>
<script type="text/javascript">
    o.mous.init(".shop-style","hover");
    o.slider.init(".inslider-<?php echo $rand  ?>");
</script>