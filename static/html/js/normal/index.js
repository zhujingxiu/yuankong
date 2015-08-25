/**
 * Created by 123 on 2015/5/28.
 */
var o={};
//导航菜单下拉
o.list={
  init:function(sel,dom){
      var sel=$(sel);
      var dom=$(dom);
      sel.bind("click",function(){
          var d=dom.css("display");
          if(d=="block"){
              dom.slideUp();
          }else{
              dom.slideDown();
          }
      })
  }
};
//页面滚动显示top
o.wscroll={
    sc:function(d){
        var d=document.getElementById(d);
        window.onscroll=function(){
            var wsc=document.documentElement.scrollTop||document.body.scrollTop;
            if(wsc>150){
                d.style.display="block";
            }else{
                d.style.display="none";
            }
        }
    }
}
//输入框获得焦点以及失去焦点
o.focu={
    init:function(sel){
        var val=$(sel).val();
        var sel=$(sel);
        sel.css("color","#888888");
        sel.focus(function(){
            $(this).val("");
            sel.css("color","#888888");
        });
        sel.blur(function(){
            if($(this).val()==""||$(this).val()==null){
                sel.css("color","#333333");
                $(this).val(val);
            }
        });
    }
};
//鼠标hover事件
o.mous={
  init:function(sel,dom){
    var sel=$(sel);
      sel.hover(function(){
          $(this).addClass(dom);
      },function(){
          $(this).removeClass(dom);
      });
  }
};
//鼠标tab事件
o.moushov={
    init:function(sel,dom){
        var sel=$(sel);
        sel.click(function(){
            var index=$(this).index();
            sel.removeClass("tabon");
            $(this).addClass("tabon");
            $(dom).hide().eq(index).show();
        });
    }
};
//下拉框
o.dlist={
    init:function(sel,dom1,dom2){
        var sel=$(sel);
        var dom1=sel.children(dom1);
        var dom2=sel.children(dom2);
        dom2.find("span").click(function(){
            var self = $(this);
            var t = self.attr("val");
            dom1.find("span").text(self.text());
            sel.removeClass("hov");
        }).hover(function(){
            $(this).addClass("on");
        }, function(){
            $(this).removeClass("on");
        });
        sel.hover(function(){
            $(this).addClass("hov");
        },function(){
            $(this).removeClass("hov");
        });

    }
};
o.taber={
    init:function(thisObj,Num){
        if(thisObj.className == "tabon")return;
        var tabObj = thisObj.parentNode.id;
        var tabList = document.getElementById(tabObj).getElementsByTagName("li");
        for(i=0; i < tabList.length; i++)

        {
            if (i == Num)
            {
                thisObj.className = "tabon";
                document.getElementById(tabObj+"_c_"+i).style.display = "block";
            }else{
                tabList[i].className = "taboff";
                document.getElementById(tabObj+"_c_"+i).style.display = "none";
            }
        }
    }
};
o.slider = {
    init: function(selector){

        var $this=$(selector),
            $s=$this.children(".bd").find("ul"),
            v_width=$this.width(),
            len=$s.children().length,
            v_w=v_width*len,
            prev=$this.children(".prev"),
            next=$this.children(".next"),
            fpage=$this.children(".hd").find("ul");
        var page=1;
        $s.children().width(v_width);
        $this.parent().width(v_width);
        fpage.find("li").mouseover(function(){
            var $w=$(this).index();
            $s.animate({"marginLeft":"-"+v_width*$w},300);
            $(this).addClass("on").siblings().removeClass("on");
            page=$w+1;
        });
        next.click(function(){
            if(!$s.is(":animated")){
                if(page==len){
                    $s.animate({"marginLeft":"0px"},300);
                    page=1;
                }else{
                    $s.animate({"marginLeft":"-="+v_width},300);
                    page++;
                }
            }
            fpage.find("li").eq((page-1)).addClass("on").siblings().removeClass("on");
        });
        prev.click(function(){
            if(!$s.is(":animated")){
                if(page==1){
                    $s.animate({"marginLeft":"-="+v_width*(len-1)+"px"},300);
                    page=len;
                }else{
                    $s.animate({"marginLeft":"+="+v_width},300);
                    page--;
                }
            }
            fpage.find("li").eq((page-1)).addClass("on").siblings().removeClass("on");
        });
        function atuoplay(){
            $this.hover(function(){
                clearInterval(sc);
            },function(){
                sc=setInterval(function(){next.click()},3000)
            }).trigger("mouseleave")
        }
        atuoplay();
    }
};
o.lrclick={
    init:function(select,dom){
        var cli=function(sel,obj){
            var that=this;
            var objs= $.extend({},that.defalut,obj);
            var box=$(sel),
                jprev=box.find(objs.jprev),
                jnext=box.find(objs.jnext),
                sbox=box.find(objs.sbox),
                sul=sbox.find(objs.sul),
                sli=sul.find(objs.sli),
                len=parseInt(sli.length);
            var num= 5,cuI=0;
            var gos=null,wdh=sli.outerWidth()+12;

            gos=function(index){
                var ml=-(index)*wdh;
                sul.stop().animate({marginLeft:ml+"px"},objs.times);
            };
            jprev.bind("click",function(){
                var index=cuI-1;
                if(index<0){
                    return false;
                }
                gos(index);
                cuI--;
            });
            jnext.bind("click",function(){
                var index=cuI+1;
                if(index>len-num){
                    return false;
                }
                gos(index);
                cuI++;
            });
        };
        cli.prototype.defalut={
            //jq元素
//            左右箭头包裹元素
            jprev:".oncl",
            jnext:".oncr",
//            滚动包裹元素
            sbox:"#spec-list",
            sul:".list-h",
            sli:"li",
            times:500
        }
        return new cli(select,dom);
    }
};
o.add={
    init:function(select){
        var sel=$(select),
            add=sel.find(".addnum"),
            jan=sel.find(".jiannum"),
            snum=sel.find(".snum");
        add.bind("click",function(){
            var v=parseInt(snum.val());
            isNaN(v)?v=1:v;
            snum.val(v+=1)
        })

        jan.bind("click",function(){
            var v=parseInt(snum.val());
            isNaN(v)?v=1:v;
            if(v<=1){
                return false;
            }else{
                snum.val(v-=1)
            }
        });

        snum.bind("keyup",function(){
            var v=parseInt(snum.val());
            isNaN(v)?v="":v;
            snum.val(v);
        })
    }
};
o.scroll={
    init:function(select,dom){
        var silder=function(sel,obj){
            var opts=$.extend(this.deflt,{},obj);
            var box=document.getElementById(sel),
                starbox=document.getElementById(opts.begbox),
                endbox=document.getElementById(opts.endbox);
            var scr;
            endbox.innerHTML=starbox.innerHTML;
            if(opts.direc=="top"){
                scr=function(){
                    if(starbox.offsetHeight-box.scrollTop<=0){
                        box.scrollTop-=starbox.offsetHeight;
                    }else{
                        box.scrollTop+=opts.scjl;
                    }
                }
            };

            var myscr=setInterval(scr,opts.speed);
            box.onmouseover=function(){ clearInterval(myscr)};
            box.onmouseout=function() {myscr=setInterval(scr,opts.speed)};

        };
        silder.prototype.deflt={
            begbox:"sc-begin",
            endbox:"sc-end",
            direc:"top",
            speed:1000,
            scjl:30
        }
        new silder(select,dom);
    }
};
//点击父元素增加类
o.dbclicked={
    init:function(sel,dom){
        var sel=$(sel);
        sel.on("click",function(){
            $(this).parent().parent().siblings().removeClass(dom);
            $(this).parent().parent().addClass(dom);
        });

    }
};
//点击增加class，同级去除class
o.silbings={
    init:function(sel,dom){
        var sel=$(sel);
        sel.on("click",function(){
            $(this).siblings().removeClass(dom);
            $(this).addClass(dom);
        });
    }
}
//新增判断浏览器滚动高度和浏览器高度
o.wscroll={
    wst:function(){
        var ws=document.body.scrollTop||document.documentElement.scrollTop;
        return ws;
    },
    wsh:function(){
        var wh=document.body.clientHeight||document.documentElement.clientHeight;
        var winh=window.innerHeight;
        return parseInt(wh)>parseInt(winh) ? winh : wh;
    },
    bodyh:function(){
        var bh=document.body.offsetHeight||document.documentElement.offsetHeight;
        return bh;
    }
}
//浏览器滚动判断隐藏和显示
o.scr={
    init:function(dom){
        window.onscroll=function(){
            var wst= o.wscroll.wst(),
                 wsh= o.wscroll.wsh(),
                 bh= o.wscroll.bodyh();
            if(wst>wsh&&wst<bh-wsh){
                $(dom).addClass("fixedes");
            }else{
                $(dom).removeClass("fixedes");
            }
        }
    }
};
var pCommon={};
pCommon.slider = {
    //对外提供重置全局参数
    opts: {},
    init: function(selector, options){
        var slider = function(sel, opt){
            var me = this;

            //参数
            var opts = $.extend({}, me.defaults, opt);
            var jcon = $(sel),
            //图片索引状态按钮
                jbtns = jcon.find(opts.btnBox).find(opts.btnItem),
            //图片显示框
                jconBox = jcon.find(opts.conBox),
            //图片滚动框
                jconInner = jcon.find(opts.conInner),
            //图片列表
                jcons = jcon.find(opts.conBox).find(opts.conItem),
            //上一页
                jpreBtn = jcon.find(opts.btnPre),
            //下一页
                jnextBtn = jcon.find(opts.btnNext),
            //len:图片个数
            //nlen:克隆首尾图片后个数，用于循环展示
            //curI当前索引值
            //unitW、unitH显示框宽高
                len = jcons.length, nlen = len + 2, curI = 0, unitW = jconBox.width(), unitH = jconBox.height();
            var go2con = null, timer = null, delayTimer = null;

            //初始化dom操作
            if (opts.type == "h" || opts.type == "v") {
                jconInner.append(jcons.eq(0).clone());
                jconInner.prepend(jcons.eq(len-1).clone());
                jcons = jcon.find(opts.conBox).find(opts.conItem);
                jcon.find(".fn_ttbox .img_index").html(1+'/'+len);
            }
            jcons.css({width: unitW + "px", height: unitH + "px", overflow: "hidden"});


            //向后循环返回初始位置
            function reStart(){
                if (opts.type == "h") {
                    jconInner.css({left: 0});
                }else if (opts.type == "v") {
                    jconInner.css({top: 0});
                }
            }
            //向前循环返回末尾位置
            function reEnd(){
                if (opts.type == "h") {
                    jconInner.css({left: -(len+1)*unitW});
                }else if (opts.type == "v") {
                    jconInner.css({top: -(len+1)*unitH});
                }
            };
            if (opts.type == "h") {
                jconInner.css({left:-unitW + "px", width: nlen * unitW + "px", height: unitH + "px"});
                go2con = function(index){
                    var l = - (index * unitW) - unitW;
                    jbtns.removeClass(opts.tabOnClass).eq(index).addClass(opts.tabOnClass);
                    jconInner.stop().animate({left: l + "px"}, 500, 'easeOutQuad');
                    jcon.find(".fn_ttbox .fn_item").hide().eq(index).show();
                    jcon.find(".fn_ttbox .img_index").html((index+1)+'/'+len);
                    curI = index;
                    if (opts.callback) {
                        opts.callback(curI);
                    }
                };
            }else if (opts.type == "v") {
                jconInner.css({top:-unitH + "px"});
                go2con = function(index){
                    var l = - (index * unitH) - unitH;
                    jbtns.removeClass(opts.tabOnClass).eq(index).addClass(opts.tabOnClass);
                    jconInner.stop().animate({top: l + "px"}, 500, 'easeOutQuad');
                    curI = index;
                    if (opts.callback) {
                        opts.callback(curI);
                    }
                };
            }else if(opts.type == "a"){
                jcons.css({position: "absolute"}).hide().eq(curI).show();
                go2con = function(index){
                    if (curI == index) {
                        return;
                    }
                    jbtns.removeClass(opts.tabOnClass).eq(index).addClass(opts.tabOnClass);
                    jcons.stop().hide().eq(index).fadeIn(300);
                    jcons.eq(curI).show().fadeOut(300);
                    curI = index;
                    if (opts.callback) {
                        opts.callback(curI);
                    }
                };
            }else if(opts.type == "n"){
                go2con = function(index){
                    var l = - (index * unitH);
                    jbtns.removeClass(opts.tabOnClass).eq(index).addClass(opts.tabOnClass);
                    jconInner.css({top: l + "px"});
                    curI = index;
                    if (opts.callback) {
                        opts.callback(curI);
                    }
                };
            }
            if (opts.ev == 'mouseover') {
                jbtns.hover(function(){
                    var Jme = $(this);
                    clearTimeout(delayTimer);
                    delayTimer = null;
                    delayTimer = setTimeout(function() {
                        var i = Jme.index();
                        go2con(i);
                    },opts.hoverDelay);
                },function() {
                    clearTimeout(delayTimer);
                    delayTimer = null;
                });
            }else{
                jbtns.bind(opts.ev, function(){
                    var Jme = $(this), i = Jme.index();
                    go2con(i);
                });
            }
            jpreBtn.click(function(){
                var i = curI - 1;
                if (i < 0) {
                    i = len - 1;
                    reEnd();
                }
                go2con(i);
            });
            jnextBtn.click(function(){
                var i = curI + 1;
                if (i >= len) {
                    i = 0;
                    reStart();
                }
                go2con(i);
            });

            if (opts.auto) {
                jcon.bind("mouseover", function(){
                    clearInterval(timer);
                    timer = null;
                }).bind("mouseout", function(){
                    clearInterval(timer);
                    timer = null;
                    timer = setInterval(function(){
                        var i = curI + 1;
                        if (i >= len) {
                            i = 0;
                        }
                        go2con(i);
                    }, opts.time);
                }).trigger("mouseout");
            }
        };

        slider.prototype.defaults = {
            //按钮包裹元素
            btnBox: ".fn_btnbox",
            //按钮元素
            btnItem: ".fn_btn_item",
            //上一页
            btnPre: ".fn_pre",
            //下一页
            btnNext: ".fn_next",
            //内容包裹元素
            conBox: ".fn_con",
            //内容包裹滚动元素
            conInner: ".fn_con_inner",
            //内容元素
            conItem: ".fn_con_item",
            //tab选中样式名
            tabOnClass: "on",
            //切换类型v(纵向)\h(横向)\a(透明度)\n(无效果)
            type: "h",
            //触发事件
            ev: "mouseover",
            //hover是触发延迟
            hoverDelay: 0,
            auto: true,
            time: 4000,
            callback: null
        };
        //复写全局设定
        slider.prototype.defaults = $.extend({}, slider.prototype.defaults, pCommon.slider.opts);
        return new slider(selector, options);
    }
};