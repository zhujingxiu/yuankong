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
                <h3 class="index-t"><b class="f_l">案列精选</b></h3>
                <div class="mt20 ovh"><span class="dib gc-tab-sub w150 tc">+新增</span> </div>
                <?php if($cases){ ?>
                <table class="usertable addt mt20 tc">
                    <thead>
                    <tr>
                        <th>案例图片</th>
                        <th>案例名称</th>
                        <th>排列顺序</th>
                        <th>管理</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach($cases as $item){ ?>
                    <tr>
                        <td><img src="<?php echo $item['photo'] ?>" width="150" /></td>
                        <td><?php echo $item['name'] ?></td>
                        <td>1</td>
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
        <h3>新增案列</h3>
    </div>
    <div class="p20">
        <table class="usertable">
            <tr>
                <td width="60">名称</td>
                <td><input type="text" class="input-t w350" name="name" /></td>
            </tr>
            <tr>
                <td>顺序</td>
                <td><input type="text" class="input-t w100" name="sort" /></td>
            </tr>
            <tr>
                <td>图片</td>
                <td>
                    <div class="l p10 bd1">
                        <p class="tc">
                            <img src="<?php echo $no_photo ?>" width="205" />
                            <input type="hidden" name="photo" value="<?php echo $cover; ?>" id="cover" />
                        </p>
                        <p class="c9 pt5 tc">
                            <a id="btn-upload" >选择图像</a>
                            <em class="plr c9">|</em>
                            <a href="#">清除图像</a>
                        </p>
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
<script type="text/javascript"><!--
new AjaxUpload('#btn-upload', {
    action: 'index.php?route=common/tool/upload',
    name: 'file',
    autoSubmit: true,
    responseType: 'json',
    onSubmit: function(file, extension) {
        $('#btn-upload').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
        $('#btn-upload').attr('disabled', true);
    },
    onComplete: function(file, json) {
        $('#btn-upload').attr('disabled', false);
        
        $('.error').remove();
        
        if (json['success']) {
            alert(json['success']);
            
            $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
        }
        
        if (json['error']) {
            alert(json['error']);
        }
        
        $('.loading').remove(); 
    }
});
//--></script>
<?php echo $footer; ?> 