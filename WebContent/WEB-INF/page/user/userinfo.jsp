<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>中国·德安网—会员中心</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/dateselect/jquery.dateselectboxes.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/dateselect/jquery.selectboxes.pack.js"/>"></script>
		<link href="<s:url value="/css/ruichang.css"/>" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/user.css"/>'/>
        <script type="text/javascript">
            $(function(){
                $().dateSelectBoxes('birthMonth_id','birthDay_id','birthYear_id');
                $("#edit_userinfo_id").bind('click',function(){
                    $("#info_view").addClass("hide");
                    $("#info_input").removeClass("hide");
                });
                $('#logout_id').bind('click',function(){
                    $.getJSON('<s:url action="logout"/>',function(){
                        window.location = '<s:url action='login'/>';
                    });
                });
            })
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
            .formFieldError {white-space: nowrap;vertical-align: middle;}
            .formFieldError ul{margin: 0px;padding: 3px;vertical-align: middle;float:left;list-style:none;color: #FF3300;}
            .formFieldError ul li{float: left;list-style:none;}
        </style>

    </head>
    <body>
        <div style="height: 35px">;</div>
        <div id="whole_bg" align="center">
            
                <table width="1008" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
                    <tr>
                        <td height="60" bgcolor="#F3F3F3" style="padding: 1px;">
                            <div align="left">
                                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
　　                                         <span style="font-size:25px;margin:10px 0;color:#CC0000;font-weight: bold;">中国·德安网—</span><span class="style3 title-sub">会员中心</span>
                                        </td>
                                        <td width="150" class="hui" align="left">
                                            你好：<s:property value="userInfo.name"/>
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
                                <table width="80%"  border="0" cellspacing="4" cellpadding="2"  >
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
                                                <span class="bold">我的资料</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="40" class="red_xudi_line">
                                            <div align="left" class="red_bt">
                                                <a href="<s:url action="password"/>"><span class="bold">修改密码</span></a>
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
                            </div>
                        </td>
                        <td valign="top" style="padding: 20px;">
                            <div id="info_view" <s:if test="edit">class="hide"</s:if>>

                                <div class="title hui separate">
                                    &nbsp;基本信息
                                    <a href="javascript:void(0);" id="edit_userinfo_id" style="margin-left: 520px;">
                                        <span style="font-size:12px;font-weight: normal;">修改用户资料</span>
                                    </a>
                                </div>
                                <table class="formtable1" align="center" border="0">
                                    <tr>
                                        <td width="70px" class="hui">昵称：</td>
                                        <td align="left">
                                            <s:property value="userInfo.name"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">真实名称：</td>
                                        <td >
                                            <s:property value="userInfo.realname"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">性别：</td>
                                        <td>
                                            <s:if test="userInfo.sex == 1">男</s:if>
                                            <s:elseif test="userInfo.sex == 2">女</s:elseif>
                                            <s:else>&nbsp;</s:else>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">生日：</td>
                                        <td>
                                            <s:if test="userInfo.birthYear != -1"><s:property value="userInfo.birthYear"/></s:if><s:else>&nbsp;&nbsp;&nbsp;&nbsp;</s:else>&nbsp;年
                                            <s:if test="userInfo.birthMonth != -1"><s:property value="userInfo.birthMonth"/></s:if><s:else>&nbsp;&nbsp;</s:else>&nbsp;月
                                            <s:if test="userInfo.birthDay != -1"><s:property value="userInfo.birthDay"/></s:if><s:else>&nbsp;&nbsp;</s:else>&nbsp;日
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">教育：</td>
                                        <td>
                                            <s:if test="userInfo.education == 1">
                                                初中/小学
                                            </s:if>
                                            <s:elseif test="userInfo.education == 2">
                                                高中/中专
                                            </s:elseif>
                                            <s:elseif test="userInfo.education == 2">
                                                大学/大专
                                            </s:elseif>
                                            <s:elseif test="userInfo.education == 2">
                                                研究生以上
                                            </s:elseif>
                                            <s:else>
                                                &nbsp;
                                            </s:else>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="separate">&nbsp;</td>
                                    </tr>
                                </table>
                                <div class="title hui separate">&nbsp;联络信息</div>
                                <table class="formtable1" align="center" border="0">
                                    <tr>
                                        <td width="70px" class="hui">邮编：</td>
                                        <td>
                                            <s:property value="userInfo.zip"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">通讯地址：</td>
                                        <td>
                                            <s:property value="userInfo.address"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">电话：</td>
                                        <td>
                                            <s:property value="userInfo.phone"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="70px" class="hui">手机：</td>
                                        <td>
                                            <s:property value="userInfo.mphone"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div id="info_input"  <s:if test="!edit">class="hide"</s:if>>
                                <s:form action="userinfoEdit" method="post">
                                    <div class="title hui separate">&nbsp;基本信息</div>
                                    <table class="formtable1" align="center">
                                        <tr>
                                            <td width="70px" class="hui">昵称：</td>
                                            <td >
                                                <s:textfield name="userInfo.name" size="20"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">真实名称：</td>
                                            <td >
                                                <s:textfield name="userInfo.realname"  size="20"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">性别：</td>
                                            <td>
                                                <s:radio name="userInfo.sex" list="#{'1':'男','2':'女'}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">生日：</td>
                                            <td>
                                                <s:select name="userInfo.birthYear" id="birthYear_id" list="years" headerKey="-1" headerValue="年"/>&nbsp;&nbsp;
                                                <s:select name="userInfo.birthMonth" id="birthMonth_id" list="months" headerKey="-1" headerValue="月"/>&nbsp;&nbsp;
                                                <s:select name="userInfo.birthDay" id="birthDay_id" list="days" headerKey="-1" headerValue="日"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">教育：</td>
                                            <td>
                                                <s:select name="userInfo.education" list="#{'1':'初中/小学','2':'高中/中专','3':'大学/大专','4':'研究生以上'}" headerKey="-1" headerValue="请选择..."/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="separate">&nbsp;</td>
                                        </tr>
                                    </table>
                                    <div class="title hui separate">&nbsp;联络信息</div>
                                    <table class="formtable1" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="70px" class="hui">邮编：</td>
                                            <td class="formFieldError">
                                                <s:textfield name="userInfo.zip" size="5"/>
                                                <s:fielderror ><s:param value="%{'userInfo.zip'}" /></s:fielderror>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">通讯地址：</td>
                                            <td>
                                                <s:textfield name="userInfo.address" size="40"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">电话：</td>
                                            <td class="formFieldError">
                                                <s:textfield name="userInfo.phone" size="20"/>&nbsp;&nbsp;<span class="hui">如：0792-1234567或1234567</span>
                                                <s:fielderror ><s:param value="%{'userInfo.phone'}" /></s:fielderror>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="70px" class="hui">手机：</td>
                                            <td class="formFieldError">
                                                <s:textfield name="userInfo.mphone" size="20"/>
                                                <s:fielderror ><s:param value="%{'userInfo.mphone'}" /></s:fielderror>
                                            </td>
                                        </tr>
                                    </table>
                                    <div align="center">
                                        <input type="button" class="btn_submit" onclick="document.forms[0].submit();" value="提交"/>
                                    </div>
                                    <div style="height: 20px"></div>
                                    <s:hidden name="userInfo.username"/>
                                    <s:hidden name="edit" value="true"/>
                                </s:form>
                            </div>
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
    </body>
</html>
