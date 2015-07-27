<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><?php echo $heading_title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/basic.css" />
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.1.min.js"></script>
</head>
<body class="admin-bg">
    <div class="admin-login-box">
        <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php } ?>
        <form action="<?php echo $action; ?>" method="post" id="form">
            <dl class="login-box">
                <dt class="login-dt t-c"><img src="view/image/logo.png" alt="消防E站" /></dt>
                <dd class="login-dd">
                    <span class="iconbox"><i class="icon icon-user"></i></span><input type="text" class="login-text" name="username" value="<?php echo $username; ?>" placeholder="<?php echo $entry_username; ?>" />
                </dd>
                <dd class="login-dd">
                      <span class="iconbox2"><i class="icon icon-pwd"></i></span><input type="password" class="login-text" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" />
                </dd>
                <?php if ($error_warning) { ?>
                <dd class="f12 cf" id="error-ts"><?php echo $error_warning; ?></dd>
                <?php } ?>
                <dd class="login-dd-foot">
                    <p class="login-btn">
                        <a href="<?php echo $homepage ?>" class="fr cf f14"><?php echo $text_homepage ?></a> 
                        <input type="submit" class="login-sub" value="<?php echo $button_login; ?>" />
                    </p>
                </dd>
                <?php if ($redirect) { ?>
                <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                <?php } ?>
            </dl>
        </form>
    </div>
<script type="text/javascript"><!--
$('#form input').keydown(function(e) {if (e.keyCode == 13) {$('#form').submit();}});
//--></script> 
</body>
</html>