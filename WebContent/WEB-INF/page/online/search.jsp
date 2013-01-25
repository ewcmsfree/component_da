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
          window.location = '<s:url value="/online/search/' + page + '_%{key}" id="pageUrl" escapeAmp="false"/>';
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
          <h5>检索结果</h5>
          <s:if test="selectId==1">
          <div class="bs_program">
          <s:iterator value="workings" id="working">
            <s:url value="/online/matter/%{#working.id}.html" id="matterUrl" escapeAmp="false"/>
            <h4><a href="<s:property value="matterUrl"/>" target="_blank"><s:property value="#working.name"/></a></h4>
            <s:iterator value="children" id="child" status="st">
              <s:if test="id != null">
              <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
              <p class="pro_tit"><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></p>
              </s:if>
            </s:iterator>
          </s:iterator>
          </div>
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
            <p><a href="<s:property value="#matterAnnex.url"/>"><s:property value="#matterAnnex.legend"/></a></p>
          </s:iterator>
          </s:else>
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
               <s:if test = "page.page==top">
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
       <!--脚注信息-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>