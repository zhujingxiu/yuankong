<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<div class="register-w f_s fix" id="main">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?> aside">
    <?php echo $column_left; ?>
    </div>
    <?php endif; ?>

    <div class="article">
        
        <!-- userbox3 -->
        <div class="userbox4">
            <div class="usergs-box">
                <div class="ovh gsjj">
                    <p class="qy-logo"><img src="<?php echo $logo ?>" /></p>
                    <h3><?php echo $title ?></h3>
                    <p class="lh30 f_m">
                        <i class="ying">营</i>
                        <?php if($recommend){ ?>
                        <i class="tjian">荐</i>
                        <?php }?>
                        <?php if($deposit){ ?>
                        <i class="jing">金</i>
                        <em class="pr10"><?php echo $deposit ?>元</em> 
                        <?php }?>
                        <i class="icon2 dezbtn"></i><?php echo $area_zone .' '.$address ?>
                    </p>
                    <p class="pt5">
                        <?php foreach ($all_groups as $item): ?>
                        <em class="design-btn <?php echo in_array($item['group_id'], $groups) ? 'styon' : '' ?>"><?php echo $item['tag'] ?></em>
                        <?php endforeach ?>
                    </p>
                </div>
            </div>
            <div class="p30">
                <h3 class="f_m c3"><b>基本资料</b></h3>
                <table class="usertable borb">
                    <tr>
                        <td width="150">公司名称</td>
                        <td><input type="text" name="title" class="input-t w350" value="<?php echo $title ?>"/></td>
                    </tr>
                    <tr>
                        <td>logo</td>
                        <td>
                            <div class="l p10 bd1">
                                <p class="tc">
                                    <img src="<?php echo $logo ?>" width="95" />
                                    <input type="hidden" name="logo" value="<?php echo $logo ?>" />
                                </p>
                                <p class="c9 pt5 tc">
                                    <a id="logo-upload">选择图像</a>
                                    <em class="plr c9">|</em>
                                    <a href="#">清除图像</a>
                                </p>
                            </div>
                            <div class="fix"></div>
                            <p class="c_red f_s mt10">建议图片尺寸120*120px,支持0-3M文件快速上传,支持png,jpg格式</p>
                        </td>
                    </tr>
                    <tr>
                        <td>公司形象</td>
                        <td>
                            <div class="l p10 bd1">
                                <p class="tc">
                                    <img src="<?php echo $cover ?>" width="280" />
                                    <input type="hidden" name="cover" value="<?php echo $cover ?>" />
                                </p>
                                <p class="c9 pt5 tc">
                                    <a id="cover-upload" data-rel="cover">选择图像</a>
                                    <em class="plr c9">|</em>
                                    <a href="#">清除图像</a>
                                </p>
                            </div>
                            <div class="fix"></div>
                            <p class="c_red f_s mt10">建议图片尺寸480*300px,支持0-3M文件快速上传,支持png,jpg格式</p>
                        </td>
                    </tr>
                    <tr>
                        <td>公司项目</td>
                        <td>
                            <?php foreach ($all_groups as $item): ?>
                            <label class="pr20">
                                <input type="checkbox" class="input-m" name="group_id[]" <?php echo in_array($item['group_id'], $groups) ? 'checked="checked"' : '' ?> />
                                <?php echo $item['name'] ?>
                            </label>
                        <?php endforeach ?>
                        </td>
                    </tr>
                    <tr>
                        <td>法人姓名</td>
                        <td><input type="text" class="input-t w150" name="corporation" value="<?php echo $corporation ?>"/></td>
                    </tr>
                    <tr>
                        <td>法人手机号码</td>
                        <td><input type="text" class="input-t w210" name="mobile_phone" value="<?php echo $mobile_phone ?>"/></td>
                    </tr>
                    <tr>
                        <td>所属区域</td>
                        <td><input type="text" class="input-t w150"/></td>
                    </tr>
                    <tr>
                        <td>公司地址</td>
                        <td>
                            <div class="ovh" id="area"></div>
                            <div class="mt10"><input type="text" class="input-t w350" name="address"/></div>
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
function ajax_upload(el){
    new AjaxUpload('#'+el, {
        action: 'index.php?route=common/tool/upload',
        name: 'file',
        autoSubmit: true,
        responseType: 'json',
        onSubmit: function(file, extension) {
            $(this).after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
            $(this).attr('disabled', true);
        },
        onComplete: function(file, json) {
            $(this).attr('disabled', false);
            
            $('.error').remove();
            
            if (json['success']) {
                alert(json['success']);
                $('input[name="'+$('#'+el).attr('data-rel')+'"]').val(json['file'])
            }
            
            if (json['error']) {
                alert(json['error']);
            }
            
            $('.loading').remove(); 
        }
    });
}
$(function(){
    ajax_upload('logo-upload');
    ajax_upload('cover-upload');
})
//--></script>
<?php echo $footer; ?> 