<?php
class ControllerModuleThemeControl extends Controller {

	private $error = array(); 

	private $moduleName = 'themecontrol';

	public function index() {   
		$this->load->model('setting/setting');
		$this->load->model('tool/image');
		$this->data['module'] = array(
						'enable_paneltool'  => 1,
						'enable_footer_center' => 1,
						'block_showcase'  => '',
						'block_promotion' => '',
						'block_footer_top'=>'',
						'block_footer_center' => '',
						'block_footer_bottom'=>'',
						'product_related_column'=> '',
						
						'cateogry_product_row' => '0',
						'cateogry_display_mode'=>'grid',
						'category_saleicon' => 1,
						'category_pzoom' => 1,	
						'product_enablezoom' => 1,
						'product_zoommode' => 'basic',
						'product_zoomeasing' => 1,		
						'product_zoomlenssize' => 150,
						'product_zoomlensshape' => 'normal',		
						'product_zoomgallery' => 0,		
						'contact_customhtml' => ''
											
		);

	
		$module = $this->config->get($this->moduleName);
		if( empty($module) ) {
			$default_data = array();
			$default_data[$this->moduleName]=$this->data['module'];
			$this->model_setting_setting->editSetting( $this->moduleName, $default_data );	 
			$this->data['first_installation'] = 1;
		}

		if (isset($this->request->post[$this->moduleName])) {
			$this->data['module'] = $this->request->post[$this->moduleName];
		} elseif ($this->config->get($this->moduleName)) { 
			$this->data['module'] = array_merge($this->data['module'],$module);
		}
	
		$this->document->addStyle('view/stylesheet/themecontrol.css');
		$this->document->addScript('view/javascript/jquery/jquery.cookie.js');
		$this->language->load('module/'.$this->moduleName);	
		
		$this->document->setTitle( strip_tags($this->language->get('heading_title')) );
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) { 
	
			$data = $this->request->post['themecontrol'];
			$a = $this->request->post['action_type'];
			$this->request->post= array();
			$this->request->post['themecontrol'] = $data;
			$this->model_setting_setting->editSetting($this->moduleName, $this->request->post);	 

			$this->session->data['success'] = $this->language->get('text_success');
		
			if( $a == 'save-edit'  ){
				$this->redirect($this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL'));
			}else {
				$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		// themes 
		$directories = glob(DIR_FRONT . 'view/theme/*', GLOB_ONLYDIR);
		$this->data['templates'] = array();
		foreach ($directories as $directory) {	 
			if( file_exists($directory."/etc/config.ini") ){
				$this->data['templates'][] = basename($directory);
			}
		}	
		if( count($this->data['templates']) && empty($this->data['module']['default_theme'])  ){ 
			$this->data['module']['default_theme'] = $this->data['templates'][0];
			
		}	
	
		$this->setTheme( $this->data['module']['default_theme']  ); 		
	
		$this->data['theme_url'] =   HTTP_CATALOG."/market/view/theme/".$this->getTheme()."/";
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_banner'] = $this->language->get('entry_banner');
		$this->data['entry_dimension'] = $this->language->get('entry_dimension'); 
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_save_keep'] = $this->language->get('button_save_keep');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['default_theme'] = '';
		$this->data['text_image_manager'] = $this->language->get('text_image_manager'); 
		// table
		$this->data['tab_layout'] = $this->language->get( 'tab_layout' );
		$this->data['tab_custom'] = $this->language->get( 'tab_custom' );


		$this->data['product_rows'] = array('0'=> $this->language->get('text_auto'), 2=>2, 3=>3,4=>4,5=>5,6=>6 );
		$this->data['category_saleicons'] = array(
			'text_sale' => 'Sale',
			'text_sale_detail' => 'Saved %s',
			'text_sale_percent' => 'Number %'
		);

		$this->data['product_zoomgallery'] = array( 
			'basic'  => $this->language->get('text_basic_zoom'),
			'slider' => $this->language->get('text_slider_gallery_zoom')
		);

		$this->data['product_zoom_modes'] = array(
			'basic' => $this->language->get('text_basic_zoom'),
			'inner'	=> $this->language->get('text_inner_zoom'),
			'lens'	=> $this->language->get('text_lens_zoom')
		);
	 
		$this->data['product_zoomlensshapes'] = array(
			'basic' => $this->language->get('text_len_zoom_basic'),
			'round'	=> $this->language->get('text_len_zoom_round'),
			 
		);

		 //general 
		$this->data['cateogry_display_modes'] = array( 'grid'=> $this->language->get('text_grid') , 'list' => $this->language->get('text_list') );
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['dimension'])) {
			$this->data['error_dimension'] = $this->error['dimension'];
		} else {
			$this->data['error_dimension'] = array();
		}
		
		$this->data['token'] = $this->session->data['token'];
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/'.$this->moduleName, 'token=' . $this->session->data['token'], 'SSL');
		$this->data['ajax_modules_position'] = $this->url->link('module/'.$this->moduleName."/ajaxsave", 'token=' . $this->session->data['token'], 'SSL');
		
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
					
		$this->load->model('design/layout');
		
		
		$t = DIR_FRONT . 'view/theme/'.$this->getTheme().'/template/common/admin/modules.tpl';
		
		if( file_exists($t) ){
			$this->data['admin_modules'] = $t;
		}
	
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

	// 	echo '<pre>'.print_r($this->data['layouts'],1);die;
		$this->load->model('design/banner');
		
		$this->data['banners'] = $this->model_design_banner->getBanners();
		
	 	
		
		$this->tabModules();
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$this->data['logo_types'] = array(
			'' => $this->language->get('logo_system'),
			'logo-text' => $this->language->get('logo_text'),
			'logo-image' =>  $this->language->get('logo_image'),
		);
	 
		/* */
		$this->template = 'module/themecontrol/'.$this->moduleName.'.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function getUnexpectedModules( $layout_id, $tmodules ){
		$this->load->model('setting/themecontrol');
		$extensions = $this->model_setting_themecontrol->getExtensions('module');		
		$module_data = array();
		foreach ($extensions as $extension) {
			$modules = $this->config->get($extension['code'] . '_module');
			$this->language->load('module/'.$extension['code']);	
			if ($modules) {
				foreach ($modules as $index => $module) {  
					if( ($module['layout_id'] == $layout_id || $module['layout_id'] == 99999) && $module['status'] && !isset($tmodules[$extension['code']]) ){
						$module_data[] = array(
							'title'      => ($this->language->get('heading_title')),
							'code'       => $extension['code'],
							'setting'    => $module,
							'sort_order' => $module['sort_order'],
							'status'     => $module['status'],
							'index'      => $index
						);				
					}
				}
			}
			$this->language->load('module/'.$this->moduleName);	
		}
		return $module_data;
	}
	
	public function tabModules() {
		$this->data['elayout_default'] = 1;
		if( isset($this->request->get['elayout_id']) ){
			$this->data['elayout_default'] = $this->request->get['elayout_id'];	
		}
		$this->data['layout_modules'] = $this->getModules( $this->data['elayout_default'] );
	}
	
	public function getModules( $layout_id ){
		
		$this->load->model('setting/themecontrol');
		$extensions = $this->model_setting_themecontrol->getExtensions('module');		
		$module_data = array();
		foreach ($extensions as $extension) {
			$modules = $this->config->get($extension['code'] . '_module');
			$this->language->load('module/'.$extension['code']);	
			if ($modules) {
				foreach ($modules as $index => $module) {  
					if( $module['layout_id'] == $layout_id || $module['layout_id'] == 99999){
						$module_data[$module['position']][] = array(
							'title'      => ($this->language->get('heading_title')). '<br><em>Code:'.$extension['code'].'</em>',
							'code'       => $extension['code'],
							'setting'    => $module,
							'sort_order' => $module['sort_order'],
							'status'     => $module['status'],
							'index'      => $index
						);				
					}
				}
			}
			$this->language->load('module/'.$this->moduleName);	
		}
		foreach( $module_data as $position => $modules ){
			$sort_order = array(); 
			foreach ($modules as $key => $value) {
			
				$sort_order[$key] = $value['sort_order'];
			}
			array_multisort($sort_order, SORT_ASC, $module_data[$position]);
		}
		return $module_data;
	}
	
	/**
	 *
	 */
	public function getLang( $key ){
		return $this->language->get( $key ); 
	}
	
	/**
	 *
	 */
	public function getConfig( $config ){
		return ''.$config;
	}
	
	/**
	 * Validation
	 */
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}	
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	
	/**
	 * Ajax Save Content
	 */
	public function ajaxsave(){

		if (!$this->user->hasPermission('modify', 'module/'.$this->moduleName)) {
			$this->error['warning'] = $this->language->get('error_permission');
			die(  $this->error['warning'] );
		}	


		$this->load->model('setting/setting');
		if( isset($this->request->post['modules']) ){
			$modules = $this->request->post['modules'];
			
			foreach( $modules  as $position => $mods ){	
				foreach( $mods as $index => $module ){
					$tmp = explode("-",$module);
					if( count($tmp)== 2 ){
						$code = $tmp[0];
						$modindex = $tmp[1];
						$data = array();
						$dbmods = $this->config->get( $code  . '_module');
						if( is_array($dbmods ) ) {
						
							foreach( $dbmods as $dbidx => $dbmod ){
								
								if( $dbidx == $modindex ){
									$dbmod['position'] = $position;
									$dbmod['sort_order'] = $index+1;
									$dbmods[$dbidx] = $dbmod ;
									break;
								}
							}
							$data = $this->model_setting_setting->getSetting( $code );
							if(  is_array($data) ){
								$data[$code."_module"] = $dbmods;			
							//	echo '<pre>'.print_r( $data, 1 );
								$this->model_setting_setting->editSetting( $code, $data );	 
							}
						}
					}
				}
			}
		}
		die();
	}
}
