<?php  
class ControllerModuleYkbookproject extends Controller {
    protected function index() {
        $this->language->load('module/ykbookproject');
        $this->load->model('service/project');
        
        $this->data['groups'] = $this->model_service_project->getProjectGroups();

        $this->load->model('service/company');
        if (isset($this->request->get['zone'])) {
            $zone_id = $this->request->get['zone'];
        } else {
            $zone_id = 1;
        }

        $this->data['companies'] = $this->model_service_company->getCompanyRank($zone_id);
        $zone = $this->model_service_company->getCompanyZone($zone_id);

        $this->data['zone_name'] = !empty($zone['name']) ? $zone['name'] : '';
        foreach ($this->data['companies'] as $key => $value) {
            $this->data['companies'][$key]['link'] = $this->url->link('service/company/info','company_id='.$value['company_id']);
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ykbookproject.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/ykbookproject.tpl';
        } else {
            $this->template = 'default/template/module/ykbookproject.tpl';
        }
        
        $this->render();
    }
}