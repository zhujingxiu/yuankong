<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w fix">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?>">
        <?php echo $column_left; ?>
    </div>
    <?php endif; ?> 
    <div class="<?php echo $SPAN[1];?> newslist l">
        <?php echo $content_top; ?>
        <div class="newslist-title">
            <div class="r gs-search">
                <input type="text" class="gs-s-text" value="<?php echo $search ?>"><i class="icon2 s-sbtn"></i>
            </div>
            <span class="c_red pr10"><?php echo $wiki_name ?></span>
            <span class="pr10">共有<em class="plr c_red"><?php echo $totals ?></em>条结果</span>
            <span class="pl20 f_m">排序:
              <select class="news-px-select" onchange="location.href=this.value">
                <option value="<?php echo $sort_order ?>" <?php echo $sort_on == 'sort_order' ? 'selected' : ''?>>默认</option>
                <option value="<?php echo $sort_viewed ?>" <?php echo $sort_on == 'viewed' ? 'selected' : ''?>>按阅读量</option>
              </select>
            </span>
        </div>
        <div class="p10">
            <ul class="newslist-item">

                <?php foreach ($wikis as $key => $item): ?>
                  <li class="newslist-li">
                    <h4><a <?php echo isset($item['link']) ? 'href="'.$item['link'].'"' : '' ?>><?php echo truncate_string($item['title']) ?></a></h4>
                    <p class="lh30 f_s c9">
                        <?php echo empty($item['from']) ? truncate_string($item['date_added'],20) : '' ?>
                        更新日期:<?php echo $item['date_added'] ?>
                        <em class="pl20">阅读:<?php echo $item['viewed'] ?>次</em>
                    </p>
                    <div class="news-text">
                        <?php echo truncate_string($item['text'],130) ?>
                    </div>
                </li>
                <?php endforeach ?>
            </ul>
            <div class="pagebox mt10">
                <?php echo $pagination; ?>
            </div>
        </div>  
        <?php echo $content_bottom; ?>
    </div> 
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div>
<script type="text/javascript">
<?php if($search){ ?>
    $('.newslist-li h4,.newslist-li .news-text').textSearch('<?php echo $search ?>',{markColor: "#C30D23"});
    $('#top-filter input[name="search_model"]').val('wiki');
    $('#top-filter .search-dt span').text(($('#top-filter').find('span[val="wiki"]').text()));
<?php }?>
$('.s-sbtn').bind('click',function(){
    if($(this).parent('.gs-search').find('input').val()!=''){
        var route = 'route='+(getQueryString('route') ? getQueryString('route') : 'information/wiki');
        var group = getQueryString('wiki_group') ? '&wiki_group='+getQueryString('wiki_group') : '';
        var sort = getQueryString('sort') ? '&sort='+getQueryString('sort') : '';
        var search = '&search='+$(this).parent('.gs-search').find('input').val();
        location.href= $('base').attr('href') + 'index.php?'+route+group+sort+search;
    }
});

</script>
<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<?php echo $footer; ?>