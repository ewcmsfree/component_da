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
        <p class="position"><span>当前位置：</span><a href="#">首页</a>&nbsp;&gt;&gt;&nbsp;公众参与</p>
      </div>
      <!--当前位置层结束-->
      <!--内容层-->
      <div id="gzcy_container">
        <!--侧边栏-->
        <div class="gzcy_left">
        	<iframe src="/qiantaomoban/interaction/qian_left/index.html" width="100%" height="580" frameborder="0" scrolling="no"> 
            	<a href="/qiantaomoban/interaction/qian_left/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
          	</iframe>
        </div>
        <!--侧边栏结束-->
        <!--主栏-->
        <div class="gzcy_main">
          <div class="out_line">
            <div class="in_line">
              <div class="mstd">
                <div class="mstd_tit">民声通道</div>
                <div class="letter_search">
                  <form action="<s:url value='/interaction/search.html'/>" name="zmhdsearchform" method="post">
                    <input class="srh_text" name="title" type="text" value="信件查询" size="20" onclick="this.value=''"/>
                    <input class="srh_but" type="submit" value="搜索"/>
                  </form>
                </div>
                <div class="clearfloat"></div>
                <div class="letter_tag">
                  <ul>
                    <li><a href="<s:url action='interaction'/>">我要写信</a></li>
                    <li><a href="/gongzhongcanyu/shiyongshuoming">使用说明</a></li>
                  </ul>
                </div>
                <div class="clearfloat"></div>
                <div class="letter_tab">
                  <ul>
                    <li id="letter1" onmouseover="ChangeFoldern(this,'letter','3','current','');" class="current"><a href="<s:url value='/interaction/list/3.html'/>">建言献策</a></li>
                    <li id="letter2" onmouseover="ChangeFoldern(this,'letter','3','current','');"><a href="<s:url value='/interaction/list/1.html'/>">在线咨询</a></li>
                    <li id="letter3" onmouseover="ChangeFoldern(this,'letter','3','current','');"><a href="<s:url value='/interaction/list/2.html'/>">投诉监督</a></li>
                  </ul>
                </div>
                <div class="clearfloat"></div>
                <div id="tletter1" class="letter_list_box">
                  <table>
                    <tr>
                      <td class="bh1">编号</td>
                      <td class="bt1">标题</td>
                      <td class="sj1">时间</td>
                    </tr>
                    <s:iterator value="interactionXcs">
                    <tr>
                      <td class="cen"><s:property value="formatId"/></td>
                      <td class="ct">
                        <s:url value="/interaction/detail/%{id}.html" id="detailUrl"/>
                        <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
                      </td>
                      <td class="cen"><s:date format="yyyy-MM-dd" name="date"/></td>
                    </tr>
                    </s:iterator>   
                  </table>
                </div>
                <div id="tletter2" class="letter_list_box" style="display:none;">
                  <table>
                    <tr>
                      <td class="bh1">编号</td>
                      <td class="bt1">标题</td>
                      <td class="sj1">时间</td>
                    </tr>
                    <s:iterator value="interactionZxs">
                    <tr>
                      <td class="cen"><s:property value="formatId"/></td>
                      <td class="ct">
                        <s:url value="/interaction/detail/%{id}.html" id="detailUrl"/>
                        <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
                      </td>
                      <td class="cen"><s:date format="yyyy-MM-dd" name="date"/></td>
                    </tr>
                    </s:iterator>   
                  </table>
                </div>
                <div id="tletter3" class="letter_list_box" style="display:none;">
                  <table>
                    <tr>
                      <td class="bh1">编号</td>
                      <td class="bt1">标题</td>
                      <td class="sj1">时间</td>
                    </tr>
                    <s:iterator value="interactionTss">
                    <tr>
                      <td class="cen"><s:property value="formatId"/></td>
                      <td class="ct">
                        <s:url value="/interaction/detail/%{id}.html" id="detailUrl"/>
                        <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
                      </td>
                      <td class="cen"><s:date format="yyyy-MM-dd" name="date"/></td>
                    </tr>
                    </s:iterator>  
                  </table>
                </div>
              </div>
              <div class="right_box">
                <div class="right_tab">
                  <ul>
                    <li id="huifu1" onmouseover="ChangeFoldern(this,'huifu','2','current','');" class="current">回复排行</li>
                    <li id="huifu2" onmouseover="ChangeFoldern(this,'huifu','2','current','');">未回复提示</li>
                  </ul>
                </div>
                <div class="clearfloat"></div>
                <div id="thuifu1" class="huifu_box">
                  <table>
                    <s:iterator value="backCount">
                    <tr>
                      <td class="t1"><a href="<s:url value='/interaction/organ/search/%{id}.html'/>" target="_blank"><s:property value="name"/></a></td>
                      <td class="t2"><s:property value="backRatio"/></td>
                    </tr>
                    </s:iterator>
                  </table>
                </div>
                <div id="thuifu2" class="huifu_box" style="display:none;">
                  <table>
                    <s:iterator value="noBackCount">
                    <tr>
                      <td class="t1"><a href="<s:url value='/interaction/organ/search/%{id}.html'/>" target="_blank"><s:property value="name"/></a></td>
                      <td class="t2"><s:property value="backRatio"/></td>
                    </tr>
                    </s:iterator>
                  </table>
                </div>
                <div class="clearfloat"></div>
                <!--网上调查列表/民意征集列表-->
                <iframe src="/qiantaomoban/interaction/qian_wsdc/index.html" width="100%" height="100%" frameborder="0" scrolling="no"> 
            		<a href="/qiantaomoban/interaction/qian_wsdc/index.html">你的浏览器不支持iframe页面嵌套，请点击这里访问页面内容。</a> 
          		</iframe>
                <!--网上调查列表/民意征集列表结束-->
              </div>
              <div class="clearfloat"></div>
            </div>
          </div>
        </div>
      </div>
      <!--主栏结束-->
      <div class="clearfloat"></div>
      <s:include value="../footer.jsp"/>
      <script type="text/javascript">
        swfobject.registerObject("FlashID");
      </script>
    </div>
  </body>
</html>