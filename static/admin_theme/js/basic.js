/**
 * Created by 123 on 2015/5/4.
 */
jQuery(function(){
    $(".sidebar-title").click(function(){
        if($(this).next(".sidebar-dl").css("display")=="none"){
            $(this).next(".sidebar-dl").slideDown();
        }else{
            $(this).next(".sidebar-dl").slideUp();
        }

    });
    $(".new-kh").hover(function(){
        $(this).find(".del-kh").stop().slideDown();
    },function(){
        $(this).find(".del-kh").stop().slideUp();
    });
    $(".menubox").hover(function(){
        $(this).children(".mbox").show();
    },function(){
        $(this).children(".mbox").hide();
    });
});
//tab切换
function taber(thisObj,Num){
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
};
//定点弹窗
function popshow(a){
    a=a||{};
   var opt={
        id: a.id || "#resetpop",
       pagex: a.px,
       pagey: a.py,
       w:"90",
       h:"15"
    }
    id=document.getElementById(opt.id.replace("#",""));
    id.style.display="block";
    id.style.top=opt.pagey+parseInt(opt.h)+"px";
    id.style.left=opt.pagex-opt.w+"px";
}
//关闭弹窗
function cosed(id){
    var id=document.getElementById(id);
    id.style.display="none"
}
//关闭窗口
function closedd(d,c,b){
    var d=document.getElementById(d);
    var c=document.getElementById(c);
    var b=document.getElementById(b);
    d.style.display="none";
    c.style.display="none";
    b.style.display="none";
}
//打开窗口
function opend(d,c,b){
    var d=document.getElementById(d);
    var c=document.getElementById(c);
    var b=document.getElementById(b);
    d.style.display="block";
    c.style.display="block";
    b.style.display="block";
}
//三级联动下拉
var xfstyle=[
    {dname:"消防产品",
    dstyle:[
        {
            name:"消火栓系统",
            style:["消火栓","消防水带","消火栓箱","消防泵","消防水炮","消防水枪","消防卷盘"]
        },{
            name:"火灾自动报警系统",
            style:["火灾探测器","声光报警器","应急广播","消防警铃","漏电火灾报警系统"]
        },{
            name:"自动灭火系统",
            style:["消防泵","喷淋","阀门","灭火器","水流指示器","灭火剂","气体检测仪","泡沫灭火装置"]
        },{
            name:"防火分隔系统",
            style:["防火门","防火阀","防火卷帘","防火水幕带"]
        },{
            name:"防、排烟系统",
            style:["风机","管件","防火阀","风阀","风机电气控制箱"]
        },{
            name:"应急疏散系统",
            style:["应急照明","疏散指示标志"]
        }
    ]
    },
    {dname:"消防装备",
     dstyle:[
         {
             name:"个人防护装备",
             style:["头盔","战斗服","消防手套","安全带","消防头灯","导向绳","消防腰斧","战斗靴","空气呼吸器","呼救器","方位灯"]
         },{
             name:"特种防护装备",
             style:["避火服","隔热服","防化服","耐寒战斗服","消防空气呼吸器"]
         },{
             name:"抢险救援装备",
             style:["担架","救援网","止坠器","头盔","安全带","防爆灯","消防服","防爆灯","缓降器","破拆工具","呼吸器","空气压缩机","生命探测仪"]
         },{
             name:"灭火救援装备",
             style:["消防斧","铁锹","铁铤","绝缘剪","液压扩张器","液压钳剪切钳","液压千斤顶","液压机动泵","无齿锯","消防安全吊带"]
         }
     ]
    }];

var stylefunc=function(s1,s2,s3,sty,stdell){
    var s1=document.getElementById(s1);
    var s2=document.getElementById(s2);
    var s3=document.getElementById(s3);
    function cmbSelect(cmb, str)
    {
        for(var i=0; i<cmb.options.length; i++)
        {
            if(cmb.options[i].value == str)
            {
                cmb.selectedIndex = i;
                return;
            }
        }
    }
    function adds(idd,str,obj){
        var option=document.createElement("OPTION");
        idd.options.add(option);
        option.innerHTML=str;
        option.value=str;
        option.obj=obj;
    }
    function fselect(){
        s2.options.length=0;
        if(s1.selectedIndex==-1) return;
        var tem=s1.options[s1.selectedIndex].obj;

        for(var i=0;i<tem.dstyle.length;i++){
            adds(s2,tem.dstyle[i].name,tem.dstyle[i])
        }
        fselect2();
        s2.onchange=fselect2;
    }
    function fselect2(){
        s3.options.length=0;
        if(s2.selectedIndex==-1) return;
        var tem=s2.options[s2.selectedIndex].obj;

        for(var i=0;i<tem.style.length;i++){
            adds(s3,tem.style[i],null)
        }
    }
    for(var j=0;j<xfstyle.length;j++){
        adds(s1,xfstyle[j].dname,xfstyle[j])
    };
    fselect();
    s1.onchange=fselect;
}
//下拉菜单
var xllist=function(){
    this.init=function(obj,obj2,e){
        var e=event||e;
        var obj=document.getElementById(obj);
        var obj2=document.getElementById(obj2);
        var span=obj.getElementsByTagName("span");

        for(var i=0;i<span.length;i++){
            span[i].onclick=this.al(i,obj,obj2);
        }
        e.stopPropagation();
    }
};
xllist.prototype={
    al:function(param,d,dd,e){
        return function(){
            var e=event||e;
            var span=d.getElementsByTagName("span");
            dd.value=span[param].innerHTML;
            d.style.display="none";
            dd.onchange=xllist.change(dd.value)
            e.stopPropagation();
        }
    },
    change:function(v){
        if(v=="待退款"){
            document.getElementById("tkbox").style.display="inline-block";
            document.getElementById("tkbox2").style.display="none";
        }else if(v=="待发货"){
            document.getElementById("tkbox2").style.display="inline-block";
            document.getElementById("tkbox").style.display="none";
        }else{
            document.getElementById("tkbox").style.display="none";
            document.getElementById("tkbox2").style.display="none";
        }

    }
};
function slide(obj,content,cal,type){
    jQuery(obj).bind(type,function(){
        var pstyel=$(this).parent().parent().find(content);
        if(pstyel.css("display")!="none"){
            pstyel.slideUp();
            $(this).removeClass(cal);
        }else{
            pstyel.slideDown();
            $(this).addClass(cal);
        }

    });
}