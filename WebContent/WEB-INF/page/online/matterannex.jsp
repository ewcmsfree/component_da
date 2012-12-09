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
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;&gt;&gt;&nbsp;<s:property value="working.name"/></p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <h5><s:property value="working.name"/></h5>
          <ul class="sub_program">
            <s:if test="working.matter!=null">
            <li>
              <s:url value="/online/matter/%{organId}_%{workingId}.html" id="matterUrl" escapeAmp="false"/>
              <a href="<s:property value="matterUrl"/>">办事指南</a>
            </li>
            </s:if>
            <li>
              <a href="http://218.87.91.208:8008/outportal">网上申报</a>
            </li>
            <s:if test="working.matter!=null && organId!=0">
            <li>
              <s:url value="/online/advisor/%{organId}_%{workingId}.html" id="advisorUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorUrl"/>">网上咨询</a></li>
            <li>
              <s:url value="/online/advisorsearch/%{organId}_%{workingId}.html" id="advisorsearchUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorsearchUrl"/>">在线查询</a>
            </li>
            </s:if>
            <s:if test="working.matter!=null && !working.matter.matterAnnexs.isEmpty()">
            <li class="current">表格下载</li>
            </s:if>
          </ul>
          <div class="clearfloat"></div>
          <div class="guide_box">
	        <ul class="list01">
	          <s:iterator value="matter.matterAnnexs">
	          <li>
	            <a href="<s:property value="url"/>" target="_blank"><s:property value="name"/></a>
	          </li>
	          </s:iterator>
	        </ul>
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