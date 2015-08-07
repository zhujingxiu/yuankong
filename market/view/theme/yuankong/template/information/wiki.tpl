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
            <span class="c_red pr10"><?php echo $wiki_name ?></span>
            <span class="pr10">共有<em class="plr c_red"><?php echo $totals ?></em>条结果</span>
            <span class="pl20 f_m">排序:
              <select class="news-px-select">
                <option>默认</option>
                <option>按阅读量</option>
              </select>
            </span>
        </div>
        <div class="p10">
            <ul class="newslist-item">

                <?php foreach ($wikis as $key => $item): ?>
                  <li class="newslist-li">
                    <h4><a <?php echo isset($item['link']) ? 'href="'.$item['link'].'"' : '' ?>"><?php echo truncate_string($item['title']) ?></a></h4>
                    <p class="lh30 f_s c9">
                        更新日期:<?php echo $item['date_added'] ?>
                        <em class="pl20">阅读:<?php echo $item['viewed'] ?>次</em>
                    </p>
                    <div class="news-text">
                        <?php echo truncate_string($item['text'],130) ?>
                    </div>
                </li>
                <?php endforeach ?>
            </ul>
            <!-- 翻页 -->
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
<?php echo $footer; ?>