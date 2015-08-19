<?php if ($error) { ?>
<div class="warning"><?php echo $error; ?></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>

    
    <div class="vtabs shipmenttabs">
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    
        <a href="#tab-<?php echo $history['order_shipment_id'].$history['tracking_no']; ?>">
          <?php echo $history['express']; ?><br><?php echo $history['tracking_no']; ?>
          <img src="view/image/delete.png" data-entity="<?php echo $history['order_shipment_id']?>" class="remove-shipment"/>
        </a>
    <?php } ?>
    <?php } ?>
    <a href="#tab-add-shipment"><?php echo $button_add_shipment; ?>&nbsp;<img src="view/image/add.png" alt="" /></a>
    </div>
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    <div id="tab-<?php echo $history['order_shipment_id'].$history['tracking_no']; ?>" class="vtabs-content">
      <table><tr><td style="width:60%">
      <table class="form">
          <tr>
            <td><?php echo $column_date_added; ?></td>
            <td><?php echo $history['date_added'];; ?></td>
          </tr>
           <tr>
            <td><?php echo $column_notify; ?></td>
            <td><?php echo $history['notify'];; ?></td>
          </tr>
          <tr>
            <td><?php echo $column_express; ?></td>
            <td><?php echo $history['express']; ?></td>
          </tr>
          <tr>
            <td><?php echo $column_tracking_no; ?></td>
            <td><?php echo $history['tracking_no']; ?></td>
          </tr>
          <tr>
            <td><?php echo $column_note; ?></td>
            <td><?php echo $history['note'] ?></td>
          </tr>
      </table>
      </td><td style="margin:0 10px;border-left:1px dashed #cccccc">
      <table class="form" id="shipment-tracking-<?php echo $history['order_shipment_id']; ?>">
        <tr>
            <td><?php echo $entry_time; ?></td>
            <td><input name="time" type="text" class="time"></td>
          </tr>
        <tr>
            <td><?php echo $entry_tracking; ?></td>
            <td>
              <textarea name="note" id="tracking-note" cols="39" rows="4"></textarea>
              <input name="order_shipment_id" type="hidden" value="<?php echo $history['order_shipment_id']; ?>">
              <div style="margin-top: 10px; text-align: right;">
                <a class="button button-tracking" data-form="shipment-tracking-<?php echo $history['order_shipment_id']; ?>"><?php echo $button_add_tracking; ?>
                </a>
              </div>
            </td>
        </tr>
      </table>
      </td></tr></table>
      
        <?php foreach ($history['tracking'] as $info): ?>
        <fieldset class="tracking">
          <legend><?php echo date('Y-m-d H:i:s',strtotime($info['date_added'])) ?> &nbsp; <img src="view/image/delete.png" data-entity="<?php echo $info['tracking_id']?>" class="remove-tracking"/></legend>
          <div class="text"><?php echo strip_tags($info['note']) ?></div>
        </fieldset>
        <?php endforeach ?>
    </div>
    <?php } ?>
    <?php } ?>
    <div id="tab-add-shipment" class="vtabs-content">
      <table class="form" >
          <tr>
            <td><?php echo $text_shipping_express; ?></td>
            <td>
              <select name="express_id">
                <option value="0"><?php echo $text_none ?></option>
              <?php foreach ($expresses as $item): ?>
                <option value="<?php echo $item['express_id'] ?>" >
                  <?php echo $item['title'] ?>
                </option>
              <?php endforeach ?>
              </select>
            </td>
          </tr>
          <tr>
            <td><?php echo $text_shipping_tracking_no; ?></td>
            <td><input type="text" name="tracking_no" value="" size="30"/></td>
          </tr>
          <tr>
              <td><?php echo $entry_notify; ?></td>
              <td><input type="checkbox" name="notify" value="1" checked/></td>
            </tr>
            <tr>
              <td><?php echo $entry_note; ?></td>
              <td><textarea name="note" rows="3" style="width: 99%"></textarea>
                <div style="margin-top: 10px; text-align: right;"><a id="button-shipment" class="button"><?php echo $button_add_shipment; ?></a></div></td>
            </tr>
        </table>
    </div>
<script type="text/javascript"><!--
$('.button-tracking').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/order/addTracking&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
    type: 'post',
    data: $('#'+$(this).attr('data-form')+' input,'+'#'+$(this).attr('data-form')+' textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#shipment').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');      
    },
    complete: function() {
      $('.loading').remove();
      $('#shipment').load('index.php?route=sale/order/shipment&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>');
    },                  
    success: function(json) {
      $('.success, .warning').remove();
            
      if (json['error']) {
        $('.box').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
        
        $('.warning').fadeIn('slow');
      }
      
      if (json['success']) {
        $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
        
        $('.success').fadeIn('slow');

      }
    }
  });
});
$('#button-shipment').bind('click', function() {
  $.ajax({
    url: 'index.php?route=sale/order/shipment&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>',
    type: 'post',
    dataType: 'html',
    data: 'express_id=' + encodeURIComponent($('#tab-add-shipment select[name=\'express_id\']').val()) + '&notify=' + encodeURIComponent($('#tab-add-shipment input[name=\'notify\']').attr('checked') ? 1 : 0) + '&tracking_no=' + encodeURIComponent($('#tab-add-shipment input[name=\'tracking_no\']').val()) + '&note=' + encodeURIComponent($('#tab-add-shipment textarea[name=\'note\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-shipment').attr('disabled', true);
      $('#shipment').prepend('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-shipment').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(html) {
      $('#shipment').html(html);      
      $('textarea[name=\'note\']').val('');      
    }
  });
});
$('.remove-tracking').bind('click',function(){
  if(confirm('<?php echo $text_confirm_shipment ?>')){
    $.ajax({
      url:'index.php?route=sale/order/removeTracking&token=<?php echo $token ?>&tracking_id='+$(this).attr('data-entity'),
      type:'get',
      dataType:'json',
      beforeSend: function() {
        $('#shipment').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');      
      },
      complete: function() {
        $('.loading').remove();
        $('#shipment').load('index.php?route=sale/order/shipment&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>');
      },
      success:function(json){
        $('.success, .warning').remove();
        if (json['error']) {
          $('#shipment').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
          
          $('.warning').fadeIn('slow');
        }
        
        if (json['success']) {
          $('#shipment').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
          
          $('.success').fadeIn('slow');
          
        }
      }
    })
  }
})
$('.remove-shipment').bind('click',function(){
  if(confirm('<?php echo $text_confirm_shipment ?>')){
    $.ajax({
      url:'index.php?route=sale/order/removeShipment&token=<?php echo $token ?>&order_shipment_id='+$(this).attr('data-entity'),
      type:'get',
      dataType:'json',
      beforeSend: function() {
        $('#shipment').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');      
      },
      complete: function() {
        $('.loading').remove();
        $('#shipment').load('index.php?route=sale/order/shipment&token=<?php echo $token; ?>&order_id=<?php echo $order_id; ?>');
      },
      success:function(json){
        $('.success, .warning').remove();
        if (json['error']) {
          $('#shipment').before('<div class="warning" style="display: none;">' + json['error'] + '</div>');
          
          $('.warning').fadeIn('slow');
        }
        
        if (json['success']) {
          $('#shipment').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
          
          $('.success').fadeIn('slow');
          
        }
      }
    })
  }
})
$('.shipmenttabs a').tabs();
$(function () {
    $('.time').datetimepicker({timeFormat: "hh:mm:ss",dateFormat: "yy-mm-dd"});
});

//--></script> 
<style type="text/css">
  fieldset.tracking{
    border: 1px dashed #cccccc;
  }
</style>