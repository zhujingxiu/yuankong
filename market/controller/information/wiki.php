<?php 
class ControllerInformationWiki extends Controller {
    public function index(){
        $this->language->load('information/wiki');
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('catalog/information');
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'sort_order';
        }
        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else { 
            $page = 1;
        }
        $this->data['breadcrumbs'] = array();
        
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),
            'separator' => false
        );
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('information/wiki'),
            'separator' => $this->language->get('text_separator')
        );
        if (isset($this->request->get['wiki_group'])) {
            $wiki_group = (int)$this->request->get['wiki_group'];
        } else {
            $wiki_group = 0;
        }

        $group_info = $this->model_catalog_information->getWikiGroup($wiki_group);
            
        if($group_info){
            if(isset($group_info['tag']) && $group_info['tag']==2){
                $text_tag = $this->language->get('text_tag_school');
            }else{
                $text_tag = $this->language->get('text_tag_information');
            }
            $this->data['breadcrumbs'][] = array(
                'text'      => $text_tag,
                'href'      => 'javascript:;',
                'separator' => $this->language->get('text_separator')
            );
            $this->data['breadcrumbs'][] = array(
                'text'      => $group_info['name'],
                'href'      => $this->url->link('information/wiki','wiki_group='.$group_info['group_id']),
                'separator' => $this->language->get('text_separator')
            );
        }
        $this->data['continue'] = $this->url->link('common/home');
        $this->data['wikis'] = array();
        $filter = array(
            'filter_group'  => $wiki_group,
            'start'         => 0,
            'limit'         => 10,
            'sort'          => $sort,
            'order'         => $order,
        );        
        $total = $this->model_catalog_information->getTotalWiki($filter);
        
        $results = $this->model_catalog_information->getWikis($filter);
        
        foreach ($results as $result) {

            $result['date_added'] = date('Y-m-d',strtotime($result['name']));
            $this->data['wikis'][] = $result;
        }

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = 10;
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('service/project', 'page={page}', 'SSL');
        
        $this->data['pagination'] = $pagination->render();
        $this->data['totals'] = $total;

        $this->template = $this->config->get('config_template') . '/template/information/wiki.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );
                    
        $this->response->setOutput($this->render());
    }

	public function info() {  
    	$this->language->load('information/wiki');
		
		$this->load->model('catalog/information');
		
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('information/wiki'),
        	'separator' => $this->language->get('text_separator')
      	);
		if (isset($this->request->get['wiki_id'])) {
			$wiki_id = (int)$this->request->get['wiki_id'];
		} else {
			$wiki_id = 0;
		}

		if (isset($this->request->get['wiki_group'])) {
			$wiki_group = (int)$this->request->get['wiki_group'];
		} else {
			$wiki_group = 0;
		}

		$group_info = $this->model_catalog_information->getWikiGroup($wiki_group);

		if($group_info){
			if(isset($group_info['tag']) && $group_info['tag']==2){
				$text_tag = $this->language->get('text_tag_school');
			}else{
				$text_tag = $this->language->get('text_tag_information');
			}
			$this->data['breadcrumbs'][] = array(
	        	'text'      => $text_tag,
				'href'      => 'javascript:;',
	        	'separator' => $this->language->get('text_separator')
	      	);
		}
		
		$wiki_info = $this->model_catalog_information->getWiki($wiki_id);
  		
		if ($wiki_info) {
	  		$this->document->setTitle($wiki_info['title']); 
	  		$group_info = $this->model_catalog_information->getWikiGroup($wiki_info['group_id']);

	  		if(!$wiki_group){

				if($group_info){
					if(isset($group_info['tag']) && $group_info['tag']==2){
						$text_tag = $this->language->get('text_tag_school');
					}else{
						$text_tag = $this->language->get('text_tag_information');
					}
					$this->data['breadcrumbs'][] = array(
			        	'text'      => $text_tag,
						'href'      => $this->url->link('information/wiki','wiki_group='.$group_info['group_id'],'SSL'),
			        	'separator' => $this->language->get('text_separator')
			      	);
				}
	  		}
	  		if($group_info){
				$this->data['breadcrumbs'][] = array(
		        	'text'      => $group_info['name'],
					'href'      => $this->url->link('information/wiki','wiki_group='.$group_info['group_id']),
		        	'separator' => $this->language->get('text_separator')
		      	);
			}
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $wiki_info['title'],
				'href'      => $this->url->link('information/wiki', 'wiki_id=' .  $wiki_id),      		
        		'separator' => $this->language->get('text_separator')
      		);		
						
      		$this->data['heading_title'] = $wiki_info['title'];
      		
      		$this->data['text_date_modified'] = $this->language->get('text_date_modified');
      		$this->data['text_viewed'] = $this->language->get('text_viewed');
			
			$this->data['title'] = html_entity_decode($wiki_info['title'], ENT_QUOTES, 'UTF-8');
			$this->data['subtitle'] = html_entity_decode($wiki_info['subtitle'], ENT_QUOTES, 'UTF-8');
			$this->data['description'] = html_entity_decode($wiki_info['text'], ENT_QUOTES, 'UTF-8');

			$this->data['viewed'] = (int)$wiki_info['viewed'];
			$this->data['date_added'] = date('Y-m-d',strtotime($wiki_info['date_added']));
      		
			$this->data['continue'] = $this->url->link('common/home');

            $this->model_catalog_information->addWikiViewed($wiki_id);

			$this->template = $this->config->get('config_template') . '/template/information/wiki_info.tpl';
			
			$this->children = array(
				'common/column_left',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
						
	  		$this->response->setOutput($this->render());
    	} else {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('information/wiki', 'wiki_id=' . $wiki_id),
        		'separator' => $this->language->get('text_separator')
      		);
				
	  		$this->document->setTitle($this->language->get('text_error'));
			
      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
					
	  		$this->response->setOutput($this->render());
    	}
  	}
	
}