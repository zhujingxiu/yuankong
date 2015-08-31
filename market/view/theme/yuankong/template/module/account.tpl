<div class="userbox1">
    <?php 
        $route = $this->request->get['route'];
        $part = explode("/", $route);
        $keyword = '';
        if(isset($part[0]) && isset($part[1]))
        $keyword = strtolower($part[0].'/'.$part[1]);

    ?>
    <b class="userbg"></b>
    <dl class="userxinxi">
        <dt><?php echo $text_order; ?></dt>
        <dd><a <?php echo $keyword == 'account/order' ? 'class="redbg"' : '' ?> href="<?php echo $order; ?>">所有订单</a></dd>
        <dd><a <?php echo $keyword == 'account/return' ? 'class="redbg"' : '' ?>href="<?php echo $return; ?>"><?php echo $text_return; ?></a></dd>
    </dl>
    <dl class="userxinxi">
        <dt>我的活动</dt>
        <dd><a <?php echo $keyword == 'account/review' ? 'class="redbg"' : '' ?> href="<?php echo $reviews ?>">订单点评</a></dd>
        <dd><a <?php echo $keyword == 'account/help' ? 'class="redbg"' : '' ?> href="<?php echo $helps ?>">我的提问</a></dd>
    </dl>
    <dl class="userxinxi">
        <dt><?php echo $text_account; ?></dt>
        <dd><a <?php echo $keyword == 'account/edit' ? 'class="redbg"' : '' ?> href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></dd>
        <dd><a <?php echo $keyword == 'account/message' ? 'class="redbg"' : '' ?> href="<?php echo $messages; ?>">站内信息</a></dd>
    </dl>
    

</div>
<?php if($this->customer->isCompany()){?>
<div class="userbox1 mt10">
    <h3><b>企业信息管理</b></h3>
    <ul class="useryy">
      <li class="usergl"><a href="<?php echo $company ?>">企业中心</a></li>
      <li class="userwt"><a href="#">在线提问</a></li>
    </ul>
</div>
<?php }?>