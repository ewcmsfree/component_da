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
    <script type="text/javascript">
      function MM_jumpMenu(targ,selObj,restore){ //v3.0
        eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
        if (restore) selObj.selectedIndex=0;
      }
      function jumpPage(obj){
      	var page = obj.options[obj.selectedIndex].text -1 ;
      	window.location = '<s:url value="/online/citizen/page/%{citizen.id}_' + page + '.html" id="pageUrl" escapeAmp="false"/>';
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
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;&gt;&gt;&nbsp;绿色通道</p>
      </div>
      <div class="out_line">
        <div class="in_line" style="padding:0;">
          <p>绿色通道</p>
          <ul class="bs_list">
            <s:iterator value="citizens" status="st">
            <s:if test="id == citizen.id">
           	  <li><a href=""><span style="font-weight: bold;"><s:property value="name"/></span></a></li>
            </s:if>
            <s:else>
              <s:url value="/online/citizen/%{id}.html" id="citizenUrl" escapeAmp="false"/>
              <li><a href="<s:property value="citizenUrl"/>"><s:property value="name"/></a></li>
            </s:else>
            </s:iterator>
          </ul>
          <div class="clearfloat"></div>
          <div class="bs_program">
            <h4><s:property value="%{working.name}"/></h4>
            <s:iterator value="matters" id='matter'>
            <s:if test="matter!=null">
            <s:if test="organ.name!=null">
            <p class="pro_tit"><s:property value="name"/></p>
            <s:url value="/online/citizen/%{id}.html" id="citizenUrl" escapeAmp="false"/>
            <p class="department">[<span>受理部门：</span><a href="<s:property value="citizenUrl"/>" target="_blank"><s:property value="organ.name"/></a>]</p>
            </s:if>
            <p class="pro_detail">
              <s:url value="/online/matter/%{organ.id}_%{id}.html" id="matterUrl" escapeAmp="false"/>
              <a href="<s:property value="matterUrl"/>" target="_blank">办事指南</a>
              &nbsp;－－－&nbsp;<a href="http://218.87.91.208:8008/outportal">网上申报</a>
              <s:if test="organ.name != null">
              <s:url value="/online/advisor/%{organ.id}_%{id}.html" id="advisoryUrl" escapeAmp="false"/>
              &nbsp;－－－&nbsp;<a href="<s:property value="advisoryUrl"/>" target="_blank">在线咨询</a>
              <s:url value="/online/advisorsearch/%{organ.id}_%{id}.html" id="advisorySearchUrl" escapeAmp="false"/>
              &nbsp;－－－&nbsp;<a href="<s:property value="advisorySearchUrl"/>"  target="_blank">在线查询</a>
              <s:if test="!working.matter.matterAnnexs.isEmpty()">
              <s:url value="/online/matterannex/%{organ.id}_%{id}.html" id="annexUrl" escapeAmp="false"/>
              &nbsp;－－－&nbsp;<a href="<s:property value="annexUrl"/>"  target="_blank">表格下载</a> 
              </s:if>
              </s:if>
            </p>
            <div class="clearfloat"></div>
            </s:if>
            </s:iterator>
          </div>
          <div class="clearfloat"></div>
          <div class="page_num">
            <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
            <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
            <s:else>
            <s:url value="/online/citizen/page/%{citizen.id}_%{page.pagePrev-1}.html" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>">上一页</a>
            </s:else>
            <s:iterator value="page.pageList">
            <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
            <s:else>
            <s:url value="/online/citizen/page/%{citizen.id}_%{top-1}.html" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
            </s:else>
            </s:iterator>
            <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
            <s:else>
            <s:url value="/online/citizen/page/%{citizen.id}_%{page.pageNext-1}.html" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>">下一页</a>
            </s:else>
          </div>
		  <div class="clearfloat"></div>
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
