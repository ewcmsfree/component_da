<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>中国瑞昌网为您服务！</title>
    <link href="../css/ruichang.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
    <script src="../js/changdiv.js" type="text/javascript"></script>
    <script src="../source/js/jquery-1.4.2.min.js" type="text/javascript"></script>
     <style type="text/css">
      <!--
      body {
        margin-top: 0px;
        background: url(/images/xy2009_20.jpg) center top repeat-x;
      }
      -->
    </style>
    <link href="<s:url value="/css/ruichang.css"/>" rel="stylesheet" type="text/css" />
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
    <script type="text/JavaScript">
      function jumpPage(obj){
        var page = obj.options[obj.selectedIndex].text -1 ;
        window.location = '<s:url action="search"/>?type=<s:property value="type"/>&title=<s:property value="title" escape="false"/>&pageNumber=' + page ;
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
         <div id="list01">
           <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
             <tr>
               <td width="750" valign="top">
                 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td class="di_line">
                       <div align="center" class="hui">
                         <s:form action="search" method="post" name="zmhdsearchform" id="zmhdsearchform">
                         <table border="0" cellpadding="0" cellspacing="0">
                           <tr>
                             <td>
                               <span style="text-align: left;">关键字：</span>
                               <s:textfield name="title" size="35"/>
                               <div class="hui" align ="left" style="padding:8px 0 8px 50px;">
                               <s:radio list="#{'0':'所有','1':'已回复','2':'未已回复'}" name = "type" value="%{type}"/>
                               </div>
                             </td>
                             <td width="100" align="center" valign="top" >
                               <img src="images/search.gif" width="51" height="35" onclick="document.zmhdsearchform.submit();"/>
                             </td>
                           </tr>
                         </table>
                         </s:form>
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
                                 <a href="<s:url action="organsearch"/>?id=<s:property value="organ.id"/>" target="_blank">
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
                         <table width="95%"  border="0" cellspacing="0" cellpadding="0">
                           <tr>
                             <td height="30" bgcolor="#F2F2F2" class="li_line">
                               <div align="center" class="hui">共<s:property value="page.pageCount"/>页&nbsp;当前为第<s:property value="page.page"/>页&nbsp;
                               <s:if test="page.pagePrev == -1">上一页</s:if>
                               <s:else>
                               <s:url action="search" id="pageUrl" escapeAmp="false">
                                 <s:param name="type" value="%{type}"/>
                                 <s:param name="title" value="%{title}"/>
                                 <s:param name="pageNumber" value="%{page.pagePrev-1}"/>
                               </s:url>
                                 <a href="<s:property value="pageUrl"/>">上一页</a>
                               </s:else>
                               <s:iterator value="page.pageList">
                                 <s:if test = "page.page == top">
                                 <strong><s:property value="top"/></strong>
                                 </s:if>
                                 <s:else>
                                   <s:url action="search" id="pageUrl" escapeAmp="false">
                                     <s:param name="type" value="%{type}"/>
                                     <s:param name="title" value="%{title}"/>
                                     <s:param name="pageNumber" value="%{top-1}"/>
                                   </s:url>
                                   <a href="<s:property value="pageUrl"/>"><s:property value="top"/></a>
                                 </s:else>&nbsp;
                               </s:iterator>
                              <s:if test="page.pageNext == -1">下一页</s:if>
                              <s:else>
                                <s:url action="search" id="pageUrl" escapeAmp="false">
                                  <s:param name="type" value="%{type}"/>
                                  <s:param name="title" value="%{title}"/>
                                  <s:param name="pageNumber" value="%{page.pageNext-1}"/>
                                </s:url>
                                <a href="<s:property value="pageUrl"/>">下一页</a>&nbsp;转到
                              </s:else>
                              <select name="select" class="hui" onchange="jumpPage(this)">
                              <s:iterator value="page.pageListAll">
                                <s:if test = "page.page == top">
                                <option selected="selected"><s:property value="top"/></option>
                                </s:if>
                                <s:else>
                                <option><s:property value="top"/></option>
                                </s:else>
                              </s:iterator>
                              </select>页
                            </div>
                          </td>
                        </tr>
                      </table>
                      <br/>
                    </div>
                  </td>
                </tr>
              </table>
            </td>
            <td width="5"></td>
          </tr>
        </table>
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