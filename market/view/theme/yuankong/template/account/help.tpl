<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<div class="register-w f_s fix" id="main">
<?php if( $SPAN[0] ): ?>
	<div class="<?php echo $SPAN[0];?> aside">
		<?php echo $column_left; ?>
	</div>
<?php endif; ?> 
<div class="<?php echo $SPAN[1];?> article">
    <?php echo $content_top; ?>
    <div class="userbox3">
        <div class="userboxtop">
          <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>
        </div>
        <?php if($helps){?>
        <h3 class="pl20 pt10"><b>我发布的问题</b></h3>
        <ul class="fabuwenti fix">
            <?php foreach ($helps as $key => $item): ?>
            <li>
                <a href="<?php echo $item['link'] ?>"><?php echo truncate_string($item['text'],38) ?></a>
                <?php if ($item['replied']){ ?>
                <p>已回答<em class="plr c9">|</em><?php echo $item['date_replied'] ?> </p>
                <?php }else{ ?>
                <p>未回答<em class="plr c9">|</em><?php echo $item['date_added'] ?></p>
                <?php }?>
            </li>
            <?php endforeach ?>
            
        </ul>
        <!------ 翻页 ------>
        <div class="pagebox mt10">
            <?php echo $pagination ?>
        </div>
        <?php }else{?>
        <div><?php echo $text_empty ?></div>
        <?php }?>
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