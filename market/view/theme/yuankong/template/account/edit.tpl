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
                <form action="<?php echo $info_action; ?>" method="post" id="info-form">
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
                <form action="<?php echo $avatar_action; ?>" method="post" id="avatar-form">
                    <div class="biaozhi">
                        <input type="button" onclick="changec('bdpic');" value="从本地上传" class="dnsc" />
                        <input type="button" value="确认保存" class="qrbc"  />
                        <p> </p>
                    </div>
                    <div class="bdscpic" style="display:none;" id="bdpic">
                        <div class="bdscpictop"><span onclick="changec('bdpic');">[关闭]</span>上传形象标识</div>
                        <ul>
                            <li>从电脑中选择一张图片</li>
                            <li>
                                <div id="button-avatar" style="width:100px;height:26px; line-height:26px; display:inline;curse:pointer;">选择图片</div>
                                <input type="button" value="上传" onclick="changec('bdpic');" id="button-upload"/>
                            </li>
                            <li style="padding-top:15px; color:#666;">
                                支持JPG格式，图片大小不超过1MB<br />上传真实头像，将大大增加大家对您的关注度
                            </li>
                        </ul>
                    </div>
                    <ul class="xingxiang martop20 fix">
                        <li>
                            <img src="<?php echo $avatar ?>" width="180" height="180" class="pre-avatar"/>
                            <p class="martop20">180×180像素</p>
                        </li>
                        <li>
                            <img src="<?php echo $avatar ?>" width="50" height="50" class="pre-avatar"/>
                            <p class="martop">50×50</p>
                        </li>
                        <li class="thirty">
                            <img src="<?php echo $avatar ?>" width="30" height="30" class="pre-avatar"/>
                            <p>30×30</p>
                        </li>
                    </ul>
                    <p>1. 请勿在形象标示上留有任何联系方式的信息 </p>
                    <p>2. 请保证图片质量，图片大小至少为180×180 </p>
                </form>
            </div>
            <div class="xinei martop" id="list0_c_2" style="display:none;">
                <form method="post" id="password-form" action="<?php echo $password_action ?>">
                    <ul class="ziliao martop20">
                        <li>
                            <label>原密码：</label>
                            <input type="password" class="xingming" name="password" />
                        </li>
                        <li>
                            <label>新密码：</label>
                            <input type="password" class="xingming" name="newpwd"/>
                        </li>
                        <li>
                            <label>重设新密码：</label>
                            <input type="password" class="xingming" name="confirm"/>
                        </li>
                        <li class="tijiao martop20">
                            <label>&nbsp;</label>
                            <input type="submit" value="提交新密码" class="baocun"/>
                        </li>
                    </ul>
                </form>
            </div>
            <div class="xinei martop" id="list0_c_3" style="display:none;">
                <div class="ovh p20">
                    <h3 class="f_m"><b>地址管理</b></h3>
                    <div class="default fix">
                        <div class="add-addr"></div>
                    </div>
                    <!--新增地址-->
                    <form method="post" id="address-form" action="<?php echo $address_action ?>">
                        <div class="newadress-box">
                            <ul>
                                <li class="item-adress" id="area">
                                    <label>收货地址：</label>
                                </li>
                                <li class="item-adress">
                                    <label>详细地址：</label>
                                    <input type="text" class="text-box w350" value="" name="address"/>
                                </li>
                                <li class="item-adress">
                                    <label>收货人姓名：</label>
                                    <input type="text" class="text-box w210" value="" name="fullname" />
                                </li>
                                <li class="item-adress">
                                    <label>手机号码：</label>
                                    <input type="text" class="text-box w210" value="" name="telephone"/>
                                </li>
                                <li class="item-adress">
                                    <label>&nbsp;</label>
                                    <input type="submit" value="添加地址" class="baocun" />
                                </li>
                            </ul>
                        </div>
                    </form>
                    <?php if(count($addresses)){?>
                    <h3 class="f_m bordert"><b>全部地址</b></h3>
                    <div class="ovh fix mt15">
                        <ul class="fix">
                            <?php foreach ($addresses as $item) { ?>
                            <li class="adtressli">
                                <i class="icon2 quej"></i>
                                <i class="icon2 adressdel"></i>
                                <h5><?php echo $item['fullname'] ?><span class="pl15"><?php echo $item['telephone'] ?></span></h5>
                                <div class="mt5"><?php echo $item['area_zone'] ?></div>
                                <div class="c8"><?php echo $item['address'] ?></div>
                            </li>
                            <?php }?>
                        </ul>
                    </div>
                    <?php }?>
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
<script type="text/javascript"><!--
    var avatar_set = new AjaxUpload('#button-avatar', {
        action: 'index.php?route=account/edit/upload',
        name: 'avatar',
        autoSubmit: false,
        responseType: 'json',
        onChange: function(file, ext){
            if(ext && !(/^(jpg|jpeg)$/i.test(ext) )){
                alert("只支持JPG格式的文件");
            }else{
                $('#button-avatar').after('<span>'+file+'</span>')
            }
        },
        onSubmit: function(file, extension) {
            $('#button-avatar').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />').attr('disabled',true);
        },
        onComplete: function(file, json) {
            $('#button-avatar').attr('disabled',false);
            $('.error').remove();
            if (json['success']) {
                $('img.pre-avatar').attr('src',json['path']);
                $('input[name="avatar"]').attr('value', json['file']);
            }
            if (json['error']) {
                alert(json['error']);
            }
            $('.loading').remove(); 
        }
    });
    $('#button-upload').bind('click',function(){avatar_set.submit()});
//--></script>
<style type="text/css">
    #button-avatar{width:60px; height:26px; margin-left:15px;cursor: pointer;text-decoration: underline;display: inline-block;}
    #button-upload{float: right;margin-right:10px; }
</style>
<?php echo $footer; ?>