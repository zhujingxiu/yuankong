<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="register-w f_s fix" id="main">

    <?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?> aside">
	<?php echo $column_left; ?>
	</div>
    <?php endif; ?>
	<div class="<?php echo $SPAN[1];?> article">
		<?php echo $content_top; ?>
	  	<div class="userbox2">
			<div class="userer">
				<div class="userleft">
                	<p class="userpic">
                        <img src="<?php echo $avatar ?>" width="112" height="112" />
                    </p>
                </div>
                <ul class="fl pad20 uname">
                	<li class="uname1">欢迎您！<strong><?php echo $fullname ?></strong></li>
                	<li>为了账户安全，请您尽快完善资料</li>
                    <li>
                    	<a class="pad15" href="<?php echo $edit ?>">完善资料</a>
                        <a href="#">编辑头像</a>
                    </li>
                    <li class="uxxjs">
                    	<span><?php echo $text_my_orders ?>
                            （<a href="<?php echo $order ?>"><?php echo $totals ?></a>）
                        </span>
                    	<span>成功订单
                            （<a href="<?php echo $finish ?>"><?php echo $finished ?></a>）
                        </span>
                    </li>
                </ul>
                <dl class="fl pad20 unameer">
                	<dt>您有（<a href="#">2</a>）条站内信息</dt>
                    <dd>共提问题：<a href="#">15</a>个</dd>
                    <dd>共评价订单：<a href="#">15</a>个</dd>
                </dl>
			</div>
			<b class="box2bottom"></b>
	  	</div>
	  	<div class="left">
			<div class="jqdingdan">
            	<b class="jqtittle"><?php echo $text_recently ?></b>
            	<table class="jqxldd">
                	<thead>
                    	<tr>
                        	<th width="100px">下单时间</th>
                            <th align="left" width="380px">产品名称</th>
                            <th width="100px">总价格</th>
                            <th width="80px">操作</th>
                        </tr>
                    </thead>

                    <tbody>
                        <?php if($recently){ ?>
                        <?php foreach ($recently as $item): ?>
                    	<tr>
                        	<td align="center"><?php echo $item['date_added'] ?></td>
                            <td >
                                <?php if($item['products']){ ?>
                                <?php foreach ($item['products'] as $product) {?>
                                <a href="<?php echo $product['link'] ?>"><?php echo truncate_string($product['name'],20) ?></a>
                                <?php }?>
                                <?php }?>
                            </td>
                            <td align="center"><strong><?php echo $item['total'] ?></strong></td>
                            <td align="center"><a href="<?php echo $item['link'] ?>">查看</a></td>
                        </tr>
                        <?php endforeach ?>
                        <?php }?>
                    </tbody>
                </table>
            </div>
            <div class="jqdingdan martop20">
            	<p class="tuijian1">为您推荐的热门商品</p>
            	<table class="wntuijian">
                	<tr>
                    	<td><a class="tjpic" href="#"><img src="imgs/adimg/newspic.jpg" width="171" height="100" alt="" /></a><a href="#">嵌入式插电安全出口疏散指示灯</a><br />全场5折起售，10件更优惠<br />优惠价:<strong>￥1250</strong></td>
                        <td><a class="tjpic" href="#"><img src="imgs/adimg/newspic.jpg" width="171" height="100" alt="" /></a><a href="#">嵌入式插电安全出口疏散指示灯</a><br />全场5折起售，10件更优惠<br />优惠价:<strong>￥1250</strong></td>
                        <td><a class="tjpic" href="#"><img src="imgs/adimg/newspic.jpg" width="171" height="100" alt="" /></a><a href="#">嵌入式插电安全出口疏散指示灯</a><br />全场5折起售，10件更优惠<br />优惠价:<strong>￥1250</strong></td>
                    </tr>
                </table>
            </div>
	  	</div>
	  	<div class="right">
			<div class="rightbox1">
            	<h3><b>温馨提示</b></h3>
                <p class="usertishi">
                	如果您的e站网账号密码和QQ或其他网站一致，请马上修改密码以免账号被盗。
                </p>
                <h3><b>近期活动</b></h3>
                <p class="jqhuodong">
                	<img src="imgs/adimg/adpic1.jpg" width="170" height="70" alt="" />
                    <a href="#">&gt;&nbsp;旅游优惠券将永久有效</a>
                    <a href="#">&gt;&nbsp;旅游优惠券将永久有效</a>
                    <a href="#">&gt;&nbsp;旅游优惠券将永久有效</a>
                    <a href="#">&gt;&nbsp;旅游优惠券将永久有效</a>
                </p>
            </div>
	  	</div>
  		<?php echo $content_bottom; ?>
	</div> 
	<?php if( $SPAN[2] ): ?>
	<div class="<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</div>
	<?php endif; ?>
</div> 
<?php echo $footer; ?> 