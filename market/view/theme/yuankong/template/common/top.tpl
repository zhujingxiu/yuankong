<?php $themeConfig = $this->config->get( 'themecontrol' ); ?>

<div class="header f_s">
    <div class="w">

        <div class="l">
            <?php if( isset($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')]) )  { 
                echo html_entity_decode($themeConfig['topleft_customhtml'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'); 
            } ?>
        </div>
        <div class="r">
            <ul class="head-ul">
                <li>
                    <?php if (!$logged) { ?>
                    <a class="plr" href="<?php echo $login ?>"><?php echo $text_login; ?></a>
                    |
                    <a class="plr" href="<?php echo $register ?>"><?php echo $text_register; ?></a>
                    <?php } else { ?>
                    <?php echo $text_logged; ?>
                    <?php } ?>
                </li>
                <li class="my-ezhan rel">
                    <div class="hd">
                        <a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
                        <em class="icon2 h-down"></em>
                    </div>
                    <div class="bd">
                        <a href="<?php echo $order ?>"><?php echo $text_order ?></a>
                        <a href="<?php echo $profile ?>"><?php echo $text_profile ?></a>
                        <a href="<?php echo $message ?>"><?php echo $text_message ?></a>
                    </div>
                </li>
                <li>|</li>
                <li class="my-ezhan rel">
                    <div class="hd">
                        <a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a>
                        <em class="icon2 h-down"></em>
                    </div>
                    <div class="bd">
                        <a href="<?php echo $upload ?>"><?php echo $text_upload ?></a>
                        <a href="<?php echo $perfact ?>"><?php echo $text_perfact ?></a>
                    </div>
                </li>
                <li>|</li>
                <li class="plr"><a href="<?php echo $help ?>"><?php echo $text_help ?></a></li>
                <li>|</li>
                <li class="pl10 cff"><?php echo $text_hotline ?></li>
                <?php if(false){?>
                <li class="top-links">
                <a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
                
                <a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
                <!--a href="<?php //echo $checkout; ?>"><?php //echo $text_checkout; ?></a-->
                <?php //echo $currency; ?>
                <?php //echo $language; ?>                  
                <?php } ?>                  
                </li>
            </ul>
        </div>
    </div>
</div>
<?php if( isset($themeConfig['custom_top_module']) )  { 
    echo html_entity_decode($themeConfig['custom_top_module'], ENT_QUOTES, 'UTF-8'); 
}?>