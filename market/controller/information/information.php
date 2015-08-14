<?php 
class ControllerInformationInformation extends Controller {
	public function index() {

    	$this->language->load('information/information');
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	 
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['baidu_analytics'] = html_entity_decode($this->config->get('config_baidu_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');
		$this->load->model('catalog/information');
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . TPL_IMG . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}
		
		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . TPL_IMG . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}
		$this->data['text_home'] = $this->language->get('text_home');

    	$this->data['home'] = $this->url->link('common/home');
		$this->data['logged'] = $this->customer->isLogged();
		
		$this->document->setTitle($this->language->get('heading_title'));
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}
		$this->data['informations'] = $this->model_catalog_information->getHelpCenterInformations();
		foreach ($this->data['informations'] as $key => $value) {
			$this->data['informations'][$key]['link'] = $this->url->link('information/information', 'information_id='.$value['information_id']);
			if(!$information_id){
				$information_id = $value['information_id'];
			}
		}
		$information_info = $this->model_catalog_information->getInformation($information_id);

  		$this->document->setTitle($information_info['title']); 
  		$this->data['title'] = $information_info['title'];
  		$this->data['breadcrumbs'][] = array(
    		'text'      => $information_info['title'],
			'href'      => $this->url->link('information/information', 'information_id=' .  $information_id),      		
    		'separator' => $this->language->get('text_separator')
  		);		
					
  		$this->data['heading_title'] = $information_info['title'];
  		
  		$this->data['information_id'] = $information_id;
		
		$this->data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
  		
		$this->data['continue'] = $this->url->link('common/home');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/information.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/information/information.tpl';
		} else {
			$this->template = 'default/template/information/information.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/top'
		);
					
  		$this->response->setOutput($this->render());
  	}
	
	public function info() {
		$this->load->model('catalog/information');
		
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}      
		
		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output  = '<html dir="ltr" lang="en">' . "\n";
			$output .= '<head>' . "\n";
			$output .= '  <title>' . $information_info['title'] . '</title>' . "\n";
			$output .= '  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
			$output .= '  <meta name="robots" content="noindex">' . "\n";
			$output .= '</head>' . "\n";
			$output .= '<body>' . "\n";
			$output .= '  <h1>' . $information_info['title'] . '</h1>' . "\n";
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
			$output .= '  </body>' . "\n";
			$output .= '</html>' . "\n";			

			$this->response->setOutput($output);
		}
	}
}
