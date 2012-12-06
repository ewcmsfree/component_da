//评论
function comment_init(url,articleId,callback){
    var html = new Array();
    html.push('<h2><span>我要评论</span><div><a href=\"\"><div id=\"comment-count-warpper\"><div></a></div></h2>');
    html.push('<form name=\"comment_post_form\" id=\"comment_post_form_id\">');
    html.push('<div id=\"comment_user_wrapper\"> 用户名<input type=\"text\"  name=\"user\"/></div>');
    html.push('<div id =\"comment_password_wrapper\">密码<input type=\"password\" name=\"password\"/></div>');
    html.push('<div><textarea name =\"content\"></textarea></div>');
    html.push('<input type=\"hidden\" name=\"article_id\" value="' + articleId + '" />');
    html.push('<div><input type=\"button\" value=\"提交评论\"/></div>');
    html.push('</form>');
    var comment_wrapper = document.getElementById('comment-warpper');
    comment_wrapper.innerHTML = html.join("\n");
    
    var counterUrl = url + "/commentCounter?jsoncallback=?";
    $.getJSON(counterUrl,{article_id:articleId},function(data){
        callback(data.commentCounter,data.personCounter);
    });

    $('#comment_post_form_id input[type=button]').bind('click',function(event){
        var data = $('#comment_post_form_id').serialize();
        var inputUrl = url + "/commentInput?jsoncallback=?";
        $.getJSON(inputUrl,data,function(data){
            callback(data.commentCounter,data.personCounter);
        });
    });
}
