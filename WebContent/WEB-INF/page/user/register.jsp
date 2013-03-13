<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>中国·德安网——会员注册</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/base.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/register.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/register.css"/>'/>
		<link href="<s:url value="/css/ruichang.css"/>" rel="stylesheet" type="text/css" />
        <style type="text/css">
            <!--
            .style2 {color: #FF0000}
            .style15 {color: #FFFFFF}
            .style3 {color: #336600}
            -->
        </style>
        <script type="text/javascript">
            $(function(){
                register.init({
                    exist_url : '<s:url action = "exist"/>',
                    register_url : '<s:url action = "register"/>',
                    checkcode_url : '<s:url value = "/checkcode.jpg"/>',
                    redirect_url : '<s:url action="userinfo"/>'
                });
            })

            function checkcode_refresh(){
                var url = '<s:url value = "/checkcode.jpg"/>?nocache='+Math.random();
                $("#checkcode_id").attr("src",url);
                $('#checkcode_input_id').val('');
            }
        </script>
        <style type="text/css">
            <!--
            .style15 {color: #FFFFFF}
            .style3 {color: #336600}
            -->
            .head_title{font-size: 25px;margin: 10px 0;}
            .head_title_sub{font-size: 18px;margin-bottom: 10px;}
        </style>
    </head>
    <body>
        <div align="center" id="whole_bg">
		<div id="content">
            <div style="height: 45px"></div>
            <div class="main" align="left">
                <form id="register_form">
                    <div class="main_top">
                        <div style="border-bottom: 2px solid #FF0000;width:670px;margin-bottom: 20px">
                            <span style="font-size:25px;margin:10px 0;color:#CC0000;font-weight:bold;">中国·德安网—</span><span class="style3 head_title_sub">会员注册</span>
                        </div>
                        <p class="title-no-border">
                            选择用户名
                            <span class="title_sub">本网站的登录名，请慎重填写并牢记</span>
                        </p>
                        <ul>
                            <li>
                                <div class="input_l"><span>*用户名称</span></div>
                                <div class="input_r">
                                    <div id="username_wapper"><input type="text" name="username"/></div>
                                    <p class="inputtxt">
                                        4-16位之间，请用英文小写、数字、下划线，不能全部是数字或下划线。
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="main_cen">
                        <p class="title">
                            设置安全信息
                            <span class="title_sub">保护您的帐号安全极为重要，请慎重填写并牢记</span>
                        </p>
                        <ul>
                            <li>
                                <div class="input_l"><span>*网站登录密码：</span></div>
                                <div class="input_r">
                                    <div>
                                        <div class="inputfloat">
                                            <div id="passwordRate1" class="passW">
                                                <div class="passW_w"></div>
                                                <div class="passW_t">弱</div>

                                            </div>
                                            <div id="passwordRate2" class="passW">
                                                <div class="passW_w"></div>
                                                <div class="passW_t">中</div>

                                            </div>
                                            <div id="passwordRate3" class="passW">
                                                <div class="passW_w"></div>
                                                <div class="passW_t">强</div>

                                            </div>
                                        </div>
                                    </div>
                                    <div style="clear: both;height:25px;"></div>
                                    <div id="password_wapper"><input type="password"  name="password"/></div>
                                    <p class="inputtxt">6-16位字符，可以是半角字母、数字、“.”、“-”、“?”和下划线（不能在最后）</p>
                                </div>
                            </li>
                            <li>
                                <div class="input_l"><span>*再次输入密码：</span></div>
                                <div class="input_r">
                                    <div id="passwordAgain_wapper"><input type="password" name="passwordAgain"/></div>
                                </div>
                            </li>
                        </ul>
                        <p class="title">填写个资料：</p>
                        <ul>
                            <li>
                                <div class="input_l"><span>*昵称：</span></div>
                                <div class="input_r">
                                    <div id="name_wapper"><input type="text" type="text" name="name"/></div>
                                    <p class="inputtxt">4-20位小写字母、数字或汉字（汉字算两位）组成</p>
                                </div>
                            </li>
                            <li>
                                <div class="input_l"><span>*邮件地址：</span></div>
                                <div class="input_r">
                                    <div id="email_wapper"><input type="text" type="text" name="email"/></div>
                                    <p class="inputtxt">例如：xxxx@qq.com</p>
                                </div>
                            </li>
                        </ul>
                        <p class="title">填写验证码：</p>
                        <ul>
                            <li>
                                <div class="input_l"><span>*验证码：</span></div>
                                <div class="input_r">
                                    <div>
                                        <img id="checkcode_id" src="<s:url value="/checkcode.jpg"/>" alt="验证码"/>
                                        <a href="javascript:checkcode_refresh()" id="checkcode_refresh_id">看不清,换一张</a>
                                    </div>
                                    <div id="checkcode_wapper">
                                        <input type="text"  type="text" name="checkcode" id="checkcode_input_id"/>
                                    </div>
                                    <p class="inputtxt">验证码不区分大小写</p>
                                </div>
                            </li>
                            <li>
                                <div class="input_l"><span></span></div>
                                <div class="input_r">
                                    <div id="pagreement_wapper">
                                        <input type="checkbox" name="pagreement" checked="checked"/><span style="margin-left: 8px;">我已经看过并同意&nbsp;<a href="<s:url value="/pagreement.html"/>" target="_blank">《中国德安网服务使用协议》</a></span>
                                    </div>
                                </div>
                                <div style="clear: both;height:5px;"></div>
                            </li>
                            <li>
                                <div class="input_l"><span></span></div>
                                <div class="input_r"><input type="button" class="btn_submit" value="提交"/></div>
                            </li>
                        </ul>
                    </div>
                </form>
                <div class="separate"></div>
            </div>
            <div align="center">
                <table width="1000"  border="0" class="hui">
                    <tr>
                        <td><div align="center" class="hui">主办：中共德安县人民政府<strong>　</strong></div></td>
                    </tr>
                    <tr>
                        <td><div align="center" class="style15">
                                <div align="center" class="hui">承办：德安县人民政府信息化工作办公室　技术支持：德安县人民政府信息化工作办公室　电话：0792-4331718 </div>
                            </div></td>
                    </tr>
                    <tr>
                        <td><div align="center" class="hui">
                                <div align="center" class="hui">Copyright 2013 dean.gov.cn All Rights </div>
                            </div></td>
                    </tr>
                </table>
            </div>
			</div>
        </div>
    </body>
</html>
