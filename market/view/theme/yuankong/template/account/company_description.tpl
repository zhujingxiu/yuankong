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
                <h3 class="index-t"><b class="f_l">公司简介</b></h3>
                <form id="company-form" action="<?php echo $action ?>" method="post" enctype="multipart/form-data">
                <table class="usertable borb">
                    <tr>
                        <td width="150" valign="top">简介内容</td>
                        <td><textarea name="description" rows="5" cols="60" class="bd1 p10"><?php echo $description ?></textarea></td>
                    </tr>
                    <tr>
                        <td width="150" valign="top">公司形象</td>
                        <td>
                            <div class="l p10 bd1">
                                <p class="tc">
                                    <img src="<?php echo $thumb ?>" width="280" id="thumb-cover"/>
                                    <input type="hidden" name="cover" value="<?php echo $cover ?>" />
                                </p>
                                <p class="c9 pt5 tc">
                                    <a id="cover-upload">选择图像</a>
                                    <em class="plr c9">|</em>
                                    <a onclick="$('#thumb-cover').attr('src', '<?php echo $no_photo; ?>'); $('input[name=\'cover\']').attr('value', '');">清除图像</a>
                                </p>
                            </div>
                            <div class="fix"></div>
                            <p class="c_red f_s mt10">建议图片尺寸480*300px,支持0-3M文件快速上传,支持png,jpg格式</p>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" class="gc-tab-sub w150" value="提交"></td>
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

<script type="text/javascript"><!--

    new AjaxUpload('#cover-upload', {
        action: 'index.php?route=common/tool/upload',
        name: 'file',
        autoSubmit: true,
        responseType: 'json',
        onSubmit: function(file, extension) {
            $('#cover-upload').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
        },
        onComplete: function(file, json) {
                        
            if (json['status']==1) {
                $('input[name="cover"]').val(json['file']);
                $('#thumb-cover').attr('src',json['file'])
            }else{
                alert(json['msg']);
                return false;
            }            
            
            $('.loading').remove(); 
        }
    });

//--></script>
<?php echo $footer; ?> 