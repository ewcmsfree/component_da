<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>中国·德安欢迎您！</title>
        <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/jquery.cookie.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/dynatree/ui.core.js"/>"></script>
        <script type="text/javascript" src="<s:url value="/source/js/dynatree/jquery.dynatree.min.js"/>"></script>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/base.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/ewcms.css"/>'/>
        <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/dynatree/skin/ui.dynatree.css"/>'/>
        <script type="text/javascript">
            $(function(){
                $("#organ_tree").dynatree({
                    rootVisible: false,
                    checkbox: true,
                    classNames: {checkbox: "ui-dynatree-radio"},
                    selectMode: 1,
                    fx: { height: "toggle", duration: 200 },
                    initAjax: {
                        url: "<s:url action = "organ" namespace="/interaction"/>"
                    },
                    onLazyRead: function(dtnode){
                        dtnode.appendAjax({
                            url: "<s:url action = "organ" namespace="/interaction"/>",
                            data: {key:dtnode.data.key}
                        });
                    },
                    onSelect: function(flag, dtnode) {
                        if(flag ){
                            var key = dtnode.data.key;
                            var title = dtnode.data.title;
                            $('#organ_id_id').val(key);
                            $('#organ_name_id').val(title);
                            $("#organ_top_id").css("display","none");
                        }else{
                            $('#organ_id_id').val('');
                            $('#organ_name_id').val('');
                        }
                    }
                });
                $("#organ_button_id").bind('click',function(){
                    var display = $("#organ_top_id").css("display");
                    if(display == "block"){
                        $("#organ_top_id").css("display","none");
                    }else{
                        $("#organ_top_id").css("display","block");
                    }
                });
                $('form input[type = radio').bind("focusin",function(){
                    $("#organ_top_id").css("display","none");
                });
                $('form textarea').bind("focusin",function(){
                    $("#organ_top_id").css("display","none");
                });
                $('#title_id').bind("focusin",function(){
                    $("#organ_top_id").css("display","none");
                });
                $('#organ_name_id').bind("focusin",function(){
                    $("#organ_top_id").css("display","block");
                });
                $('#no_organ_id').bind("click",function(){
                    if(this.checked){
                        $("#organ_top_id").css("display","none");
                        $('#organ_button_id').attr("disabled",true);
                        $('#organ_name_id').unbind("focusin");
                        $('#organ_id_id').val("");
                        $('#organ_name_id').val("");
                    }else{
                        $('#organ_button_id').attr("disabled",false);
                        $('#organ_name_id').bind("focusin",function(){
                            $("#organ_top_id").css("display","block");
                        })
                    }
                });
            });
            function checkcode_refresh(){
                var url = '<s:url value = "/checkcode.jpg"/>?nocache='+Math.random();
                $("#checkcode_id").attr("src",url);
                $('#checkcode_input_id').val('');
            }
        </script>
        <style type="text/css">
            .organ_width {width:250px;}
            .organ_top {border: 1px #a9c9e2 solid;background: #FFFFFF;position:absolute;display: none;height:200px;overflow: auto;}
            .formtable1{width:95%;}
            .formtable1 td{border-bottom:1px solid #eeeeee;text-align:left;padding:3px 1px 6px 20px;}
        </style>
    </head>
    <body>
        <div>
            <div style="margin-left: 20px;font-size: 13px;">
                <s:if test="hasActionErrors()">
                    <s:iterator value="actionErrors">
                        <span class="error"><s:property escape="false"/></span>
                    </s:iterator>
                </s:if>
                <s:if test="success">
                     <script language="Javascript" type="text/Javascript">
                         parent.refresh();
                     </script>
                </s:if>
            </div>
            <div style="clear: both;height: 6px;"></div>
        </div>
        <s:form namespace="/user" action="userinteractionEdit" method="post">
            <table  border="0" cellspacing="0" cellpadding="0"  class="formtable1" align="center">
                <tr style="display:none;">
                    <td width="90px" height="32px">*用户名：</td>
                    <td align="left" height="32px"><s:textfield name="username" value="123456"/></td>
                </tr>
                <tr style="display:none;">
                    <td width="90px" height="32px">*密码：</td>
                    <td align="left" height="32px"><s:textfield name="password" value="123456"/></td>
                </tr>
                <tr>
                    <td width="90px">*信件类型：</td>
                    <td><s:radio list="#{'1':'在线咨询','2':'投诉监督','3':'建言献策'}" name = "type" value="1"/></td>
                </tr>
                <tr>
                    <td width="90px">*信件标题：</td>
                    <td class="formFieldError">
                        <s:textfield id = "title_id" name = "title"/>
                        <s:fielderror ><s:param value="%{'title'}" /></s:fielderror>
                    </td>
                </tr>
                <tr>
                    <td width="90px">*提交部门：</td>
                    <td>
                        <s:hidden name="organId" id="organ_id_id"/>
                        <s:textfield id="organ_name_id" cssClass="organ_width" name="organName" readonly="true"/>
                        <input type="button" id="organ_button_id" value="部门"/>&nbsp;&nbsp;&nbsp;&nbsp;<s:checkbox id="no_organ_id" name="noOrgan"/>我不清楚部门
                        <br/>
                        <div id="organ_top_id" class="organ_width organ_top">
                            <div id ="organ_tree"></div>
                        </div>
                        <s:fielderror ><s:param value="%{'organId'}" /></s:fielderror>
                    </td>
                </tr>
                <tr>
                    <td width="90px">*信件内容：</td>
                    <td class="formFieldError">
                        <s:textarea name = "content" cols="50" rows="4"/>
                        <s:fielderror ><s:param value="%{'content'}" /></s:fielderror>
                    </td>
                </tr>
                <tr>
                    <td width="90px" valign="top" style="padding-top: 20px;">*验证码：</td>
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
