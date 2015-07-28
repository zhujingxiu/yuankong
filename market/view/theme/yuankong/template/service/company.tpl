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
                <span class="gs-dz-c">苏州<i class="icon2 h-down"></i></span>共有<i class="c_red"> 3234 </i>家消防服务公司
            </div>
            <div class="ovh fix">
                <span class="l label-s">公司类型</span><a href="#" class="gs-s son">设计公司</a><a href="#" class="gs-s">维保公司</a><a href="#" class="gs-s">工程公司</a><a href="#" class="gs-s">检测公司</a>
            </div>
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
                    <li class="item">
                        <p class="gspic"><a href="#"><img src="<?php echo TPL_IMG."nopic.jpg" ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="#">苏州源控智能有限公司</a></h3>
                            <p class="lh30 c9 f_m"><i class="icon2 dezbtn"></i>太仓市北京西路6号创业园主楼406</p>
                            <p class="pt5"><em class="design-btn styon">设计</em><em class="design-btn">设计</em></p>
                            <p class="gsjj-t">郑重承诺:所有与消防e站签约客户，消防服务项目均实行先办理后付费，同时免费享有一年后续服务；若未在约定时间内完成办理，消防e站将双倍退款。</p>
                        </div>
                        <p class="sqyuyue">
                            <a href="#" class="yybtn">立即申请预约</a>
                        </p>
                    </li>
                    <li class="item">
                        <p class="gspic"><a href="#"><img src="<?php echo TPL_IMG."nopic.jpg" ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="#">苏州源控智能有限公司</a></h3>
                            <p class="lh30 c9 f_m"><i class="icon2 dezbtn"></i>太仓市北京西路6号创业园主楼406</p>
                            <p class="pt5"><em class="design-btn styon">设计</em><em class="design-btn">设计</em></p>
                            <p class="gsjj-t">郑重承诺:所有与消防e站签约客户，消防服务项目均实行先办理后付费，同时免费享有一年后续服务；若未在约定时间内完成办理，消防e站将双倍退款。</p>
                        </div>
                        <p class="sqyuyue">
                            <a href="#" class="yybtn">立即申请预约</a>
                        </p>
                    </li>
                    <li class="item">
                        <p class="gspic"><a href="#"><img src="<?php echo TPL_IMG."nopic.jpg" ?>"></a></p>
                        <div class="ovh gsjj">
                            <h3><a href="#">苏州源控智能有限公司</a></h3>
                            <p class="lh30 c9 f_m"><i class="icon2 dezbtn"></i>太仓市北京西路6号创业园主楼406</p>
                            <p class="pt5"><em class="design-btn styon">设计</em><em class="design-btn">设计</em></p>
                            <p class="gsjj-t">郑重承诺:所有与消防e站签约客户，消防服务项目均实行先办理后付费，同时免费享有一年后续服务；若未在约定时间内完成办理，消防e站将双倍退款。</p>
                        </div>
                        <p class="sqyuyue">
                            <a href="#" class="yybtn">立即申请预约</a>
                        </p>
                    </li>
                </ul>
                <!------ 翻页 ------>
                <div class="pagebox mt10">
                    <div class="page">
                        <a href="#" class="prev-page"><i>&lt;</i>上一页</a>
                        <a href="#" class="page-num pon">1</a>
                        <a href="#" class="page-num">2</a>
                        <a href="#" class="page-num">3</a>
                        <a href="#" class="page-num">4</a>
                        <a href="#" class="page-num">5</a>
                        <a href="#" class="page-num">6</a>
                        <a href="#" class="next-page">下一页<i>&gt;</i></a>
                        <a href="#" class="page-num">末页</a>
                    </div>
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

<?php echo $footer; ?>
