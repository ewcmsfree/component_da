<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
    <head>
        <title>网民留言</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/ewcms.css"/>'/>
        <script type="text/javaScript">
            $(function(){
                $("#logout_id").bind("click",function(){
                    var url = '<s:url action="logout" namespace="/user"/>';
                    $.getJSON(url,function(data){
                        location.reload();
                    });
                });
            });
            function checkcode_refresh(){
                var url = '<s:url value = "/checkcode.jpg"/>?nocache='+Math.random();
                $("#checkcode_id").attr("src",url);
                $('#checkcode_input_id').val('');
            }
        </script>
    </head>
    <body>
        <div>
            <div class="formFieldError" style="margin-left: 20px;font-size: 13px;">
                <s:actionerror/>
            </div>
            <div style="clear: both;height: 6px;"></div>
        </div>
        <s:form action="speakEdit" method="post">
            <table border="0" cellspacing="0" cellpadding="0"  class="formtable" align="center">
                <s:if test="!login">
                    <tr id="username_id">
                        <td width="60px" height="32px">*用户名：</td>
                        <td align="left" height="32px" class="formFieldError">
                            <s:textfield name="username"/>
                            &nbsp;&nbsp;<a href="<s:url action="register" namespace="/user"/>" target="_blank">注册会员</a>
                            <s:fielderror ><s:param value="%{'username'}" /></s:fielderror>
                        </td>
                    </tr>
                    <tr id="password_id" class="formFieldError">
                        <td width="60px" height="32px">*密码：</td>
                        <td align="left" height="32px">
                            <s:password name="password"/>
                            <s:fielderror ><s:param value="%{'password'}" /></s:fielderror>
                        </td>
                    </tr>
                </s:if>
                <s:else>
                    <tr style="display:none;">
                        <td width="60px" height="32px">*用户名：</td>
                        <td align="left" height="32px"><s:textfield name="username" value="ssss"/></td>
                    </tr>
                    <tr style="display:none;">
                        <td width="60px" height="32px">*密码：</td>
                        <td align="left" height="32px"><s:textfield name="password" value="123456"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" height="32px">&nbsp;&nbsp;
                            <s:property value="user.name"/>&nbsp;
                            <a href="javascript:void(0);" id="logout_id">退出</a>
                        </td>
                    </tr>
                </s:else>
                <tr>
                    <td colspan="2" height="95px" class="formFieldError">
                        <div>
                            <s:textarea name="content" style ="width:80%" rows = "5"/>
                        </div>
                        <s:fielderror ><s:param value="%{'content'}" /></s:fielderror>
                    </td>
                </tr>
                <tr>
                    <td width="60px" valign="top" style="padding-top: 20px;">*验证码：</td>
                    <td align="left" class="formFieldError">
                        <img id="checkcode_id" src="<s:url value="/checkcode.jpg"/>" alt="验证码"/><a href="javascript:checkcode_refresh()" id="checkcode_refresh_id">看不清,换一张</a><br/>
                        <s:textfield name="checkcode" id="checkcode_input_id"/>
                        <s:fielderror ><s:param value="%{'checkcode'}" /></s:fielderror>
                        <p>验证码不区分大小写</p>
                    </td>
                </tr>
            </table>
            <s:hidden name="interactionId"/>
        </s:form>
        <div align="center" style="margin-top: 10px"><input type="button" value="提交" class="btn_submit" onclick="document.forms[0].submit();"/></div>
    </body>
</html>
