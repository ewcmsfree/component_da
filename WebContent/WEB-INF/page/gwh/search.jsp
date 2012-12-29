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
    <script src="<s:url value="/datepicker/WdatePicker.js"/>" type="text/javascript"></script>
    <script src="<s:url value='/source/js/jquery-1.4.2.min.js'/>" type="text/javascript"></script>
    <script type="text/JavaScript">
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
    <div id="container">
      <s:include value="../top.jsp"/>
      <div class="clearfloat"></div>
      <s:include value="../header.jsp"/>
      <div class="clearfloat"></div>
      <!--当前位置层-->
      <div class="pos_box">
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;公文检索</p>
      </div>
      <div class="out_line">
        <div class="in_line">
          <s:form action="searchresult" namespace="/interaction" target="_blank">
            <div class="article_box1">
              <div class="art_text">
                <table width="80%" align="center">
                  <tr>
	                <td>检索时间:</td>
                    <td>从<input type="text"  name="beginDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>至<input type="text"  name="endDate" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
                  </tr>
			      <tr>
				    <td>检索方式:</td>
				    <td>
				      <select name="searchRange">
						<option value=1>文件标题</option>
                        <option value=2>文件内容</option>
                        <option value=3>文号</option>
					  </select>
				    </td>
			      </tr>
			      <tr>
				    <td>检索范围:</td>
				    <td>
					  <s:select list="gwhChannelList" listValue="channelName" listKey="id" name="searchChannel"></s:select>
				    </td>
				  </tr>
			      <tr>
				    <td>查找关键字:</td>
				    <td><s:textfield name="searchKey" size="50"/></td>
			      </tr>
		        </table>
		        <br/>
		        <hr/>
		        <center><input type="submit" value="提  交 "/>    <input type="reset" value="重  置 "/></center>
		      </div>
            </div>
    	  </s:form>
	    </div>
      </div>
      <!--内容层结束-->
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>