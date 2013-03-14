<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国·德安欢迎您！</title>
    <link href="<s:url value='/css/dean.css'/>" rel="stylesheet" type="text/css" />
    <script src="<s:url value='/js/changdiv.js'/>" type="text/javascript"></script>
    <script src="<s:url value='/Scripts/swfobject_modified.js'/>" type="text/javascript"></script>
    <script src="<s:url value="/datepicker/WdatePicker.js"/>" type="text/javascript"></script>
    <script src="<s:url value='/source/js/jquery-1.4.2.min.js'/>" type="text/javascript"></script>
	<style type="text/css">
	body{ margin:0 auto; font-size:12px; font-family:Arial, Helvetica, sans-serif; line-height:1.5; background:#CCC; }
	ul,dl,dd,h1,h2,h3,h4,h5,h6,form,p{ padding:0; margin:0;}
	h1,h2,h3,h4,h5,h6{ font-size:14px; }
	ul{ list-style:none;}
	img{ border:0px; margin: 0px; padding: 0px; }
	a{ color:#555; text-decoration:none; }
	a:hover{ color:#F00; text-decoration: underline; }
	.clearfloat{clear:both; height:0; font-size:1px; line-height:0px; }
	#container{ width:900px; border:#999 1px solid; background:#FFF; padding:20px; margin:0 auto; }
	.bar{ height:35px; line-height:35px; border-bottom:1px dotted #999; }
	.bar a{ color:#C00; }
	.srh{ padding:10px; text-align:center; font-size:14px; }
	.btn{ font-size:14px; }
	.list ul{ border:#CCC 1px solid; padding:10px; background:#F0F0F0; }
	.list ul li{ height:20px; line-height:20px; }
	p{ height:40px; line-height:40px; padding-left:100px; }
	p span{ padding:5px; }
	</style>
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <!--当前位置层-->
		<div id="container">
		 <div class="bar"><a href="/">德安网首页</a>＞＞网站检索</div>
		  <s:form namespace="/online" action="advquery" method="post" name="advqueryform" id="advqueryform">
		 <div class="srh">
		 标题：<s:textfield name="title" size="35"/>发布日期：<input name="beginDate" type="text" size="10" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>至<input name="endDate" type="text" size="10" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><input class="btn" name="" type="button" value="检索" onclick="document.advqueryform.submit();"/>
		 </div>
		 <div class="list">
              <s:iterator value="articles">
			   <ul>
			     <li><span>·</span><a href="<s:property value="url"/>" target="_blank"><span class="news"><s:property value="title"/></span></a></li>
			   </ul>              
			  </s:iterator>
			  		   
		   <p class="page"><span>
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
              <s:param name="title" value="%{title}" />
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
		   </span></p>
		 </div>
		 </s:form>
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