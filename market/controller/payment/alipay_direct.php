<?php
require_once(DIR_LIB."alipay/alipay_submit.class.php");
class ControllerPaymentAlipayDirect extends Controller {
	public function index() {
		
		$this->load->model('checkout/order');
		$this->checkout->clear();
		$this->cart->clear();
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		
		/**************************请求参数**************************/

        //支付类型
        $payment_type = "1";
        //必填，不能修改
        //服务器异步通知页面路径
        $notify_url = HTTP_SERVER . "alipay_direct/notify_url.php";
        //需http://格式的完整路径，不能加?id=123这类自定义参数

        //页面跳转同步通知页面路径
        $return_url = HTTP_SERVER . 'index.php?route=checkout/success';
        //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

        //商户订单号
        $out_trade_no = $this->session->data['order_id'];
        //商户网站订单系统中唯一订单号，必填
		
		$order_id = $this->session->data['order_id'];
		$title= array();
		$products = $this->model_checkout_order->getOrderProducts($order_id);
		foreach ($products as $product) {
			if(!empty($product['name']))
			$title[] = $product['name'];
		}
		
        //订单名称
        $subject = $this->config->get('config_store').' #' . $order_id.'-'.truncate_string(implode(" ", $title));
        //必填

        //付款金额
        $total_fee = $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value'], false);;
        //必填

        //订单描述

        $body = $this->config->get('config_store').' #' . $order_id.'-'.truncate_string(implode(" ", $title));
        //商品展示地址
        $show_url = '';
        //需以http://开头的完整路径，例如：http://www.商户网址.com/myorder.html

        //防钓鱼时间戳
        $anti_phishing_key = "";
        //若要使用请调用类文件submit中的query_timestamp函数

        //客户端的IP地址
        $exter_invoke_ip = "";
        //非局域网的外网IP地址，如：221.0.0.1
		
		
		//签名方式 不需修改
		$alipay_config['sign_type']    = strtoupper('MD5');
		
		//字符编码格式 目前支持 gbk 或 utf-8
		$alipay_config['input_charset']= strtolower('utf-8');
		
		//ca证书路径地址，用于curl中ssl校验
		//请保证cacert.pem文件在当前文件夹目录中
		$alipay_config['cacert']    = getcwd().'\\cacert.pem';
		
		//访问模式,根据自己的服务器是否支持ssl访问，若支持请选择https；若不支持请选择http
		$alipay_config['transport']    = 'http';
		
		
		$alipay_config['key'] = trim($this->config->get('alipay_direct_cod'));


		/************************************************************/
		
		//构造要请求的参数数组，无需改动
		$parameter = array(
			"service"            => "create_direct_pay_by_user",
			"partner"            => trim($this->config->get('alipay_direct_partner_id')),
			"seller_email"       => trim($this->config->get('alipay_direct_account')),
			"payment_type"	     => $payment_type,
			"notify_url"	     => $notify_url,
			"return_url"	     => $return_url,
			"out_trade_no"	     => $out_trade_no,
			"subject"	         => $subject,
			"total_fee"	         => $total_fee,
			"body"	             => $body,
			"show_url"	         => $show_url,
			"anti_phishing_key"	 => $anti_phishing_key,
			"exter_invoke_ip"	 => $exter_invoke_ip,
			"_input_charset"	 => trim(strtolower($alipay_config['input_charset']))
		);
		//建立请求
		$alipaySubmit = new AlipaySubmit($alipay_config);

		$html_text = $alipaySubmit->buildRequestForm($parameter,"get", " 确认支付 ");
		header("Content-type:text/html;charset=utf-8");
		die($html_text);
		
		$this->data['button_confirm'] = $html_text;

		$this->data['continue'] = $this->url->link('checkout/success');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/alipay_direct.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/payment/alipay_direct.tpl';
		} else {
			$this->template = 'default/template/payment/alipay_direct.tpl';
		}

        $this->render();
	}

}