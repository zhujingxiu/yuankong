  <div class="breadcrumb">
    <?php $i=0; $z=999; foreach ($breadcrumbs as $breadcrumb) { $i++; $z--;?>
    <a class="lever_<?php echo $i?>" style="z-index:<?php echo $z; ?>" href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>