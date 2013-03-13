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
      function checkcode_refresh(){
	    var url = '<s:url value = "/checkcode.jpg"/>?nocache='+Math.random();
        $("#checkcode_id").attr("src",url);
        $('#checkcode_input_id').val('');
      }
    </script>
  </head>
  <body>
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/online/index.html'/>">在线服务</a>&nbsp;&gt;&gt;&nbsp;<s:property value="matter.name"/></p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <h5><s:property value="working.name"/></h5>
          <ul class="sub_program">
            <s:if test="working.matter!=null">
            <li>
              <s:url value="/online/matter/%{organId}_%{workingId}.html" id="matterUrl" escapeAmp="false"/>
              <a href="<s:property value="matterUrl"/>">办事指南</a>
            </li>
            </s:if>
            <li><a href="http://218.65.5.117:8008/outportal/index.jsp">网上申报</a></li>
            <s:if test="working.matter!=null">
            <li class="current"><a href="http://218.65.5.117:8008/outportal/outquery/outquery.jsp">网上咨询</a></li>
            <li>
              <!-- 
              <s:url value="/online/advisorsearch/%{organId}_%{workingId}.html" id="advisorsearchUrl" escapeAmp="false"/>
              <a href="<s:property value="advisorsearchUrl"/>">在线查询</a>
              -->
              <a href="http://218.65.5.117:8008/outportal/outquery/outquerylist.jsp">在线查询</a>
            </li>
            <s:if test="!working.matter.matterAnnexs.isEmpty()">
            <li>
              <s:url value="/online/matterannex/%{organId}_%{workingId}.html" id="annexUrl" escapeAmp="false"/>
              <a href="<s:property value="annexUrl"/>">表格下载</a>
            </li>
            </s:if>
            </s:if>
          </ul>
          <div class="clearfloat"></div>
            <div class="guide_box">
              <s:form namespace="/online" id="advisor" name="advisor" action="advisorEdit" method="post">
                <table  border="0" cellspacing="0" cellpadding="0" class="formtable1" align="center">
                <s:if test="!login">
                  <tr id="username_id">
                    <td width="90px" height="32px">*用户名：</td>
                    <td align="left" height="32px" class="formFieldError">
                      <s:textfield name="username"/>
                      &nbsp;&nbsp;<a href="<s:url action="register" namespace="/user"/>" target="_blank">注册会员</a>
                      <s:fielderror ><s:param value="%{'username'}" /></s:fielderror>
                    </td>
                  </tr>
                  <tr id="password_id" class="formFieldError">
                    <td width="90px" height="32px">*密码：</td>
                    <td align="left" height="32px">
                      <s:password name="password"/>
                      <s:fielderror ><s:param value="%{'password'}" /></s:fielderror>
                    </td>
                  </tr>
                </s:if>
                <s:else>
                  <tr style="display:none;">
                    <td width="90px" height="32px">*用户名：</td>
                    <td align="left" height="32px"><s:textfield name="username"/></td>
                  </tr>
                  <tr style="display:none;">
                    <td width="90px" height="32px">*密码：</td>
                    <td align="left" height="32px"><s:textfield name="password"/></td>
                  </tr>
                  <tr>
                    <td colspan="2" height="32px">欢迎&nbsp;<font color="red"><s:property value="user.name"/></font>&nbsp;用户&nbsp;&nbsp;
                      <a href="<s:url namespace='/user' action='advisor'/>">[会员中心]</a>&nbsp;&nbsp;
                      <a href="javascript:void(0);" id="logout_id">[退出]</a>
                    </td>
                  </tr>
                </s:else>
                  <tr>
                    <td width="90px">*标题：</td>
                    <td align="left" class="formFieldError">
                      <s:textfield id="title_id" name="advisor.title"/>
                      <s:fielderror ><s:param value="%{'advisor.title'}" /></s:fielderror>
                    </td>
                  </tr>
                  <tr>
                    <td width="90px">*咨询内容：</td>
                    <td class="formFieldError">
                      <s:textarea name = "advisor.content" cols="56" rows="8"/>
                      <s:fielderror ><s:param value="%{'advisor.content'}" /></s:fielderror>
                    </td>
                  </tr>
                  <tr>
                    <td width="90px" valign="top" style="padding-top: 20px;">*验证码：</td>
                    <td align="left" class="formFieldError">
                      <img id="checkcode_id" src="<s:url value="/checkcode.jpg"/>" alt="验证码"/><a href="javascript:checkcode_refresh()" id="checkcode_refresh_id">看不清,换一张</a><br/>
                      <s:textfield name="checkcode" id="checkcode_input_id"/>
                      <div class="hui">验证码不区分大小写</div>
                      <s:fielderror ><s:param value="%{'checkcode'}" /></s:fielderror>
                    </td>
                  </tr>
                </table>
                <s:hidden name="organId"/>
                <s:hidden name="workingId"/>
              </s:form>
              <div align="center" style="margin-top: 10px"><input type="button" value="提交" class="btn_submit" onclick="document.advisor.submit();"/></div>
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
