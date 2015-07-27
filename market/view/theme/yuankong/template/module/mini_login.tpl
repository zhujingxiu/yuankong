<form id="mini-login" method="post" action="<?php echo $login ?>">
    <div class="login-jion-box">
        <div class="logintext">
            <i class="icon2 person"></i><input type="text" name="mobile_phone" value="<?php echo $mobile_phone; ?>" class="login-t" placeholder="<?php echo $entry_mobile_phone; ?>"/>
        </div>
        <div class="logintext">
            <i class="icon2 passwd"></i><input type="password" name="password" value="<?php echo $password; ?>" class="login-t" placeholder="<?php echo $entry_password; ?>"/>
        </div>
        <div class="loginb-yz">
            <a href="<?php echo $forgotten; ?>" class="r"><?php echo $text_forgotten; ?></a>
            <input type="checkbox" name="remember" value="1"/><em class="pl5"><?php echo $text_auto ?></em>
        </div>
        <div class="mt15">
            <input type="submit" class="gc-tab-sub" value="<?php echo $button_login; ?>" />
        </div>
        <input name="redirect" value="" type="hidden">
        <?php if($oauth_html){ ?>
        <div class="mt15">
            <?php echo $oauth_html ?>
        </div>
        <?php }?>
    </div>
</form>