<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">
    <?php if( $SPAN[0] ): ?>
    <div class="<?php echo $SPAN[0];?>">
        <?php echo $column_left; ?>
    </div>
    <?php endif; ?>
    <div class="<?php echo $SPAN[1];?>">
        <?php echo $content_top; ?>
        <div class="xfgs-chose-box">
            <div class="xfgs-ad">
                <span class="gs-dz-c">苏州<i class="icon2 h-down"></i></span>
                <?php if($search){ ?>
                <span class="gs-dz-c"><?php echo $search ?></span>
                <?php }?>
                <?php echo $text_totals ?>
            </div>
            <?php if($groups){?>
            <div class="ovh fix">
                <span class="l label-s"><?php echo $entry_type ?></span>
                <?php foreach ($groups as $item): ?>
                <a href="<?php echo $item['link'] ?>" class="gs-s <?php echo $item['group_id'] == $group ? 'son' : ''?>"><?php echo $item['name'] ?></a>    
                <?php endforeach ?>
            </div>
            <?php }?>
        </div>
        <div class="xg-style mt10">
            <div class="xfgs-px-box pr15">
                <div class="r gs-search">
                    <input type="text" class="gs-s-text" value="<?php echo $search ?>"><i class="icon2 s-sbtn"></i>
                </div>
                <ul class="gs-px-list">
                    <li class="<?php echo $sort_on == 'sort_order' ? 'son' : ''?>" >
                      <a href="<?php echo $sort_order ?>"><?php echo $text_sort_default; ?></a>
                    </li>
                    <li class="<?php echo $sort_on == 'recommend' ? 'son' : ''?>">
                      <a href="<?php echo $sort_recommend ?>"><?php echo $text_sort_recommend; ?></a>
                    </li>
                    <li class="<?php echo $sort_on == 'viewed' ? 'son' : ''?>">
                      <a href="<?php echo $sort_viewed ?>"><?php echo $text_sort_viewed; ?></a>
                    </li>
                    <li class="<?php echo $sort_on == 'credit' ? 'son' : ''?>">
                      <a href="<?php echo $sort_credit ?>"><?php echo $text_sort_credit; ?></a>
                    </li>
                </ul>
            </div>
            <div class="p10">
                <ul class="gongslist">
                    <?php foreach ($companies as $item): ?>
                    <li class="item">
                        <p class="gspic"><a href="<?php echo $item['link'] ?>"><img src="<?php echo $item['logo'] ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="<?php echo $item['link'] ?>"><?php echo $item['title'] ?></a></h3>
                            <p class="lh30 c9 f_m">
                                <i class="ying">营</i>
                                <?php if ($item['recommend']): ?>
                                <i class="tjian">荐</i>
                                <?php endif ?>
                                <?php if ($item['deposit']): ?>
                                <i class="jing">金</i>
                                <em class="pr10"><?php echo $item['deposit'] ?>元</em> 
                                <?php endif ?>
                                
                                <i class="icon2 dezbtn"></i><?php echo $item['area_zone'].' '.$item['address'] ?>
                            </p>
                            <p class="pt5">
                                <?php foreach ($groups as $group): ?>
                                <em class="design-btn <?php echo in_array($group['group_id'], $item['groups']) ? 'styon' : '' ?>"><?php echo $group['tag'] ?></em>
                                <?php endforeach ?>
                            </p>
                            <p class="gsjj-t"><?php echo $item['description'] ?></p>
                        </div>
                        <p class="sqyuyue">
                            <a onclick="company_request(<?php echo $item['company_id'] ?>);" class="yybtn" >立即申请预约</a>
                        </p>
                    </li>
                    <?php endforeach ?>
                </ul>
                <div class="pagebox mt10">
                    <?php echo $pagination; ?>
                </div>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
    <!--right-->
    <?php if( $SPAN[2] ): ?>
    <div class="<?php echo $SPAN[2];?>">    
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
</div>
<script type="text/javascript">
<?php if($search){ ?>
    $('#top-filter input[name="search_model"]').val('company');
    $('#top-filter .search-dt span').text(($('#top-filter').find('span[val="company"]').text()));
<?php }?>
</script>
<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<?php echo $footer; ?>
