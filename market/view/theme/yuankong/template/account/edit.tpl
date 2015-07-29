<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
	  <div class="<?php echo $SPAN[0];?> aside">
		<?php echo $column_left; ?>
	  </div>
    <?php endif; ?>
    <div class="<?php echo $SPAN[1];?> article">
        <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php } ?>
        <?php echo $content_top; ?>
        <div id="content" class="userbox3">
            <div class="userboxtop">
              <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
            </div>
            <ul class="xiaoxi martop20"  id="list0">
                <li class="yes" onclick="list(this,0)">基本资料管理</li>
                <li class="not" onclick="list(this,1)">形象标识</li>
                <li class="not" onclick="list(this,2)">密码修改</li>
                <li class="not" onclick="list(this,3)">收件地址</li>
            </ul>
                
            <div class="xinei martop"  id="list0_c_0" style="display:block;">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <ul class="ziliao mt10">
                        <li class="none"><label>手机号：</label>
                            <b id="block4"><?php echo $mobile_phone; ?></b>
                            <span onclick="tihuan('block');">[修改]</span>
                            <a href="#">未验证</a>
                        </li>
                        <li><label>会员名：</label>
                            <input type="text" name="fullname" class="xingming" value="<?php echo $fullname; ?>">
                        </li>
                        <li class="none">
                            <label>邮箱：</label>
                            <input id="blocks3" style="display:none;" type="text" class="xingming" value="">
                            <b id="blocks4">modeko@126.com</b>
                            <span onclick="tihuan('blocks');">[修改]</span>
                            <a href="#">未验证</a>
                        </li>
                        <li>
                            <label>性别：</label>
                            <input type="radio" name="sex" class="sex">男
                            <input type="radio" name="sex" class="sex">女
                        </li>
                        <li><label>&nbsp;</label><input type="submit" value="保存资料" class="baocun"></li>
                    </ul>
                </form>
            </div>
            <div class="xinei martop20" id="list0_c_1" style="display:none;">
                <div class="biaozhi">
                    <input type="submit" onclick="changec('bdpic');" value="从本地上传" class="dnsc" />
                    <input type="submit" value="确认保存" class="qrbc" />
                    <p>仅支持JPG、GIF、PNG格式的图片，且文件小于5M</p>
                </div>
                <div class="bdscpic" style="display:none;" id="bdpic">
                    <div class="bdscpictop"><span onclick="changec('bdpic');">[关闭]</span>上传形象标识</div>
                    <ul>
                        <li>从电脑中选择一张图片</li>
                        <li><input type="file" size="35" style="height:26px; line-height:26px; " /><input type="submit" value="上传" onclick="changec('bdpic');" style="width:60px; height:26px; margin-left:15px;" /></li>
                        <li style="padding-top:15px; color:#666;">支持JPG格式，图片大小不超过1MB<br />上传真实头像，将大大增加大家对您的关注度</li>
                    </ul>
                </div>
                <ul class="xingxiang martop20 fix">
                    <li><img src="linkimage/touxiang.png" width="180" height="180" /><p class="martop20">180×180像素</p></li>
                    <li><img src="linkimage/touxiang.png" width="50" height="50" /><p class="martop">50×50</p></li>
                    <li class="thirty"><img src="linkimage/touxiang.png" width="30" height="30" /><p>30×30</p></li>
                </ul>
                <p>1. 请勿在形象标示上留有任何联系方式的信息 </p>
                <p>2. 请保证图片质量，图片大小至少为180×180 </p>
            </div>
            <div class="xinei martop" id="list0_c_2" style="display:none;">
                <ul class="ziliao martop20">
                    <li><label>原密码：</label><input type="password" class="xingming" /></li>
                    <li><label>新密码：</label><input type="password" class="xingming" /></li>
                    <li><label>重设新密码：</label><input type="password" class="xingming" /></li>
                    <li class="tijiao martop20"><label>&nbsp;</label><input type="submit" value="提交新密码" class="baocun"/></li>
                </ul>
            </div>
            <div class="xinei martop" id="list0_c_3" style="display:none;">
                <div class="ovh p20">
                    <h3 class="f_m"><b>地址管理</b></h3>
                    <div class="default fix">
                        <div class="add-addr"></div>
                    </div>
                    <!--新增地址-->
                    <div class="newadress-box">
                        <ul>
                            <li class="item-adress" id="area">
                                <label>收货地址：</label>
                            </li>
                            <li class="item-adress"><label>详细地址：</label><input type="text" class="text-box w350" value="" /></li>
                            <li class="item-adress"><label>收货人姓名：</label><input type="text" class="text-box w210" value="" /></li>
                            <li class="item-adress"><label>手机号码：</label><input type="text" class="text-box w210" value="" /></li>
                            <li class="item-adress"><label>&nbsp;</label><input type="submit" value="添加地址" class="baocun" /></li>
                        </ul>
                    </div>
                    <h3 class="f_m bordert"><b>全部地址</b></h3>
                    <div class="ovh fix mt15">
                        <ul class="fix">
                            <li class="adtressli">
                                <i class="icon2 quej"></i>
                                <i class="icon2 adressdel"></i>
                                <h5>刘志国<span class="pl15">15959112345</span></h5>
                                <div class="mt5">江苏省 南京市 玄武区 全区</div>
                                <div class="c8">花园路11号森林公安学院内25栋2单元203</div>
                            </li>
                            <li class="adtressli">
                                <i class="icon2 quej"></i>
                                <i class="icon2 adressdel"></i>
                                <h5>刘志国<span class="pl15">15959112345</span></h5>
                                <div class="mt5">江苏省 南京市 玄武区 全区</div>
                                <div class="c8">花园路11号森林公安学院内25栋2单元203</div>
                            </li>
                            <li class="adtressli">
                                <i class="icon2 quej"></i>
                                <i class="icon2 adressdel"></i>
                                <h5>刘志国<span class="pl15">15959112345</span></h5>
                                <div class="mt5">江苏省 南京市 玄武区 全区</div>
                                <div class="c8">花园路11号森林公安学院内25栋2单元203</div>
                            </li>
                        </ul>
                    </div>
                </div>
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
<script type="text/javascript">
    $(function(){
        add_select(0);
        $('body').on('change', '#area select', function() {
            var $me = $(this);
            var $next = $me.next();

            if ($me.val() == $next.data('pid')) {
                return;
            }
            $me.nextAll().remove();
            add_select($me.val());
        });

        function add_select(pid) {
            var area_names = area['name'+pid];
            if (!area_names) {
                return false;
            }
            var area_codes = area['code'+pid];
            var $select = $('<select >');
            $select.attr('name', 'area[]');
            $select.attr('class', 'adress-sec');
            $select.data('pid', pid);
            if (area_codes[0] != -1) {
                area_names.unshift('请选择');
                area_codes.unshift(0);
            }
            for (var idx in area_codes) {
                var $option = $('<option>');
                $option.attr('value', area_codes[idx]);
                $option.text(area_names[idx]);
                $select.append($option);
            }
            $('#area').append($select);
        };
        //下拉选框事件
        o.mous.init(".adtressli","adrhover");
        $(".add-addr").on("click",function(){
            $(this).parent().hide();
            $(".newadress-box").show();
        });
    });


</script>
<?php echo $footer; ?>