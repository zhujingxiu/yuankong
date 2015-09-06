<?php echo $header; ?>
<!--当前位置显示-->
<div class="w lh30 f_m pt5">
    <a href="<?php echo $home ?>">首页</a><em class="plr fa_s">></em>免费消防报价
</div>
<div class="w mt10">
    <h3 class="f_xl c3">免费消防报价</h3>
    
    <table class="bj-table mt15" id="quoted-form">
        <tr>
            <td class="label-td">报价项目</td>
            <td>
                <label><input type="radio" class="radio-btn" name="group" checked="checked" value="消防设计"/>消防设计</label>
                <label><input type="radio" class="radio-btn" name="group" value="消防工程"/>消防工程</label>
                <label><input type="radio" class="radio-btn" name="group" value="消防检测"/>消防检测</label>
                <label><input type="radio" class="radio-btn" name="group" value="消防维保"/>消防维保</label>
            </td>
        </tr>
        <tr>
            <td class="label-td">项目性质</td>
            <td>
                <label><input type="radio" class="radio-btn" name="season" checked="checked" value="首次项目"/>首次项目</label>
                <label><input type="radio" class="radio-btn" name="season" value="二次项目"/>二次项目</label>
            </td>
        </tr>
        <tr>
            <td class="label-td">房屋类型</td>
            <td>
                <label><input type="radio" class="radio-btn" name="place" checked="checked" value="商铺"/>商铺</label>
                <label><input type="radio" class="radio-btn" name="place" value="办公楼"/>办公楼</label>
                <label><input type="radio" class="radio-btn" name="place" value="网吧"/>网吧</label>
                <label><input type="radio" class="radio-btn" name="place" value="商场超市"/>商场超市</label>
                <label><input type="radio" class="radio-btn" name="place" value="其他"/>其他</label>
            </td>
        </tr>
        <tr>
            <td class="label-td">房屋面积</td>
            <td>
                <div class="pl15">
                    <input type="text" class="regis-text w100" name="size"/>
                    <em class="pl10">平方米</em>
                </div> 
            </td>
        </tr>
        <tr>
            <td class="label-td">所在地区</td>
            <td><div class="pl15" id="area"></div></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="button" class="gc-tab-sub w200" value="帮我估价" id="btn-quoted"/>
            </td>
        </tr>
    </table>
    
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
            $select.attr('class', 'cadress');
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
        add_select(<?php echo $this->config->get('config_province_id') ?>);
        $('select.cadress:first').val(<?php echo $this->config->get('config_province_id') ?>);

    });
    $('#btn-quoted').bind('click',function(){
        var size = $('#quoted-form input[name="size"]').val();
        if(!$.isNumeric(size) && size<= 0){
            alert('请填写有效数字');
            $('#quoted-form input[name="size"]').focus();
            return false;
        }
        $.ajax({
            type:'post',
            url:'<?php echo $action ?>',
            data:$('#quoted-form input[type="text"],#quoted-form input[type="radio"]:checked,#quoted-form select'),
            dataType:'json',
            success:function(json){

            }
        });
    })
</script>
<?php echo $footer; ?>