<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?> aside">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?> article">
    <?php echo $content_top; ?>
    <div class="userbox3">
        <div class="userboxtop">
          <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
        </div>
        <div class="userboxcen">
            <ul class="xiaoxi martop20"  id="list0">
                <li <?php echo $tab=='unreview' ? 'class="yes"' : 'class="no"' ?>>
                    <a href="<?php echo $unreview ?>">待点评订单</a>
                </li>
                <li <?php echo $tab=='reviewed' ? 'class="yes"' : 'class="no"' ?>>
                    <a href="<?php echo $reviewed ?>">已点评订单</a>
                </li>
            </ul>
            <div class="xinei clearfix"  id="list0_c_0" style="display:block;">
                <ul class="dianping martop">
                    <li><input type="submit" value="立即点评" class="lijidp"/><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><input type="submit" value="立即点评" class="lijidp"/><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><input type="submit" value="立即点评" class="lijidp"/><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                </ul>
            </div>
            <div class="xinei" id="list0_c_1" style="display:none;">
                <ul class="dianping martop">
                    <li><span>已点评<a href="#">删除</a></span><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><span>已点评<a href="#">删除</a></span><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><span>已点评<a href="#">删除</a></span><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><span>已点评<a href="#">删除</a></span><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                    <li><span>已点评<a href="#">删除</a></span><a href="#">【牛丸优惠】价比三家图优惠，不如看准品质更优惠！</a>（2012-03-13）</li>
                </ul>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div> 
<?php if( $SPAN[2] ): ?>
<div class="<?php echo $SPAN[2];?>">	
	<?php echo $column_right; ?>
</div>
<?php endif; ?>
</div>
<?php echo $footer; ?>