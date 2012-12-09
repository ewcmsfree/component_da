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
        <p class="position"><span>当前位置：</span><a href="/">首页</a>&nbsp;&gt;&gt;&nbsp;在线服务</p>
      </div>
      <!--当前位置层结束-->
      <!--内容层-->
      <div class="zxbs_containt">
      <!--在线办事左边栏-->
      <div class="zxbs_left">
          <div class="out_line">
            <div class="in_line" style=" padding:7px; ">
              <!--左边盒子-->
              <div class="box06">
                <p class="l_tit01">公共服务</p>
                <ul>
                  <li><a href="#">文化教育</a></li>
                  <li><a href="#">社会保障</a></li>
                  <li><a href="#">就业服务</a></li>
                  <li><a href="#">医疗卫生</a></li>
                  <li><a href="#">交通出行</a></li>
                  <li><a href="#">公用事业</a></li>
                </ul>
                <div class="clearfloat"></div>
              </div>
              <!--左边盒子结束-->
              <!--左边盒子-->
              <div class="box06">
                <p class="l_tit02">绿色通道</p>
                <ul>
                  <li><a href="#">社区服务</a></li>
                  <li><a href="#">三农服务</a></li>
                  <li><a href="#">妇女儿童</a></li>
                  <li><a href="#">军人服务</a></li>
                  <li><a href="#">残疾人服务</a></li>
                  <li><a href="#">公用事业</a></li>
                </ul>
                <div class="clearfloat"></div>
              </div>
              <!--左边盒子结束-->
              <!--左边盒子-->
              <div class="box06">
                <p class="l_tit03">便民查询</p>
                <ul>
                  <li><a href="#">常用电话</a></li>
                  <li><a href="#">部门电话</a></li>
                  <li><a href="#">公积金查询</a></li>
                  <li><a href="#">列车时刻</a></li>
                  <li><a href="#">话费查询</a></li>
                  <li><a href="#">违章查询</a></li>
                  <li><a href="#">学校查询</a></li>
                  <li><a href="#">学历查询</a></li>
                  <li><a href="#">邮编查询</a></li>
                  <li><a href="#">股票查询</a></li>
                  <li><a href="#">公交查询</a></li>
                  <li><a href="#">网络测试</a></li>
                  <li><a href="#">医务人员</a></li>
                  <li><a href="#">IP查询</a></li>
                </ul>
                <div class="clearfloat"></div>
              </div>
              <!--左边盒子结束-->
              <!--便民提示盒子-->
              <div class="bmts_box">
                <p class="l_tit04">便民提示</p>
                <ul>
                  <li><a href="#">叶心林等县师节心林等走</a></li>
                  <li><a href="#">县政协主木视主木视小区物</a></li>
                  <li><a href="#">我县召开201四县召次全体</a></li>
                  <li><a href="#">县一小师生教师小师生节</a></li>
                  <li><a href="#">县市检察机关检察机文书</a></li>
                  <li><a href="#">县交警大化道警大化路交</a></li>
                  <li><a href="#">县一中举暨凌金中举暨颁奖</a></li>
                  <li class="more"><a href="#">更多&gt;&gt;</a></li>
                </ul>
              </div>
              <!--便民提示盒子结束-->
            </div>
          </div>
        </div>
        <!--在线办事左边栏结束-->
        <div class="zxbs_main">
          <div class="out_line">
            <div class="in_line" style=" padding:0; ">
              <!--场影导航盒子-->
              <div class="cjdh_box">
                <ul>
                  <li><a href="#">户籍办理</a></li>
                  <li><a href="#">婚育收养</a></li>
                  <li><a href="#">医疗卫生</a></li>
                  <li><a href="#">劳动就业</a></li>
                  <li><a href="#">教育培训</a></li>
                  <li><a href="#">养老保险</a></li>
                  <li><a href="#">公用事业</a></li>
                  <li><a href="#">饮食娱乐</a></li>
                </ul>
              </div>
            </div>
          </div>
          <!--场影导航盒子结束-->
          <!--市民、企业办事盒子-->
	      <s:iterator value = "workings" id="working" status="st">
	      <div class="smbs_box">
	        <div class="bs_tit_search"> 	
	          <p class="bs_tit" style="float:left;"><s:property value="#working.name"/></p>
	          <!-- 出现页面报错-->
	          <s:if test="#st.index==0">
	          <form style="float:right;">
	            <input class="srh_text" name="" type="text" />
	            <select class="srh_list" name="" size="1">
	              <option>事项</option>
	              <option>表格</option>
	            </select>
	            <input class="srh_but" name="" type="button" value="搜索" />
	          </form>
		      </s:if>
	        </div>
	       <div class="clearfloat"></div>
	       <ul class="bs_list">
	         <s:iterator value="children" id="child">
	         <s:if test="id != null">                
	         <s:url value="/online/working/%{#child.id}_%{#working.id}.html" id="workingUrl" escapeAmp="false"/>
             <li><a href="<s:property value="workingUrl"/>" target="_blank" ><s:property value="#child.name"/></a></li>
	         </s:if>              
	         </s:iterator>         
	       </ul>
	       <div class="clearfloat"></div>
	     </div>
         </s:iterator>
         <!--市民、企业办事盒子结束-->
         <!--部门办事盒子-->
         <div class="smbs_box">
           <p class="bs_tit">部门办事</p>
           <ul class="bs_list">
             <s:iterator value="organs" status="st">              
             <s:if test="id != null">                
             <s:url value="/online/organ/%{id}.html" id="organUrl" escapeAmp="false"/>
             <li><a href="<s:property value="organUrl"/>" target="_blank"><s:property value="name"/></a></li>              
             </s:if>            
           </s:iterator>
           </ul>
           <div class="clearfloat"></div>
         </div>
         <!--部门办事盒子结束-->
         <!--办件公示盒子-->
         <div class="bjgs_box">
           <p class="bjgs_tit"><span><a href="#">更多&gt;&gt;</a></span>［&nbsp;办件公示&nbsp;］</p>
           <div class="bjgs_box_bjtj">
             <ul>
               <li><span>累计收件：</span>87454件</li>
               <li><span>累计办结：</span>86924件</li>
               <li><span>昨日收件：</span>43件</li>
               <li><span>昨日办结：</span>34件</li>     
             </ul>
             <form>
               <input name="" type="text" class="srh_text" value="办件查询" />
               <input class="srh_but" name="" type="button" value="搜索" />
              </form>
            </div>
            <div class="bj_list">
              <table>
                <tr>
                  <td style="width:70px; background:#ececec; text-align:center; color:#000;">流水号</td>
                  <td style="width:350px; background:#ececec; text-align:center; color:#000;">项目名</td>
                  <td style="width:70px; background:#ececec; text-align:center; color:#000;">状态</td>
                </tr>
                <tr>
                  <td class="cen">0076030</td>
                  <td><a href="#">关于旭阳雷迪的加工贸易审批</a></td>
                  <td class="cen">办结</td>
                </tr>
                <tr>
                  <td class="cen">0076032</td>
                  <td><a href="#">关于蔡灿琼的审批</a></td>
                  <td class="cen">办结</td>
                </tr>
                <tr>
                  <td class="cen">0076026</td>
                  <td><a href="#">关于王茂松的审批</a></td>
                  <td class="cen">办结</td>
                </tr>
                <tr>
                  <td class="cen">0076033</td>
                  <td><a href="#">关于徐家林的审批</a></td>
                  <td class="cen">办结</td>
                </tr>
                <tr>
                  <td class="cen">0076035</td>
                  <td><a href="#">关于郑皇平的审批</a></td>
                  <td class="cen">办结</td>
                </tr>  
              </table>
            </div>
          </div>
          <!--办件公示盒子结束-->
        </div>
        <div class="clearfloat"></div>
      </div>
      <!--内容层结束-->
      <s:include value="../footer.jsp"/>
    </div>
    <script type="text/javascript">
      swfobject.registerObject("FlashID");
    </script>
  </body>
</html>
