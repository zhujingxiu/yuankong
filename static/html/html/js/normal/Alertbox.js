/**
 * Created by zhiguo on 2015/8/5.
 */
(function(w,d){
    function Alertbox(opts){
        if(!(this instanceof Alertbox)){
            return  new Alertbox(opts).init();
        }
        this.opts=opts||{};
        this.type=this.opts.type||"mini";
        this.title = this.opts.title || "";
        this.msg = this.opts.msg || "";
    }
    Alertbox.prototype={
        constructor:Alertbox,
        init: function(){
            var me=this;
            me.setStyle();
            console.log("123");
        },
        setStyle: function(){
            var self = this,
                style = d.createElement("style"),
                cssStr = ".alert-box{position:absolute;left:0;top:0;border-radius:0.2rem;background:#FFF;-webkit-box-sizing:border-box;z-index:100;font-size:0.6rem;}" +
                    ".alert-msg{padding:0.4rem 0.6rem 0.6rem;text-align:center;line-height:1.8;word-break:break-all;}" +
                    ".alert-title{padding:0.6rem 0.6rem 0;text-align:center;}" +
                    ".alert-btn{display:-webkit-flex !important;display:-webkit-box;border-top:1px solid #DCDCDC;}" +
                    ".alert-btn a{display:block;-webkit-flex:1 !important;-webkit-box-flex:1;height:1.68rem;line-height:1.68rem;text-align:center;}" +
                    ".alert-btn a.alert-confirm{border-left:1px solid #DCDCDC;color:#EDA200;}" +
                    ".alert-btn a.alert-confirm.single{border-left:none;}" +
                    ".alert-mini-box{border-radius:0.2rem;background:rgba(0,0,0,.7);color:#fff;}";
            style.type= "text/css";
            style.innerText = cssStr;
            d.head.appendChild(style);
        },
        minEvent: function(){
            var self = this;
            setTimeout(function(){
                if (navigator.userAgent.match(/iPhone/i)) {
                    $(self.alertBox).fadeOut(500, function(){
                        self.getEl(d, "body").removeChild(self.alertBox);
                        self.callback && typeof self.callback == "function" && self.callback();
                    });
                } else{
                    self.remove(self.alertBox);
                    self.callback && typeof self.callback == "function" && self.callback();
                }
                self.remove(self.getEl(d, "#alertMask_"+self.uuid));

            },self.delay);
        }
    }
    return w.Alertbox=Alertbox;
})(window,document);