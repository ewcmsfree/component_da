<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国瑞昌网欢迎您！</title>
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
        <div class="wsbs_side">
          <iframe src="/zxfw/zaixianfuwuqiantaozuo/index.html" width="228" height="760" frameborder="0" scrolling="no"> 
            <a href="/zxfw/zaixianfuwuqiantaozuo/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
          </iframe>
        </div>
        <div class="wsbs_main">
          <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">在线服务</a>＞<s:property value="working.name"/></span></p></div>
          <div class="clearfloat"></div>
          <h5><s:property value="working.name"/></h5>
          <ul class="pro">
            <s:if test="working.matter!=null">
            <li class="nobg">
              <s:url action="matter" id="url" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="url"/>">办事指南</a>
            </li>
            </s:if>
            <li>
              <a href="http://218.87.91.208:8008/outportal">网上申报</a>
            </li>
            <s:if test="working.matter!=null && organId != 0">
            <li>
              <s:url action="advisor" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">网上咨询</a>
            </li>
            <li>
              <s:url action="advisorSearch" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">在线查询</a>
            </li>
            </s:if>
            <s:if test="working.matter!=null">
            <s:if test="!matter.matterAnnexs.isEmpty()">
            <li>
              <a class="current">表格下载</a>
            </li>
            </s:if>
            </s:if>
          </ul>
          <div class="clearfloat"></div>
          <div class="bs_box">
            <strong>表格下载</strong>
            <s:iterator value="matter.matterAnnexs">
            <p class="annex">
              <a href="<s:property value="url"/>" target="_blank"><s:property value="name"/></a>
            </p>
            </s:iterator>
          </div>
        </div>
        <!--内容结束-->
      </div>
      <!--脚注信息-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>