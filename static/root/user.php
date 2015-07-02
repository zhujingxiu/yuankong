<?php
// 不需要登录的操作或自己验证是否登录（如ajax处理）的act
$not_login_arr =
array('login','act_login','register','act_register','act_edit_password','get_password','send_pwd_email','password', 'signin', 'add_tag', 'collect', 'return_to_cart', 'logout', 'email_list', 'validate_email', 'send_hash_mail', 'order_query', 'is_registered', 'check_email','clear_history','qpassword_name', 'get_passwd_question', 'check_answer', 'oauth_login','act_oauth_login');

/* 显示会员注册界面 */
if ($action == 'register')
{
    if ((!isset($back_act)||empty($back_act)) && isset($GLOBALS['_SERVER']['HTTP_REFERER']))
    {
        $back_act = strpos($GLOBALS['_SERVER']['HTTP_REFERER'], 'user.php') ? './index.php' : $GLOBALS['_SERVER']['HTTP_REFERER'];
    }

    /* 取出注册扩展字段 */
    $sql = 'SELECT * FROM ' . $ecs->table('reg_fields') . ' WHERE type < 2 AND display = 1 ORDER BY dis_order, id';
    $extend_info_list = $db->getAll($sql);
    $smarty->assign('extend_info_list', $extend_info_list);

    /* 验证码相关设置 */
    if ((intval($_CFG['captcha']) & CAPTCHA_REGISTER) && gd_version() > 0)
    {
        $smarty->assign('enabled_captcha', 1);
        $smarty->assign('rand',            mt_rand());
    }

    /* 密码提示问题 */
    $smarty->assign('passwd_questions', $_LANG['passwd_questions']);

    /* 增加是否关闭注册 */
    $smarty->assign('shop_reg_closed', $_CFG['shop_reg_closed']);
//    $smarty->assign('back_act', $back_act);
    $smarty->display('user_passport.dwt');
}

//  第三方登录接口
elseif($action == 'oauth_login')
{
	$type = empty($_REQUEST['type']) ?  '' : $_REQUEST['type'];
    include_once(ROOT_PATH . 'includes/login/functions.php');
	$url=get_oauth_url($type);
	if($url){
		echo("<script> top.location.href='" . $url . "'</script>");
	}else{
		die('错误！');
	}
}
elseif($action == 'act_oauth_login')
{
    include_once(ROOT_PATH . 'includes/login/functions.php');
	$type = empty($_REQUEST['type']) ?  '' : $_REQUEST['type'];
	//die(print_r($_REQUEST));
	$info=get_oauth_info($type);
	if(!empty($info['error']))
	{
		show_message('登录出错,错误码'.$info['error'], $_CFG['url'] , 'error' , false);
	}
	$info_user_id = $type .'_'.$info['user_id'];
	$info['user_name'] = str_replace("'" , "" , $info['user_name']); 
	
	$sql = 'SELECT user_name,password,aite_id FROM '.$ecs->table('users')." WHERE aite_id = '$info_user_id' OR aite_id='$info[user_id]'";		
	$user_info = $db->getRow($sql);
	//die(print_r($user_info));
	if(!$user_info)   // 没有当前数据
	{
		if($user->check_user($info['user_name']))  // 重名处理
		{
			$info['user_name'] = $info['user_name'].'_'.(rand( 0 , 100));
		}
		$password = $user->compile_password(array('password'=>$info['user_id']));
		
		$sql = 'INSERT INTO '.$ecs->table('users').'(user_name , password, aite_id , sex , reg_time , user_rank , is_validated) VALUES '.
				"('$info[user_name]' , '$password' , '$info_user_id' , '$info[sex]' , '".gmtime()."' , '0' , '1')" ;
		$db->query($sql);
	}
	else
	{
		$sql = '';
		if($info['user_id'] == $user_info['aite_id'])  // 为兼容之前的版本写的  // 直接使用 可以 删除 此段
		{
			$sql .= 'aite_id = \''.$info_user_id.'\' ,';
		}		
		if($info['user_name'] != $user_info['user_name'])
		{
			$sql .= " user_name = '$info[user_name]' ,";
		}
		if($info['sex'] != $user_info['sex'])
		{
			$sql .= " sex = $info[sex] ,";
		}
		if($sql)
		{
			$sql = substr($sql , 0 ,strlen($sql) -1);
			
			$sql = 'UPDATE '.$ecs->table('users').' SET '. $sql ." WHERE aite_id= '$info[user_id]'";
			$db->query($sql);
		}
	}
	
	$user->set_session($info['user_name']);
    $user->set_cookie($info['user_name']);
	update_user_info();
	recalculate_price();
	die('<script>window.opener.window.location.reload(); window.close();</script>');
}
?>