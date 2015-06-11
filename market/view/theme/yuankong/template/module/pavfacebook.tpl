<div class="box facebook">
<?php if(isset($application_id) && $application_id) { ?>
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/<?php echo $displaylanguage ?>/all.js#xfbml=1&appId=<?php echo $application_id ?>";
	fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
<?php } else {?>
	<script>(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "//connect.facebook.net/<?php echo $displaylanguage ?>/all.js#xfbml=1";
	fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	<?php } ?>
<div style="width:<?php echo $width?>px">	
<?php
	echo '<fb:like-box '
	.'href="'.$page_url.'" '
	.'width="'.$width.'" '
	.'height="'.$height.'" '
	.'border_color="'.$border_color.'" data-show-border="false"'
	.'show_faces="'.($show_faces ? 'true' : 'false').'" '
	.'stream="'.($tream ? 'true' : 'false').'" '
	.'header="'.($header ? 'true' : 'false').'"'
	.($colorscheme=='dark' ? 'colorscheme="dark"' : '')
	.'></fb:like-box>';
?>
</div>
</div>