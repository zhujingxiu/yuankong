$(function(){
    $('#product :input[name^="option"]').bind('click',function(){
        $(this).parentsUntil('.xh-style').parent().find('.hov').removeClass('hov').find('[name^="option"]').removeAttr('checked');
        $(this).attr('checked','checked').parent().addClass('hov');
        live_price();
    });
});


function live_price() {
    $.ajax({
        type: 'post',
        url: 'index.php?route=product/product/live_price',
        dataType: 'json',
        data: $('input[name^="option"][checked], select[name^="option"], input[type="hidden"], input[name="quantity"]'),
        success: function (json) {  
            $('#price-special').fadeOut(150, function() {$(this).html(json.new_price.special).fadeIn(50);});
            $('#price-tax').fadeOut(150, function() {$(this).html(json.new_price.tax).fadeIn(50);});
            $('#price-now').fadeOut(150, function() {$(this).html(json.new_price.price).fadeIn(50);});
        },
        error: function(xhr, ajaxOptions, thrownError) {
            console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}

function getURLVar(key) {
    var value = [];
    
    var query = String(document.location).split('?');
    
    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');
            
            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }
        
        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
} 

function addToCart(product_id, quantity) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: 'product_id=' + product_id + '&quantity=' + quantity,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            }
            
            if (json['success']) {
                $('#notification').html('<div class="msg-success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                
                $('.msg-success').fadeIn('slow');
                
                $('#cart-total').html(json['total']);
                
                $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                
            }   
        }
    });
}
function addToWishList(product_id) {
    $.ajax({
        url: 'index.php?route=account/wishlist/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();
                        
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                
                $('.success').fadeIn('slow');
                
                $('#wishlist-total').html(json['total']);
                
                $('html, body').animate({ scrollTop: 0 }, 'slow');
            }   
        }
    });
}

function addToCompare(product_id) { 
    $.ajax({
        url: 'index.php?route=product/compare/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();
                        
            if (json['success']) {
                $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                
                $('.success').fadeIn('slow');
                
                $('#compare-total').html(json['total']);
                
                $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                $.get('index.php?route=product/compare/getComparedCount',{},function(data){
                    if(data>1){
                        location.href='index.php?route=product/compare';
                    }
                })
            }   
        }
    });
}

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]); 
    }       
    return null;
}
function getImgUrl(fileName){
    var url='';
    var ext=fileName.substring(fileName.lastIndexOf(".")+1);
    if(ext=='jpg'||ext=='jpeg'||ext=='gif'||ext=='png'){
        url=fileName;
    }else{
        url="/asset/image/img/icons/"+ext+".png";
    }
    return url;
}
function current(type){
    var d=new Date();
    var _date = ''; 
    _date += d.getFullYear()+'-'; //获取当前年份 
    _date += zeroize(d.getMonth()+1)+'-'; //获取当前月份（0——11） 
    _date += zeroize(d.getDate())+' '; 
    if(type=='date'){
        return _date;
    }
    var _time = '';
    _time += zeroize(d.getHours())+':'; 
    _time += zeroize(d.getMinutes())+':'; 
    _time += zeroize(d.getSeconds())+' '; 
    if(type=='time'){
        return _time;
    }
    return _date+_time; 
} 

function zeroize(value, length) {
    if (!length) {
        length = 2;
    }
    value = new String(value);
    for (var i = 0, zeros = ''; i < (length - value.length); i++) {
        zeros += '0';
    }
    return zeros + value;
};


function getRequest() {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i ++) {
            theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}