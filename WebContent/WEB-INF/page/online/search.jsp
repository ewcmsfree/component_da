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
    </script>
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;&gt;&gt;&nbsp;搜索结果</p>
      </div>
      <div class="clearfloat"></div>
      <div class="out_line">
        <div class="in_line">
          <div class="more_main">
          <h4>检索结果</h4>
          <div class="bs_program">
          <ul class="list01">
          <s:if test="selectId==1">
          <s:iterator value="workings" id="working">
            <s:url value="/online/matter/%{#working.organ.id}_%{#working.id}.html" id="matterUrl" escapeAmp="false"/>
            <li><a href="<s:property value="matterUrl"/>" target="_blank"><s:property value="#working.name"/></a></li>
            <!-- 
            <s:iterator value="children" id="child" status="st">
              <s:if test="id != null">
              <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
              <p class="pro_tit"><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></p>
              </s:if>
            </s:iterator>
             -->
          </s:iterator>
            <!-- 
            <ul class="bs_list">
            <s:iterator value="children" id="child" status="st">
              <s:if test="id != null">
              <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
              <li><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></li>
              </s:if>
            </s:iterator>
            </ul>
             -->
            <div class="clearfloat"></div>
          </s:if>
          <s:else>
          <s:iterator value="annexs" id="matterAnnex">
            <li><a href="<s:property value="#matterAnnex.url"/>"><s:property value="#matterAnnex.legend"/></a></li>
          </s:iterator>
          </s:else>
          </ul>
          </div>
          <div class="clearfloat"></div>
          <div class="num">
          <div class="page_num">
            <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
            <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
            <s:else>
            <s:url value="/online/search/%{page.pagePrev-1}_%{key}" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>">上一页</a>
            </s:else>
            <s:iterator value="page.pageList">
            <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
            <s:else>
            <s:url value="/online/search/%{top-1}_%{key}" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
            </s:else>
            </s:iterator>
            <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
            <s:else>
            <s:url value="/online/search/%{page.pageNext-1}_%{key}" id="pageUrl" escapeAmp="false"/>
            <a href="<s:property value="pageUrl"/>">下一页</a>
            </s:else>
          </div>
          </div>
		  <div class="clearfloat"></div>
       </div>
        </div>
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