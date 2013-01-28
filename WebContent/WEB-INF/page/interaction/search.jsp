<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>中国·德安欢迎您！</title>
    <link href="<s:url value='/css/dean.css'/>" rel="stylesheet" type="text/css" />
    <script src="<s:url value='/Scripts/swfobject_modified.js'/>" type="text/javascript"></script>
    <script src="<s:url value='/js/changdiv.js'/>" type="text/javascript"></script>
    <script type="text/javascript" src="<s:url value='/source/js/jquery-1.4.2.min.js'/>"></script>
     <style type="text/css">
      <!--
      body {
        margin-top: 0px;
        background: url(/images/xy2009_20.jpg) center top repeat-x;
      }
      -->
    </style>
    <style type="text/css">
      <!--
      .style9 {color: #CC0000}
      .style13 {font-size: 9pt}
      .style15 {color: #FFFFFF}
      .style21 {color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
      .style34 {font-family: Arial, Helvetica, sans-serif}
      .style40 {color: #336600}
      .style41 {color: #FF0000}
      -->
    </style>
   </head>
   <body>
     <div id="container">
       <s:include value="../top.jsp"/>
       <div class="clearfloat"></div>
       <s:include value="../header.jsp"/>
       <div class="clearfloat"></div>
       <!--当前位置层-->
       <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;<a href="<s:url value='/interaction/index.html'/>">公众参与</a>&nbsp;&gt;&gt;&nbsp;信件检索</p>
       </div>
       <!--当前位置层结束-->
       <div class="out_line">
         <div class="in_line">
           <h2 style="margin:0 30px 10px 30px;">信件搜索</h2>
           <div id="list01">
	         <table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
	           <tr>
	             <td width="800" valign="top">
	               <table width="100%"  border="0" cellspacing="0" cellpadding="0">
	                 <tr>
	                   <td class="di_line">
	                     <div align="center" class="hui">
	                       <form action="<s:url value='/interaction/search.html'/>" method="post" name="zmhdsearchform" id="zmhdsearchform">
	                       <table border="0" cellpadding="0" cellspacing="0">
	                         <tr>
	                           <td>
	                             <span style="text-align: left;">关键字：</span>
	                             <s:textfield name="title" size="35"/>
	                             <div class="hui" align ="left" style="padding:8px 0 8px 50px;">
	                             <s:radio list="#{'0':'所有','1':'已回复','2':'未回复'}" name = "type" value="%{type}"/>
	                             </div>
	                           </td>
	                           <td width="100" align="center" valign="top" >
	                             <img src="images/search.gif" width="51" height="35" onclick="document.zmhdsearchform.submit();"/>
	                           </td>
	                         </tr>
	                       </table>
	                       </form>
	                     </div>
	                   </td>
	                 </tr>
	                 <tr>
	                   <td class="zyd_line">
	                     <div align="center">
	                       <br/>
	                       <table width="95%"  border="0" cellspacing="0" cellpadding="0">
	                         <tr>
	                           <td width="60" height="40"><div align="center" class="zongcolor"><strong>编号</strong></div></td>
	                           <td width="50"><div align="center" class="zongcolor"><strong>类型</strong></div></td>
	                           <td><div align="center" class="zongcolor"><strong>内容</strong></div></td>
	                           <td width="110"><div align="center" class="zongcolor"><strong>受理单位</strong></div></td>
	                           <td width="40"><div align="center" class="zongcolor"><strong>状态</strong></div></td>
	                           <td width="70"><div align="center" class="zongcolor"><strong>日期</strong></div></td>
	                         </tr>
	                       </table>
	                       <table width="95%"  border="0" cellspacing="0" cellpadding="0">
	                         <tr>
	                           <td height="1" bgcolor="#F1D68D"></td>
	                         </tr>
	                       </table>
	                       <table width="95%"  border="0" cellpadding="0" cellspacing="0">
	                       <s:iterator value="interactions">
	                         <tr bgcolor="#F9F9F9">
	                           <td width="60" height="40" bgcolor="#F9F9F9" class="xu_di_line">
	                            <div align="center" class="hui">
	                              <s:property value="formatId"/>
	                            </div>
	                           </td>
                               <td width="50" class="xu_di_line">
	                             <div align="center" class="hui">
	                               [<s:if test = "type==1">咨询</s:if><s:if test = "type==2">投诉</s:if><s:if test = "type==3">建议</s:if>]
	                             </div>
	                           </td>
	                           <td class="xu_di_line">
                                 <div align="left" class="news">
                                 <s:url action="detail" id="detailUrl">
                                   <s:param name="id" value="%{id}"/>
                                 </s:url>
                                 <a href="<s:property value="detailUrl"/>" target="_blank"><s:property value="title"/></a>
                                 </div>
                               </td>
                               <td width="110" class="xu_di_line">
                                 <div align="center" class="hui">
                                   <a href="<s:url value='/interaction/organ/search/%{organ.id}.html'/>" target="_blank">
                                   <s:property value="organ.name"/>
                                   </a>
                                 </div>
                               </td>
	                           <td width="40" class="xu_di_line"><div align="center" class="hui style40"><s:property value="state.title"/></div></td>
	                           <td width="70" class="xu_di_line"><div align="center" class="hui"><s:date format="yyyy-MM-dd" name="date"/></div></td>
	                         </tr>
	                         </s:iterator>
	                       </table>
	                       <br/>
				          <div class="page_num">
				            <span>共<s:property value="page.pageCount"/>页</span><span>第<s:property value="page.page"/>页</span>
				            <s:if test="page.pagePrev == -1"><span>上一页</span></s:if>
				            <s:else>
				            <s:url value="/interaction/search/page/%{type}_%{page.pagePrev-1}_%{title}.html" id="pageUrl" escapeAmp="false"/>
				            <a href="<s:property value="pageUrl"/>">上一页</a>
				            </s:else>
				            <s:iterator value="page.pageList">
				            <s:if test = "page.page == top"><span class="act"><s:property value="top"/></span></s:if>
				            <s:else>
				            <s:url value="/interaction/search/page/%{type}_%{top-1}_%{title}.html" id="pageUrl" escapeAmp="false"/>
				            <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
				            </s:else>
				            </s:iterator>
				            <s:if test="page.pageNext == -1"><span>下一页</span></s:if>
				            <s:else>
				            <s:url value="/interaction/search/page/%{type}_%{page.pageNext-1}_%{title}.html" id="pageUrl" escapeAmp="false"/>
				            <a href="<s:property value="pageUrl"/>">下一页</a>
				            </s:else>
				          </div>
						  <div class="clearfloat"></div>
	                    <br/>
	                  </div>
	                </td>
	              </tr>
	            </table>
	          </td>
	        </tr>
	      </table>
	     </div>
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