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
      function jumpPage(obj){
          var page = obj.options[obj.selectedIndex].text -1 ;
          window.location = ' <s:url action="advisorSearch"/>?matterId=<s:property value="matterId"/>&organId=<s:property value="organId"/>&title=<s:property value="title" escape="false"/>&pageNumber=' + page ;
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
          <h5><s:property value="working.name"/></h5><!--具体办件标题-->
          <ul class="pro">
            <s:if test="working.matter!=null">
            <li>
              <s:url action="matter" id="url" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="url"/>">办事指南</a>
            </li>
            </s:if>
            <li><a href="http://218.87.91.208:8008/outportal">网上申报</a></li>
            <s:if test="working.matter!=null">
            <li>
              <s:url action = "advisor" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">网上咨询</a>
            </li>
            <li><a class="current" href="#">在线查询</a></li>
            <s:if test="!working.matter.matterAnnexs.isEmpty()">
            <li>
              <s:url action="matterannex" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">表格下载</a>
            </li>
            </s:if>
            </s:if>
          </ul><!--办件的流程-->
          <div class="clearfloat"></div>
          <div class="zw_box2">
            <div class="zx_k">
              <s:form action="advisorSearch" method="post" id="advisorSearch" name="advisorSearch">
                <table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td valign="middle" class="hui">
                      &nbsp;&nbsp;&nbsp;&nbsp;标题：<s:textfield name="title" size="20"/>
                    </td>
                    <td  width="60" align="center" valign="middle">
                      <img src="images/search.gif" width="51" height="35" onclick="document.advisorSearch.submit();"/>
                    </td>
                    <td>
                      &nbsp;&nbsp;&nbsp;&nbsp;<a href="<s:url action="advisor" namespace="/user"/>" class="hui style39" target="_blank">我的咨询</a>
                    </td>
                  </tr>
                </table>
                <s:hidden name="workingId"/>
                <s:hidden name="organId"/>
              </s:form>
            </div>
          </div>
          <div class="list02">
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="60" height="40"><div align="center" class="zongcolor"><strong>编号</strong></div></td>
                <td><div align="center" class="zongcolor"><strong>标题</strong></div></td>
                <td width="130"><div align="center" class="zongcolor"><strong>咨询用户</strong></div></td>
                <td width="40"><div align="center" class="zongcolor"><strong>状态</strong></div></td>
                <td width="100"><div align="center" class="zongcolor"><strong>日期</strong></div></td>
              </tr>
            </table>
            <table width="95%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="1" bgcolor="#F1D68D"></td>
              </tr>
            </table>
            <table width="95%"  border="0" cellpadding="0" cellspacing="0">
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
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td height="30" bgcolor="#F2F2F2" class="li_line"><div align="center" class="hui">共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                 <s:if test="page.pagePrev == -1">上一页</s:if>
                 <s:else>
                 <s:url action="advisorSearch" id="pageUrl" escapeAmp="false">
                   <s:param name="matterId" value="%{matterId}"/>
                   <s:param name="organId" value="%{organId}"/>
                  <s:param name="title" value="%{title}"/>
                  <s:param name="pageNumber" value="%{page.pagePrev-1}"/>
                 </s:url>
                 <a href="<s:property value="pageUrl"/>">上一页</a>
                 </s:else>
                 <s:iterator value="page.pageList">
                 <s:if test = "page.page == top">
                 <strong><s:property value="top"/></strong>
                 </s:if>
                 <s:else>
                 <s:url action="advisorSearch" id="pageUrl" escapeAmp="false">
                   <s:param name="matterId" value="%{matterId}"/>
                   <s:param name="organId" value="%{organId}"/>
                   <s:param name="title" value="%{title}"/>
                   <s:param name="pageNumber" value="%{top-1}"/>
                 </s:url>
                 <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                 </s:else>&nbsp;
                 </s:iterator>
                 <s:if test="page.pageNext == -1">下一页</s:if>
                 <s:else>
                 <s:url action="advisorSearch" id="pageUrl" escapeAmp="false">
                   <s:param name="matterId" value="%{matterId}"/>
                   <s:param name="organId" value="%{organId}"/>
                   <s:param name="title" value="%{title}"/>
                   <s:param name="pageNumber" value="%{page.pageNext-1}"/>
                 </s:url>
                 <a href="<s:property value="pageUrl"/>">下一页</a>
                 </s:else>&nbsp;转到
                 <select name="select" class="hui" onchange="jumpPage(this)">
                 <s:iterator value="page.pageListAll">
                 <s:if test = "page.page == top">
                   <option selected="selected"><s:property value="top"/></option>
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
