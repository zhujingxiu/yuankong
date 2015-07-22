<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/country.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td><input type="text" name="name" value="<?php echo $name; ?>" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span> <?php echo $entry_description; ?></td>
            <td><input type="text" name="description" value="<?php echo $description; ?>" />
              <?php if ($error_description) { ?>
              <span class="error"><?php echo $error_description; ?></span>
              <?php } ?></td>
          </tr>
        </table>
        <br />
        <table id="area-to-geo-area" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_area; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $area_to_area_geo_row = 0; ?>
          <?php foreach ($area_to_area_geos as $area_to_area_geo) { ?>
          <tbody id="area-to-geo-area-row<?php echo $area_to_area_geo_row; ?>">
            <tr>
              
              <td class="left"><select name="area_to_area_geo[<?php echo $area_to_area_geo_row; ?>][area_id]" id="area<?php echo $area_to_area_geo_row; ?>">
                </select></td>
              <td class="left"><a onclick="$('#area-to-geo-area-row<?php echo $area_to_area_geo_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $area_to_area_geo_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td></td>
              <td class="left"><a onclick="addGeoZone();" class="button"><?php echo $button_add_area_geo; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#area-id').load('index.php?route=localisation/area_geo/area&token=<?php echo $token; ?>&area_id=0');
//--></script>
<?php $area_to_area_geo_row = 0; ?>
<?php foreach ($area_to_area_geos as $area_to_area_geo) { ?>
<script type="text/javascript"><!--
$('#area<?php echo $area_to_area_geo_row; ?>').load('index.php?route=localisation/area_geo/area&token=<?php echo $token; ?>&area_id=<?php echo $area_to_area_geo['area_id']; ?>');
//--></script>
<?php $area_to_area_geo_row++; ?>
<?php } ?>
<script type="text/javascript"><!--
var area_to_area_geo_row = <?php echo $area_to_area_geo_row; ?>;

function addGeoZone() {
	html  = '<tbody id="area-to-geo-area-row' + area_to_area_geo_row + '">';
	html += '<tr>';
	html += '<td class="left"><select name="area_to_area_geo[' + area_to_area_geo_row + '][area_id]" id="area' + area_to_area_geo_row + '"></select></td>';
	html += '<td class="left"><a onclick="$(\'#area-to-geo-area-row' + area_to_area_geo_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '</tr>';
	html += '</tbody>';
	
	$('#area-to-geo-area > tfoot').before(html);
		
	$('#area' + area_to_area_geo_row).load('index.php?route=localisation/area_geo/area&token=<?php echo $token; ?>&area_id=0');
	
	area_to_area_geo_row++;
}
//--></script> 
<?php echo $footer; ?>