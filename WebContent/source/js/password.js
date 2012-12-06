var util = {
    get_input : function(name){
        return $('#'+ name + '_wapper input[name=' + name  + ']');
    },
    msg_append : function(name,error,ok){
        this.msg_clear(name);
        if(error != ""){
            $('#'+ name + '_wapper').append("<span class='error'>"+error+"</span>");
            return false;
        }else{
            if(ok){
                $('#'+ name + '_wapper').append("<span class='success'></span>");
            }
            return true;
        }
    },
    msg_clear : function(name){
        $('#'+ name + '_wapper' + ' .error').remove();
        $('#'+ name + '_wapper' + ' .success').remove();
    }
};

validate ={
    password:function(name){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "现有密码不能为空";
        }
        return util.msg_append(name, error);
    },
    newpassword: function (name) {
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "新密码不能为空。";
        }else if(! /^.{6,16}$/.test( val ) ){
            error = "新密码合法长度为6-16个字符。";
        }else  if( /[\.\-\?\_]$/.test( val ) ){
            error = "新密码最后不能为“.”、“-”、“?”和下划线。";
        }
        return util.msg_append(name,error,true);
    },
    passwordAgain:function(name){
        var val = util.get_input(name).val();
        var error = "";
        if(val.trim() == ""){
            error = "再次输入密码不能为空。";
        }
        var password = $("#newpassword_wapper input[name=newpassword]").val();
        if(password != val){
            error = "密码不一致。";
        }
        return util.msg_append(name,error,true);
    },
    all : function(){
        var ok = true;
        ok = validate.password('password') && ok;
        ok = validate.newpassword('newpassword') && ok;
        ok = validate.passwordAgain('passwordAgain') && ok;

        return ok;
    }

}
password={
    init:function(){
        password.focus('password', validate.password);
        password.focus('newpassword',validate.newpassword);
        password.focus('passwordAgain',validate.passwordAgain);
        password.rate_password();
        password.submit();
    },
    focus:function(name,callback){
        var input =util.get_input(name);
        input.bind('focusin',function(){
            util.msg_clear(name);
        }).bind('focusout', function(){
            callback(name);
        })
    },
    rate_password : function(){
        var element =util.get_input("newpassword");
        element.bind('keyup',function(){
            $('.inputfloat div').removeClass('passW_curr');
            var val = element.val();
            var rate = 1;
            if(val.length == 0){
                rate = 0;
                return;
            }
            if(val.length > 5){
                if(!(/^[a-z]*$/.test(val)
                    || /^[0-9]*$/.test(val)
                    || /^[A-Z]*$/.test(val))){
                    rate++;
                }
                if(val.length > 9){
                    rate ++;
                }
            }
            $('#passwordRate'+rate).addClass('passW_curr');
        });
    },
    submit :function(){
        $('.btn_submit').bind('click',function(){
            var ok = validate.all();
            if(!ok){
                password.alert_error();
                return ;
            }
            $('form').submit();
        });
    },
    alert_error : function(){
        alert('您填写的信息有误，请根据页面红字更改！');
    }
}


