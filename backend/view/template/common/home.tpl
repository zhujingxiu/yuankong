<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_install) { ?>
  <div class="warning"><?php echo $error_install; ?></div>
  <?php } ?>
  <?php if ($error_image) { ?>
  <div class="warning"><?php echo $error_image; ?></div>
  <?php } ?>
  <?php if ($error_image_cache) { ?>
  <div class="warning"><?php echo $error_image_cache; ?></div>
  <?php } ?>
  <?php if ($error_cache) { ?>
  <div class="warning"><?php echo $error_cache; ?></div>
  <?php } ?>
  <?php if ($error_download) { ?>
  <div class="warning"><?php echo $error_download; ?></div>
  <?php } ?>
  <?php if ($error_logs) { ?>
  <div class="warning"><?php echo $error_logs; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/home.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <div class="shortcuts">
        <ul>
          <li> <a href="<?php echo $emenu_add_product; ?>"> <img src="view/image/shortcut/add-product.png">
            <h6><?php echo $text_emenu_add_product; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_products; ?>"> <img src="view/image/shortcut/products.png">
            <h6><?php echo $text_emenu_products; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_add_category; ?>"> <img src="view/image/shortcut/add-category.png">
            <h6><?php echo $text_emenu_add_category; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_projects; ?>"> <img src="view/image/shortcut/projects.png">
            <h6><?php echo $text_emenu_projects; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_options; ?>"> <img src="view/image/shortcut/options.png">
            <h6><?php echo $text_emenu_options; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_information; ?>"> <img src="view/image/shortcut/information.png">
            <h6><?php echo $text_emenu_information; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_reviews; ?>"> <img src="view/image/shortcut/reviews.png">
            <h6><?php echo $text_emenu_reviews; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_orders; ?>"> <img src="view/image/shortcut/orders.png">
            <h6><?php echo $text_emenu_orders; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_returns; ?>"> <img src="view/image/shortcut/returns.png">
            <h6><?php echo $text_emenu_returns; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_customers; ?>"> <img src="view/image/shortcut/customers.png">
            <h6><?php echo $text_emenu_customers; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_settings; ?>"> <img src="view/image/shortcut/settings.png">
            <h6><?php echo $text_emenu_settings; ?></h6>
            </a> </li>
          <li> <a href="<?php echo $emenu_backup_restore; ?>"> <img src="view/image/shortcut/backup_restore.png">
            <h6><?php echo $text_emenu_backup_restore; ?></h6>
            </a> </li>
        </ul>
      </div>
      <div style="clear:both;"></div>
      <div class="overview">
        <div class="dashboard-heading"><?php echo $text_overview; ?></div>
        <div class="dashboard-content">
          <table>
            <tr>
              <td><?php echo $text_total_sale; ?></td>
              <td><?php echo $total_sale; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_sale_year; ?></td>
              <td><?php echo $total_sale_year; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_order; ?></td>
              <td><?php echo $total_order; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_customer; ?></td>
              <td><?php echo $total_customer; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_customer_approval; ?></td>
              <td><?php echo $total_customer_approval; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_review_approval; ?></td>
              <td><?php echo $total_review_approval; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_company; ?></td>
              <td><?php echo $total_company; ?></td>
            </tr>
            <tr>
              <td><?php echo $text_total_company_approval; ?></td>
              <td><?php echo $total_company_approval; ?></td>
            </tr>
          </table>
        </div>
      </div>
      <div class="statistic">
        <div class="range"><?php echo $entry_range; ?>
          <select id="range" onchange="getSalesChart(this.value)">
            <option value="day"><?php echo $text_day; ?></option>
            <option value="week"><?php echo $text_week; ?></option>
            <option value="month"><?php echo $text_month; ?></option>
            <option value="year"><?php echo $text_year; ?></option>
          </select>
        </div>
        <div class="dashboard-heading"><?php echo $text_statistics; ?></div>
        <div class="dashboard-content">
          <div id="report" style="width: 390px; height: 170px; margin: auto;"></div>
        </div>
      </div>
      <div class="latest">
        <div class="dashboard-heading"><?php echo $text_latest_10_orders; ?></div>
        <div class="dashboard-content">
          <table class="list">
            <thead>
              <tr>
                <td class="right"><?php echo $column_order; ?></td>
                <td class="left"><?php echo $column_customer; ?></td>
                <td class="left"><?php echo $column_status; ?></td>
                <td class="left"><?php echo $column_date_added; ?></td>
                <td class="right"><?php echo $column_total; ?></td>
                <td class="right"><?php echo $column_action; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php if ($orders) { ?>
              <?php foreach ($orders as $order) { ?>
              <tr>
                <td class="right"><?php echo $order['order_id']; ?></td>
                <td class="left"><?php echo $order['customer']; ?></td>
                <td class="left"><?php echo $order['status']; ?></td>
                <td class="left"><?php echo $order['date_added']; ?></td>
                <td class="right"><?php echo $order['total']; ?></td>
                <td class="right"><?php foreach ($order['action'] as $action) { ?>
                  [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                  <?php } ?></td>
              </tr>
              <?php } ?>
              <?php } else { ?>
              <tr>
                <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<!--[if IE]>
<script type="text/javascript" src="view/javascript/jquery/flot/excanvas.js"></script>
<![endif]--> 
<script type="text/javascript" src="view/javascript/jquery/flot/jquery.flot.js"></script> 
<script type="text/javascript"><!--
function getSalesChart(range) {
	$.ajax({
		type: 'get',
		url: 'index.php?route=common/home/chart&token=<?php echo $token; ?>&range=' + range,
		dataType: 'json',
		async: false,
		success: function(json) {
			var option = {	
				shadowSize: 0,
				lines: { 
					show: true,
					fill: true,
					lineWidth: 1
				},
				grid: {
					backgroundColor: '#FFFFFF'
				},	
				xaxis: {
            		ticks: json.xaxis
				}
			}

			$.plot($('#report'), [json.order, json.customer], option);
		}
	});
}

getSalesChart($('#range').val());
//--></script> 
<?php echo $footer; ?>