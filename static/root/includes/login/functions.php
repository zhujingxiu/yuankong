<?php 
function & get_oauth_url($type='')
{	
	if(!file_exists(ROOT_PATH . 'includes/login/config/'.$type.'_config.php'))
	{
		return false;
	}
	$open = empty($_REQUEST['open']) ? 0 : intval($_REQUEST['open']);
	include_once(ROOT_PATH . 'includes/login/config/'.$type.'_config.php');
	if($type=='qq'){
		$app_id=APP_KEY;
		$app_key=APP_SECRET;
		$request_url='http://'.$_SERVER['HTTP_HOST'].'/user.php?act=act_oauth_login&type='.$type;
		$_SESSION['REQ_STATE'] = md5(uniqid(mt_rand(1, 100000), true));
		$data=array(
			'client_id'		=>	APP_KEY,
			'redirect_uri'  =>  $request_url,
			'state'			=>	$_SESSION['REQ_STATE']
		);
		$data=http_build_query($data);
		$url='https://graph.qq.com/oauth2.0/authorize?response_type=code&'.$data;  
	}elseif($type=='alipay'){
		$alipay_config = array(
			'partner'		=> APP_KEY,
			'key'			=> APP_SECRET,
			'sign_type'     => strtoupper('MD5'),
			'input_charset' => strtolower('utf-8'),
			'cacert'	    => getcwd().'\\cacert.pem',
			'transport'    	=> 'http'
		);
		//die(print_r($alipay_config));
		include_once(ROOT_PATH . 'includes/login/alipay/alipay_submit.class.php');
		$return_url ='http://'.$_SERVER['HTTP_HOST'].'/user.php?act=act_oauth_login&type=alipay&open='.$open;
		//$return_url ='http://'.$_SERVER['HTTP_HOST'].'/alipay/return_url.php';

		$parameter = array(
			"service" 		=> "alipay.auth.authorize",
			"partner" 		=> trim($alipay_config['partner']),
			"target_service"=> "user.auth.quick.login",
			"return_url"	=> $return_url,
			"anti_phishing_key"	=> "",
			"exter_invoke_ip"	=> "",
			"_input_charset"	=> trim(strtolower($alipay_config['input_charset']))
		);
		$alipaySubmit = new AlipaySubmit($alipay_config);
		die($alipaySubmit->buildRequestForm($parameter,"get", "确认"));
	}elseif($type=='sina'){
		include_once(ROOT_PATH . 'includes/login/sina/saetv2.ex.class.php' );
		$WB_CALLBACK_URL='http://'.$_SERVER['HTTP_HOST'].'/user.php?act=act_oauth_login&type=sina&open='.$open;
		$o = new SaeTOAuthV2( APP_KEY , APP_SECRET );
		
		$code_url = $o->getAuthorizeURL($WB_CALLBACK_URL);	
		//die(print_r($code_url));
		header('Location: '.$code_url);
		exit;
	}
	return $url;
}
function & get_oauth_info($type='')
{	
	if(!file_exists(ROOT_PATH . 'includes/login/config/'.$type.'_config.php'))
	{
		return false;
	}
	include_once(ROOT_PATH . 'includes/login/config/'.$type.'_config.php');
	//$request_prefix = $this->url->link('account/oauth_login','type='.$type,'SSL');
	if($type=='qq'){

		//获取token
		$request_url='http://'.$_SERVER['HTTP_HOST'].'/user.php?act=act_oauth_login&type='.$type;
		$data=array(
			'client_id'		=>	APP_KEY,
			'client_secret' =>	APP_SECRET,
			'redirect_uri'  =>  $request_url,
			'code'  		=>  $_REQUEST['code'],
			'state'			=>	$_SESSION['REQ_STATE']
		);
		
		$get_code_url='https://graph.qq.com/oauth2.0/token?grant_type=authorization_code&'.http_build_query($data);
		
		$token = get_oauth_contents($get_code_url); 
		parse_str($token,$token);
		$access_token=$token['access_token'];
		//获取uid
		$uid_url='https://graph.qq.com/oauth2.0/me?access_token='.$access_token;
		$uid=get_oauth_contents($uid_url); 
		if(strpos($uid, "callback") !== false){
			$lpos = strpos($uid, "(");
			$rpos = strrpos($uid, ")");
			$uid = substr($uid, $lpos + 1, $rpos - $lpos -1);
		}
		$uid = json_decode($uid);
		$uid = $uid->openid;
		//获取用户信息
		$info_url='https://graph.qq.com/user/get_user_info?access_token='.$access_token.'&oauth_consumer_key='.$app_id.'&openid='.$uid;
		$infos=get_oauth_contents($info_url); 
		$infos = json_decode($infos);
		//获取信息
		$info=array();
		$info['user_id']=$uid;
		$info['user_name']=$infos->nickname;
		$info['rank_id'] = RANK_ID;
		$info['sex']=$infos->gender;						//性别
		//$info['user_photo']=$infos->figureurl_2;			//头像100x100
		//$info['figureurl']=$infos->figureurl;				//头像30x30
		//$info['figureurl_1']=$infos->figureurl_1;			//头像50x50
		//$info['figureurl_qq_1']=$infos->figureurl_qq_1;	//QQ头像40x40
		//$info['figureurl_qq_2']=$infos->figureurl_qq_2;	//QQ头像100x100	 
		$info['sex']= $info['sex']=='男' ? 1:2;
	}elseif($type=='alipay'){
		$alipay_config['partner']		= APP_KEY;
		$alipay_config['key']			= APP_SECRET;
		$alipay_config['sign_type']    = strtoupper('MD5');
		$alipay_config['input_charset']= strtolower('utf-8');
		$alipay_config['cacert']    = getcwd().'\\cacert.pem';
		$alipay_config['transport']    = 'http';
		include_once(ROOT_PATH . 'includes/login/alipay/alipay_notify.class.php');
		$alipayNotify = new AlipayNotify($alipay_config);
		$verify_result = $alipayNotify->verifyReturn();		
		//验证成功
		$alipay_user_id = $_GET['user_id'];
		$alipay_user_name = $_GET['real_name'];
		//授权令牌
		$token = $_GET['token'];	
		
		if(!$alipay_user_id)
		{
			die('授权失败');
		}
		$arr['user_id'] = $alipay_user_id;
		$arr['user_name'] = $alipay_user_name;
		$arr['sex']  =  '0';
		$arr['rank_id'] = RANK_ID;
		$info = $arr;	
	}elseif($type=='sina'){
		//die(print_r($_REQUEST));
		include_once(ROOT_PATH . 'includes/login/sina/saetv2.ex.class.php' );	
		$o = new SaeTOAuthV2( APP_KEY , APP_SECRET );
		$WB_CALLBACK_URL='http://'.$_SERVER['HTTP_HOST'].'/user.php?act=oath_login&type=sina&open='.$open;
		if (isset($_REQUEST['code'])) {
			$keys = array();
			$keys['code'] = $_REQUEST['code'];
			$keys['redirect_uri'] = $WB_CALLBACK_URL;
			try {
				$token = $o->getAccessToken( 'code', $keys ) ;
			} catch (OAuthException $e) {
			}
		}
		$c = new SaeTClientV2( WB_AKEY , WB_SKEY , $token['access_token'] );
		$ms  = $c->home_timeline(); // done
		$uid_get = $c->get_uid();
		$uid = $uid_get['uid'];
		$user_message = $c->show_user_by_id( $uid);//根据ID获取用户等基本信息
		if(!$user_message)
		{
			die('授权失败');
		}
		$arr = array();
		if(!empty($user_message['error_code']))
		{
			$arr['error'] = $user_message['error_code'];
			$arr['message'] = $user_message['error'];
			return $arr;
		}
		
		$arr['user_id'] = $user_message['id'];
		$arr['user_name'] = $user_message['name'];
		$arr['location'] = $user_message['location'];
		$arr['sex']  = $user_message['gender'] == 'm' ? '1' : '0';
		$arr['rank_id'] = RANK_ID;
		$arr['img'] = $user_message['profile_image_url'];
		$arr['user_info'] = $user_message;
		$info = $arr;	
	}
	return $info;
}
function get_oauth_contents($url){
        if (ini_get("allow_url_fopen") == "1") {
            $response = file_get_contents($url);
        }else{
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
            curl_setopt($ch, CURLOPT_URL, $url);
            $response =  curl_exec($ch);
            curl_close($ch);
        }
        //-------请求为空
        if(empty($response)){
            $response='error';
        }

        return $response;
}

?>