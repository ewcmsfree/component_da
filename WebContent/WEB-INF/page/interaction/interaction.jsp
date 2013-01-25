<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国·德安欢迎您！</title>
    <link href="<s:url value='/source/css/dynatree/skin/ui.dynatree.css'/>" rel="stylesheet" type="text/css"/>
	<link href="<s:url value="/css/dean.css"/>" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<s:url value='/source/js/jquery-1.4.2.min.js'/>"></script>
    <script type="text/javascript" src="<s:url value='/source/js/jquery.cookie.js'/>"></script>
    <script type="text/javascript" src="<s:url value='/source/js/dynatree/ui.core.js'/>"></script>
    <script type="text/javascript" src="<s:url value='/source/js/dynatree/jquery.dynatree.min.js'/>"></script>
	<script type="text/javascript" src="<s:url value='/Scripts/swfobject_modified.js'/>"></script>
    <script type="text/javascript" src="<s:url value='/js/changdiv.js'/>"></script>
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
      .organ_top {border: 1px #a9c9e2 solid;background: #FFFFFF;position:absolute;display: none; height:200px;overflow: auto;}
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
              url: "<s:url action='organ'/>",
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
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="#">公众参与</a></p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <h2 style="margin:0 30px 10px 30px;">我要写信</h2>
          <div style="padding:10px 100px;">
	        <div class="formFieldError" style="margin-left:10px;font-size:13px;"><s:actionerror/></div>
		    <div class="formMessage" style="margin-left: 10px;font-size: 14px;color: #3300ff;"><s:actionmessage/></div>
		    <div style="clear:both;height: 1px;"></div>
		    <s:form namespace="/interaction" id="interaction" name="interaction" action="interactionEdit" method="post">
		      <s:if test="!login">
		        <div>*用&nbsp;户&nbsp;名：
		          <s:textfield name="username" cssClass="le_tit"/>&nbsp;&nbsp;<a href="<s:url action="register" namespace="/user"/>" target="_blank">注册会员</a>
		          <span style="color:red"><s:fielderror ><s:param value="%{'username'}" /></s:fielderror></span>
		        </div>
		        <br/>
		        <div>*密&nbsp;&nbsp;&nbsp;&nbsp;码：
		          <s:password name="password" cssClass="le_tit"/>
		          <span style="color:red"><s:fielderror><s:param value="%{'password'}" /></s:fielderror></span>
		        </div>
		      </s:if>
		      <s:else>
		        <div>欢迎
		          &nbsp;<font color="red"><s:property value="user.name"/></font>
		          &nbsp;用户&nbsp;&nbsp;<a href="<s:url namespace='/user' action='interaction'/>">[会员中心]</a>&nbsp;
		          &nbsp;<a href="javascript:void(0);" id="logout_id">[退出]</a>
		        </div>
		      </s:else>
		      <br/>
	          <div>*类&nbsp;&nbsp;&nbsp;&nbsp;型：
	            <s:select list="#{'1':'在线咨询','2':'投诉监督','3':'建言献策'}" name="type" value="1" cssClass="sel"/>
	          </div>
	          <br/>
	          <div>*标&nbsp;&nbsp;&nbsp;&nbsp;题：
	            <s:textfield id="title_id" name="title" cssClass="le_tit"/>
	            <span style="color:red"><s:fielderror><s:param value="%{'title'}" /></s:fielderror></span>
	          </div>
	          <br/>
	          <div>*内&nbsp;&nbsp;&nbsp;&nbsp;容：
	            <s:textarea name="content" rows="10" cssClass="le_text"/>
	            <span style="color:red"><s:fielderror><s:param value="%{'content'}" /></s:fielderror></span>
	          </div>
	          <br/>
              <div>*提交单位：
                <s:textfield id="organ_name_id" cssClass="danwei" name="organName" readonly="true"/>
	            <input type="button" id="organ_button_id" value="选择" class="button1"/>&nbsp;&nbsp;&nbsp;&nbsp;
	            <s:checkbox id="no_organ_id" name="noOrgan"/>我不清楚部门
	            <br/>
	            <div style="padding-left:70px;">
		        <div id="organ_top_id" class="organ_width organ_top">
		          <div id="organ_tree"></div>
		        </div>
		        </div>
		        <span style="color:red"><s:fielderror><s:param value="%{'organId'}"/></s:fielderror></span>
		      </div>
		      <br/>
		      <div>*联系电话：
		        <s:textfield id="tel" name="tel" maxLength="15" cssClass="le_tit"/>
		        <span style="color:red"><s:fielderror ><s:param value="%{'tel'}"/></s:fielderror></span>
		      </div>
		      <br/>
              <div>
		        <img id="checkcode_id" src="<s:url value="/checkcode.jpg"/>" alt="验证码"/><a href="javascript:checkcode_refresh()" id="checkcode_refresh_id">看不清,换一张</a><br/>
		        <s:textfield name="checkcode" id="checkcode_input_id" cssClass="danwei"/>
		               验证码不区分大小写
		        <span style="color:red"><s:fielderror><s:param value="%{'checkcode'}"/></s:fielderror></span>
		      </div>
		      <s:hidden name="organId" id="organ_id_id"/>
		      <s:hidden name="interactionId"/>
		    </s:form>
		    <br/>
	        <div style="padding-left:200px;">
	          <input class="button1" name="" type="button" value="提　交" onclick="document.interaction.submit();"/>&nbsp;&nbsp;&nbsp;&nbsp;<input class="button1" name="" type="button" value="重　置" />
	        </div>
	      </div>
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
