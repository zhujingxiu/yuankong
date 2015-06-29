<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/setting.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
        <a href="#tab-qq"><?php echo $tab_qq; ?></a>
        <a href="#tab-weibo"><?php echo $tab_weibo; ?></a>
        <a href="#tab-alipay"><?php echo $tab_alipay; ?></a>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-qq">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo 'Appid'; ?></td>
              <td><input type="text" name="api_qq_appid" value="<?php echo $api_qq_appid; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'Appkey'; ?></td>
              <td><input type="text" name="api_qq_appkey" value="<?php echo $api_qq_appkey; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'callback'; ?></td>
              <td><textarea name="api_qq_callback" cols="40" rows="5"><?php echo $api_qq_callback; ?></textarea>
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo '请求授权列表'; ?></td>
              <td><div class="scrollbox" style="height:200px;">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($qq_scope as $item) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($item, $api_qq_scope)) { ?>
                    <input type="checkbox" name="api_qq_scope[]" value="<?php echo $item; ?>" checked="checked" />
                    <?php echo $item; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="api_qq_scope[]" value="<?php echo $item; ?>" />
                    <?php echo $item; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_debug; ?></td>
              <td><?php if ($api_qq_debug) { ?>
                <input type="radio" name="api_qq_debug" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_qq_debug" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="api_qq_debug" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_qq_debug" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
          </table>
        </div>
        <div id="tab-weibo">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo 'Appid'; ?></td>
              <td><input type="text" name="api_weibo_appid" value="<?php echo $api_weibo_appid; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'Appkey'; ?></td>
              <td><input type="text" name="api_weibo_appkey" value="<?php echo $api_weibo_appkey; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'callback'; ?></td>
              <td><textarea name="api_weibo_callback" cols="40" rows="5"><?php echo $api_weibo_callback; ?></textarea>
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo '请求授权列表'; ?></td>
              <td><div class="scrollbox" style="height:200px;">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($weibo_scope as $item) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($item, $api_weibo_scope)) { ?>
                    <input type="checkbox" name="api_weibo_scope[]" value="<?php echo $item; ?>" checked="checked" />
                    <?php echo $item; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="api_weibo_scope[]" value="<?php echo $item; ?>" />
                    <?php echo $item; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_debug; ?></td>
              <td><?php if ($api_weibo_debug) { ?>
                <input type="radio" name="api_weibo_debug" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_weibo_debug" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="api_weibo_debug" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_weibo_debug" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
          </table>
        </div>
        <div id="tab-alipay">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo 'Appid'; ?></td>
              <td><input type="text" name="api_alipay_appid" value="<?php echo $api_alipay_appid; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'Appkey'; ?></td>
              <td><input type="text" name="api_alipay_appkey" value="<?php echo $api_alipay_appkey; ?>" size="40" />
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo 'callback'; ?></td>
              <td><textarea name="api_alipay_callback" cols="40" rows="5"><?php echo $api_alipay_callback; ?></textarea>
                </td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo '请求授权列表'; ?></td>
              <td><div class="scrollbox" style="height:200px;">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($alipay_scope as $item) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div class="<?php echo $class; ?>">
                    <?php if (in_array($item, $api_alipay_scope)) { ?>
                    <input type="checkbox" name="api_alipay_scope[]" value="<?php echo $item; ?>" checked="checked" />
                    <?php echo $item; ?>
                    <?php } else { ?>
                    <input type="checkbox" name="api_alipay_scope[]" value="<?php echo $item; ?>" />
                    <?php echo $item; ?>
                    <?php } ?>
                  </div>
                  <?php } ?>
                </div>
              </td>
            </tr>
            <tr>
              <td><?php echo $entry_debug; ?></td>
              <td><?php if ($api_alipay_debug) { ?>
                <input type="radio" name="api_alipay_debug" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_alipay_debug" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="api_alipay_debug" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="api_alipay_debug" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<?php echo $footer; ?>