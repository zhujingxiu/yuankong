<div class="xg-style">
  <h3 class="title f_l"><?php echo $heading_title; ?></h3>
  <div class="fix p10">
      <?php foreach ($categories as $category) { ?>
      <div class="shopsty-box <?php echo ($category['category_id'] == $category_id) ? 'phover' : '' ?>">
        
        <h3 class="s-show f_m ">
          <i class="icon2 sshow"></i>
          <a href="<?php echo $category['href'] ?>"><?php echo $category['name']; ?></a>
        </h3>
        <?php if ($category['children']) { ?>
        <div class="shopstylebox">
          <?php foreach ($category['children'] as $child) { ?>
          <dl <?php echo ($child['category_id'] == $child_id) ? 'class="chover"' : ''  ?>>
            
            <dt><i class="icon2 sshow"></i><a href="<?php echo $child['href'] ?>"><?php echo $child['name'] ?></a></dt>
            <?php if(isset($child['children']) && is_array($child['children'])){?>
            <dd class="c-dd-box">
            <?php foreach ($child['children'] as $item): ?>
            <a <?php echo ($item['category_id'] == $last_id) ? 'class="c_red"' : ''  ?> href="<?php echo $item['href'] ?>">
              <?php echo $item['name'] ?>
            </a>
            <?php endforeach ?>
            </dd>
            <?php }?>
          </dl>
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>

  </div>

<script type="text/javascript">

    $(".shopsty-box h3>i.sshow").click(function(){
        if($(this).parent().parent().hasClass("phover")){
            $(this).parent().parent().removeClass("phover");
        }else{
        $(this).parent().parent().siblings().removeClass("phover");
        $(this).parent().parent().addClass("phover");}
    });
    $(".shopstylebox dl dt > i.sshow").click(function(){
        if($(this).parent().parent().hasClass("chover")){
            $(this).parent().parent().removeClass("chover");
        }else{
        $(this).parent().parent().siblings().removeClass("chover");
        $(this).parent().parent().addClass("chover");}
    });
    <?php if(!isset($this->request->get['path'])){?>
    $(function(){
      $(".shopsty-box h3 > i.sshow:first").trigger('click');
    });
    <?php }?>
</script>
</div>