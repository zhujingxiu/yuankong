<?php
function truncate_string($string, $length = 80, $etc = '...', $count_words = true) {
    mb_internal_encoding ( "UTF-8" );
    $string = strip_tags(trim(html_entity_decode($string)));
    if ($length == 0) return '';
    preg_match_all ( "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|\xe0[\xa0-\xbf][\x80-\xbf]|[\xe1-\xef][\x80-\xbf][\x80-\xbf]|\xf0[\x90-\xbf][\x80-\xbf][\x80-\xbf]|[\xf1-\xf7][\x80-\xbf][\x80-\xbf][\x80-\xbf]/", $string, $info );
    if ($count_words) {
        $k = 0;
        $wordscut = '';
        for($i = 0; $i < count ( $info [0] ); $i ++) {
            $wordscut .= $info [0] [$i];
            $k ++;
            if ($k >= $length) {
                return $wordscut . $etc;
            }
        }
        return join ( '', $info [0] );
    }
    return join ( "", array_slice ( $info [0], 0, $length ) ) . $etc;
}
/*
operation E:Encrypt D:Decrypt

*/
function JEncrypt($string,$operation='E'){ 
    $key = md5('JingJian'); 
    $key_length = strlen($key); 
    $string = $operation == 'D' ? base64_decode($string) : substr(md5($string.$key),0,8).$string; 
    $string_length = strlen($string); 
    $rndkey = $box = array(); 
    $result = ''; 
    for($i = 0;$i <= 255;$i++){ 
        $rndkey[$i] = ord($key[$i%$key_length]); 
        $box[$i] = $i; 
    } 
    for($j = $i = 0;$i < 256;$i++){ 
        $j = ($j+$box[$i]+$rndkey[$i])%256; 
        $tmp = $box[$i]; 
        $box[$i] = $box[$j]; 
        $box[$j] = $tmp; 
    } 
    for($a = $j = $i = 0;$i<$string_length;$i++){ 
        $a = ($a+1)%256; 
        $j = ($j+$box[$a])%256; 
        $tmp = $box[$a]; 
        $box[$a] = $box[$j]; 
        $box[$j] = $tmp; 
        $result .= chr(ord($string[$i])^($box[($box[$a]+$box[$j])%256])); 
    } 
    if($operation == 'D'){ 
        if(substr($result,0,8) == substr(md5(substr($result,8).$key),0,8)){ 
            return substr($result,8); 
        }else{ 
            return''; 
        } 
    }else{ 
        return str_replace('=','',base64_encode($result)); 
    } 
}
function mb_unserialize($serial_str) {
    $out = preg_replace('!s:(\d+):"(.*?)";!se', "'s:'.strlen('$2').':\"$2\";'", $serial_str );
    return unserialize($out);
}
function dayList($begin,$end){
    $data = array();
    $begin = strtotime($begin);
    $end = strtotime($end);
    for($i=$begin; $i<=$end;$i+=(24*3600)){
        $data[] =  date("Y-m-d",$i) ;
    }
    return $data; 
}

function get_image_url($fileName){
    $imgurl = '';
    $ext = substr($fileName,strrpos($fileName,'.') + 1);
    if(in_array($ext,array('jpg','jpeg','gif','png'))){
        $imgurl = $fileName;
    }else{
        if(defined("HTTP_CATALOG")){
            $prefix  =  HTTP_CATALOG;
        }else{
            $prefix  =  HTTP_SERVER;
        }
        $imgurl = $prefix."asset/image/icons/$ext.png";
    }
    return $imgurl;
}


function zeroFull($value,$length = 3){
    $zeroFull = array();
    for($i=strlen((int)$value);$i<$length;$i++){
        $zeroFull[]='0';
    }
    $zeroFull[] = (int)$value;
    return implode('', $zeroFull);
}

function _is_curl_installed() {
    if(in_array('curl', get_loaded_extensions())) {
        return true;
    }
    else {
        return false;
    }
}

function deldir($dir) {
  //先删除目录下的文件：
    $dh=opendir($dir);
    while ($file=readdir($dh)) {
        if($file!="." && $file!="..") {
            $fullpath=$dir."/".$file;
            if(!is_dir($fullpath)) {
                unlink($fullpath);
            } else {
                deldir($fullpath);
            }
        }
    }
    closedir($dh);
    //删除当前文件夹：
    if(rmdir($dir)) {
        return true;
    } else {
        return false;
    }
}
/* *
* 对变量进行 JSON 编码
* @param mixed value 待编码的 value ，除了resource 类型之外，可以为任何数据类型，该函数只能接受 UTF-8 编码的数据
* @return string 返回 value 值的 JSON 形式
*/ 
function json_encode_ex( $value){ 
    if(version_compare( PHP_VERSION,'5.4.0','<')){ 
        $str = json_encode( $value); 
        $str = preg_replace_callback( 
                    "#\\\u([0-9a-f]{4})#i", 
                    function( $matchs){ 
                        return  iconv('UCS-2BE', 'UTF-8',  pack('H4',  $matchs[1])); 
                    }, 
                    $str 
                ); 
        return  $str; 
    }else{ 
        return json_encode( $value, JSON_UNESCAPED_UNICODE); 
    } 
}

function getIpPlace(){
    $ip=file_get_contents("http://fw.qq.com/ipaddress");
    $ip=str_replace('"',' ',$ip);
    $ip2=explode("(",$ip);
    $a=substr($ip2[1],0,-2);
    $b=explode(",",$a);
    return $b;
}

function getProjectStatus($status,$entry_id){
    $text = '';
    switch ((int)$status) {
        case 1:
            $text = '<span class="red">未处理</span><i class="padlr12 cd">|</i><em class="zt-reset" data-status="'.$status.'" data-entry="'.$entry_id.'">修改</em>';
            break;
        case 2:
            $text = '<span class="cgreen">处理中</span><i class="padlr12 cd">|</i><em class="zt-reset" data-status="'.$status.'" data-entry="'.$entry_id.'">修改</em>';
            break;
        case 3:
            $text = '<span class="c9">已完成</span>';
            break;
        default :
            $text = '<span class="red">未知异常</span>';
    }
    return $text;
}

function getCompanyFileStatus($status){
    $text = '';
    switch ((int)$status) {
        case 1:
            $text = '已过审';
            break;
        case 2:
            $text = '未过审';
            break;
        default:
            $text = '待审核';
            break;
    }
    return $text;

}

  /**
   * *
   * @param string $value
   * @param string $match
   * @return boolean
   */
    function isURL($url,$match='/^(http:\/\/)?(https:\/\/)?([\w\d-]+\.)+[\w-]+(\/[\d\w-.\+\/?%&=#]*)?$/i'){
        if(empty($url)){
            return false;
        }
        $url = strtolower(trim($url));
        return preg_match($match, $url);
        return false;
        
    }

  /**
   * @param string $value
   * @param int $length
   * @return boolean
   */
    function isEmail($value,$match='/^[\w\d]+[\w\d-.]*@[\w\d-.]+\.[\w\d]{2,10}$/i'){
        $v = trim($value);
        if(empty($v)) 
            return false;

        return preg_match($match,$v);
    }
  
  /**
   * @param string $value
   * @return boolean
   */
    function isTelephone($value,$match='/^0[0-9]{2,3}[-]?\d{7,8}$/'){
        $v = trim($value);
        if(empty($v)) 
            return false;
        return preg_match($match,$v);
    }

    /**
     * @param string $value
     * @param string $match
     * @return boolean
     */
    function isMobile($value,$match='/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/'){
        $v = trim($value);
        if(empty($v)) 
            return false;
        return preg_match($match,$v);
    }
    /**
     * @param string $value
     * @param string $match
     * @return boolean
     */
    function isPostcode($value,$match='/\d{6}/'){
        $v = trim($value);
        if(empty($v)) 
            return false;
        return preg_match($match,$v);
    }
    /**
     * @param string $value
     * @param string $match
     * @return boolean
     */
    function isIP($value,$match='/^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/'){
        $v = trim($value);
        if(empty($v))
            return false;
        return preg_match($match,$v);
    }

//配置后台菜单
function initAdminMenu(){
    $dashboard      = 'common/home';
    $project        = array(
            'project'       => 'sale/project',
            'project_group' => 'sale/project_group',
        );
    $sale           = array(
            'order'         => 'sale/order',
            'return'        => 'sale/return',
        );
    $module         = 'extension/module';
    $catalog        = array(
            'category'      => 'catalog/category',
            'product'       => 'catalog/product',
            'option'        => 'catalog/option',
            'attribute'     => array(
                    'attribute'         => 'catalog/attribute',
                    'attribute_group'   => 'catalog/attribute_group'
                ),
            'manufacturer'  => 'catalog/manufacturer',
            );
    $wiki           = array(
            'wiki'          => 'extension/wiki',
            'wiki_group'    => 'extension/wiki_group',
        );
    
    $customer       = array(
            'customer'      => 'sale/customer',
            'customer_group'=> 'sale/customer_group',
            'contact'       => 'sale/contact',
            'customer_ban'  => 'sale/customer_ban_ip',
        );
    $review         = 'catalog/review';
    $help           = 'extension/help';
    $company        = array(
            'company'       => 'sale/company',
            'company_group' => 'sale/company_group',
            'company_zone'  => 'sale/company_zone',
            'company_request' => 'sale/company_request',
            'case'          => 'extension/case',

        );
    $link           = 'extension/link';
    $message        = array(
            'msg_order'     => 'common/message/order',
            'msg_return'    => 'common/message/return',
            'msg_project'   => 'common/message/project',
            'msg_company'   => 'common/message/company',
            'msg_help'      => 'common/message/help',
        );
    $system         = array(
            'setting'       => 'setting/setting',
            'users'         => array(
                'user'              =>'user/user',
                'user_group'        =>'user/user_permission',
            ),
            'localisation'  => array(
                'order_status'      =>'localisation/order_status',
                'return'            => array(
                    'return_status'      =>'localisation/return_status',
                    'return_action'      =>'localisation/return_action',
                    'return_reason'      =>'localisation/return_reason',
                ),
                'area'          =>'localisation/area',
                'area_geo'      =>'localisation/area_geo',
                'tax'           => array(
                    'tax_class'         =>'localisation/tax_class',
                    'tax_rate'          =>'localisation/tax_rate',
                ),
                'length_class'      =>'localisation/length_class',
                'weight_class'      =>'localisation/weight_class',
                'stock_status'      =>'localisation/stock_status',
                'currency'          =>'localisation/currency',
                'language'          =>'localisation/language',
                
            ),
            'error_log'     => 'tool/error_log',
            'backup'        => 'tool/backup'
        );

    $extension = array(
            'shipping'      => 'extension/shipping',
            'payment'       => 'extension/payment',
            'total'         => 'extension/total',
            'feed'          => 'extension/feed',
            'coupon'        => 'sale/coupon',
            'voucher'       => array(
                'voucher'           =>'sale/voucher',
                'voucher_theme' =>'sale/voucher_theme',
            ),   
        );

    return array(
        'left'  =>  array(
            'dashboard' => $dashboard,
            'project'   => $project,
            'order'     => $sale,
            'module'    => $module,
            'catalog'   => $catalog,
            'wiki'      => $wiki,
            'customer'  => $customer,
            'review'    => $review,
            'help'      => $help,
            'company'   => $company,
            'link'      => $link,
            
        ),
        'right' =>  array(
            //'message'   =>$message,
            'system'    =>$system,
            'extension' =>$extension,
        )
    );
}