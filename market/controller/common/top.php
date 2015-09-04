<?php   
class ControllerCommonTop extends Controller {
    protected function index() {
   
        
        $this->language->load('common/header');
        
        $this->data['text_home'] = $this->language->get('text_home');
        $this->data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
        $this->data['text_help'] = $this->language->get('text_help');
        $this->data['text_search'] = $this->language->get('text_search');
        $this->data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
        $account = ($this->customer->isCompany() ? $this->customer->getCompany() : $this->customer->getFullName());
        $this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $account, $this->url->link('account/logout', '', 'SSL'));
        $this->data['text_account'] = $this->language->get('text_account');
        $this->data['text_checkout'] = $this->language->get('text_checkout');
        $this->data['text_login'] = $this->language->get('text_login');
        $this->data['text_register'] = $this->language->get('text_register');
        $this->data['text_order'] = $this->language->get('text_order');
        $this->data['text_profile'] = $this->language->get('text_profile');
        $this->data['text_message'] = $this->language->get('text_message');
        $this->data['text_company'] = $this->language->get('text_company');
        $this->data['text_upload'] = $this->language->get('text_upload');
        $this->data['text_perfact'] = $this->language->get('text_perfact');
        $this->data['text_hotline'] = $this->language->get('text_hotline');
                
        $this->data['home'] = $this->url->link('common/home');
        $this->data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
        $this->data['logged'] = $this->customer->isLogged();
        $this->data['account'] = $this->url->link('account/account', '', 'SSL');
        $this->data['shopping_cart'] = $this->url->link('checkout/cart');
        $this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
        $this->data['login'] = $this->url->link('account/login', '', 'SSL');
        $this->data['register'] = $this->url->link('account/register', '', 'SSL');
        $this->data['order'] = $this->url->link('account/order', '', 'SSL');
        $this->data['profile'] = $this->url->link('account/edit', '', 'SSL');
        $this->data['message'] = $this->url->link('account/message', '', 'SSL');
        $this->data['help'] = $this->url->link('information/information', '', 'SSL');
        $this->data['news'] = $this->url->link('information/wiki', 'wiki_group=2', 'SSL');
        $this->data['company'] = $this->url->link('account/company', '', 'SSL');
        $this->data['upload'] = $this->url->link('account/company/file', '', 'SSL');
        $this->data['perfact'] = $this->url->link('account/company', '', 'SSL');
        
        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        $part = explode("/", $route);
        $this->data['container_class'] = "w";
        if(isset($part[0]) && $part[0] =='account'){
            $this->data['container_class'] = "register-w";
        }
        $this->template = $this->config->get('config_template') . '/template/common/top.tpl';
        
        $this->render();
    }   
}