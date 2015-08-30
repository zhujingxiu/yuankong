$.validator.addMethod("byteRangeLength", function(value, element, params) {
	var valueStripped = stripHtml(value);
	return this.optional(element) || valueStripped.length >= params[0] && valueStripped.length <= params[1];
}, "字符长度须在 {0} 到 {1} 之间");

$.validator.addMethod("isMobile", function(phone_number, element) {
	phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
	var isMobile = this.optional(element) || phone_number.length > 9 &&
		phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
	return isMobile;
}, "手机号码非法");

$.validator.addMethod("hasMobile", function(phone_number, element) {
	phone_number = phone_number.replace(/\(|\)|\s+|-/g, "");
	var isMobile = this.optional(element) || phone_number.length > 9 &&
		phone_number.match(/^[(86)|0]?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/);
	if(isMobile){
		var validate = false;
		$.ajax({
			url:'index.php?route=common/tool/validateHasMobile',
			data:{mobile_phone:phone_number},
			type:'post',
			async:false,
			dataType:'json',
			success:function(json){
				validate = ( json.exist == 0 );
			}
		});
		return validate;
	}
	return isMobile;
}, "手机号码已注册");

$.validator.addMethod("hasEmail", function(email, element) {
    var isEmail = this.optional( element ) || /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/.test( email );
    if(isEmail){
        var validate = false;
        $.ajax({
            url:'index.php?route=common/tool/validateHasEmail',
            data:{email:email},
            type:'post',
            async:false,
            dataType:'json',
            success:function(json){
                validate = ( json.exist == 0 );
            }
        });
        return validate;
    }
    return isMobile;
}, "邮箱已注册");


$.validator.addMethod("validateCaptcha", function(captcha, element) {
	captcha = captcha.replace(/\(|\)|\s+|-/g, "");
	var validateCaptcha = this.optional(element) || captcha.length == 4 ;
	if(validateCaptcha){
		var validate = false;
		$.ajax({
			url:'index.php?route=common/tool/validateCaptcha',
			data:{captcha:captcha},
			type:'post',
			dataType:'json',
			async:false,
			success:function(json){
				validate = ( json.status == 1 );
			}
		});
		return validate ;
	}
	return validateCaptcha;
}, "验证码错误");

$.validator.addMethod("validateSMS", function(sms, element,param) {
	sms = sms.replace(/\(|\)|\s+|-/g, "");
	var target = $( param );
	var validateSMS = this.optional(element) || sms.length == 6 ;
	if(validateSMS){
		var validate = false;
		$.ajax({
			url:'index.php?route=common/tool/validateSMS',
			data:{sms:sms,mobile_phone:target.val()},
			type:'post',
			dataType:'json',
			async:false,
			success:function(json){
				validate = ( json.status == 1 );
			}
		});
		return validate;
	}
	return validateSMS;
}, "短信验证码错误");

$(function(){
	$.validator.setDefaults({      
        submitHandler: function(form) {   
            form.submit();   
        }
    }),
    $("#customer-signup").validate({
    	rules:{
    		password: {
                required: true,
                byteRangeLength: [6,20]
            },
            confirm: {
                required: true,
                equalTo: "#customer-password"
            },	            
            mobile_phone: {
            	required: true,
            	isMobile: true,
                hasMobile: true
            },
            captcha:{
            	required:true,
            	validateCaptcha:true
            },
            sms:{
            	validateSMS:"#customer-mobilephone"
            },
            agree:{
            	required:true
            }
    	},
    	messages:{
    		password:{
    			required:"密码必填",
    			byteRangeLength:"密码长度须在6到20个字符",
    		},
    		mobile_phone:{
    			required:"手机号必填",
    			isMobile:"手机号非法，请填写有效的手机号码",
    			hasMobile:"手机号码已注册",
    		},
    		sms:{
    			validateSMS:"短信验证码无效"
    		},
    		agree:{
    			required:"请先阅读注册协议"
    		}
    	},
    	errorElement: "span",
    	errorPlacement: function (error, element) {	 
    		element.parent('.form-group').removeClass('valid').after(error);         
        },
        focusInvalid: true,
        success:function(e){
        	e.prev('.form-group').addClass("valid").next('.error').remove();
        }
    });
    $('#company-signup').validate({
    	rules:{
    		email:{
				required: true,
				email:true,
                hasEmail:true
    		},
    		company:{
    			required: true,
    			byteRangeLength:[4,32]
    		},
    		corporation:{
    			required: true,
    			byteRangeLength:[2,6]
    		},
            'group_id[]':{
                required: true,
            },
    		address:{
    			required: true,
    			byteRangeLength:[4,32]
    		},
    		password: {
                required: true,
                byteRangeLength:[6,20]
            },
            confirm: {
                required: true,
                equalTo: "#company-password"
            },	            
            mobile_phone: {
            	required: true,
            	isMobile: true,
                hasMobile: true
            },
            captcha:{
            	required:true,
            	validateCaptcha:true
            },
            agree: "required"
    	},
    	messages:{
    		password:{
    			required:"密码必填",
    			byteRangeLength:"密码长度须在6到20个字符",
    		},
    		mobile_phone:{
    			required:"手机号必填",
    			isMobile:"手机号非法，请填写有效的手机号码",
    			hasMobile:"手机号码已注册"
    		},
    		agree:{
                required:"请先阅读注册协议"
            },
    	},
    	errorElement: "span",
    	errorPlacement: function (error, element) {
            element.parent('.form-group').removeClass('valid').after(error); 
        },
        focusInvalid: true,
        success:function(e){
        	e.prev('.form-group').addClass("valid").next('.error').remove();
        }
    });

});
