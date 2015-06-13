<div class="r b_f">

   <div class="e-news">
        <h3 class="e-title"><a href="#" class="more r">更多</a>e站快报</h3>
        <div class="ovh p10">
            <ul class="f_s lh30">
            <?php if( count($news) ) { ?>
             <?php foreach ($news as $i => $item) {  ?>
                <li class="txt_clip">
                    <em>[公告]</em>
                    <a href="<?php echo $item['link']; ?>"><?php echo $item['title']; ?></a>
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