var util = {
    get_input : function(name){
        return $('#'+ name + '_wapper input[name=' + name  + ']');
    },
    msg_append : function(name,error){
        this.msg_clear(name);
        if(error != ""){
            $('#'+ name + '_wapper').append("<span class='error'>"+error+"</span>");
            return false;
        }else{
            $('#'+ name + '_wapper').append("<span class='success'></span>");
            return true;
        }
    },
    msg_clear : function(name){
        $('#'+ name + '_wapper' + ' .error').remove();
        $('#'+ name + '_wapper' + ' .success').remove();
    }
};
validate ={
    exist : function(name,options,callback){
        var val = util.get_input(name).val();
        $.getJSON(options.exist_url,{
            username:val
        },function(data){
            if(data.exist){
                util.msg_append(name,'用户已经存在');
            }
            if(callback){
                callback(data.exist,options);
            }
        });
    },
    username : function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "用户名不能为空。";
        }else if(! /^.{4,16}$/.test( val ) ){
            error = "用户名合法长度为4-16个字符。";
        }else if (!/^[0-9a-z\_]*$/.test(val)) {
            error = "用户名只能用英文小写、数字、下划线。";
        }else  if( /^[0-9]*$/.test( val ) ){
            error = "用户名不能全部是数字。";
        }else  if( /^[_]*$/.test( val ) ){
            error = "用户名不能全部是下划线。";
        }
        return util.msg_append(name,error);
    },
    password:function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "密码不能为空。";
        }else if(! /^.{6,16}$/.test( val ) ){
            error = "密码合法长度为6-16个字符。";
        }else  if( /[\.\-\?\_]$/.test( val ) ){
            error = "密码最后不能为“.”、“-”、“?”和下划线。";
        }else{
            var charCode = val.charCodeAt(0);
            var same = true;
            for(var i = 0 ; i < val.length;i++){
                if(charCode != val.charCodeAt(i)){
                    same = false;
                    break;
                }
            }
            if(same){
                 error = "密码不能为同一字符或数字。";
            }
        }

        return util.msg_append(name,error);
    },
    passwordAgain:function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "再次输入密码不能为空。";
        }
        var password = util.get_input('password').val();
        if(password != val){
            error = "密码不一致。";
        }
        return util.msg_append(name,error);
    },
    name : function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "昵称不能为空";
        }else if (!/^[\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9]*$/.test(val)) {
            error = "昵称只能用小写字母、数字或汉字。";
        }else{
            var len = val.replace(/[^\x00-\xff]/g,"xx").length;
            if(4 > len || len >20){
                error = "昵称合法长度为4-20个字符（汉字算两位）。";
            }
        }
        return util.msg_append(name,error);
    },
    email:function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "邮件地址不能为空";
        }else if(! /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(val)){
            error = "邮件地址不正确";
        }
        return util.msg_append(name,error);
    },
    checkcode:function(name,options){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "验证码不能为空";
        }
        return util.msg_append(name,error);
    },
    username_exist:function(name,options){
        validate.username(name, options);
        validate.exist(name,options);
    },
    all : function(){
        var ok = true;
        ok = validate.username('username') && ok;
        ok = validate.password('password') && ok;
        ok = validate.passwordAgain('passwordAgain') && ok;
        ok = validate.name('name') && ok;
        ok = validate.email('email') && ok;
        ok = validate.checkcode('checkcode') && ok;

        return ok;
    },
    char_mode:function(iN){
        if (iN>=48 && iN <=57)
            return 1;
        if (iN>=65 && iN <=90)
            return 2;
        if (iN>=97 && iN <=122)
            return 4;
        else
            return 8;  
    },
    bit_total:function(num){
        modes=0;
        for (i=0;i<4;i++){
            if (num & 1) modes++;
            num>>>=1;
        }
        return modes;
    },
    check_passwd_rate:function(pw){
        var modes=0;
        for (i=0;i<pw.length;i++){
            modes|=validate.char_mode(pw.charCodeAt(i));
        }
        return validate.bit_total(modes);
    }
};
var register = {
    init:function(options){
        register.focus('username', validate.username_exist,options);
        register.focus('password',validate.password,options);
        register.focus('passwordAgain',validate.passwordAgain,options);
        register.focus('name',validate.name,options);
        register.focus('email',validate.email,options);
        register.focus('checkcode',validate.checkcode,options);
        register.rate_password();
        register.submit(options);
    },
    focus:function(name,callback,options){
        var input =util.get_input(name);
        input.bind('focusin',function(){
            util.msg_clear(name);
        }).bind('focusout', function(){
            callback(name,options);
        })
    },
    rate_password : function(){
        var element =util.get_input("password");
        element.bind('keyup',function(){
            $('.inputfloat div').removeClass('passW_curr');
            var val = element.val();
            var rate = 1;
            if(val.length == 0){
                rate = 0;
                return;
            }
            rate = validate.check_passwd_rate(val);
            $('#passwordRate'+rate).addClass('passW_curr');
        });
    },
    agree_pagreement:function(){
        $('#pagreement_wapper .error').remove();
        if(!util.get_input('pagreement').attr('checked')){
            $('#pagreement_wapper').append("<div class='error'><span>请确认您已看过并同意《中国浔阳网服务使用协议》</span></div>");
            return false;
        }
        return true;
    },
    alert_error : function(){
        alert('您填写的信息有误，请根据页面红字更改！');
    },
    submit :function(options){
        $('.btn_submit').bind('click',function(event){
            if(!register.agree_pagreement()){
                register.alert_error();
                return;
            }

            var ok = validate.all();
            if(!ok){
                register.alert_error();
                return ;
            }

            validate.exist("username",options,function(exist,options){
                if(exist){
                    register.alert_error();
                    return ;
                }
                var postData = $('#register_form').serialize();
                $.post(options.register_url,postData,function(data){
                    if(!data.checkcode){
                        register.checkcode_refresh(options.checkcode_url);
                        util.msg_append('checkcode','验证码错误。');
                        register.alert_error();
                        return ;
                    }
                    if(!data.success){
                        register.checkcode_refresh(options.checkcode_url);
                        alert('注册失败');
                        return ;
                    }
                    window.location.href = options.redirect_url + '?username='+util.get_input("username").val();
                });
            });
        });
    }
};