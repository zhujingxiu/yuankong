<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="view/stylesheet/stylesheet.css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
<?php if(strtolower($lang)=='cn'){?>
<script type="text/javascript" src="view/javascript/jquery/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
<?php }?>
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="view/javascript/jquery/superfish/js/superfish.js"></script>
<script type="text/javascript" src="view/javascript/common.js"></script>
<script type="text/javascript" src="view/javascript/scrolltop.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<script type="text/javascript">
$(document).ready(function(){
    // Confirm Delete
    $('#form').submit(function(){
        if ($(this).attr('action').indexOf('delete',1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
    	
    // Confirm Uninstall
    $('a').click(function(){
        if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
            if (!confirm('<?php echo $text_confirm; ?>')) {
                return false;
            }
        }
    });
});
</script>
</head>
<body>
<div id="container">
<div id="header">
  <div class="div1">
    <div class="div2"><img src="view/image/logo.png" title="<?php echo $heading_title; ?>" onclick="location = '<?php echo $home; ?>'" /></div>
    <?php if ($logged) { ?>
    <div class="div3">
      <img src="view/image/lock.png" alt="" style="position: relative; top: 3px;" />
      &nbsp;
      <?php echo $logged; ?>
      &nbsp;
      <a href="<?php echo HTTP_CATALOG ?>" target="_blank" class="top"><?php echo $text_front; ?></a>
      &nbsp;
      <a class="top" href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
    </div>
    <?php } ?>
  </div>
  <?php if ($logged) {;?>
  <div id="menu">
    <?php if (isset($menu['left'])): ?>
    <ul class="left" style="display: none;">
      <?php foreach ($menu['left'] as $key => $top): ?>
      <li id="<?php echo strtolower($key) ?>" class="lv1">
        <?php if (is_array($top)): ?>
        <a class="top"><?php echo $this->language->get('text_'.strtolower($key)) ?></a>
          <ul>
          <?php foreach ($top as $key1 => $item): ?>
            <li>
              <?php if (is_array($item)): ?>
              <a class="parent"><?php echo $this->language->get('text_'.strtolower($key1)); ?></a>
              <ul>
                <?php foreach ($item as $key2 => $last): ?>
                <?php if ($this->user->hasPermission('access',$last)): ?>
                <li>
                  <a href="<?php echo $this->url->link($last,'token='.$token,'SSL'); ?>">
                    <?php echo $this->language->get('text_'.strtolower($key2)) ?>
                  </a>
                </li>
                <?php endif ?>
                <?php endforeach ?>
              </ul>
              <?php else: ?>
                <?php if ($this->user->hasPermission('access',$item)): ?>
                <a href="<?php echo $this->url->link($item,'token='.$token,'SSL'); ?>">
                <?php echo $this->language->get('text_'.strtolower($key1)) ?>
                </a>
                <?php endif ?>              
              <?php endif ?>              
            </li>
          <?php endforeach ?>
          </ul>         
        <?php else: ?>
          <?php if ($this->user->hasPermission('access',$top)): ?>
          <a class="top" href="<?php echo $this->url->link($top,'token='.$token,'SSL'); ?>">
            <?php echo $this->language->get('text_'.strtolower($key)) ?>
          </a> 
          <?php endif ?>         
        <?php endif ?>        
      </li>
      <?php endforeach ?>      
    </ul>
    <?php endif ?>
    <?php if (isset($menu['right'])): ?>
    <ul class="right" style="display: none;">
      <li id="messages"><a class="top lv1"><?php echo $text_messages; ?></a>
        <ul>
          <li><a href="<?php echo $new_orders; ?>"><?php echo $text_new_orders; ?></a></li>
          <li><a href="<?php echo $new_projects; ?>"><?php echo $text_new_projects; ?></a></li>
          <li><a href="<?php echo $new_helps; ?>"><?php echo $text_new_helps; ?></a></li>
        </ul>
      </li>
      <?php foreach ($menu['right'] as $key => $top): ?>
      <li id="<?php echo strtolower($key) ?>" class="lv1">
        <?php if (is_array($top)): ?>
        <a class="top"><?php echo $this->language->get('text_'.strtolower($key)) ?></a>
          <ul>
          <?php foreach ($top as $key1 => $item): ?>
            <li>
              <?php if (is_array($item)): ?>
              <a class="parent"><?php echo $this->language->get('text_'.strtolower($key1)); ?></a>
              <ul>
                <?php foreach ($item as $key2 => $last): ?>
                <?php if ($this->user->hasPermission('access',$last)): ?>
                <li>
                  <a href="<?php echo $this->url->link($last,'token='.$token,'SSL'); ?>">
                    <?php echo $this->language->get('text_'.strtolower($key2)) ?>
                  </a>
                </li>
                <?php endif ?>
                <?php endforeach ?>
              </ul>
              <?php else: ?>
                <?php if ($this->user->hasPermission('access',$item)): ?>
                <a href="<?php echo $this->url->link($item,'token='.$token,'SSL'); ?>">
                <?php echo $this->language->get('text_'.strtolower($key1)) ?>
                </a>
                <?php endif ?>              
              <?php endif ?>              
            </li>
          <?php endforeach ?>
          </ul>         
        <?php else: ?>
        <?php if ($this->user->hasPermission('access',$top)): ?>
        <a class="top" href="<?php echo $this->url->link($top,'token='.$token,'SSL'); ?>">
          <?php echo $this->language->get('text_'.strtolower($key)) ?>
        </a>  
        <?php endif ?>        
        <?php endif ?>        
      </li>
      <?php endforeach ?>      
    </ul>
    <?php endif ?>    
    <?php if (false): ?>    
    <ul class="left" style="display: none;">
      <li id="dashboard"><a href="<?php echo $home; ?>" class="top"><?php echo $text_dashboard; ?></a></li>
      <li id="project"><a class="top"><?php echo $text_project; ?></a>
          <ul>
            <li><a href="<?php echo $project; ?>"><?php echo $text_project; ?></a></li>
            <li><a href="<?php echo $project_group; ?>"><?php echo $text_project_group; ?></a></li>
          </ul>
      </li>
      <li id="order"><a class="top"><?php echo $text_order; ?></a>
        <ul>
          <li><a href="<?php echo $order; ?>"><?php echo $text_all_orders; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          
        </ul>
      </li>
      <li id="module"><a href="<?php echo $module; ?>" class="top"><?php echo $text_module; ?></a></li>
      <li id="catalog"><a class="top"><?php echo $text_catalog; ?></a>
        <ul>
          <li><a href="<?php echo $category; ?>"><?php echo $text_category; ?></a></li>
          <li><a href="<?php echo $product; ?>"><?php echo $text_product; ?></a></li>
          <li><a href="<?php echo $option; ?>"><?php echo $text_option; ?></a></li>
          <li><a class="parent"><?php echo $text_attribute; ?></a>
            <ul>
              <li><a href="<?php echo $attribute; ?>"><?php echo $text_attribute; ?></a></li>
              <li><a href="<?php echo $attribute_group; ?>"><?php echo $text_attribute_group; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
        </ul>
      </li>
      
      <li id="wiki"><a class="top"><?php echo $text_wiki; ?></a>
          <ul>
            <li><a href="<?php echo $wiki ?>"><?php echo $text_wiki; ?></a></li>
            <li><a href="<?php echo $wiki_group; ?>"><?php echo $text_wiki_group; ?></a></li>
          </ul>
      </li>
          
      <li id="customer"><a class="top"><?php echo $text_customer; ?></a>
        <ul>
          <li><a href="<?php echo $customer; ?>"><?php echo $text_customer; ?></a></li>
          <li><a href="<?php echo $customer_group; ?>"><?php echo $text_customer_group; ?></a></li>
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $customer_ban_ip; ?>"><?php echo $text_customer_ban_ip; ?></a></li>
        </ul>
      </li>
      <li id="review"><a href="<?php echo $review; ?>" class="top"><?php echo $text_review; ?></a></li>
      <li id="help"><a href="<?php echo $help ?>" class="top"><?php echo $text_help; ?></a></li>
      <li id="company"><a class="top"><?php echo $text_company; ?></a>
        <ul>
          <li><a href="<?php echo $company; ?>"><?php echo $text_company; ?></a></li>
          <li><a href="<?php echo $company_group; ?>"><?php echo $text_company_group; ?></a></li>
          <li><a href="<?php echo $company_zone; ?>"><?php echo $text_company_zone; ?></a></li>
          <li><a href="<?php echo $company_request; ?>"><?php echo $text_company_request; ?></a></li>
          <li><a href="<?php echo $case; ?>"><?php echo $text_case; ?></a></li>
        </ul>
      </li>
      <li id="link"><a href="<?php echo $link; ?>" class="top"><?php echo $text_link; ?></a></li>
      <?php if(false){?>
      <li id="reports"><a class="top"><?php echo $text_reports; ?></a>
        <ul>
          <li><a class="parent"><?php echo $text_sale; ?></a>
            <ul>
              <li><a href="<?php echo $report_sale_order; ?>"><?php echo $text_report_sale_order; ?></a></li>
              <li><a href="<?php echo $report_sale_tax; ?>"><?php echo $text_report_sale_tax; ?></a></li>
              <li><a href="<?php echo $report_sale_shipping; ?>"><?php echo $text_report_sale_shipping; ?></a></li>
              <li><a href="<?php echo $report_sale_return; ?>"><?php echo $text_report_sale_return; ?></a></li>
              <li><a href="<?php echo $report_sale_coupon; ?>"><?php echo $text_report_sale_coupon; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_product; ?></a>
            <ul>
              <li><a href="<?php echo $report_product_viewed; ?>"><?php echo $text_report_product_viewed; ?></a></li>
              <li><a href="<?php echo $report_product_purchased; ?>"><?php echo $text_report_product_purchased; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_customer; ?></a>
            <ul>
              <li><a href="<?php echo $report_customer_online; ?>"><?php echo $text_report_customer_online; ?></a></li>
              <li><a href="<?php echo $report_customer_order; ?>"><?php echo $text_report_customer_order; ?></a></li>
              <li><a href="<?php echo $report_customer_reward; ?>"><?php echo $text_report_customer_reward; ?></a></li>
              <li><a href="<?php echo $report_customer_credit; ?>"><?php echo $text_report_customer_credit; ?></a></li>
            </ul>
          </li>
        </ul>
      </li>
      <?php }?>
    </ul>
    <ul class="right" style="display: none;">
      <li id="messages"><a class="top"><?php echo $text_messages; ?></a>
        <ul>
          <li><a href="<?php echo $new_orders; ?>"><?php echo $text_new_orders; ?></a></li>
          <li><a href="<?php echo $new_projects; ?>"><?php echo $text_new_projects; ?></a></li>
          <li><a href="<?php echo $new_helps; ?>"><?php echo $text_new_helps; ?></a></li>
        </ul>
      </li>
      <li id="system"><a class="top"><?php echo $text_system; ?></a>
        <ul>
          <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
          <li><a class="parent"><?php echo $text_users; ?></a>
            <ul>
              <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
              <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
            </ul>
          </li>
          <li><a class="parent"><?php echo $text_localisation; ?></a>
            <ul>
              <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
              <li><a href="<?php echo $currency; ?>"><?php echo $text_currency; ?></a></li>
              <li><a href="<?php echo $stock_status; ?>"><?php echo $text_stock_status; ?></a></li>
              <li><a href="<?php echo $order_status; ?>"><?php echo $text_order_status; ?></a></li>
              <li><a class="parent"><?php echo $text_return; ?></a>
                <ul>
                  <li><a href="<?php echo $return_status; ?>"><?php echo $text_return_status; ?></a></li>
                  <li><a href="<?php echo $return_action; ?>"><?php echo $text_return_action; ?></a></li>
                  <li><a href="<?php echo $return_reason; ?>"><?php echo $text_return_reason; ?></a></li>
                </ul>
              </li>
              <li><a href="<?php echo $province; ?>"><?php echo $text_province; ?></a></li>
              <li><a href="<?php echo $area_geo; ?>"><?php echo $text_area_geo; ?></a></li>
              <li><a class="parent"><?php echo $text_tax; ?></a>
                <ul>
                  <li><a href="<?php echo $tax_class; ?>"><?php echo $text_tax_class; ?></a></li>
                  <li><a href="<?php echo $tax_rate; ?>"><?php echo $text_tax_rate; ?></a></li>
                </ul>
              </li>
              <li><a href="<?php echo $length_class; ?>"><?php echo $text_length_class; ?></a></li>
              <li><a href="<?php echo $weight_class; ?>"><?php echo $text_weight_class; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $information; ?>"><?php echo $text_information; ?></a></li>
          
          <li><a class="parent"><?php echo $text_design; ?></a>
            <ul>
              <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
              <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $error_log; ?>"><?php echo $text_error_log; ?></a></li>
          <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
        </ul>
      </li>
      <li id="extension"><a class="top"><?php echo $text_extension; ?></a>
        <ul>
          <li><a href="<?php echo $shipping; ?>"><?php echo $text_shipping; ?></a></li>
          <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
          <li><a href="<?php echo $total; ?>"><?php echo $text_total; ?></a></li>
          <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
          
          <li><a href="<?php echo $coupon; ?>"><?php echo $text_coupon; ?></a></li>
          <li><a class="parent"><?php echo $text_voucher; ?></a>
            <ul>
              <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
              <li><a href="<?php echo $voucher_theme; ?>"><?php echo $text_voucher_theme; ?></a></li>
            </ul>
          </li>
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
        </ul>
      </li>
    </ul>
    <?php endif ?>
  </div>
  <?php } ?>
</div>
<script type="text/javascript">
  $(function(){
    $.each($('#menu li'),function(index) {   
      if($.trim($(this).text()).length == 0){
        $(this).remove();
      }
    });
    $.each($('#menu ul'),function(index) {   
      $.each($(this).children('li'),function(){
        if($.trim($(this).text()).length == 0){
          $(this).remove();
        }
      });
    });
    $.each($('#menu ul'),function(){
      if($(this).children('li').size()==0){
        $(this).parent().remove();
      }
    })
      /*
    $('li a.parent').each(function(index) { 
       if($(this).next('ul').children('li').size() == 0) {
          $(this).parent('li').css('display', 'none');
       }
    });*/
  });
</script>