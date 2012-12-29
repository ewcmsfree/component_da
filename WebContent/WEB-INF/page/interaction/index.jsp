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
          <div class="left_btn">
            <ul>
              <li><a href="#">县长信箱</a></li>
              <li><a href="#">县长热线</a></li>
              <li><a href="#">民声直通车</a></li>
              <li><a href="#">网上信访</a></li>
              <li><a href="#">提案议案</a></li>
            </ul>
          </div>
          <div class="zxft_box">
            <p class="zxft_btn"></p>
            <ul class="zxft_tab">
              <li id="subft1" onmouseover="ChangeFoldern(this,'subft','3','current','');" class="current">最新访谈</li>
              <li id="subft2" onmouseover="ChangeFoldern(this,'subft','3','current','');">访谈预告</li>
              <li id="subft3" onmouseover="ChangeFoldern(this,'subft','3','current','');"><a href="#">访谈回顾</a></li>
            </ul>
            <div class="clearfloat"></div>
            <!--最新访谈盒子-->
            <div id="tsubft1" class="ft_subbox">
              <p><img src="../images/ft_pic.jpg" width="220" height="147" /></p>
              <p><b>访谈主题：</b>喜迎十八大，志愿我先行</p>
              <p><b>访谈嘉宾：</b>市委书记：江凌</p>
              <p><b>访谈时间：</b>2012-12-03  15：00</p>
              <p style="padding-left:70px;"><a href="#">进入文字实录&gt;&gt;</a></p>
            </div>
            <!--最新访谈盒子结束-->
            <!--访谈预告盒子-->
            <div id="tsubft2" class="ft_subbox" style="display:none;">
              <p><img src="../images/ft_pic.jpg" width="220" height="147" /></p>
              <p><b>访谈主题：</b>喜迎十八大，志愿我先行喜迎十八大，志愿我</p>
              <p><b>访谈嘉宾：</b>市委书记：江凌</p>
              <p><b>访谈时间：</b>2012-12-03  15：00</p>
              <p style="padding-left:70px;"><a href="#">进入直播室&gt;&gt;</a></p>
            </div>
            <!--访谈预告盒子结束-->
            <!--访谈回顾盒子-->
            <div id="tsubft3" class="ft_subbox" style="display:none;">
              <ul>
                <li><a href="#">叶心林等县领导节走访慰</a></li>
                <li><a href="#">县政协主席高茂木视小区物</a></li>
                <li><a href="#">我县召开2012年四次全体</a></li>
                <li><a href="#">县一小师生共庆教师节</a></li>
                <li><a href="#">县检察院干警机关法律文书</a></li>
                <li><a href="#">叶心林等县领导节走访慰</a></li>
                <li><a href="#">县检察院干警机关法律文书</a></li>
                <li><a href="#">叶心林等县领导节走访慰</a></li>
              </ul>
            </div>
            <!--访谈回顾盒子结束-->
            <!--访谈预告盒子-->
          </div>
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
                    <li><a href="#">使用说明</a></li>
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
                <div class="right_tab" style="margin-top:10px;">
                  <ul>
                    <li id="fazhan1" onmouseover="ChangeFoldern(this,'fazhan','2','current','');" class="current">网上调查</li>
                    <li id="fazhan2" onmouseover="ChangeFoldern(this,'fazhan','2','current','');">民意征集</li>
                  </ul>
                </div>
                <div class="clearfloat"></div>
                <!--网上调查列表-->
                <ul id="tfazhan1" class="lis02">
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                  <li><a href="#">县政协主席高茂木视小区物</a></li>
                  <li><a href="#">我县召开2012年四次全体</a></li>
                  <li><a href="#">县一小师生共庆教师节</a></li>
                  <li><a href="#">县检察院干警机关法律文书</a></li>
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                  <li><a href="#">县检察院干警机关法律文书</a></li>
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                </ul>
                <!--网上调查列表结束-->
                <!--民意征集列表-->
                <ul id="tfazhan2" class="lis02" style="display:none;">
                  <li><a href="#">县检察院干警机关法律文书</a></li>
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                  <li><a href="#">县检察院干警机关法律文书</a></li>
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                  <li><a href="#">叶心林等县领导节走访慰</a></li>
                  <li><a href="#">县政协主席高茂木视小区物</a></li>
                  <li><a href="#">我县召开2012年四次全体</a></li>
                  <li><a href="#">县一小师生共庆教师节</a></li>
                </ul>
                <!--民意征集列表结束-->
                <div class="clearfloat"></div>
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