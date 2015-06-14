<div class="r b_f">

   <div class="e-news">
        <h3 class="e-title"><a href="<?php echo $news ?>" class="more r"><?php echo $text_more ?></a><?php echo $title ?></h3>
        <div class="ovh p10">
            <ul class="f_s lh30">
            <?php if( count($newses) ) { ?>
             <?php foreach ($newses as $i => $item) {  ?>
                <li class="txt_clip">
                    <em>[<?php echo $item['group_name'] ?>]</em>
                    <a href="<?php echo $item['link']; ?>" <?php echo !$i ? 'class="'.$first_class.'"' : '' ?>><?php echo $item['title']; ?></a>
                </li>
            <?php } ?>
            <?php } ?>
            </ul>
        </div>
    </div>
    <div class="e-news mt5">
        <h3 class="e-title">装修消防</h3>
        <div class="xf-box">
            <ul>
                <li><a href="#" class="db"><i class="icon zxxf-des"></i><br />装修消防设计</a></li>
                <li><a href="#" class="db"><i class="icon zxxf-sg"></i><br />装修消防设计</a></li>
                <li><a href="#" class="db"><i class="icon zxxf-jc"></i><br />装修消防设计</a></li>
                <li><a href="#" class="db"><i class="icon zxxf-bs"></i><br />装修消防设计</a></li>
            </ul>
        </div>
    </div>


</div>