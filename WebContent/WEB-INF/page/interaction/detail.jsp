<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国·德安欢迎您！</title>
    <link href="<s:url value='/css/dean.css'/>" rel="stylesheet" type="text/css" />
    <script src="<s:url value='/js/changdiv.js'/>" type="text/javascript"></script>
    <script src="<s:url value='/Scripts/swfobject_modified.js'/>" type="text/javascript"></script>
    <style type="text/css">
      <!--
      .label{ text-align:center; height:35px; line-height:35px; }
      .label span{ margin:0 10px; }
      .label span b{ color:#C00; }
      .box07{ width:800px; margin:0 auto; border:dotted 1px #999; padding:15px; font-size:14px; line-height:2; }
      .box07 b{ color:#03F; }
      -->
    </style>
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <!--当前位置层-->
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/interaction/index.html'/>">公众参与</a>&nbsp;&gt;&gt;&nbsp;在线咨询</p>
      </div>
      <!--内容层-->
      <div class="out_line">
        <div class="in_line">
          <h5><s:property value="interaction.title"/></h5> 
          <div class="label">
            <span><b>编号：</b><s:property value="interaction.formatId"/></span>
            <span><b>咨询人：</b><s:property value="interaction.name"/></span>
            <span><b>信件类型：</b><s:if test = "interaction.type==1">在线咨询</s:if><s:if test = "interaction.type==2">投诉监督</s:if><s:if test = "interaction.type==3">建言献策</s:if></span>
            <span><b>提交时间：</b><s:date format="yyyy-MM-dd" name="interaction.date"/></span>
            <span><b>受理单位：</b><s:property value="interaction.organ.name"/></span>
          </div>
          <div class="box07"><b>信件内容：</b><s:property value="interaction.content" escape="false"/></div>
          <div class="box07"><b>受理状态：</b><s:if test="interaction.state.ordinal() == 1">已回复</s:if><s:else>办理中</s:else></div>
          <div class="box07"><b>受理单位：</b><s:property value="interaction.organ.name"/></div>
          <div class="box07"><b>回复时间：</b><s:date format="yyyy-MM-dd" name="interaction.replayDate"/>
            <s:if test="interaction.state.ordinal()==1"><div class="box07"><s:property value="interaction.replay" escape="false"/></div></s:if>
          </div>
        </div>
      </div>
      <!--内容层结束-->
      <!--脚注信息-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>