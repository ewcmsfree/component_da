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
          window.location = ' <s:url action="search"/>?key=<s:property value="key"/>&pageNumber=' + page ;
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
              <s:url action="matter" id="matterUrl" escapeAmp="false"><s:param name="workingId" value="#working.id"/></s:url>
              <p><a href="<s:property value="matterUrl"/>" target="_blank"><s:property value="#working.name"/></a></p>
              <ul class="bs_list">
              <s:iterator value="children" id="child" status="st">
                <s:if test="id != null">
                <s:url action="working" id="url" escapeAmp="false"><s:param name="workingId" value="#child.id"/><s:param name="parentId" value="#working.id"/></s:url>
                <li><a href="<s:property value="url"/>" target="_blank" ><s:property value="#child.name"/></a></li>
                </s:if>
              </s:iterator>
              </ul>
              <div class="clearfloat"></div>
            </s:iterator>
          </div>
          <div class="clearfloat"></div>
                     <p class="page">
              <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" bgcolor="#F2F2F2" class="li_line"><div align="center" class="hui">
                                                    共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                                                    <s:if test="page.pagePrev == -1">
                                                        上一页
                                                    </s:if>
                                                    <s:else>
                                                        <s:url action="search" id="pageUrl" escapeAmp="false">
                                                            <s:param name="key" value="%{key}"/>
                                                            <s:param name="pageNumber" value="%{page.pagePrev-1}"/>
                                                        </s:url>
                                                        <a href="<s:property value="pageUrl"/>">上一页</a>
                                                    </s:else>
                                                    <s:iterator value="page.pageList">
                                                        <s:if test = "page.page == top">
                                                            <strong><s:property value="top"/></strong>
                                                        </s:if>
                                                        <s:else>
                                                            <s:url action="search" id="pageUrl" escapeAmp="false">
                                                                <s:param name="key" value="%{key}"/>
                                                                <s:param name="pageNumber" value="%{top-1}"/>
                                                            </s:url>
                                                            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                                                        </s:else>&nbsp;
                                                    </s:iterator>
                                                    <s:if test="page.pageNext == -1">
                                                        下一页
                                                    </s:if>
                                                    <s:else>
                                                        <s:url action="working" id="pageUrl" escapeAmp="false">
                                                            <s:param name="key" value="%{key}"/>
                                                            <s:param name="pageNumber" value="%{page.pageNext-1}"/>
                                                        </s:url>
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
                                                </div></td>
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
