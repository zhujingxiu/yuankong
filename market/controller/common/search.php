<?php
class ControllerCommonSearch extends Controller {
    public function index() {
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
     
}
