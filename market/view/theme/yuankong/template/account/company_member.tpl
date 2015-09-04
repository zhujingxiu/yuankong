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
                        <td>
                            <a onclick="detail(<?php echo $item['member_id'] ?>);" class="plr c_red">编辑</a>
                            <a onclick="delMember(<?php echo $item['member_id'] ?>)" class="plr c_red">删除</a> 
                        </td>
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
        <form id="member-form" method="post" action="<?php echo $action ?>" enctype="multipart/form-data">
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
                        <p class="tc">
                            <img src="<?php echo $no_photo ?>" width="205" id="thumb"/>
                            <input type="hidden" name="avatar" />
                        </p>
                        <p class="c9 pt5 tc">
                            <a id="member-upload">选择图像</a>
                            <em class="plr c9">|</em>
                            <a onclick="$('#thumb').attr('src', '<?php echo $no_photo; ?>'); $('input[name=\'avatar\']').attr('value', '');">清除图像</a>
                        </p>
                    </div>
                    <div class="fix"></div>
                    <p class="c_red f_s mt10">建议图片尺寸480*300px,支持0-3M文件快速上传,支持png,jpg格式</p>
                </td>
            </tr>
            <tr>
                <td>&nbsp;<input name="member_id" type="hidden"></td>
                <td><input type="submit" class="gc-tab-sub w150" value="提交"/></td>
            </tr>
        </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    function detail(member_id){
        $.get(
            'index.php?route=account/company/ajax_data',
            {action:'getmember',member_id:member_id},
            function(json){
                if(json.status==1){
                    $('#member-form input[type!="submit"]').val('');
                    $('#member-form #thumb').attr('src','<?php echo $no_photo ?>');
                    var data = json.info;
                    $('#member-form input[name="name"]').val(data.name);
                    $('#member-form input[name="position"]').val(data.position);
                    $('#member-form input[name="member_id"]').val(data.member_id);
                    $('#member-form input[name="avatar"]').val(data.avatar);
                    $('#member-form input[name="sort"]').val(data.sort);
                    $('#member-form #thumb').attr('src',data.avatar);
                    $(".add-anli").show();
                    $(".tm-mask").show();
                }else{  
                    alert(json.msg)
                }
        },'json');
    }
    function delMember(member_id){
        if(confirm('确认删除该成员？')){
            $.get(
                'index.php?route=account/company/ajax_data',
                {action:'deletemember',member_id:member_id},
                function(json){
                    if(json.status==1){
                        location.reload();
                    }else{  
                        alert(json.msg)
                    }
            },'json');
        }
    }
    $(".add-anl-title span").bind('click',function(){
        $(this).parent().parent().hide();
        $(".tm-mask").hide();
    });
    $("span.gc-tab-sub").bind('click',function(){
        $('#member-form input[type!="submit"]').val('');
        $('#member-form #thumb').attr('src','<?php echo $no_photo ?>');
        $(".add-anli").show()
        $(".tm-mask").show();
    });
</script>
<script type="text/javascript"><!--
new AjaxUpload('#member-upload', {
    action: 'index.php?route=common/tool/upload',
    name: 'file',
    autoSubmit: true,
    responseType: 'json',
    onSubmit: function(file, extension) {
        $('#member-upload').after('<img src="market/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    },
    onComplete: function(file, json) {
        
        if (json['status']==1) {
            $('input[name="avatar"]').val(json['file']);
            $('#thumb').attr('src',json['file'])
        }else{
            alert(json['msg']);
            return false;
        } 
        
        $('.loading').remove(); 
    }
});
//--></script>
<?php echo $footer; ?> 