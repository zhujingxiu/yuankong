<?php
class ControllerCommonUpload extends Controller {
    public function upload() {
        $this->load->language('common/filemanager');

        $json = array();

        if(isset($this->request->files['attach']) && $this->request->files['attach']['tmp_name']){
            $filename = basename(html_entity_decode($this->request->files['attach']['name'], ENT_QUOTES, 'UTF-8'));
            
            if ((strlen($filename) < 3) || (strlen($filename) > 255)) {
                $json['error'] = $this->language->get('error_filename');
            }
            $tempFile = $this->request->files['attach']['tmp_name'];
            $basePath = DIR_UPLOAD;
            if(!file_exists($basePath)){
                mkdir($basePath);
            }
            $targetPath = $basePath.'/'.date('Ymd',time());
            if(!file_exists($targetPath)){
                mkdir($targetPath);
            }
            $fileInfo = pathinfo($this->request->files['attach']['name']);
            
            $fileName = date('YmdHis')."_".substr(md5(uniqid()),rand(0, 15),8).'.'.$fileInfo['extension'];
            $targetFile = rtrim($targetPath,'/') . '/'. $fileName;
             
            if(!isset($this->request->get['type'])){
                $allowed = array('jpg','jpeg','gif','png','doc','docx','txt','zip','csv');
            }else{
                $allowed = explode("|", $this->request->get['type']);
            }
            if (!in_array($fileInfo['extension'],$allowed)) {

                $json['error'] = $this->language->get('error_filetype');
            }
        }else {
            $json['error'] = $this->language->get('error_upload');
        }

        if (!$json) {

            if(@move_uploaded_file($tempFile,$targetFile)){
                $json['success'] = $this->language->get('text_uploaded');
                $upload_relsrc = '../'.substr(TPL_UPLOAD,strpos(TPL_UPLOAD,'/')+1);
                $json['path'] = $upload_relsrc.date('Ymd',time()).'/'.$fileName;
                $json['name'] = iconv("UTF-8","UTF-8",$fileInfo['filename']);
            }else {
                $json['error'] = $this->language->get('error_upload');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}