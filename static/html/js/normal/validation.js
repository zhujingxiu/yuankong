/**
 * Created by 123 on 2015/6/4.
 */
var valid={};
//首页工程登记验证
valid.gcdj={
    gcvdation:function(select,option){
        var $gname=$(".gcname");
        var $gtel=$(".gctel");
        var mytelreg = /^(((13[0-9]{1})|159|153)+\d{8})$/;
        var mynreg=/^[\u4e00-\u9fa5]{2,6}$/;
        $gname.blur(function(){
            if(!mynreg.test($gname.val())){
                $(this).parent().find("p").html("<em class='c_r'>请填写正确的姓名</em>");
                return false;
            }else{
                $(this).parent().find("p").html("申请后我们会及时与您联系");
            }
        });
        $gtel.blur(function(){
            if(!mytelreg.test($gtel.val())){
                $(this).parent().find("p").html("<em class='c_r'>请输入正确的手机号码</em>");
                return false;
            }else{
                $(this).parent().find("p").html("申请后我们会及时与您联系");
            }
        });
    }
};
valid.gcdj.gcvdation();
