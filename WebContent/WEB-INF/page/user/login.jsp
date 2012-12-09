<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>登录中国·德安网</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/base.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/login.css"/>'/>
        <script type="text/javascript">
            $(function(){
                $('.btn_submit').bind('click',function(){
                    $('span').remove('.error');
                    var ok = true;
                    ok = empty_validate('username','用户名不能为空') && ok;
                    ok = empty_validate('password','密码不能为空') && ok;
                    ok = empty_validate('checkcode','验证码不能为空') && ok;
                    if(ok){
                        document.forms[0].submit();
                    }
                });
            });
            function empty_validate(name,error){
                $('#'+ name + '_wapper' + ' .error').remove();
                var value = get_input(name).val();
                if(value.trim() == ""){
                    $('#'+ name + '_wapper').append("<span class='error'>"+error+"</span>");
                    return false;
                }
                return true;
            }
            function get_input(name){
                return $('#'+ name + '_wapper input[name=' + name  + ']');
            }
            function checkcode_refresh(){
                $("#checkcode_id").attr("src","<s:url value = "/checkcode.jpg"/>?nocache="+Math.random());
                get_input('checkcode').val('');
            }
        </script>
        <style type="text/css">
            <!--
            .style9 {color: #CC0000}
            .style13 {font-size: 9pt}
            .style15 {color: #FFFFFF}
            .style21 {color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
            .style34 {font-family: Arial, Helvetica, sans-serif}
            .style40 {color: #336600}
            .style41 {color: #FF0000}
            .style2 {color: #FF0000}
            .style3 {color: #336600}
            -->
            ul {list-style: none;margin: 0;}
            li{padding-left:20px;margin-bottom: 10px;}
        </style>
    </head>
    <body>
        <div align="center" id="whole_bg" style="padding-top: 40px;">
            <table width="700px" border="0" cellpadding="0" cellspacing="4" bgcolor="#EAEAEA">
                <tr>
                    <td bgcolor="#F6F6F6">
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td height="50px" align="center" valign="middle" colspan="2" style="padding: 0px 30px;">
                                    <p style="border-bottom: 1px solid #33cc00;padding:20px 0; ">
                                        <span class="style41" style="font-size: 20px;">登录</span><span class="style9" style="font-size: 28px;font-weight: bold;">中国瑞昌网</span>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td width="120px" style="padding-left: 30px;padding-top: 60px;" valign="top" >
                                    <span class="style41" style="font-size: 15px;">>中国·德安网登录</span>
                                </td>
                                <td>
                                    <div class="main">
                                        <div class="main_cen">
                                            <s:form  action="login" method="post">
                                                <ul>
                                                    <li>
                                                        <div style="padding-left: 10px;height:30px;">
                                                            <s:if test="hasActionErrors()">
                                                                <s:iterator value="actionErrors">
                                                                    <span class="error"><s:property escape="false"/></span>
                                                                </s:iterator>
                                                            </s:if>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="input_l"><span>*登录名：</span></div>
                                                        <div class="input_r">
                                                            <div id="username_wapper"><input type="text" name="username"/></div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="input_l"><span>*密码：</span></div>
                                                        <div class="input_r">
                                                            <div id="password_wapper"><input type="password" name="password"/></div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="input_l"><span>*验证码：</span></div>
                                                        <div class="input_r">
                                                            <div style="margin: 5px 0;">
                                                                <img id="checkcode_id" src="<s:url value = "/checkcode.jpg"/>" alt="验证码"/>
                                                                <a href="javascript:void(0);" onclick='checkcode_refresh()'>看不清,换一张</a>
                                                            </div>
                                                            <div id="checkcode_wapper">
                                                                <input type="text" name="checkcode"/>
                                                            </div>
                                                            <p class="inputtxt">验证码不区分大小写</p>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="input_l"><span></span></div>
                                                        <div class="input_r">
                                                            <input type="button" class="btn_submit" value="登录"/>
                                                            &nbsp;&nbsp;<a href="<s:url action="register"/>" target="_blank">注册会员</a>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </s:form>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="750" border="0" cellspacing="1" cellpadding="1">
                <tr>
                    <td><div align="center">
                <table width="1000"  border="0" class="hui">
                    <tr>
                        <td><div align="center" class="hui">主办：中共德安县人民政府<strong>　</strong></div></td>
                    </tr>
                    <tr>
                        <td><div align="center" class="style15">
                                <div align="center" class="hui">承办：德安县人民政府信息化工作办公室　技术支持：德安县人民政府信息化工作办公室　电话：0792-4224685 </div>
                            </div></td>
                    </tr>
                    <tr>
                        <td><div align="center" class="hui">
                                <div align="center" class="hui">Copyright 2010 dean.gov.cn All Rights </div>
                            </div></td>
                    </tr>
                </table>
                        </div></td>
                </tr>
            </table>
        </div>
    </body>
</html>
