<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>中国瑞昌网为您服务！</title>
    <script type="text/javascript" src="<s:url value="/source/js/jquery-1.4.2.min.js"/>"></script>
    <script type="text/javascript" src="<s:url value="/source/js/jquery.cookie.js"/>"></script>
    <script type="text/javascript" src="<s:url value="/source/js/dynatree/ui.core.js"/>"></script>
    <script type="text/javascript" src="<s:url value="/source/js/dynatree/jquery.dynatree.min.js"/>"></script>
    <link rel="stylesheet" type="text/css" href='<s:url value="/source/css/dynatree/skin/ui.dynatree.css"/>'/>
	<link href="<s:url value="/css/ruichang.css"/>" rel="stylesheet" type="text/css" />
	<script src="<s:url value="/Scripts/swfobject_modified.js"/>" type="text/javascript"></script>
    <script src="../js/changdiv.js" type="text/javascript"></script>
    <style type="text/css">
      <!--
      .style9 {color: #CC0000}
      .style13 {font-size: 9pt}
      .style15 {color: #FFFFFF}
      .style21 {color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
      .style34 {font-family: Arial, Helvetica, sans-serif}
      .style40 {color: #336600}
      .style41 {color: #FF0000}
      -->
      input,textarea,select,td,button { margin: 0; font-size: 12px; font-family: Tahoma, SimSun, sans-serif;}
      .organ_width {width:250px;}
      .organ_top {border: 1px #a9c9e2 solid;background: #FFFFFF;position:absolute;display: none;height:200px;overflow: auto;}
      .formtable1{width:100%;}
      .formtable1 td{border-bottom:1px solid #eeeeee;text-align:left;padding:3px 1px 6px 20px;}
      .formMessage {white-space: nowrap;vertical-align: middle;}
      .formMessage ul{margin: 0px;padding: 3px;vertical-align: middle;float:left;list-style:none;color: #6633cc;}
      .formMessage ul li{float: left;list-style:none;}
      .formFieldError {white-space: nowrap;vertical-align: middle;}
      .formFieldError ul{margin: 0px;padding: 3px;vertical-align: middle;float:left;list-style:none;color: #FF3300;}
      .formFieldError ul li{float: left;list-style:none;}
      .btn_submit {width:95px;height:28px;line-height:28px;text-align:center;margin-top:10px;font-size:14px;font-weight:bold;cursor:pointer;}
    </style>
    <script type="text/javascript">
      $(function(){
        $("#organ_tree").dynatree({
          rootVisible: false,
          checkbox: true,
          classNames: {checkbox: "ui-dynatree-radio"},
          selectMode: 1,
          fx: { height: "toggle", duration: 200 },
          initAjax: {
            url: "<s:url action = "organ"/>"
          },
          onLazyRead: function(dtnode){
            dtnode.appendAjax({
              url: "<s:url action = "organ"/>",
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
      $('form input[type = radio]').bind("focusin",function(){
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
          $('#organ_id_id').val("-1");
          $('#organ_name_id').val("");
        }else{
          $('#organ_id_id').val("");
          $('#organ_button_id').attr("disabled",false);
          $('#organ_name_id').bind("focusin",function(){
            $("#organ_top_id").css("display","block");
          });
        }
      });
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
    <!--顶部信息栏-->
    <s:include value="../top.jsp"/>
    <!--顶部信息栏结束-->
    <div id="whole_bg">
      <div id="content">
        <s:include value="../header.jsp"/>
        <!--内容-->
        <div id="list01">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="750" valign="top" align="center">
                <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>
                      <div align="center">
                        <table width="98%" border="0" cellpadding="0" cellspacing="4" bgcolor="#EAEAEA">
                          <tr>
                            <td bgcolor="#F6F6F6">
                              <div class="formFieldError" style="margin-left: 10px;font-size: 13px;">
                                <s:actionerror/>
                              </div>
                              <div class="formMessage" style="margin-left: 10px;font-size: 14px;color: #3300ff;">
                                <s:actionmessage/>
                              </div>
                              <div style="clear:both;height: 1px;"></div>
                              <s:form namespace="/interaction" id="interaction" name="interaction" action="interactionEdit" method="post">
                                <table  border="0" cellspacing="0" cellpadding="0" class="formtable1" align="center">
                                  <s:if test="!login">
                                  <tr id="username_id">
                                    <td width="90px" height="32px">*用户名：</td>
                                    <td align="left" height="32px" class="formFieldError">
                                      <s:textfield name="username"/>
                                      &nbsp;&nbsp;<a href="<s:url action="register" namespace="/user"/>" target="_blank">注册会员</a>
                                      <s:fielderror ><s:param value="%{'username'}" /></s:fielderror>
                                    </td>
                                  </tr>
                                  <tr id="password_id" class="formFieldError">
                                    <td width="90px" height="32px">*密码：</td>
                                    <td align="left" height="32px">
                                      <s:password name="password"/>
                                      <s:fielderror ><s:param value="%{'password'}" /></s:fielderror>
                                    </td>
                                  </tr>
                                  </s:if>
                                  <s:else>
                                  <tr style="display:none;">
                                    <td width="90px" height="32px">*用户名：</td>
                                    <td align="left" height="32px"><s:textfield name="username" value="ssss"/></td>
                                  </tr>
                                  <tr style="display:none;">
                                    <td width="90px" height="32px">*密码：</td>
                                    <td align="left" height="32px"><s:textfield name="password" value="123456"/></td>
                                  </tr>
                                  <tr>
                                    <td colspan="2" height="32px">
                                                                                                     欢迎&nbsp;<font color="red"><s:property value="user.name"/></font>&nbsp;用户&nbsp;&nbsp;
                                      <a href="<s:url namespace='/user' action='interaction'/>">[会员中心]</a>&nbsp;&nbsp;
                                      <a href="javascript:void(0);" id="logout_id">[退出]</a>
                                    </td>
                                  </tr>
                                  </s:else>
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
                                    <td class="formFieldError">
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
                                      <s:textarea name = "content" cols="60" rows="8"/>
                                      <s:fielderror ><s:param value="%{'content'}" /></s:fielderror>
                                    </td>
                                  </tr>
                                  <tr>
                                  	<td width="90px">联系电话：</td>
                                  	<td>
                                  		<s:textfield id="tel" name="tel" maxLength="15"></s:textfield>
                                  	</td>
                                  </tr>
                                  <tr>
                                    <td width="90px" valign="top" style="padding-top: 20px;">*验证码：</td>
                                    <td align="left" class="formFieldError">
                                      <img id="checkcode_id" src="<s:url value="/checkcode.jpg"/>" alt="验证码"/><a href="javascript:checkcode_refresh()" id="checkcode_refresh_id">看不清,换一张</a><br/>
                                      <s:textfield name="checkcode" id="checkcode_input_id"/>
                                      <div class="hui">验证码不区分大小写</div>
                                      <s:fielderror ><s:param value="%{'checkcode'}" /></s:fielderror>
                                    </td>
                                  </tr>
                                </table>
                                <s:hidden name="interactionId"/>
                              </s:form>
                            </td>
                          </tr>
                        </table>
                      </div>
                    </td>
                  </tr>
                </table>
                <div align="center" style="margin-top: 10px"><input type="button" value="提交" class="btn_submit" onclick="document.interaction.submit();"/></div>
              </td> 
            </tr>
          </table>
        </div>
      </div>
      <!--内容结束-->
      <!--脚注信息-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>
