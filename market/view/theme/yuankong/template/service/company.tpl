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
                <span class="gs-dz-c">苏州<i class="icon2 h-down"></i></span><?php echo $text_totals ?>
            </div>
            <dd class="c-xm-dd">
                    <span>消防设计</span>
                    <span>消防检测</span>
                    <span>消防工程</span>
                    <span>消防维保</span>
                </dd>
            <?php if($groups){?>
            <div class="ovh fix">
                <span class="l label-s"><?php echo $entry_type ?></span>
                <?php foreach ($groups as $item): ?>
                <a href="#" class="gs-s son"><?php echo $item['name'] ?></a>    
                <?php endforeach ?>
            </div>
            <?php }?>
        </div>
        <div class="xg-style mt10">
            <div class="xfgs-px-box pr15">
                <div class="r gs-search"><input type="text" class="gs-s-text" value=""><i class="icon2 s-sbtn"></i></div>
                <ul class="gs-px-list">
                    <li class="son">默认排序</li><li>推荐</li><li>人气</li><li>信誉</li>
                </ul>
            </div>
            <div class="p10">
                <ul class="gongslist">
                    <?php foreach ($companies as $item): ?>
                        
                    
                    <li class="item">
                        <p class="gspic"><a href="#"><img src="<?php echo $item['logo'] ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="#"><?php echo $item['title'] ?></a></h3>
                            <p class="lh30 c9 f_m">
                                <i class="ying">营</i>
                                <i class="tjian">荐</i>
                                <i class="jing">金</i>
                                <em class="pr10">150000元</em> 
                                <i class="icon2 dezbtn"></i><?php echo $item['address'] ?>
                            </p>
                            <p class="pt5"><em class="design-btn styon">设计</em><em class="design-btn">设计</em></p>
                            <p class="gsjj-t">郑重承诺:所有与消防e站签约客户，消防服务项目均实行先办理后付费，同时免费享有一年后续服务；若未在约定时间内完成办理，消防e站将双倍退款。</p>
                        </div>
                        <p class="sqyuyue">
                            <a href="#" class="yybtn">立即申请预约</a>
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
    o.dlist.init(".xfgs-chose-box",".xfgs-ad",".c-xm-dd");
</script>
<?php echo $footer; ?>
