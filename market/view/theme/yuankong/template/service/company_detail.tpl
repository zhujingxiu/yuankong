<?php echo $header; ?>
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
<div class="w mt10 fix">
    <div class="gs-detail-box fix">
        <div class="l gs-ad-pic">
            <img src="<?php echo $cover ?>" width="480" height="300"/>
        </div>
        <div class="r gs-detail">
            <div class="ovh gsjj">
                <p class="qy-logo"><img src="<?php echo $logo ?>" width="100" height="100"/></p>
                <h3><?php echo $title ?></h3>
                <p class="lh30 c9 f_m">
                	<i class="ying">营</i>
                	<?php if($recommend){ ?>
                	<i class="tjian">荐</i>
                	<?php }?>
                	<?php if($deposit){ ?>
                	<i class="jing">金</i>
                	<em class="pr10"><?php echo $deposit ?>元</em> 
                	<?php }?>
                	<i class="icon2 dezbtn"></i><?php echo $address ?>
                </p>
                <p class="pt5">
                	<?php foreach ($all_groups as $item): ?>
                	<em class="design-btn <?php echo in_array($item['group_id'], $groups) ? 'styon' : '' ?>"><?php echo $item['tag'] ?></em>
                	<?php endforeach ?>
                </p>
            </div>
            <div class="gs-jianj mt15">
                <h5>公司简介:</h5>
                <p class="t-indet"><?php echo $description ?></p>
            </div>
            <div class="mt15 tr">
                <span class="gc-tab-sub dib" onclick="company_request(<?php echo $company_id ?>);">立即申请预约</span>
            </div>
        </div>
    </div>
        <!--消防e站 全程保障-->
    <div class="box-b-2 mt15 p20">
        <h5 class="gs-d-box-t">消防e站全程跟踪保障</h5>
        <div class="ovh mt20 ebbox">
            <span><img src="market/view/theme/yuankong/yk_img/adimg/eb1.png" /></span>
            <span><img src="market/view/theme/yuankong/yk_img/adimg/eb2.png" /></span>
            <span><img src="market/view/theme/yuankong/yk_img/adimg/eb3.png" /></span>
            <span><img src="market/view/theme/yuankong/yk_img/adimg/eb4.png" /></span>
            <span><img src="market/view/theme/yuankong/yk_img/adimg/eb5.png" /></span>
        </div>
    </div>
    <?php if($certificates){ ?>
    <div class="box-b-2 mt15 p20">
        <h5 class="gs-d-box-t">资质证书</h5>
        <div class="ovh mt20">
            <ul class="jslist">
                <?php foreach ($certificates as $item): ?>
                <li class="itempic">
                    <img src="<?php echo $item['image'] ?>" title="<?php echo $item['title'] ?>" alt="<?php echo $item['title'] ?>" width="210" height="140"/>
                </li>   
                <?php endforeach ?>
            </ul>
        </div>
    </div>
    <?php }?>    
    <?php if($modules){ ?>
    <?php foreach ($modules as $item): ?> 
    <div class="box-b-2 mt15 p20">
        <h5 class="gs-d-box-t"><?php echo $item['title'] ?></h5>
        <div class="ovh mt20">
            <img src="<?php echo $item['image'] ?>" />
        </div>
    </div>
    <?php endforeach ?>
    
    <?php }?>
        <!--上传单个图片模块-->
    <?php if($cases){ ?>
    <div class="box-b-2 mt15 p20">
        <h5 class="gs-d-box-t">案列精选</h5>
        <div class="ovh mt20">
            <ul class="jslist">
            	<?php foreach ($cases as $item): ?>
            	<li class="itempic">
                    <img src="<?php echo $item['photo'] ?>" title="<?php echo $item['title'] ?>" alt="<?php echo $item['title'] ?>" width="280" height="219"/>
                </li>	
            	<?php endforeach ?>
            </ul>
        </div>
    </div>
    <?php }?>
    <!--上传100%图片模块-->
    <?php if($members){?>
    <div class="box-b-2 mt15 p20">
        <h5 class="gs-d-box-t">团队成员</h5>
        <div class="ovh mt20">
            <ul class="yk_members">
            	<?php foreach ($members as $item): ?>
            	<li>
                    <img src="<?php echo $item['avatar'] ?>" title="<?php echo $item['name'] ?>" alt="<?php echo $item['name'] ?>" width="122" height="122"/>
                    <p><?php echo $item['name'] ?></p>
                    <p class="thin"><?php echo $item['position'] ?></p>
                </li>	
            	<?php endforeach ?>
            </ul>
        </div>
    </div>
    <?php }?>
</div>
<div class="tm-mask" id="tm-mask" style="display:none;"></div>
<div class="iframe-login" style="display:none;">
  <?php echo $mini_login ?>
</div>
<?php echo $footer; ?>