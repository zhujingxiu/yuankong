  <div class="w lh30 f_m pt5">
    <?php $i=0; foreach ($breadcrumbs as $breadcrumb) { $i++;?>
        <?php if(count($breadcrumbs) == $i){?>
        <?php echo $breadcrumb['text']; ?>
        <?php }else{ ?>
        <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <em class="plr fa_s">&gt;</em>
        <?php } ?>
    <?php } ?>
  </div>