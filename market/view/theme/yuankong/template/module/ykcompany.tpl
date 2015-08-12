    <div class="rel pb10">
        <h3 class="index-t l-products"><?php echo $title ?></h3>
    </div>
    <div class="ovh fix b_f">
        <div class="l-gs-list btb3">
            <div class="w900 fix">
                <?php foreach ($companies as $item): ?>
                <dl class="gslist-dl">
                    <dt class="gs-list-dt">
                        <i class="<?php echo $item['icon_class'] ?>"></i>
                        <?php echo $item['title'] ?>
                    </dt>
                    <?php if(isset($item['data']) && is_array($item['data'])){?>
                    <?php  foreach ($item['data'] as $info): ?>
                    <dd class="gs-l-dd">
                        <a href="<?php echo $info['link'] ?>">
                            <?php if(!empty($info['title'])){
                                echo truncate_string($info['title'],30);
                            }?>
                        </a>
                    </dd>
                    <?php endforeach ?>
                    <?php }?>
                </dl>
                <?php endforeach ?>                
            </div>
        </div>
        <div class="r-gs-list btb3">
            <ul class="r-gs-ul" id="taber">
                <li class="taboff tabon"><?php echo $text_find ?><i class="icon s-down"></i></li>
                <li class="taboff"><?php echo $text_lateast ?><i class="icon s-down"></i></li>
            </ul>
            <div class="plr ovh">
                <form action="<?php echo $action ?>" method="post" id="find-form">
                    <div class="gsbox" style="display: block;">
                        <p class="f_m c8 pt5"><em class="c_r"><?php echo $error_name ?></em></p>
                        <input type="text" class="gc-tab-text mt5 gcname" name="account" placeholder="<?php echo $entry_name ?>">
                        <input type="text" class="gc-tab-text mt15 gctel" name="telephone" placeholder="<?php echo $entry_telephone ?>">
                        <input type="submit" class="gc-tab-sub mt15" value="<?php echo $button_apply ?>">
                    </div>
                </form>
                <div class="gsbox" style="display: none;">
                    <ul class="ovh mt5">
                        <?php foreach ($lateast as $key => $item): ?>
                        <li class="new-gs txt_clip">
                            <i class="r-bg-b"><?php echo $key+1 ?></i>
                            <a href="<?php echo $item['link'] ?>"><?php echo truncate_string($item['title'],30) ?></a></li>    
                        <?php endforeach ?>
                    </ul>
                    <?php if(count($lateast) > 5){ ?>
                    <p class="tr"><a href="<?php echo $more ?>" class="more"><?php echo $text_more ?></a></p>
                    <?php }?>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        o.moushov.init("#taber li",".gsbox");
    </script>