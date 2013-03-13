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
      <!--当前位置层-->
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="#">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;&gt;&gt;&nbsp;<s:property value="working.name"/></p>
      </div>
      <!--当前位置层结束-->
      <div class="out_line">
        <div class="in_line">
          <h5><s:property value="working.name"/></h5><!--具体办件标题-->
          <ul class="sub_program">
            <s:if test="working.matter!=null">
            <li>
              <s:url value="/online/matter/%{organId}_%{workingId}.html" id="matterUrl" escapeAmp="false"/>
              <a href="<s:property value="matterUrl"/>">办事指南</a>
            </li>
            </s:if>
            <li><a href="http://218.65.5.117:8008/outportal/index.jsp">网上申报</a></li>
            <!-- 
            <s:if test="working.matter!=null">
             -->
            <li>
              <!--  
              <s:url value="/online/advisor/%{organId}_%{workingId}.html" id="advisorUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorUrl"/>">网上咨询</a>
              -->
              <a href="http://218.65.5.117:8008/outportal/outquery/outquery.jsp">网上咨询</a>
            </li>
            <li class="current"><a href="http://218.65.5.117:8008/outportal/outquery/outquerylist.jsp">在线查询</a></li>
            <s:if test="!working.matter.matterAnnexs.isEmpty()">
            <li>
              <s:url value="/online/matterannex/%{organId}_%{workingId}.html" id="annexUrl" escapeAmp="false"/>
              <a href="<s:property value="annexUrl"/>">表格下载</a>
            </li>
            </s:if>
            <!-- 
            </s:if>
            -->
          </ul>
          <div class="clearfloat"></div>
          <div class="guide_box">
            <s:form action="advisorSearch" method="post" id="advisorSearch" name="advisorSearch">
              <input name="title" type="text" class="cx_area" value="请输入关键字" onclick="this.value='';"/>
              <input class="zx_btn" type="button" value="提　交" onclick="document.advisorSearch.submit();"/>
              &nbsp;&nbsp;&nbsp;&nbsp;<a href="<s:url action="advisor" namespace="/user"/>" class="hui style39" target="_blank">我的咨询</a>
              <s:hidden name="workingId"/>
              <s:hidden name="organId"/>
            </s:form>
          </div>
          <div class="clearfloat"></div>
          <div class="list01">
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="60" height="40"><div align="center" class="zongcolor"><strong>编号</strong></div></td>
                <td><div align="center" class="zongcolor"><strong>标题</strong></div></td>
                <td width="130"><div align="center" class="zongcolor"><strong>咨询用户</strong></div></td>
                <td width="40"><div align="center" class="zongcolor"><strong>状态</strong></div></td>
                <td width="100"><div align="center" class="zongcolor"><strong>日期</strong></div></td>
              </tr>
            </table>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" bgcolor="#F1D68D"></td>
              </tr>
            </table>
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
              <s:iterator value="advisors">
              <tr bgcolor="#F9F9F9">
                <td width="60" height="40" bgcolor="#F9F9F9" class="xu_di_line">
                  <div align="center" class="hui"><img src="../images/bullet_01.gif" width="14" height="10"/>
                    <s:property value="id"/>
                  </div>
                </td>
                <td class="xu_di_line"><div align="left" class="news"><s:property value="title"/></div></td>
                <td width="130" class="xu_di_line"><div align="center" class="hui"><s:property value="name"/></div></td>
                <s:if test="state == 0">
                <td width="40" class="xu_di_line"><div align="center" class="hui style40">待处理</div></td>
                </s:if>
                <s:else>
                <td width="40" class="xu_di_line"><div align="center" class="hui style40">回复</div></td>
                </s:else>
                <td width="100" class="xu_di_line"><div align="center" class="hui"><s:date format="yyyy-MM-dd" name="date"/></div></td>
              </tr>
              </s:iterator>
            </table>
            <br/>
            <div class="num">
            <div class="page_num">
              <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
              <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
              <s:else>
              <s:url value="/online/advisorsearch/page/%{matterId}_%{organId}_%{page.pagePrev-1}_%{title}" id="pageUrl" escapeAmp="false"/>
              <a href="<s:property value="pageUrl"/>">上一页</a>
              </s:else>
              <s:iterator value="page.pageList">
              <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
              <s:else>
              <s:url value="/online/advisorsearch/page/%{matterId}_%{organId}_%{top-1}_%{title}" id="pageUrl" escapeAmp="false"/>
              <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
              </s:else>
              </s:iterator>
              <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
              <s:else>
              <s:url value="/online/advisorsearch/page/%{matterId}_%{organId}_%{page.pageNext-1}_%{title}" id="pageUrl" escapeAmp="false"/>
              <a href="<s:property value="pageUrl"/>">下一页</a>
              </s:else>
            </div>
            </div>
		    <div class="clearfloat"></div>
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
