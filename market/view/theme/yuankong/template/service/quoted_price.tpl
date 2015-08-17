<?php echo $header; ?>
<!--当前位置显示-->
<div class="w lh30 f_m pt5">
    <a href="#">首页</a><em class="plr fa_s">></em>免费消防报价
</div>
<div class="w mt10">
    <h3 class="f_xl c3">免费消防报价</h3>
    <table class="bj-table mt15">
        <tr>
            <td class="label-td">报价项目</td>
            <td><label><input type="radio" class="radio-btn" name="xmbj" />消防设计</label><label><input type="radio" class="radio-btn" name="xmbj" />消防工程</label><label><input type="radio" class="radio-btn" name="xmbj" />消防检测</label><label><input type="radio" class="radio-btn" name="xmbj" />消防维保</label></td>
        </tr>
        <tr>
            <td class="label-td">项目性质</td>
            <td><label><input type="radio" class="radio-btn" name="xmbj2" />首次项目</label><label><input type="radio" class="radio-btn" name="xmbj2" />二次项目</label></td>
        </tr>
        <tr>
            <td class="label-td">房屋类型</td>
            <td><label><input type="radio" class="radio-btn" name="xmbj3" />商铺</label><label><input type="radio" class="radio-btn" name="xmbj3" />办公楼</label><label><input type="radio" class="radio-btn" name="xmbj3" />网吧</label><label><input type="radio" class="radio-btn" name="xmbj3" />商场超市</label><label><input type="radio" class="radio-btn" name="xmbj3" />其他</label></td>
        </tr>
        <tr>
            <td class="label-td">房屋面积</td>
            <td><div class="pl15"><input type="text" class="regis-text w100" value=""/><em class="pl10">平方米</em></div> </td>
        </tr>
        <tr>
            <td class="label-td">所在地</td>
            <td><div class="pl15"><select class="cadress"><option>江苏省</option></select>  <select class="cadress"><option>苏州市</option></select> </div></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;"><input type="submit" class="gc-tab-sub w200" value="帮我估价" /></td>

        </tr>
    </table>
</div>
<?php echo $footer; ?>