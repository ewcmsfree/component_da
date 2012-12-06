<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>中国瑞昌网为您服务！</title>
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
          window.location = ' <s:url action="organsearch"/>?id=<s:property value="id"/>&pageNumber=' + page ;
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
      <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">民声通道</a></span></p></div>
        <div id="list01">
          <ul class="menu01"><li class="blank"></li><li class="current"><s:property value="name"/></li></ul>
          <div class="list02">
            <table width="100%" border="0" cellpadding="0" cellspacing="3">
              <tr>
                <th>编号</th>
                <th>内容</th>
                <th>受理单位</th>
                <th>状态</th>
                <th>日期</th>
              </tr>
              <s:iterator value="interactions">
              <tr>
                <td><s:property value="formatId"/></td>
                <td class="ct">
                  <s:url action="detail" id="detailUrl">
                    <s:param name="id" value="%{id}"/>
                  </s:url>
                  <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
                </td>
                <td><s:property value="organ.name"/></td>
                <td><s:property value="state.title"/></td>
                <td><s:date format="yyyy-MM-dd" name="date"/></td>
              </tr>
              </s:iterator>
            </table>
            <table width="95%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="30" bgcolor="#F2F2F2" class="li_line">
                <div align="center" class="hui">
                                                 共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                  <s:if test="page.pagePrev == -1">上一页</s:if>
                  <s:else>
                  <s:url action="organsearch" id="pageUrl" escapeAmp="false">
                    <s:param name="id" value="%{id}"/>
                    <s:param name="pageNumber" value="%{page.pagePrev-1}"/>
                  </s:url>
                  <a href="<s:property value="pageUrl"/>">上一页</a>
                  </s:else>
                  <s:iterator value="page.pageList">
                    <s:if test = "page.page == top">
                    <strong><s:property value="top"/></strong>
                    </s:if>
                    <s:else>
                    <s:url action="organsearch" id="pageUrl" escapeAmp="false">
                      <s:param name="id" value="%{id}"/>
                      <s:param name="pageNumber" value="%{top-1}"/>
                    </s:url>
                    <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                    </s:else>&nbsp;
                  </s:iterator>
                  <s:if test="page.pageNext == -1">下一页</s:if>
                  <s:else>
                  <s:url action="organsearch" id="pageUrl" escapeAmp="false">
                    <s:param name="id" value="%{id}"/>
                    <s:param name="pageNumber" value="%{page.pageNext-1}"/>
                  </s:url>
                  <a href="<s:property value="pageUrl"/>">下一页</a>&nbsp;转到
                  </s:else>
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