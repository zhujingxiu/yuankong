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
                <h3 class="index-t"><b class="f_l">自定义模块<?php echo $sort ?></b></h3>
                <form id="custom-form" action="<?php echo $action ?>" method="post" enctype="multipart/form-data">
                <table class="usertable">
                    <tr>
                        <td width="60">状态</td>
                        <td>
                            <label class="pr20">
                                <input type="radio" name="status" class="input-m" <?php echo $status==1 ? 'checked="checked"' : '' ?> value="1"/>开启
                            </label>
                            <label class="pr20">
                                <input type="radio" name="status" class="input-m" <?php echo !$status ? 'checked="checked"' : '' ?> value="0"/>关闭
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>名称</td>
                        <td><input type="text" class="input-t w350" name="title" value="<?php echo $title ?>" /></td>
                    </tr>
                    <tr>
                        <td>内容</td>
                        <td>
                            <div class="l p10 bd1">
                                <p class="tc">
                                    <img src="<?php echo $thumb ?>" width="205" id="thumb-custom"/>
                                    <input type="hidden" name="image" value="<?php echo $image ?>" />
                                </p>
                                <p class="c9 pt5 tc widget">
                                    <a id="custom-upload">选择图像</a>
                                    <em class="plr c9">|</em>
                                    <a href="$('#thumb-custom').attr('src', '<?php echo $no_photo; ?>'); $('input[name=\'image\']').attr('value', '');">清除图像</a>
                                </p>
                            </div>
                            <div class="fix"></div>
                            <p class="c_red f_s mt10">最大单张图片尺寸——宽1150px,支持0-3M文件快速上传,支持png,jpg格式</p>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;<input name="sort" value="<?php echo $sort ?>" type="hidden"></td>
                        <td><input type="submit" class="gc-tab-sub w150" value="提交"/></td>
                    </tr>
                </table>
                </form>
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
        <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div> 
<script type="text/javascript">
$('input[name="status"]').bind('change',function(){
    if(parseInt($('input[name="status"]:checked').val())!=1){
        $('#custom-form input:text').attr('readonly','readonly');
        $('#custom-form p.widget').hide();
    }else{
        $('#custom-form input').removeAttr('readonly');
        $('#custom-form p.widget').show();
    }
})
$(function(){
    $('input[name="status"]').trigger('change');
})

new AjaxUpload('#custom-upload', {
    action: 'index.php?route=common/tool/upload',
    name: 'file',
    autoSubmit: true,
    responseType: 'json',
    onSubmit: function(file, extension) {
        $('#custom-upload').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    },
    onComplete: function(file, json) {
                    
        if (json['status']==1) {
            $('input[name="image"]').val(json['file']);
            $('#thumb-custom').attr('src',json['file'])
        }else{
            alert(json['msg']);
            return false;
        }            
        
        $('.loading').remove(); 
    }
});
</script>
<?php echo $footer; ?> 


    