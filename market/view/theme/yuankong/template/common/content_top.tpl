<?php 
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/
?>
<?php if( count($modules) ) : ?>

<?php foreach ($modules as $module) { ?>
<div class="w mt15">
<?php echo $module; ?>
</div>
<?php } ?>

<?php endif; ?>