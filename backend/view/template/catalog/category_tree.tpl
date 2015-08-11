<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/category.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a href="<?php echo $mode; ?>" class="button"><?php echo $button_mode; ?></a>
        <a href="<?php echo $repair; ?>" class="button"><?php echo $button_repair; ?></a>
        <a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a>
      </div>
    </div>
    <div class="content">
        <table class="form">
            <tr>
                <td valign ="top" style="border:1px dashed #dedede;">
                    <a class="button toggle">展开 / 收缩</a>
                    <br/>
                    <div class="tree" id="category-tree"></div></td>
                <td valign ="top" style="width:80%;margin-left:10px;border:1px dashed #dedede;">
                    <div id="tree-category" >
                        
                    </div>
                </td>
            </tr>
        </table>
    </div>
  </div>
</div>
<script type="text/javascript">
    $(function () { 
        $("#category-tree").tree({
            types : {"file" :{icon : {image : "view/image/file.png"}}},
            ui : {theme_name : "apple"},
            data : { 
                async : true,
                type : "json",
                opts : {
                    method : 'POST',
                    url:'index.php?route=catalog/category&tree=1&token=<?php echo $token ?>'
                }
            },
            callback : { 
                onselect:function(n){
                    var cid = $(n).attr('category_id');
                    if(cid>0){
                        $('#tree-category').load('index.php?route=catalog/category/update&category_id='+cid+'&token=<?php echo $token ?>&ajax=1')
                    }
                },
                beforedelete : function(n,t,r){
                    if(confirm("确定删除吗?")) {
                        $.post('index.php?route=catalog/category/delete&token=<?php echo $token; ?>',{'selected[]':$(n).attr('node_id')},function(json){
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
                        create : false,
                        rename : {
                            label: "编辑",
                            icon : "rename",
                            visible : function(n,t){
                                return 1;
                            },
                            action  : function(n,t){
                              window.open(n.attr('link'))
                            }
                        },
                        remove :{label:'删除'}
                    }
                }
            }
        });
    });

    $('.toggle').toggle(
        function(){$.tree.reference('.tree').open_all()},
        function(){$.tree.reference('.tree').close_all()}
    );
    $('#tree-category').load('index.php?route=catalog/category/insert&token=<?php echo $token ?>&ajax=1')
</script>
<style type="text/css">   
.tree{margin:0 auto;padding: 10px;}
</style>
<?php echo $footer; ?>