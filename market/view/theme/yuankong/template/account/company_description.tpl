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
                <table class="usertable">
                    <tbody><tr>
                        <td colspan="2"><textarea rows="10" cols="80" class="bd1 p10"><?php echo $description ?></textarea></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" class="gc-tab-sub w150" value="提交"></td>
                    </tr>
                </tbody></table>
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


    