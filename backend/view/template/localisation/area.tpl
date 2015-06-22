<?php echo $header; ?>

<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?>
        <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/user.png" alt="" /> <?php echo $heading_title; ?></h1>
        </div>
        <div class="content">

                <table class="form">
                    <tr>
                        <td style="width:80%"><div class="tree" id="menu-tree"></div></td>
                        <td valign ="top">
                            <br/><br/>
                            <a data-rel="menu-tree" class="button toggle">展开 / 收缩</a>
                        </td>
                    </tr>
                </table>
        </div>
    </div>
</div>
<div id="menu-dialog" style="display:none">
    <table class="form">
        <tr>
            <td>上级:</td>
            <td>
                <input type="hidden" name="area_id">
                <input type="hidden" name="pid">
                <span id="parent-name">/</span>
            </td>
        </tr>
        <tr>
            <td>名称:</td>
            <td><input type="text" name="name" ></td>
        </tr>
        <tr>
            <td>激活:</td>
            <td>
                <select name="status" >
                  <option value="1"><?php echo $text_yes;?></option>
                  <option value="0"><?php echo $text_no;?></option>
                </select>
            </td>
        </tr>
        <tr>
            <td>排序:</td>
            <td><input type="text" name="sort"></td>
        </tr>
    </table>
    <div id="do-result"></div>
</div>
<script type="text/javascript">
    $(function () { 
        $("#menu-tree").tree({
            types : {"file" :{icon : {image : "view/image/file.png"}}},
            ui : {theme_name : "default"},
            data : { 
                async : true,
                type : "json",
                opts : {
                    method : 'POST',
                    url:'index.php?route=localisation/area&ajax=1&token=<?php echo $token ?>'
                }
            },
            callback : { 
                beforedelete : function(n,t,r){
                    if(confirm("确认删除吗")) {
                        $.post('index.php?route=localisation/area/delete&token=<?php echo $token; ?>',{area_id:$(n).attr('area_id')},function(json){
                            data = JSON.parse(json);
                            if(data.status==1){
                                alert(data.msg);
                            }else{
                                return false;
                            }
                        });
                        return true;
                    }else{
                        return false;
                    }
                }
            },
            plugins : {
                contextmenu:{
                    items : {
                        create :{
                            label: "新增",
                            icon : "create",
                            visible : function(n,t){
                                if(n.length != 1) return 0;
                                return 1;
                            },
                            action  : function(n,t){
                                render_dialog(n,'create',t.get_text(n));
                            }
                        },
                        rename : {
                            label: "编辑",
                            icon : "rename",
                            visible : function(n,t){
                                if(n.length != 1) return 0;
                                return 1;
                            },
                            action  : function(n,t){
                                render_dialog(n,'edit',t.get_text(n));
                            }
                        },
                        remove:{
                            label:"删除"
                        }
                    }
                }
            }
        });
    });
    function render_dialog(node,mode,text){
        $('#menu-dialog input').val('');
        $('#menu-dialog #do-result').empty();
        var title = '';
        var that = this;
        if(node && mode=='edit'){
            title = '编辑 ['+text+']';
            $('#parent-name').html(node.attr('p_name'));
            $('#menu-dialog input[name="area_id"]').val(node.attr('area_id'));
            $('#menu-dialog input[name="pid"]').val(node.attr('pid'));
            $('#menu-dialog input[name="name"]').val(text);
            $('#menu-dialog select[name="status"]').val(node.attr('status'));
            $('#menu-dialog input[name="sort"]').val(node.attr('sort'));
        }else{
            title = '新建 ';
            $('#parent-name').html(node ? node.attr('p_name')+'/'+text :'/');
            $('#menu-dialog input[name="pid"]').val(node ? node.attr('area_id') : 0); 
        }
        $('#menu-dialog input[name="mode"]').val('menu');
        $('#menu-dialog').dialog({
            title:title,
            width:500,
            modal:true,
            buttons:{
                "Save" : function(){
                    $.ajax({
                        url:'index.php?route=localisation/area/save&token=<?php echo $token; ?>',
                        type:'post',
                        data:$('#menu-dialog input,#menu-dialog select'),
                        dataType:'json',
                        success:function(json){
                            if(json.status==1){
                                $.tree.focused().refresh();
                                $('#do-result').html('<div class="alert success">'+json.msg+'</div>');
                                
                            }else{
                                $('#do-result').html('<div class="alert warning">'+json.msg+'</div>');
                                return false;
                            }
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            return false;
                        }
                    });
                    $(that).dialog('close');
                }
                //,'Close':function(){$.tree.focused().refresh();$(this).dialog('close');}
            }
        });
        return true;
    }
    $('.toggle').toggle(
        function(){$.tree.reference($(this).attr('data-rel')).open_all()},
        function(){$.tree.reference($(this).attr('data-rel')).close_all()}
    );
    $('#root-node').bind('click',function(){render_dialog(false,'create','');});
    $('.htabs a').tabs();
</script>

<style type="text/css">
   .tree{margin:0 auto;width:90%;padding: 20px;border:1px dashed #dedede;}
   .tree li[pid="0"] > a {font-weight: bold}
</style>
<?php echo $footer; ?> 