<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?> aside">
    <?php echo $column_left; ?>
    </div>
    <?php endif; ?>

    <div class="article">
        <div class="userbox4">
            <div class="p30">
                <h3 class="index-t"><b class="f_l">团队成员</b></h3>
                <div class="mt20 ovh"><span class="dib gc-tab-sub w150 tc">+新增</span> </div>
                <?php if($members){ ?>
                <table class="usertable addt mt20 tc">
                    <thead>
                    <tr>
                        <th>头像</th>
                        <th>名称</th>
                        <th>职位</th>
                        <th>排序</th>
                        <th>管理</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach($members as $item){ ?>
                    <tr>
                        <td><img src="<?php echo $item['avatar'] ?>" width="150" /></td>
                        <td><?php echo $item['name'] ?></td>
                        <td><?php echo $item['position'] ?></td>
                        <td><?php echo $item['sort'] ?></td>
                        <td><a href="#" class="plr c_red">编辑</a><a href="#" class="plr c_red">删除</a> </td>
                    </tr>
                    <?php } ?>

                    </tbody>
                </table>
                <?php }?>
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
        <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div> 

<!--蒙层以及弹窗-->
<div class="tm-mask" style="display: none;"></div>
<div class="add-anli" style="display: none;">
    <div class="add-anl-title">
        <span class="r f_xl">X</span>
        <h3>新增成员</h3>
    </div>
    <div class="p20">
        <table class="usertable">
            <tr>
                <td width="60">名称</td>
                <td><input type="text" class="input-t w350" name="name" /></td>
            </tr>
            <tr>
                <td width="60">职位</td>
                <td><input type="text" class="input-t w350" name="position" /></td>
            </tr>
            <tr>
                <td>顺序</td>
                <td><input type="text" class="input-t w100" name="sort" /></td>
            </tr>
            <tr>
                <td>头像</td>
                <td>
                    <div class="l p10 bd1">
                        <p class="tc"><img src="<?php echo $no_photo ?>" width="205" /></p>
                        <p class="c9 pt5 tc"><a href="#">选择图像</a><em class="plr c9">|</em><a href="#">清除图像</a></p>
                    </div>
                    <div class="fix"></div>
                    <p class="c_red f_s mt10">建议图片尺寸480*300px,支持0-3M文件快速上传,支持png,jpg格式</p>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" class="gc-tab-sub w150" value="提交"/></td>
            </tr>
        </table>
    </div>
</div>
<script type="text/javascript">

    $(".add-anl-title span").bind('click',function(){
        $(this).parent().parent().hide();
        $(".tm-mask").hide();
    });
    $("span.gc-tab-sub").bind('click',function(){
        $(".add-anli").show()
        $(".tm-mask").show();
    });
</script>
<?php echo $footer; ?> 