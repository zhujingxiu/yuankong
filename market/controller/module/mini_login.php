<?php  
class ControllerModuleMiniLogin extends Controller {
    private $error;
    protected function index() {
        $this->language->load('account/login');
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['text_new_customer'] = $this->language->get('text_new_customer');
        $this->data['text_customer'] = $this->language->get('text_customer');
        $this->data['text_register'] = $this->language->get('text_register');
        $this->data['text_register_account'] = $this->language->get('text_register_account');
        $this->data['text_forgotten'] = $this->language->get('text_forgotten');
        $this->data['text_auto'] = $this->language->get('text_auto');

        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
        $this->data['entry_password'] = $this->language->get('entry_password');
        
        if (isset($this->request->post['email'])) {
            $this->data['email'] = $this->request->post['email'];
        } else {
            $this->data['email'] = '';
        }

        if (isset($this->request->post['mobile_phone'])) {
            $this->data['mobile_phone'] = $this->request->post['mobile_phone'];
        } else {
            $this->data['mobile_phone'] = '';
        }

        if (isset($this->request->post['password'])) {
            $this->data['password'] = $this->request->post['password'];
        } else {
            $this->data['password'] = '';
        }
        $this->data['button_continue'] = $this->language->get('button_continue');
        $this->data['button_login'] = $this->language->get('button_login');
        $this->data['login'] = $this->url->link('account/login', '', 'SSL');
        $this->data['register'] = $this->url->link('account/register', '', 'SSL');
        $this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

        $oauth_html = '';
        
        $oauth_lists = array();
        
        if ($this->config->get('oauth')) {
            foreach ($this->config->get('oauth') as $key => $val) {
                if ($val['status']) {           
                    $oauth_lists[$val['sort']] = array(
                        'tag'      => $key,
                        'status'   => $val['status'],
                        'href'     => $this->url->link('account/oauth/bind', 'tag='.$key, 'SSL')
                    );
                }
            }
                
            ksort($oauth_lists);
        }
        
        if ($oauth_lists) {
            $this->language->load('account/oauth');
            
            $oauth_html .= '<p class="f_s c8">'.$this->language->get('text_login').'</p>';
            $oauth_html .= '<p class="mt5">';
            foreach ($oauth_lists as $item) {
                $oauth_html .= '<a class="pr15" href="' . $item['href'] . '" >' ;
                $oauth_html .=  $item['tag'] ;
                $oauth_html .= '</a>';
            }
            $oauth_html .= '</p>';
        }
        
        if ($this->customer->isLogged()) {
            $oauth_html = '<div class="oauth_login">';
            $oauth_html .= $this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFullName(), $this->url->link('account/logout', '', 'SSL'));
            $oauth_html .= '</div>';
        }
        $this->data['oauth_html'] = $oauth_html;

        $this->template = $this->config->get('config_template') . '/template/module/mini_login.tpl';

        
        $this->render();
    }
}
