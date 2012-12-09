<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中国·德安欢迎您！</title>
    <link href="../css/ruichang.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
    <script src="../js/changdiv.js" type="text/javascript"></script>
    <script src="../source/js/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script type="text/JavaScript">
                $(function(){
                   
                });
                function jumpPage(obj){
                    var page = obj.options[obj.selectedIndex].text -1 ;
                    window.location = ' <s:url action="index"/>?type=<s:property value="type"/>&pageNumber=' + page ;
                }
                function findAll(){
                    window.location = '<s:url action="index"/>?type=0' ;
                }
                function findReplay(){
                    window.location = '<s:url action="index"/>?type=1' ;
                }
                function findNoReplay(){
                    window.location = '<s:url action="index"/>?type=2' ;
                }
        </script>
    </head>
    <body>
        <s:include value="../top.jsp"/>
    	<div id="whole_bg">
  			<div id="content">
            <s:include value="../header.jsp"/>
			<div class="article_box1">
     		<div class="art_text">
			<h3> 检索文件结果</h3>
            <hr/>
			<div class="clearfloat"></div>
       <ul class="zw_list1 h_min2 w1">
	   <s:iterator value="articleList">
              <li><a href="<s:property value="url"/>" target="_blank"><s:property value="title"/></a></li>
		</s:iterator>    
       </ul> 
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
																<option selected>
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
	           <br/>
            <s:include value="../footer.jsp"/>
	</div>
</body>
</html>