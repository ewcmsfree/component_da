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
      	window.location = ' <s:url action="citizen"/>?citizenId=<s:property value="citizen.id"/>&pageNumber=' + page ;
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
        <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">在线服务</a>＞绿色通道</span></p></div>
        <div class="clearfloat"></div>
        <div class="detail_list">
          <div class="detail_son">
            <p>绿色通道</p>
            <ul class="bs_list">
              <s:iterator value="citizens" status="st">
              <s:if test="id == citizen.id">
              	<li><a href=""><span style="font-weight: bold;"><s:property value="name"/></span></a></li>
              </s:if>
              <s:else>
                <s:url action="citizen" id="url" escapeAmp="false"><s:param name="citizenId" value="id"/></s:url>
                <li><a href="<s:property value="url"/>"><s:property value="name"/></a></li>
              </s:else>
              </s:iterator>
            </ul>
          </div>
          <div class="clearfloat"></div>
          <div class="bs_process">
            <h5><s:property value="citizen.name"/></h5>
            <s:iterator value="matters" id='matter'>
            <s:if test = "matter != null">
            <s:if test="organ.name != null">
            <s:url action="organ" id="url" escapeAmp="false"><s:param name="organId" value="organ.id"/></s:url>
             <p class="bs_tit"><s:property value="name"/>[办理部门： <a href="<s:property value="url"/>" target="_blank"><s:property value="organ.name"/></a>]</p>
           
           
            <s:url action="matter" id="matterUrl" escapeAmp="false"><s:param name="organId" value="organ.id"/><s:param name="workingId" value="id"/></s:url>
            <ul>
              <li class="nobg">
                <a href="<s:property value="matterUrl"/>" target="_blank">办事指南</a>
              </li>
              <li>
                <a href="http://218.87.91.208:8008/outportal">网上申报</a>
              </li>
              <s:if test="organ.name != null">
              <li>
                <s:url action = "advisor" id="advisoryUrl" escapeAmp="false"><s:param name="organId" value="organ.id"/><s:param name="workingId" value="id"/></s:url>
                <a href="<s:property value="advisoryUrl"/>"  target="_blank">网上咨询</a>
              </li>
              </s:if>
              <li>
                <s:url action = "advisorSearch" id="advisorySearchUrl" escapeAmp="false"><s:param name="organId" value="organ.id"/><s:param name="workingId" value="id"/></s:url>
                <a href="<s:property value="advisorySearchUrl"/>"  target="_blank">在线查询</a>
              </li>
              <s:if test="!matter.matterAnnexs.isEmpty()">
              <li>
                <s:url action = "matterannex" id="annexUrl" escapeAmp="false"><s:param name="organId" value="organ.id"/><s:param name="workingId" value="id"/></s:url>
                <a href="<s:property value="annexUrl"/>"  target="_blank">表格下载</a>
              </li>
              </s:if>
            </ul>
            </s:if>
             </s:if>
             <div class="clearfloat"></div>
            </s:iterator>
          </div>
          <div class="clearfloat"></div>
          <p class="page">
            <table width="100%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="30" bgcolor="#F2F2F2" class="li_line">
                  <div align="center" class="hui">共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                    <s:if test="page.pagePrev == -1">上一页</s:if>
                    <s:else>
                    <s:url action="citizen" id="pageUrl" escapeAmp="false">
                      <s:param name="citizenId" value="%{citizen.id}"/>
                      <s:param name="pageNumber" value="%{page.pagePrev-1}"/>
                    </s:url>
                    <a href="<s:property value="pageUrl"/>">上一页</a>
                    </s:else>
                    <s:iterator value="page.pageList">
                    <s:if test = "page.page == top"><strong><s:property value="top"/></strong></s:if>
                    <s:else>
                    <s:url action="citizen" id="pageUrl" escapeAmp="false">
                      <s:param name="citizenId" value="%{citizen.id}"/>
                      <s:param name="pageNumber" value="%{top-1}"/>
                    </s:url>
                    <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                    </s:else>&nbsp;
                    </s:iterator>
                    <s:if test="page.pageNext == -1">下一页</s:if>
                    <s:else>
                    <s:url action="citizen" id="pageUrl" escapeAmp="false">
                      <s:param name="citizenId" value="%{citizen.id}"/>
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
          </p>
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
