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
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;>>&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;>>&nbsp;<s:property value="working.name"/></p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <h5><s:property value="working.name"/></h5>
          <ul class="sub_program">
            <s:if test="working.matter!=null">
            <li class="current">办事指南</li>
            </s:if>
            <li>
              <a href="http://218.87.91.208:8008/outportal">网上申报</a>
            </li>
            <s:if test="working.matter!=null && organId!=0">
            <li>
              <s:url value="/online/advisor/%{organId}_%{workingId}.html" id="advisorUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorUrl"/>">网上咨询</a></li>
            <li>
              <s:url value="/online/advisorsearch/%{organId}_%{workingId}.html" id="advisorsearchUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorsearchUrl"/>">在线查询</a>
            </li>
            </s:if>
            <s:if test="working.matter!=null && !working.matter.matterAnnexs.isEmpty()">
            <li>
              <s:url value="/online/matterannex/%{organId}_%{workingId}.html" id="annexUrl" escapeAmp="false"/>
              <a href="<s:property value="annexUrl"/>">表格下载</a>
            </li>
            </s:if>
          </ul>
          <div class="clearfloat"></div>
          <div class="guide_box">
            <s:if test="matter.acceptedWay != null">
	          <p class="guide_tit">受理方式</p>
	          <p class="guide_text"><s:property value="matter.acceptedWay" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.handleSite != null">
	          <p class="guide_tit">办理理地点</p>
	          <p class="guide_text"><s:property value="matter.handleSite" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.handleBasis != null">
	          <p class="guide_tit">办理依据</p>
	          <p class="guide_text"><s:property value="matter.handleBasis" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.handleWay != null">
	          <p class="guide_tit">审批、服务数量及方式</p>
	          <p class="guide_text"><s:property value="matter.handleWay" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.acceptedCondition != null">
	          <p class="guide_tit">受理条件</p>
	          <p class="guide_text"><s:property value="matter.acceptedCondition" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.petitionMaterial != null">
	          <p class="guide_tit">申请材料</p>
	          <p class="guide_text"><s:property value="matter.petitionMaterial" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.handleCourse != null">
	          <p class="guide_tit">办理程序</p>
	          <p class="guide_text"><s:property value="matter.handleCourse" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.timeLimit != null">
	          <p class="guide_tit">法定时限</p>
	          <p class="guide_text"><s:property value="matter.timeLimit" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.deadline != null"> 
	          <p class="guide_tit">承诺期限</p>
	          <p class="guide_text"><s:property value="matter.deadline" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.fees != null">
	          <p class="guide_tit">收费标准:</p>
	          <p class="guide_text"><s:property value="matter.fees" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.feesBasis != null"> 
	          <p class="guide_tit">收费依据</p>
	          <p class="guide_text"><s:property value="matter.feesBasis" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.consultingTel != null"> 
	          <p class="guide_tit">咨询电话</p>
	          <p class="guide_text"><s:property value="matter.consultingTel" escape="false"/></p>
	        </s:if>
	        <s:if test="matter.contactName != null"> 
	          <p class="guide_tit">联系人姓名及方式</p>
	          <p class="guide_text"><s:property value="matter.contactName" escape="false"/></p>
	        </s:if> 
	    	<s:if test="matter.email != null">
	    	  <p class="guide_tit">E—MAIL</p>
	          <p class="guide_text"><s:property value="matter.email" escape="false"/></p>
	    	</s:if>
          </div>
        </div>
      </div>
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>
