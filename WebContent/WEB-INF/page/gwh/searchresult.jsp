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
    <script src="<s:url value="/datepicker/WdatePicker.js"/>" type="text/javascript"></script>
    <script src="<s:url value='/source/js/jquery-1.4.2.min.js'/>" type="text/javascript"></script>
    <script type="text/JavaScript">
      function findAll(){
        window.location = '<s:url action="index"/>?type=0' ;
      }
      function findReplay(){
        window.location = '<s:url action="index"/>?type=1' ;
      }
      function findNoReplay(){
        window.location = '<s:url action="index"/>?type=2' ;
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
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;公文检索结果</p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <ul class="zw_list1 h_min2 w1">
          <s:iterator value="articleList">
            <li><a href="<s:property value="url"/>" target="_blank"><s:property value="title"/></a></li>
		  </s:iterator>
		  </ul>
          <div class="page_num">
            <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
            <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
            <s:else>
            <s:url action="advquery" id="pageUrl" escapeAmp="false">
              <s:param name="isContent" value="%{isContent}" />
			  <s:param name="title" value="%{title}" />
			  <s:param name="beginDate" value="%{beginDate}" />
			  <s:param name="endDate" value="%{endDate}" />
			  <s:param name="pageNumber" value="%{page.pagePrev-1}" />
            </s:url>
            <a href="<s:property value="pageUrl"/>">上一页</a>
            </s:else>
            <s:iterator value="page.pageList">
            <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
            <s:else>
            <s:url action="advquery" id="pageUrl" escapeAmp="false">
              <s:param name="isContent" value="%{isContent}" />
			  <s:param name="title" value="%{title}"/>
			  <s:param name="beginDate" value="%{beginDate}" />
			  <s:param name="endDate" value="%{endDate}" />
			  <s:param name="pageNumber" value="%{top-1}"/>
			</s:url>
            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
            </s:else>
            </s:iterator>
            <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
            <s:else>
            <s:url action="advquery" id="pageUrl" escapeAmp="false">
			  <s:param name="isContent" value="%{isContent}" />
			  <s:param name="title" value="%{title}" />
			  <s:param name="beginDate" value="%{beginDate}" />
			  <s:param name="endDate" value="%{endDate}" />
			  <s:param name="pageNumber" value="%{page.pageNext-1}"/>
			</s:url>
            <a href="<s:property value="pageUrl"/>">下一页</a>
            </s:else>
          </div>
		  <div class="clearfloat"></div>
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
