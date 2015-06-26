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
        <a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a>
      </div>
    </div>
    <div class="content">
        <table class="form">
            <tr>
                <td style="width:80%"><div class="tree" id="category-tree"></div></td>
                <td valign ="top">
                    <br/><br/>
                    <a class="button toggle">展开 / 收缩</a>
                    <br/><br/>
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
                beforedelete : function(n,t,r){
                    if(confirm("Do you want to delete?")) {
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
                            label: "Edit",
                            icon : "rename",
                            visible : function(n,t){
                                return 1;
                            },
                            action  : function(n,t){
                              window.open(n.attr('link'))
                            }
                        }
                    }
                }
            }
        });
    });

    $('.toggle').toggle(
        function(){$.tree.reference('.tree').open_all()},
        function(){$.tree.reference('.tree').close_all()}
    );

</script>
<style type="text/css">   
.tree{margin:0 auto;width:90%;padding: 20px;border:1px dashed #dedede;}
</style>
<?php echo $footer; ?>