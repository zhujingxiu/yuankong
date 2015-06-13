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
        sel.hover(function(){
            var index=$(this).index();
            sel.removeClass("tabon");
            $(this).addClass("tabon");
            $(this).parent().next().children(dom).hide().eq(index).show();
        },function(){
            return false;
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

$(function(){
    o.mous.init(".h-weix","hov");
    o.mous.init(".nav-adbox","hov");
    o.mous.init(".my-ezhan","hov");
    o.mous.init(".shop-style","hover");
    o.dlist.init(".s-select",".search-dt",".search-dd");
    o.moushov.init("#tab li",".gc-b-detail");
    o.moushov.init("#taber li",".gsbox");
});