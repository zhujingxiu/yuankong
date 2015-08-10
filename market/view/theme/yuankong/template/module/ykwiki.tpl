	<div class="rel pb10">
        <h3 class="index-t l-green"><?php echo $title ?></h3>
    </div>
    <div class="ovh fix b_f btb3">
    	<div class="l">
            <div class="newsbox1"><a href="#" class="newsb-bg1"></a></div>
            <div class="newsbox2"><a href="#" class="newsb-bg2"></a></div>
        </div>
        <div class="index-news b_f btb3">
        	<ul class="index-news-ul">
        		<?php foreach ($wiki['top'] as $item): ?>
        		<li class="index-n-li fix">
        			<h3 class="f_l lh30"><a href="<?php echo $item['link'] ?>" class="c3"><?php echo $item['title'] ?></a></h3>
        			<p class="newspic"><img src="<?php echo TPL_IMG.$item['icon'] ?>" /></p>
        			<div class="news-a">
        				<?php if(isset($item['data']) && is_array($item['data'])){?>
        				<?php foreach ($item['data'] as $info): ?>
        				<a href="<?php echo $info['link'] ?>">
        					<?php if(!empty($info['title'])){
        						echo truncate_string($info['title'],18);
        					}else if(!empty($info['text'])){
								echo truncate_string($info['text'],18);
        					}?>
        				</a>
        				<?php endforeach ?>
        				<?php }?>
        			</div>
        		</li>
        		<?php endforeach ?>
        	</ul>
        	<ul class="index-news-ul mt10">
        		<?php foreach ($wiki['bottom'] as $item): ?>
        		<li class="index-n-li fix">
        			<h3 class="f_l lh30"><a href="<?php echo $item['link'] ?>" class="c3"><?php echo $item['title'] ?></a></h3>
        			<p class="newspic"><img src="<?php echo TPL_IMG.$item['icon'] ?>" /></p>
        			<div class="news-a">
        				<?php if(isset($item['data']) && is_array($item['data'])){?>
        				<?php foreach ($item['data'] as $info): ?>
        				<a href="<?php echo $info['link'] ?>">
        					<?php if(!empty($info['title'])){
        						echo truncate_string($info['title'],18);
        					}else if(!empty($info['text'])){
								echo truncate_string($info['text'],18);
        					}?>
        				</a>
        				<?php endforeach ?>
        				<?php }?>
        			</div>
        		</li>
        		<?php endforeach ?>
        	</ul>
        </div>
    </div>