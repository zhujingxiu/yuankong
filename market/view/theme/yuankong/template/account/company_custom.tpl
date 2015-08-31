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
                <h3 class="index-t"><b class="f_l">自定义模块</b></h3>
                <table class="usertable">
                    <tr>
                        <td width="60">状态</td>
                        <td><label class="pr20"><input type="radio" name="r1" class="input-m"/>开启</label><label class="pr20"><input type="radio" name="r1" class="input-m"/>关闭</label></td>
                    </tr>
                    <tr>
                        <td>名称</td>
                        <td><input type="text" class="input-t w350"/></td>
                    </tr>
                    <tr>
                        <td>内容</td>
                        <td>
                            <div class="l p10 bd1">
                                <p class="tc"><img src="imgs/adimg/sjadpic.jpg" width="205" /></p>
                                <p class="c9 pt5 tc"><a href="#">选择图像</a><em class="plr c9">|</em><a href="#">清除图像</a></p>
                            </div>
                            <div class="fix"></div>
                            <p class="c_red f_s mt10">最大单张图片尺寸——宽1150px,支持0-3M文件快速上传,支持png,jpg格式</p>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" class="gc-tab-sub w150" value="提交"/></td>
                    </tr>
                </table>
            </div>
        </div>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
        <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div> 
<?php echo $footer; ?> 


    