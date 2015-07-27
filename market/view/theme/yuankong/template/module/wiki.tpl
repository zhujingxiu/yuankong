<div class="xg-style">
    <h3 class="title f_l"><?php echo $heading_title ?></h3>
    <div class="fix p10">
        <div class="shopsty-box">
            <h3 class="s-show f_m"><i class="icon2 sshow"></i><b><?php echo $text_tag_information ?></b></h3>
            <div class="shopstylebox">
                <dl class="chover">
                    <dd class="c-dd-box">
                      <?php foreach ($groups_information as $key => $item): ?>
                        <a href="<?php echo $item['link'] ?>" class="wiki-item<?php echo $item['group_id'] == $group ? ' c_red' : '' ?>"><?php echo $item['name'] ?></a>
                      <?php endforeach ?>
                    </dd>
                </dl>
            </div>
        </div>
        <div class="shopsty-box">
            <h3 class="s-show f_m"><i class="icon2 sshow"></i><b><?php echo $text_tag_school; ?></b></h3>
            <div class="shopstylebox">
                <dl class="chover">
                    <dd class="c-dd-box">
                        <a href="<?php echo $wiki_help ?>" class="wiki-item"><?php echo $text_wiki_help ?></a>
                        <?php foreach ($groups_school as $key => $item): ?>
                        <a href="<?php echo $item['link'] ?>" class="wiki-item<?php echo $item['group_id'] == $group ? ' c_red' : '' ?>"><?php echo $item['name'] ?></a>
                      <?php endforeach ?>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
<script type="text/javascript">

    $(".shopsty-box h3").click(function(){
        if($(this).parent().hasClass("phover")){
            $(this).parent().removeClass("phover");
        }else{
            $(this).parent().siblings().removeClass("phover");
            $(this).parent().addClass("phover");}
    });
    $(function(){
        $.each($('a.wiki-item'),function(){
            if($(this).hasClass('c_red')){
                $('.shopsty-box').removeClass('phover');
                $(this).parent().parent().parent('.shopstylebox').parent('.shopsty-box').addClass('phover');
            }
        })
    })
</script>
</div>