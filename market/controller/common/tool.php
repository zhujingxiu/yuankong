<?php
class ControllerCommonTool extends Controller {
    public function search() {
        $mode = isset($this->request->get['mode']) ? strtolower(trim($this->request->get['mode'])) : '';
        $search = isset($this->request->get['search']) ? trim($this->request->get['search']) : false;
        $route = '';
        switch($mode){
            case 'wiki':
                $route = 'information/wiki';
                break;
            case 'company':
                $route = 'service/company';
                break;
            default:
                $route = 'product/search';
        }
        // Decode URL
        $this->response->redirect($this->url->link($route,'search='.$search));
    }

    public function validateHasEmail(){
        
        $this->load->model('account/customer');
        $customer = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

        $this->response->setOutput(json_encode(array('exist'=> $customer ? 1 : 0)));
    }


    public function validateHasMobile(){
        
        $this->load->model('account/customer');
        $customer = $this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone']);

        $this->response->setOutput(json_encode(array('exist'=> $customer ? 1 : 0)));
    }

    public function getSMS(){
        $this->language->load('common/tool');
        $json = array();    

        if(empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
            $json['error']['captcha'] = $this->language->get('error_captcha');
        }
        if ((utf8_strlen($this->request->post['mobile_phone']) < 3) || !isMobile($this->request->post['mobile_phone'])) {
            $json['error']['mobile_phone'] = $this->language->get('error_mobile_phone');
        }
        $this->load->model('account/customer');
        if ($this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone'])) {
            $json['error']['mobile_phone'] = $this->language->get('error_exists');
        }
        $sms_log = $this->model_account_customer->getSMS($this->request->post['mobile_phone']);     
        if(!empty($sms_log['sms']) && time() < ($sms_log['time']+120) ){
            $json['error']['sms'] = $this->language->get('error_sms_time');
        }

        if(!$json){
            $sms = new Sms();
            $sms_number = mt_rand(100000,999999);
            $pattern = "尊敬的用户，".$sms_number."是您本次的验证码，该验证码10分钟内有效。【消防e站】";
            $res = $sms->sendMsg($this->request->post['mobile_phone'],$pattern);
            //var_dump($res);
            $this->model_account_customer->delSMS($this->request->post['mobile_phone']);
            $this->model_account_customer->addSMS($this->request->post['mobile_phone'],$sms_number);
            $json['success'] =  $this->language->get('text_send_success');           
        }
        $this->response->setOutput(json_encode($json));
    }

    public function validateSMS(){
        $status = 0;
        $sms = isset($this->request->post['sms']) ? $this->request->post['sms'] : false;
        $mobile_phone = isset($this->request->post['mobile_phone']) ? $this->request->post['mobile_phone'] : false;
        $this->load->model('account/customer');
        $sms_log = $this->model_account_customer->getSMS($this->request->post['mobile_phone']);
        if(!empty($sms_log['sms']) && ($sms_log['sms'] == $sms) && (time() < ($sms_log['time']+600))) {
            $status = 1;
        }
        $this->response->setOutput(json_encode(array('status'=>$status)));
    }

    public function captcha() {
        $this->load->library('captcha');
        
        $captcha = new Captcha(4,35,60);
        
        $this->session->data['captcha'] = $captcha->getCode();
        
        $captcha->showImage();
    }

    public function validateCaptcha(){
        $status = 0;
        $captcha = isset($this->session->data['captcha']) ? $this->session->data['captcha'] : false;
        $_captcha = isset($this->request->post['captcha']) ? $this->request->post['captcha'] : false;
        if($captcha && $_captcha && $captcha==$_captcha ){
            $status = 1;
        }
        $this->response->setOutput(json_encode(array('status'=>$status)));
    }

    public function validatePwd(){
        $status = 0;
        $this->load->model('account/customer');
        $pwd = isset($this->request->post['pwd']) ? $this->request->post['pwd'] : false;
        if($pwd && $this->model_account_customer->validatePassword($pwd)){
            $status = 1;
        }
        $this->response->setOutput(json_encode(array('status'=>$status)));
    }

    public function upload(){
        $result=array('status'=>0,'msg'=>'');
        if (!empty($this->request->files)){
            $timePath=date('Ymd',time());
            $targetPath = DIR_UPLOAD.'/'.$timePath;
            if(!file_exists($targetPath)){
                mkdir($targetPath);
            }           
    
            // Validate the file type
            $fileTypes  = array('jpg','jpeg','gif','png'); // File extensions
            $pathinfo  = pathinfo($this->request->files['file']['name']);
            $file   = date('His').substr(md5(uniqid()),rand(0,9),4).'.'.$pathinfo['extension'];
            $targetFile = rtrim($targetPath,'/') . '/'. $file;
            if ($this->request->files['file']['size'] > 3100000) {
                $result = array('status' => 0,'msg' =>'仅支持3M以下大小的文件');
            }else if (in_array($pathinfo['extension'],$fileTypes)) {
                @move_uploaded_file($this->request->files['file']['tmp_name'],$targetFile);
                $result = array('status' => 1,'file' => TPL_UPLOAD.$timePath.'/'.$file);
            } else {
                $result = array('status' => 0,'msg' =>'无效的文件类型,允许上传的类型为 '.join(' | ',$fileTypes));
            }
        }
        die(json_encode($result));
    }
    
}