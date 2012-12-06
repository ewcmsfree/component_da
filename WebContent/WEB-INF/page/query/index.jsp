<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>中国瑞昌网欢迎您！</title>
    <link href="../css/ruichang.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
    <script src="../js/changdiv.js" type="text/javascript"></script>
    <script src="../source/js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script language="JavaScript" type="text/javascript" src="<s:url value="/datepicker/WdatePicker.js"/>"></script>
    <script type="text/javascript">
       function jumpPage(obj){
         var page = obj.options[obj.selectedIndex].text -1 ;
         window.location =  '<s:url action="/component/online/advquery.do"/>?isContent=<s:property value="isContent"/>&title=<s:property value="title"/>&beginDate=<s:property value="beginDate"/>&endDate=<s:property value="endDate"/>&pageNumber=' + page;
       }
    </script>
    </head>
    <body>
        <s:include value="../top.jsp"/>
    	<div id="whole_bg">
  			<div id="content">
            <s:include value="../header.jsp"/>
	<div class="banjiangonshi">
         <div class="current_position"><s:form namespace="/online" action="advquery" method="post" name="advqueryform" id="advqueryform"><select name="isContent" id="isContent">
									<option value="false">标题</option>
									<option value="true">正文和标题</option>
								</select>
								<s:textfield name="title" size="35"/><span class="red"><strong>发布日期<input type="text"  name="beginDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> 至 </strong></span><input type="text"  name="endDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/><img src="images/search.gif" width="51" height="25" onclick="document.advqueryform.submit();"/></s:form></div>
         <div class="gs_list1">
  <table width="100%">
  <tr>
    <th height="25">标题</th>
    <th height="25">所属频道</th>
    <th height="25">发布日期</th>
  </tr>
  <tr>
 <s:iterator value="articles">
											<tr>
											<td  height="25" align="left" bgcolor="#FAFAFA"><a href="<s:property value="url"/>" target="_blank"><span class="news"><s:property value="title"/></span></a></td>
											<td height="25" align="center" bgcolor="#FAFAFA"><s:property value="channelName"/></td>
											<td height="25" align="center" bgcolor="#FAFAFA"><s:property value="published"/></td>
											</tr>
										</s:iterator>
 </table>
         </div>
		 <p class="page">
		 共
													<s:property value="page.pageCount" />
													页&nbsp;当前为第
													<s:property value="page.page" />
													页&nbsp;
													<s:if test="page.pagePrev == -1">
                                                            上一页
                                                        </s:if>
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
														<s:if test="page.page == top">
															<strong><s:property value="top" /></strong>
														</s:if>
														<s:else>
															<s:url action="advquery" id="pageUrl" escapeAmp="false">
																<s:param name="isContent" value="%{isContent}" />
																<s:param name="title" value="%{title}" />
																<s:param name="beginDate" value="%{beginDate}" />
																<s:param name="endDate" value="%{endDate}" />
																<s:param name="pageNumber" value="%{top-1}"/>
															</s:url>
															<a href="<s:property value="pageUrl"/>"><s:property
																	value="top" /></a>
														</s:else>&nbsp;
                                                        </s:iterator>
													<s:if test="page.pageNext == -1">
                                                            下一页
                                                        </s:if>
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
													&nbsp;转到 <select name="select" class="hui"
														onchange="jumpPage(this)">
														<s:iterator value="page.pageListAll">
															<s:if test="page.page == top">
																<option  selected="selected">
																	<s:property value="top" />
																</option>
															</s:if>
															<s:else>
																<option>
																	<s:property value="top" />
																</option>
															</s:else>
														</s:iterator>
													</select>页
		 </p>
       </div>
	   </div>
<!--脚注信息-->
  <div class="clearfloat"></div>
   <!--页脚-->
  <s:include value="../footer.jsp"/>
</div>
<script type="text/javascript">
    //swfobject.registerObject("FlashID");
</script>
</body>
</html>
