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
      function jumpPage(obj){
          var page = obj.options[obj.selectedIndex].text -1 ;
          window.location = '<s:url value="/online/search/' + page + '_%{key}" id="pageUrl" escapeAmp="false"/>';
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
          <div class="zw_box2">
            <div class="zx_k">
              <form action="search.do" method="post" name="onlineform" id="onlineform">
                <span>标题：</span><input name="key" type="text" size="60"/>
                <input class="cx_bt" type="submit" value="查询" />
              </form>
            </div>
          </div>
	      <div class="clearfloat"></div>
          <div class="bs_process">
            <h5>检索结果</h5>
            <s:iterator value="workings" id="working">
              <s:url value="/online/matter/%{#working.id}.html" id="matterUrl" escapeAmp="false"/>
              <p><a href="<s:property value="matterUrl"/>" target="_blank"><s:property value="#working.name"/></a></p>
              <ul class="bs_list">
              <s:iterator value="children" id="child" status="st">
                <s:if test="id != null">
                <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
                <li><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></li>
                </s:if>
              </s:iterator>
              </ul>
              <div class="clearfloat"></div>
            </s:iterator>
          </div>
          <div class="clearfloat"></div>
          <p class="page_num">
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" bgcolor="#F2F2F2" class="li_line">
                <div align="center" class="hui">
                               共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                 <s:if test="page.pagePrev == -1">
                               上一页
                 </s:if>
                 <s:else>
                 <s:url value="/online/search/%{page.pagePrev-1}_%{key}" id="pageUrl" escapeAmp="false"/>
                 <a href="<s:property value="pageUrl"/>">上一页</a>
                 </s:else>
                 <s:iterator value="page.pageList">
                 <s:if test = "page.page == top">
                 <strong><s:property value="top"/></strong>
                 </s:if>
                 <s:else>
                 <s:url value="/online/search/%{top-1}_%{key}" id="pageUrl" escapeAmp="false"/>
                 <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                 </s:else>&nbsp;
                 </s:iterator>
                 <s:if test="page.pageNext == -1">
                               下一页
                 </s:if>
                 <s:else>
                 <s:url value="/online/search/%{page.pageNext-1}_%{key}" id="pageUrl" escapeAmp="false"/>
                 <a href="<s:property value="pageUrl"/>">下一页</a>
                 </s:else>&nbsp;转到
                 <select name="select" class="hui" onchange="jumpPage(this)">
                 <s:iterator value="page.pageListAll">
                 <s:if test = "page.page == top">
                 <option selected><s:property value="top"/></option>
                 </s:if>
                 <s:else>
                 <option><s:property value="top"/></option>
                 </s:else>
                 </s:iterator>
                 </select>页
               </div>
               </td>
              </tr>
            </table>
           </p>
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
