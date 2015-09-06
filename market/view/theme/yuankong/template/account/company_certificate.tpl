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
                <h3 class="index-t"><b class="f_l">资质证书</b></h3>
                <div class="mt20 ovh"><span class="dib gc-tab-sub w150 tc">+新增</span> </div>
                <?php if($certificates){ ?>
                <table class="usertable addt mt20 tc">
                    <thead>
                    <tr>
                        <th>资质图片</th>
                        <th>资质名称</th>
                        <th>排列顺序</th>
                        <th>管理</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach($certificates as $item){ ?>
                    <tr>
                        <td><img src="<?php echo $item['image'] ?>" width="205" /></td>
                        <td><?php echo $item['title'] ?></td>
                        <td><?php echo $item['sort'] ?></td>
                        <td>
                            <a onclick="detail(<?php echo $item['file_id'] ?>)" class="plr c_red">编辑</a>
                            <a onclick="delFile(<?php echo $item['file_id'] ?>)" class="plr c_red">删除</a>
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
        <h3>资质详情</h3>
    </div>
    <div class="p20">
        <form id="file-form" method="post" action="<?php echo $action ?>" enctype="multipart/form-data">
        <table class="usertable">
            <tr>
                <td width="60">资质名称</td>
                <td><input type="text" class="input-t w350" name="title" /></td>
            </tr>
            <tr>
                <td>排列顺序</td>
                <td><input type="text" class="input-t w100" name="sort" value="1"/></td>
            </tr>
            <tr>
                <td>资质图片</td>
                <td>
                    <div class="l p10 bd1">
                        <p class="tc">
                            <img src="<?php echo $no_photo ?>" width="205" id="thumb"/>
                            <input type="hidden" name="image"/>
                        </p>
                        <p class="c9 pt5 tc">
                            <a id="btn-upload" >选择图像</a>
                            <em class="plr c9">|</em>
                            <a onclick="$('#thumb').attr('src', '<?php echo $no_photo; ?>'); $('input[name=\'image\']').attr('value', '');">清除图像</a>
                        </p>
                    </div>
                    <div class="fix"></div>
                    <p class="c_red f_s mt10">建议图片尺寸210*140px，支持0~3M jpg、png等格式图片快速上传</p>
                </td>
            </tr>
            <tr>
                <td>&nbsp;<input name="file_id" type="hidden"></td>
                <td><input type="submit" class="gc-tab-sub w150" value="提交"/></td>
            </tr>
        </table>
        </form>
    </div>
</div>
<script type="text/javascript">
    function detail(file_id){
        $.get(
            'index.php?route=account/company/ajax_data',
            {action:'getcertificate',file_id:file_id},
            function(json){
                if(json.status==1){
                    $('#file-form input[type!="submit"]').val('');
                    $('#file-form #thumb').attr('src','<?php echo $no_photo ?>');
                    var data = json.info;
                    $('#file-form input[name="file_id"]').val(data.file_id);
                    $('#file-form input[name="title"]').val(data.title);                    
                    $('#file-form input[name="sort"]').val(data.sort);                    
                    $('#file-form input[name="image"]').val(data.image);                    
                    $('#file-form #thumb').attr('src',data.image);
                    $(".add-anli").show();
                    $(".tm-mask").show();
                }else{  
                    alert(json.msg);
                }
        },'json');
    }
    function delfile(file_id){
        if(confirm('确认删除该文件？')){
            $.get(
                'index.php?route=account/company/ajax_data',
                {action:'deletecertificate',file_id:file_id},
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
        $('#file-form input[type!="submit"][type!="radio"]').val('');
        $('#file-form #thumb').attr('src','<?php echo $no_photo ?>');
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
    },
    onComplete: function(file, json) {
        
        if (json['status']==1) {
            $('input[name="image"]').val(json['file']);
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