<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国·德安欢迎您！</title>
    <link href="../css/ruichang.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
    <script src="../js/changdiv.js" type="text/javascript"></script>
    <script type="text/javascript">
      function MM_jumpMenu(targ,selObj,restore){ //v3.0
        eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
        if (restore) selObj.selectedIndex=0;
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
        <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">民声通道</a>＞在线咨询</span></p></div>
        <div id="letter_detail">
          <div class="title"><s:property value="interaction.title"/></div>
          <div class="source">
            <span><strong>编号：</strong><s:property value="interaction.formatId"/></span>
            <span><strong>咨询人：</strong><s:property value="interaction.name"/></span>
            <span><strong>咨询类型：</strong><s:if test = "interaction.type==1">在线咨询</s:if><s:if test = "interaction.type==2">投诉监督</s:if><s:if test = "interaction.type==3">建言献策</s:if></span>
            <span><strong>提交时间：</strong><s:date format="yyyy-MM-dd" name="interaction.date"/></span><span>
            <strong>受理单位：</strong><s:property value="interaction.organ.name"/></span>
          </div>
          <div class="text_detail">
          <strong>信件内容：</strong><s:property value="interaction.content" escape="false"/>
          </div>
          <div class="text_detail">
            <strong>受理状态：</strong>
            <s:if test="interaction.state.ordinal() == 1">已回复</s:if>
            <s:else>办理中</s:else>
          </div>
          <div class="text_detail">
            <strong>回复单位：</strong><s:property value="interaction.organ.name"/><br />
            <strong>回复时间：</strong><s:date format="yyyy-MM-dd" name="interaction.replayDate"/>
            <s:if test="interaction.state.ordinal()==1"><div class="text_detail"><s:property value="interaction.replay" escape="false"/></div></s:if>
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