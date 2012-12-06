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
          <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">在线服务</a>＞<s:property value="matter.name"/></span></p></div>
          <div class="clearfloat"></div>
          <h5><s:property value="working.name"/></h5>
          <ul class="pro">
            <s:if test="working.matter!=null">                                          　　　　　
            <li>
              <a class="current">办事指南</a>
            </li>
            </s:if>
            <li>
              <a href="http://218.87.91.208:8008/outportal">网上申报</a>
            </li>
            <s:if test="working.matter!=null && organId != 0">
            <li>
              <s:url action = "advisor" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">网上咨询</a></li>
            <li>
              <s:url action = "advisorSearch" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">在线查询</a>
            </li>
            </s:if>
            <s:if test="working.matter!=null && !working.matter.matterAnnexs.isEmpty()">
            <li>
              <s:url action="matterannex" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">表格下载</a>
            </li>
            </s:if>
          </ul>
          <div class="clearfloat"></div>
          <s:if test="matter.acceptedWay != null">
          <div class="bs_box">
            <strong>受理方式</strong>
            <p><s:property value="matter.acceptedWay" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.handleSite != null">
          <div class="bs_box">
            <strong>办理理地点</strong>
            <p><s:property value="matter.handleSite" escape="false"/></p>
          </div> 
          </s:if>
          <s:if test="matter.handleBasis != null">
          <div class="bs_box">
            <strong>办理依据</strong>
            <p><s:property value="matter.handleBasis" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.handleWay != null">
          <div class="bs_box">
            <strong>审批、服务数量及方式</strong>
            <p><s:property value="matter.handleWay" escape="false"/></p>
          </div> 
          </s:if>
          <s:if test="matter.acceptedCondition != null">
          <div class="bs_box">
            <strong>受理条件</strong>
            <p><s:property value="matter.acceptedCondition" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.petitionMaterial != null">
          <div class="bs_box">
            <strong>申请材料</strong>
            <p><s:property value="matter.petitionMaterial" escape="false"/></p>
          </div> 
          </s:if>
          <s:if test="matter.handleCourse != null">
          <div class="bs_box">
            <strong>办理程序</strong>
            <p><s:property value="matter.handleCourse" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.timeLimit != null">
          <div class="bs_box">
            <strong>法定时限</strong>
            <p><s:property value="matter.timeLimit" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.deadline != null"> 
          <div class="bs_box">
            <strong>承诺期限</strong>
            <p><s:property value="matter.deadline" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.fees != null">
          <div class="bs_box">
            <strong>收费标准:</strong>
            <p><s:property value="matter.fees" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.feesBasis != null"> 
          <div class="bs_box">
            <strong>收费依据</strong>
            <p><s:property value="matter.feesBasis" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.consultingTel != null"> 
          <div class="bs_box">
            <strong>咨询电话</strong>
            <p><s:property value="matter.consultingTel" escape="false"/></p>
          </div>
          </s:if>
          <s:if test="matter.contactName != null"> 
          <div class="bs_box">
            <strong>联系人姓名及方式</strong>
            <p><s:property value="matter.contactName" escape="false"/></p>
          </div>
          </s:if> 
    	  <s:if test="matter.email != null">
    	  <div class="bs_box">
    	    <strong>E—MAIL</strong>
            <p><s:property value="matter.email" escape="false"/></p>
          </div>
    	  </s:if>
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
