<div class="xg-style">
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
    <h3 class="title f_l">客户咨询    </h3>
    <?php }?>
    <div class="p15">
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
        <ul class="ovh">
            <li class="gs-l-dd"><a href="#">苏港消防（苏港消防（苏港消防（苏州分公司）</a></li>
            <li class="gs-l-dd"><a href="#">苏港消防（苏港消防（苏港消防（苏州分公司）</a></li>
            <li class="gs-l-dd"><a href="#">苏港消防（苏港消防（苏港消防（苏州分公司）</a></li>
            <li class="gs-l-dd"><a href="#">苏港消防（苏港消防（苏港消防（苏州分公司）</a></li>
            <li class="gs-l-dd"><a href="#">苏港消防（苏港消防（苏港消防（苏州分公司）</a></li>
        </ul>
        <div class="mt15">
    <?php }?>
            <h4 class="f_m c3">没有想要的回答试试这里</h4>
            <div class="ovh pt10">
                <textarea class="ask-textarea" placeholder="请再次输入您要问的问题"></textarea>
            </div>
            <p class="ovh tc pt10"><input type="submit" class="gc-tab-sub db" value="立即提交" /></p>
    <?php if(isset($this->request->get['wiki_group']) && (int)$this->request->get['wiki_group']) {?>
        </div>
    <?php }?>
    </div>
    
</div>