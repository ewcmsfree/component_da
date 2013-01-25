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
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <!--当前位置层-->
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;在线服务</p>
      </div>
      <!--当前位置层结束-->
      <!--内容层-->
      <div class="zxbs_containt">
      <!--在线办事左边栏-->
      <div class="zxbs_left">
        <iframe src="/qiantaomoban/online/qian_left/index.html" width="100%" height="100%" frameborder="0" scrolling="no"> 
          <a href="/qiantaomoban/online/qian_left/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
        </iframe>
      </div>
      <!--在线办事左边栏结束-->
      <div class="zxbs_main">
      <!--场影导航盒子-->
      <div class="out_line">
        <iframe src="/qiantaomoban/online/qian_cjfw/index.html" width="100%" height="100%" frameborder="0" scrolling="no"> 
        	<a href="/qiantaomoban/online/qian_cjfw/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
        </iframe>
      </div>
      <!--场影导航盒子结束-->
      <!--市民、企业办事盒子-->
	  <s:iterator value = "workings" id="working" status="st">
	  <div class="smbs_box">
	    <div class="bs_tit_search"> 	
	      <p class="bs_tit" style="float:left;"><s:property value="#working.name"/></p>
	      <!-- 出现页面报错-->
	      <s:if test="#st.index==0">
	      <form action="search.do" method="post" name="onlineform" id="onlineform" style="float:right;">
	        <input class="srh_text" name="key" type="text" />
	        <select class="srh_list" name="selectId" size="1">
	          <option value="1">事项</option>
	          <option value="2">表格</option>
	        </select>
	        <input class="srh_but" type="submit" value="搜索" />
	      </form>
		  </s:if>
	    </div>
	    <div class="clearfloat"></div>
        <ul class="bs_list">
	      <s:iterator value="children" id="child">
	      <s:if test="id != null">                
	      <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
          <li><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></li>
	      </s:if>              
	      </s:iterator>         
	    </ul>
	    <div class="clearfloat"></div>
	  </div>
      </s:iterator>
      <!--市民、企业办事盒子结束-->
      <!--部门办事盒子-->
      <div class="smbs_box">
        <p class="bs_tit">部门办事</p>
        <ul class="bs_list">
        <s:iterator value="organs" status="st">              
        <s:if test="id != null">                
        <s:url value="/online/organ/%{id}.html" id="organUrl" escapeAmp="false"/>
          <li><a href="<s:property value="organUrl"/>" target="_blank"><s:property value="name"/></a></li>              
        </s:if>            
        </s:iterator>
        </ul>
        <div class="clearfloat"></div>
      </div>
      <!--部门办事盒子结束-->
      <!--办件公示盒子-->
      <div class="bjgs_box">
        <iframe src="/qiantaomoban/online/qian_bs/index.html" width="100%" height="240" frameborder="0" scrolling="no"> 
          <a href="/qiantaomoban/online/qian_bs/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
        </iframe>
      </div>
      <!--办件公示盒子结束-->
    </div>
    <div class="clearfloat"></div>
  </div>
  <!--内容层结束-->
  <s:include value="../footer.jsp"/>
 </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>
