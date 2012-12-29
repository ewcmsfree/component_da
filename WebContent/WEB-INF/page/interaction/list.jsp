<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国·德安欢迎您！</title>
    <link href="<s:url value='/css/dean.css'/>" rel="stylesheet" type="text/css" />
    <script src="<s:url value='/Scripts/swfobject_modified.js'/>" type="text/javascript"></script>
    <script src="<s:url value='/js/changdiv.js'/>" type="text/javascript"></script>
    <script src="<s:url value='/source/js/jquery-1.4.2.min.js'/>" type="text/javascript" ></script>
    <script type="text/javascript">
      function MM_jumpMenu(targ,selObj,restore){ //v3.0
        eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
        if (restore) selObj.selectedIndex=0;
      }
      function jumppage(obj){
          var page = obj.options[obj.selectedIndex].text - 1 ;
          var ct = '<s:property value="currentTable"/>';
          window.location = '<s:url value="/interaction/list/page/0_' + page + '_' + ct + '.html"/>';
      }
    </script>
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <s:hidden id="currentTable" name="currentTable"/>
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="/component/interaction/index.do">公众参与</a>&nbsp;&gt;&gt;&nbsp;
        <s:if test="currentTable==1">在线咨询</s:if>
        <s:if test="currentTable==2">投诉监督</s:if>
        <s:if test="currentTable==3">建言献策</s:if>
        </p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <h2 style="margin:0 30px 10px 30px;">
            <s:if test="currentTable==1">在线咨询</s:if>
            <s:if test="currentTable==2">投诉监督</s:if>
            <s:if test="currentTable==3">建言献策</s:if>
          </h2>
          <table class="subletter">
            <tr>
              <td class="bh2">编号</td>
              <td class="bt2">标题</td>
              <td class="sj2">时间</td>
            </tr>
            <s:iterator value="interactions">
            <tr>
              <td class="cen"><s:property value="formatId"/></td>
              <td>
                <s:url value="/interaction/detail/%{id}.html" id="detailUrl"/>
                <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
              </td>
              <td class="cen"><s:date format="yyyy-MM-dd" name="date"/></td>
            </tr>
            </s:iterator>
          </table>
          <p class="page_num">
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" bgcolor="#F2F2F2">
                  <div align="center">共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                  <s:if test="page.pagePrev == -1">上一页</s:if>
                  <s:else>
                  <s:url id="pageUrl" value="/interaction/list/page/%{type}_%{page.pagePrev-1}_%{currentTable}.html" escapeAmp="false"/>
                  <a href="<s:property value="pageUrl"/>">上一页</a>
                  </s:else>
                  <s:iterator value="page.pageList">
                  <s:if test = "page.page == top"><strong><s:property value="top"/></strong></s:if>
                  <s:else>
                  <s:url id="pageUrl" value="/interaction/list/page/%{type}_%{top-1}_%{currentTable}.html" escapeAmp="false"/>
                  <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                  </s:else>&nbsp;
                  </s:iterator>
                  <s:if test="page.pageNext == -1">下一页</s:if>
                  <s:else>
                  <s:url id="pageUrl" value="/interaction/list/page/%{type}_%{page.pageNext-1}_%{currentTable}.html" escapeAmp="false"/>
                  <a href="<s:property value="pageUrl"/>">下一页</a>
                  </s:else>&nbsp;转到
                  <select name="select" class="hui" onchange="jumppage(this)">
                  <s:iterator value="page.pageListAll">
                  <s:if test = "page.page == top"><option selected="selected"><s:property value="top"/></option></s:if>
                  <s:else><option><s:property value="top"/></option></s:else>
                  </s:iterator>
                  </select>页
                </div>
              </td>
            </tr>
          </table>
        </p>
        </div>
      </div>
      <!--内容结束-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>