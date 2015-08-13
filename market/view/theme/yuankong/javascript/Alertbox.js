/**
 * Created by zhiguo on 2015/8/5.
 */
(function(w,d){
    function Alertbox(opts){
        if(!(this instanceof Alertbox)){
            return  new Alertbox(opts).init();
        }
        this.opts=opts||{};
        this.type=this.opts.type;
        this.msg=this.opts.msg || "";
        this.delay=this.opts.delay;
    }
    Alertbox.prototype={
        constructor:Alertbox,
        init: function(){
            var me=this;
            me.setStyle();
            me.getbox();
            me.minEvent();
        },
        setStyle: function(){
            var self = this,
                style = d.createElement("style"),
                cssStr = ".alertbox { background: #f8f8f8; border:1px solid #eee; border-radius: 5px; -webkit-border-radius: 5px;  position: fixed; *position: absolute; top: 25%; left: 50%; width: 360px; margin-left: -210px; padding:30px; z-index: 111; }"+
                         ".alertbox h3 { line-height: 40px; font-size: 16px; color: #333;text-align: center;}"+
                         ".truebtn { background: url('market/view/theme/yuankong/yk_img/icon/icon2.png') no-repeat -71px -170px; height: 48px; width: 48px; display: inline-block;}"+
                         ".falsebtn { background: url('market/view/theme/yuankong/yk_img/icon/icon2.png') no-repeat -71px -380px; height: 48px; width: 48px; display: inline-block;}"+
                         ".alertp { padding-bottom: 20px; text-align: center;}";
            style.type= "text/css";
            style.innerText = cssStr;
            d.head.appendChild(style);
        },
        getbox:function(){
            var me=this;
            var alertbox="";
            var alertid= d.createElement("div");
            alertid.id="alertbox";
            if(me.type){
                alertbox+='<div class="alertbox">'+
                '<p class="alertp">'+'<i class="truebtn"></i>'+'</p>'+
                '<h3>'+ me.msg+'</h3>'+
                '</div>';
            }else{
                alertbox+='<div class="alertbox" id="alertbox">'+
                    '<p class="alertp">'+'<i class="falsebtn"></i>'+'</p>'+
                    '<h3>'+ me.msg+'</h3>'+
                    '</div>';
            };
            alertid.innerHTML=alertbox;
            d.body.appendChild(alertid);

        },
        minEvent: function(){
            var self = this;
            var id= d.getElementById("alertbox");
            setTimeout(function(){
                d.body.removeChild(id);
            },self.delay);
        }
    }
    return w.Alertbox=Alertbox;
})(window,document);