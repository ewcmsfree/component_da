<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--顶部信息栏-->
<script src="/js/accessbar.js" type="text/javascript"></script>
<div id="top_inf">
  <div class="top_l">德安县人民政府网站<span>欢迎您！</span></div>
  <div class="top_r">
    <ul>
      <li><a name="gb2big5" id="gb2big5">繁體中文</a></li>
      <li><a href="javascript:void(0);" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.dean.gov.cn/');">设为首页</a></li>
      <li><a href="javascript:void(0);" onClick="window.external.addFavorite('http://www.dean.gov.cn/','德安县人民政府网')">加入收藏</a></li>
      <li><a href="/component/rss.html" target="_blank">RSS订制</a></li>
      <li><a id="zoom" title="无障碍浏览工具" onclick="kqNav();" href="javascript:;">无障碍浏览</a></li>
    </ul>
  </div>
  <div class="top_srh">
    <form name="searchform" method="get" action="/search/search.jsp" target="_blank">
      <input type="hidden" name="lang" value="zh"/>
      <input type="hidden" name="hitsPerSite" value="0"/>
      <input type="hidden" name="clustering" value=""/>
      <input class="srh_area" name="query" type="text" value="请输入关键字" onclick="this.value='';"/>
      <input class="button1" name="button" type="submit" value="搜索"/>
      <input class="button1" name="advbutton" type="button" value="高级检索" onclick="window.open('/component/online/advquery.do');"/>
    </form>
   </div>
 </div>
<script src="/js/gb2big5.js" type="text/javascript"></script> 
<div class="clearfloat"></div>