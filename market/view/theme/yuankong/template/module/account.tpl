<div class="userbox1">
    <?php 
        $route = $this->request->get['route'];
        $part = explode("/", $route);
        $keyword = '';
        if(isset($part[0]) && isset($part[1]))
        $keyword = strtolower($part[0].'/'.$part[1]);
        if(!isset($part[2]) || strtolower($part[2]) == 'index'){
            $action = 'index';
        }else{
            $action = strtolower($part[2]);
        }
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
        <dd><a <?php echo $keyword == 'account/bind' ? 'class="redbg"' : '' ?> href="<?php echo $bind; ?>"><?php echo '绑定手机'; ?></a></dd>
        <dd><a <?php echo $keyword == 'account/message' ? 'class="redbg"' : '' ?> href="<?php echo $messages; ?>">站内信息</a></dd>
    </dl>
    

</div>
<?php if($this->customer->isCompany()){ ?>
<div class="userbox1 mt10">
    <h3><b>企业中心</b></h3>
    <dl class="userxinxi"> 
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'index' ) ? 'class="redbg"' : '' ?> href="<?php echo $company ?>">基本资料</a></dd>
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'file' ) ? 'class="redbg"' : '' ?> href="<?php echo $file ?>">上传信息</a></dd>       
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'description' ) ? 'class="redbg"' : '' ?> href="<?php echo $description ?>">公司简介</a></dd>
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'custom1' ) ? 'class="redbg"' : '' ?> href="<?php echo $custom1 ?>">自定义1</a></dd>
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'custom2' ) ? 'class="redbg"' : '' ?> href="<?php echo $custom2 ?>">自定义2</a></dd>
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'cases' ) ? 'class="redbg"' : '' ?> href="<?php echo $cases ?>">案例精选</a></dd>
        <dd><a <?php echo ( $keyword == 'account/company' && $action == 'member' ) ? 'class="redbg"' : '' ?> href="<?php echo $member ?>">优秀团队</a></dd>
    </dl>
</div>
<?php }?>