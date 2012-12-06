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
      function checkcode_refresh(){
	    var url = '<s:url value = "/checkcode.jpg"/>?nocache='+Math.random();
        $("#checkcode_id").attr("src",url);
        $('#checkcode_input_id').val('');
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
          <div class="current_position"><p><span><strong>当前位置：</strong><a href="/">首页</a>＞<a href="<s:url action='index'/>">在线服务</a></span></p></div>
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
              <a class="current">网上咨询</a>
            </li>
            <li>
              <s:url action="advisorSearch" id="annexUrl" escapeAmp="false"><s:param name="workingId" value="workingId"/><s:param name="organId" value="organId"/></s:url>
              <a href="<s:property value="annexUrl"/>">在线查询</a>
            </li>
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
              <div class="formFieldError" style="margin-left: 10px;font-size: 13px;"><s:actionerror/></div>
              <div class="formMessage" style="margin-left: 10px;font-size: 14px;color: #3300ff;"><s:actionmessage/></div>
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
                    <td align="left" height="32px"><s:textfield name="username" value="ssss"/></td>
                  </tr>
                  <tr style="display:none;">
                    <td width="90px" height="32px">*密码：</td>
                    <td align="left" height="32px"><s:textfield name="password" value="123456"/></td>
                  </tr>
                  <tr>
                    <td colspan="2" height="32px">
                                                          欢迎&nbsp;<font color="red"><s:property value="user.name"/></font>&nbsp;用户&nbsp;&nbsp;
                      <a href="<s:url namespace='/user' action='advisor'/>">[会员中心]</a>&nbsp;&nbsp;
                      <a href="javascript:void(0);" id="logout_id">[退出]</a>
                    </td>
                  </tr>
                </s:else>
                  <tr>
                    <td width="90px">*标题：</td>
                    <td class="formFieldError">
                      <s:textfield id = "title_id" name = "advisor.title"/>
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
