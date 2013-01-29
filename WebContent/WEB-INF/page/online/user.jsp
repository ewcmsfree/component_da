<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>中国·德安—会员中心</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/password.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/password.css"/>'/>
        <script type="text/javascript">
            $(function(){
                $('#logout_id').bind('click',function(){
                    $.getJSON('<s:url action="logout"/>',function(){
                        window.location = '<s:url action='login'/>';
                    });
                });
            });
        </script>
        <link href="<s:url value="/css/dean.css"/>" rel="stylesheet" type="text/css" />
        <style type="text/css">
            <!--
            .style15 {color: #FFFFFF}
            .style3 {color: #336600}
            -->
            .title{font-size: 20px;margin: 10px 0;}
            .title-sub{font-size: 18px;margin-bottom: 10px;}
            .bold{font-weight: bold;}
            ul{list-style: none;padding:5px 10px;}
            li{padding: 3px 0;}
            .init{color: #33cc00;}
            .wait{color:#A65300;}
            .back{color: #3300ff;}
            .rtitle{font-size: 12px;font-weight: bold;color:#00cc00;margin: 5px 0px;border-bottom: 1px dotted #00cc00;}
        </style>

    </head>
    <body>
        <div style="height: 35px"></div>
        <div align="center" id="whole_bg">
            <div style="width:1008px;" class="cheng_line" align="center" style="padding: 0;">
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
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
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
                                                <span class="bold">我的咨询</span>
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
                        <td valign="top" style="padding: 15px;">
                            <s:if test="advisors == null || advisors.isEmpty()">
                                <div class="separate red_bt">我的咨询</div>
                                <div align="center" style="height:100px"></div>
                            </s:if>
                            <s:else>
                                <div align="center">
                                    <s:iterator value="advisors">
                                        <table width="95%"  border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td colspan="2" class="separate" align="center">
                                                    <table width="95%" border="0" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td class="red_bt"><s:property value="title"/></td>
                                                            <td align="right">咨询时间：<s:date format="yyyy年MM月dd日" name="date"/></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="150px" style="padding: 8px 2px;" class="separate">
                                                    <ul style="border-right: 1px solid #ccffff;">
                                                        <li>编号：<s:property value="id"/></li>
                                                        <li>咨询对象：<s:property value="organName"/></li>
                                                    </ul>
                                                </td>
                                                <td valign="top" class="separate">
                                                    <div align="left" style="margin:10px 6px;">
                                                        <div>咨询：<span class="red_bt"><s:property value="matterName"/></span></div>
                                                        <div style="margin:5px;"><s:property value="content"/></div>
                                                        <s:if test="state == 1">
                                                            <div style="margin:12px 0 0 20px;">
                                                                <p class="rtitle"><s:property value="organName"/>回复：</p>
                                                                <s:property value="replay"/>
                                                            </div>
                                                        </s:if>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>
                                        <div class="" style="height:1px;"></div><br/>
                                    </s:iterator>
                                    <div class="num">
						          <div class="page_num">
						            <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
						            <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
						            <s:else>
						            <s:url action="advisor" id="pageUrl" escapeAmp="false"><s:param name="pageNumber" value="%{page.pagePrev-1}"/></s:url>
						            <a href="<s:property value="pageUrl"/>">上一页</a>
						            </s:else>
						            <s:iterator value="page.pageList">
						            <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
						            <s:else>
						            <s:url action="advisor" id="pageUrl" escapeAmp="false"><s:param name="pageNumber" value="%{top-1}"/></s:url>
						            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
						            </s:else>
						            </s:iterator>
						            <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
						            <s:else>
						            <s:url action="advisor" id="pageUrl" escapeAmp="false"><s:param name="pageNumber" value="%{page.pageNext-1}"/></s:url>
						            <a href="<s:property value="pageUrl"/>">下一页</a>
						            </s:else>
						          </div>
						          </div>
								  <div class="clearfloat"></div>
                                </div>
                            </s:else>
                        </td>
                    </tr>
                </table>
                <table width="100%"  border="0" class="hui">
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
  </body>
</html>
