<?php
class Sms {
	private $target_url = "http://sms.chanzor.com:8001/sms.aspx";
	private $account = 'wcs8695';
	private $password = '152317';
			
	public function sendMsg($telephone,$msg) {
		$post_data = array(
			'action'	=> 'send',
			'userid'	=> '',
			'account'	=> $this->account,
			'password'	=> $this->password,
			'mobile'	=> $telephone,
			'sendTime'	=> '',
			'content'	=> rawurlencode($msg)
		);

		$response = $this->_request(http_build_query($post_data), $this->target_url);
		var_dump($response);
		$start=strpos($response,"<?xml");
		$data=substr($response,$start);
		$xml=simplexml_load_string($data);
		return (json_decode(json_encode($xml),TRUE));
	}
		
	private function _request($data, $target) {
	    $url_info = parse_url($target);
	    $httpheader = "POST " . $url_info['path'] . " HTTP/1.0\r\n";
	    $httpheader .= "Host:" . $url_info['host'] . "\r\n";
	    $httpheader .= "Content-Type:application/x-www-form-urlencoded\r\n";
	    $httpheader .= "Content-Length:" . strlen($data) . "\r\n";
	    $httpheader .= "Connection:close\r\n\r\n";
	    //$httpheader .= "Connection:Keep-Alive\r\n\r\n";
	    $httpheader .= $data;

	    $fd = fsockopen($url_info['host'], 80);
	    fwrite($fd, $httpheader);
	    $response = "";
	    while(!feof($fd)) {
	        $response .= fread($fd, 128);
	    }
	    fclose($fd);
	    return $response;
	}
}