<div class="l sliderbox">
<?php if( count($banners) ) { ?>
	<?php $id = rand(1,10)+rand(0, time());?>
   <div class="focus" id="focus">
	
		<div class="bd">
			<ul class="fix">
			 <?php foreach ($banners as $i => $banner) {  ?>
				<li>
					<?php if ($banner['link']) { ?>
					<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['thumb']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
					<?php } else { ?>
					<img src="<?php echo $banner['thumb']; ?>" alt="<?php echo $banner['title']; ?>" />
					<?php } ?>

				</li>
			<?php } ?>
			</ul>
        </div>
        <div class="hd">
            <ul>
                <?php foreach ($banners as $i => $banner) {  ?>
                <li <?php echo !$i ? 'class="on"' : '' ?>></li>
                <?php } ?>
            </ul>
        </div>
        <a class="prev icon2" href="javascript:void(0)"></a>
        <a class="next icon2" href="javascript:void(0)"></a>
    </div>
	<div class="ovh mt10 fix">
            <a class="l db" href=""><img src="market/view/theme/<?php echo $this->config->get('config_template') ?>/yk_img/adimg/ztpic1.jpg"></a>
            <a class="l db ml15" href=""><img src="market/view/theme/<?php echo $this->config->get('config_template') ?>/yk_img/adimg/ztpic2.jpg"></a>
            <a class="r db" href=""><img src="market/view/theme/<?php echo $this->config->get('config_template') ?>/yk_img/adimg/ztpic3.jpg"></a>
    </div>
<?php if( count($banners) > 1 ){ ?>
<script type="text/javascript">
	$(function(){
        o.slider.init(".focus");
        
    });
</script>
<?php } ?>
<?php } ?>
</div>