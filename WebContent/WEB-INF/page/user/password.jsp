<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>中国·德安网—会员中心</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/password.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/password.css"/>'/>
		<link href="<s:url value="/css/ruichang.css"/>" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            $(function(){
                password.init();
                $('#logout_id').bind('click',function(){
                    $.getJSON('<s:url action="logout"/>',function(){
                        window.location = '<s:url action='login'/>';
                    });
                });
            });
        </script>
        <style type="text/css">
            <!--
            .style15 {color: #FFFFFF}
            .style3 {color: #336600}
            -->
            .title{font-size: 20px;margin: 10px 0;}
            .title-sub{font-size: 18px;margin-bottom: 10px;}
            .bold{font-weight: bold;}
            .formtable1{width:95%;}
            .formtable1 td{border-bottom:1px solid #eeeeee;text-align:left;padding:3px 1px 6px 20px;}
        </style>

    </head>
    <body>
        <div style="height: 35px">;</div>
        <div align="center" id="whole_bg">
            <div style="width:1008px;" class="cheng_line" align="center" style="padding: 0;">
                <table width="1008" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
                    <tr>
                        <td height="60" bgcolor="#F3F3F3" style="padding: 1px;">
                            <div align="left">
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
　　                                         <span class="red_bt title">中国·德安网—</span><span class="style3 title-sub">会员中心</span>
                                        </td>
                                        <td width="150" class="hui" align="left">
                                            你好：<s:property value="user.name"/>
                                            [<a id="logout_id" href="javascript:void(0);">退出</a>]
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="separate" style="height:1px;"></div>
                <table width="1006"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="200" valign="top" bgcolor="#FFF5E8" class="y_line">
                            <div style="height: 30px">&nbsp;</div>
                            <div align="center">
                                <table width="80%"  border="0" cellspacing="4" cellpadding="2">
                                    <tr>
                                        <td height="40" class="red_xudi_line">
                                            <div align="left" class="red_bt">
                                                <a href="<s:url action="interaction"/>"><span class="bold">我的信件</span></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" class="red_xudi_line">
                                            <div align="left" class="red_bt">
                                                <a href="<s:url action="advisor"/>"><span class="bold">我的咨询</span></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" class="red_xudi_line">
                                            <div align="left" class="red_bt">
                                                <a href="<s:url action="userinfo"/>"><span class="bold">我的资料</span></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" class="red_xudi_line">
                                            <div align="left" class="red_bt">
                                                <span class="bold">修改密码</span>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                                <p>&nbsp;</p>
                            </div>
                        </td>
                        <td valign="top" style="padding: 60px 100px;">
                            <s:form action="password" method="post">
                                <table cellpadding="0" cellspacing="0" border="0" class="main">
                                    <tr>
                                        <td>
                                            <s:if test="hasActionErrors()">
                                                <s:iterator value="actionErrors">
                                                    <span class="error"><s:property escape="false"/></span>
                                                </s:iterator>
                                            </s:if>
                                            <s:if test="hasActionMessages()">
                                                <s:iterator value="actionMessages">
                                                    <span class="success"><s:property escape="false"/></span>
                                                </s:iterator>
                                            </s:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>*现有密码:</td>
                                        <td id="password_wapper"><s:password name="password"/></td>
                                    </tr>
                                    <tr>
                                        <td>*新密码:</td>
                                        <td>
                                            <table class="newpassowrd" align="left" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td>
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
                                                        <div style="clear: both;height:18px;"></div>
                                                    </td>
                                                </tr>
                                                <tr><td id ="newpassword_wapper"><s:password  name="newpassword"/></td></tr>
                                                <tr><td><span class="inputtxt">6-16位字符，可以是半角字母、数字、“.”、“-”、“?”和下划线（不能在最后）</span></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>*确认密码:</td>
                                        <td id="passwordAgain_wapper"><input type="password" name="passwordAgain"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <input type="button" class="btn_submit" value="提交"/>
                                        </td>
                                    </tr>
                                </table>
                                <s:hidden name="username"/>
                            </s:form>
                        </td>
                    </tr>
                </table>
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
            </div>
                
        </div>
    </body>
</html>
