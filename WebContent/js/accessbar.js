//----------------------------------------------------------------------
//名称：无障碍辅助浏览工具条
//开发：skyest、scorpio
//----------------------------------------------------------------------

//载入运行模块----------------------------
var pageLoaded = false;
window.onload = function(){
	getAllElement();
	browserType();
	beginCookie();

	iframeKeyListenerWrite();
	pageLoaded = true;

	try{pagescriptrun()}catch(e){}
	//try{skiptomain()}catch(e){}

}


window.onscroll = function(){
	if(toolBarState){$("toolbar").style.top = document.documentElement.scrollTop+"px";}
	if(guidesState){moveGuides();};
	if(document.getElementById("tempdiv")){
		document.getElementById("tempdiv").style.top=document.documentElement.scrollTop+"px";
	}
}

//功能快捷键预设（只预设单键）------------
var toolBarControlKey = 74;			//工具条开启（J键）
var textModeControlKey = 74;		//纯文本通道控制（J键）
var columnSkipKey = 90;				//栏目跳转（z键）
var skipToHeaderAreaKey = 75;		//跳到头部区域（k键）
var skipToMainAreaKey = 77;			//跳到中间内容区域（m键）
var skipToLeftAreaKey = 76;			//跳到左侧区域（l键）
var skipToContentAreaKey = 67;		//跳到主要内容区域（c键）
var skipToRightAreaKey = 100;		//跳到右侧区域（J键）
var skipToFooterAreaKey = 66;		//跳到底部区域（b键）

//节点命名规则预设------------------------
var header = "header";				//头部
var otherheader = "head";			//头部例外
var main = "main";					//内容区域
var leftSideBar = "leftcolumn";		//左侧
var content = "content";			//主要内容区
var rightSideBar = "rightcolumn";	//右侧
var footer = "footer";				//底部
var articleBox = "mainpage";		//内容页正文容器
var skipClassName = "columnjump";	//跳转节点的class名

//其它全局变量预设------------------------
var defaultFontSize = 16;			//初始页面字号
var maxFontSize = 24;				//页面最大字号
var minFontSize = 16;				//页面最小字号

var guidesWidth = 4;				//辅助线宽度
var guidesColor = "#F00";			//辅助线颜色
var guidesSkew = 5;					//辅助线相对鼠标指针偏移量

//工具条操作说明URL-----------------------
var operateExplainURL = "/wusm.htm";
//iframe页键盘监听功能模块文件地址--------
var iframeKeyListenerFilesSrc = "/js/public/iframeKeyListener.js";
//纯文本通道样式文件地址------------------
var textModeStyleURL = "/css/textmode.css";

//公共节点获取函数------------------------
function $(elementId){return document.getElementById(elementId);}

//键盘监听模块----------------------------
document.onkeydown = function keyListener(e){
	if(!pageLoaded){return false;}
	var currkey=0,e=e||event;
	currkey=e.keyCode||e.which||e.charCode;
	//alert(currkey);
	//通用键盘监听
	if(e.altKey&&!e.shiftKey&&!e.ctrlKey){
		if(currkey==toolBarControlKey){toolBarControl();};
		if(currkey==skipToHeaderAreaKey){
			buildAreaSkipElement(header,headerSkipElementHTML);
			buildAreaSkipElement(otherheader,headerSkipElementHTML);
		};
		if(currkey==skipToContentAreaKey){skipToMain();};
		if(currkey==columnSkipKey){skipToNextColumn();};
		if(currkey==skipToLeftAreaKey){buildAreaSkipElement(leftSideBar,leftSideBarSkipElementHTML);};
		if(currkey==skipToFooterAreaKey){buildAreaSkipElement(footer,footerSkipElementHTML);};
		if(currkey==skipToMainAreaKey){skipToCenter();};
	}
	if(e.altKey&&e.shiftKey&&!e.ctrlKey){
		if(currkey==textModeControlKey){textMode(true);};
		if(currkey==columnSkipKey){skipToPreviousColumn();};
	}
	if(e.altKey&&!e.shiftKey&&e.ctrlKey){
		if(currkey==textModeControlKey){textMode(false);};
		if(currkey==skipToContentAreaKey){skipToMain();};
	}
	if(!e.altKey&&!e.shiftKey&&e.ctrlKey){
		if(currkey==columnSkipKey){skipToNextColumn();};
	}
	if(!e.altKey&&e.shiftKey&&e.ctrlKey){
		if(currkey==columnSkipKey){skipToPreviousColumn();};
	}
	if(e.altKey&&e.shiftKey&&e.ctrlKey){
		if(currkey==skipToLeftAreaKey){buildAreaSkipElement(leftSideBar,leftSideBarSkipElementHTML);};
		if(currkey==skipToFooterAreaKey){buildAreaSkipElement(footer,footerSkipElementHTML);};
		if(currkey==skipToMainAreaKey){skipToCenter();};
	}
}


//浏览器类型判断函数----------------------
var browserIsIE;
var IEVAR;
function browserType(){
	if(window.ActiveXObject){
		browserIsIE = true;
		var ua = navigator.userAgent.toLowerCase();
		IEVAR = Number(ua.match(/msie ([\d.]+)/)[1]);
	}
	else{browserIsIE = false;}
}

//获取节点公用函数------------------------
var allElements = new Array();
var allFrame = new Array();
var allColumnElement = new Array();
var allLink = new Array();
var allImg = new Array();
function getAllElement(){
	allElements = $("container").getElementsByTagName("*");
	allFrame = $("container").getElementsByTagName("iframe");
	allLink = document.getElementsByTagName("link");
	var ColumnElementCount = 0;
	for(var i=0;i<allElements.length;i++){
		if(allElements[i].nodeName=="H3"||allElements[i].nodeName=="H4"||allElements[i].nodeName=="H5"){
			if(!($(articleBox)&&(allElements[i].nodeName=="H4"||allElements[i].nodeName=="H5"))){
				allColumnElement[ColumnElementCount] = allElements[i];
				ColumnElementCount++;
			}
		}
	}
}

//组装工具条函数--------------------------
var toolBarDOM;
var toolBarStyleText = "border:1px solid #C80000;margin:5px 1px;background-color:#FFF;color:#C80000;padding:0px 1px;font-size:16px;font-weight:bold;line-height:16px;height:20px;";
function assemblyToolBar(){
	toolBarDOM = "";
	if(textModeState){toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:130px;\" id=\"textmodebutton\" type=\"button\" value=\"切换为可视模式\" title=\"切换为可视模式\" onclick=\"textMode()\" />";}
	else{toolBarDOM = toolBarDOM;}
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:80px;\" type=\"button\" value=\"文字放大\" title=\"文字放大\" onclick=\"fontSizeZoom('zoomIn')\" />";
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:80px;\" type=\"button\" value=\"文字缩小\" title=\"文字缩小\" onclick=\"fontSizeZoom('zoomOut')\" />";
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:80px;\" id=\"contrasbutton\" type=\"button\" value=\"高对比度\" title=\"高对比度\" onclick=\"highContrast()\" />";
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:100px;\" id=\"guidesbutton\" type=\"button\" value=\"开启辅助线\" title=\"开启辅助线\" onclick=\"guidesOpen()\" />";
if(browserIsIE){
		toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:80px;\" type=\"button\" value=\"界面放大\" title=\"界面放大\" onclick=\"pageZoom('zoomIn')\" />";
		toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:80px;\" type=\"button\" value=\"界面缩小\" title=\"界面缩小\" onclick=\"pageZoom('zoomOut')\" />";
}
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:130px;\" type=\"button\" value=\"无障碍操作说明\" title=\"无障碍操作说明\" onclick=\"openDeclare()\" />";
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:50px;\" type=\"button\" value=\"重置\" title=\"重置工具条\" onclick=\"resetToolBar()\" />";
	toolBarDOM = toolBarDOM+"<input style=\""+toolBarStyleText+"width:50px;\" type=\"button\" value=\"关闭\" title=\"关闭工具条\" onclick=\"toolBarControl()\" />";
}
var guidesHTML = "<div id=\"guidesXLine\" style=\"position:absolute;width:100%;left:0px;font-size:0px;line-height:0px;z-index:200;\"></div><div id=\"guidesYLine\" style=\"position:absolute;height:100%;top:0px;font-size:0px;line-height:0px;z-index:201;\"></div>";

//工具条开关函数--------------------------
var toolBarState = false;
function toolBarControl(){
	if(!toolBarState){
		assemblyToolBar();
		var toolBarElement = document.createElement("div");
		toolBarElement.setAttribute("id","toolbar");
		toolBarElement.style.cssText = "text-align:center;width:100%;background:#FFF;";
		toolBarElement.innerHTML = toolBarDOM;

		document.body.insertBefore(toolBarElement,$("skip"));

		
		
		var guidesElement = document.createElement("div");
		guidesElement.setAttribute("id","guides");
		guidesElement.style.display = "none";
		guidesElement.style.zIndex = 199;
		guidesElement.innerHTML = guidesHTML;
		document.body.insertBefore(guidesElement,$("skip"));
		
		toolBarPosition();
		setCookie("toolBarState",1);
		toolBarState = true;
	}
	else{
		document.body.removeChild($("toolbar"));
		document.body.removeChild($("guides"));
		document.body.style.paddingTop = 0+"px";
		setCookie("toolBarState",0);
		setCookie("guidesState",0);
		toolBarState = false;
		guidesState = false;
	}
	toolBarStatePrompt();
}
//工具条样式及定位函数--------------------
function toolBarPosition(){
	document.body.style.position = "relative";
	document.body.style.paddingTop = 30+"px";
	$("toolbar").style.position = "absolute";
	$("toolbar").style.top = document.documentElement.scrollTop+"px";
	$("toolbar").style.left = 0+"px";
	$("toolbar").style.zIndex = 202;
}

//----------------------------------------------------------------------
//页面文字放大缩小模块
//----------------------------------------------------------------------
function fontSizeZoom(zoomMode){
	if(zoomMode == "zoomIn"){
		defaultFontSize = defaultFontSize+2;
		if(defaultFontSize>maxFontSize){defaultFontSize=maxFontSize;}
	}
	else if(zoomMode == "zoomOut"){
		defaultFontSize = defaultFontSize-2;
		if(defaultFontSize<minFontSize){defaultFontSize=minFontSize;}
	}
	if(defaultFontSize == minFontSize){
		for(var i=0;i<allElements.length;i++){
			allElements[i].style.fontSize = "";
			allElements[i].style.lineHeight = "";
		}
	}
	else{
		for(var i=0;i<allElements.length;i++){
			allElements[i].style.fontSize = defaultFontSize+"px";
			allElements[i].style.lineHeight = defaultFontSize+2+"px";
		}
	}
	guidesHeightRefresh();
	setCookie("pageFontSize",defaultFontSize);
}
//字体直接放大函数------------------------
function directChangeFontSize(){
	for(var i=0;i<allElements.length;i++){
		allElements[i].style.fontSize = Number(defaultFontSize)+"px";
		allElements[i].style.lineHeight = (Number(defaultFontSize)+2)+"px";
	}
	guidesHeightRefresh();
}

//----------------------------------------------------------------------
//纯文本通道执行模块
//----------------------------------------------------------------------
var textModeState = false;
//纯文本通道执行函数----------------------
function textMode(keyContorl){
	if(keyContorl == undefined){textModeState = textModeState;}
	else if(keyContorl == true){if(textModeState){return false;};}
	else{if(!textModeState){return false;};}
	if(!textModeState){
		for(var i=0;i<allLink.length;i++){allLink[i].setAttribute("href",textModeStyleURL);}
		frameTextMode();
		imgTextMode();
		textModeState = true;
		if($("textmodebutton")){$("textmodebutton").setAttribute("value","切换为可视模式");}
		if($("textmodebutton")){$("textmodebutton").setAttribute("title","切换为可视模式");}
		if($("textmodebutton")){$("textmodebutton").style.width = "130px";}
		setCookie("textModeState",1);
		guidesHeightRefresh();
		clearStyle();
	}
	else{
		window.location.reload();
		setCookie("textModeState",0);
	}
}
//图片文本替换执行函数--------------------
function imgTextMode(){
	allImg = $("container").getElementsByTagName("img");
	var tempVar1 = allImg.length
	for(var i=0;i<tempVar1;i++){
		var replaceImg = document.createElement("span");
		var imgAlt;
		if(allImg[0].getAttribute("alt")!=null&&allImg[0].getAttribute("alt")!=""){imgAlt = allImg[0].getAttribute("alt");}
		else if(allImg[0].getAttribute("title")!=null&&allImg[0].getAttribute("title")!=""){imgAlt = allImg[0].getAttribute("title");}
		else{imgAlt = document.getElementsByTagName("title")[0].innerHTML;}
		replaceImg.innerHTML = imgAlt;
		allImg[0].parentNode.insertBefore(replaceImg,allImg[0]);
		allImg[0].parentNode.removeChild(allImg[0]);
	}
}
//iframe文本替换执行函数------------------
function frameTextMode(){
	allFrame = $("container").getElementsByTagName("iframe");
	var tempVar2 = allFrame.length;
	/*for(var i=0;i<tempVar2;i++){
		var iframeDOM = allFrame[i].contentWindow;
		var replaceFrame = document.createElement("div");
		try{
			replaceFrame.innerHTML = iframeDOM.document.body.innerHTML;
			allFrame[i].parentNode.insertBefore(replaceFrame,allFrame[i]);
		}catch(e){}
	}*/
	for(var a=0;a<tempVar2;a++){allFrame[0].parentNode.removeChild(allFrame[0]);}
}
//页面样式清除函数------------------------
function clearStyle(){
	var newAllElements = $("container").getElementsByTagName("*");
	for(var b=0;b<newAllElements.length;b++){newAllElements[b].style.cssText = "";}
	for(var c=0;c<newAllElements.length;c++){newAllElements[c].style.height = "auto";};
	try{
		$("rightcolumn").style.height = "";
		$("mainrightcolumn").style.height = "";
	}
	catch(e){}
}

//----------------------------------------------------------------------
//高对比度执行模块
//----------------------------------------------------------------------
var contrastState = false;
//本页高对比度执行函数--------------------
function highContrast(){
	if(!contrastState){
		contrastControl($("container"));
		for(var i=0;i<allElements.length;i++){contrastControl(allElements[i]);}
		iframeHighContrast();
		$("contrasbutton").setAttribute("value","还原对比度");
		$("contrasbutton").setAttribute("title","还原对比度");
		$("contrasbutton").style.width = "100px";
		contrastState = true;
		setCookie("contrastState",1);
	}
	else{
		contrastControl($("container"));
		for(var j=0;j<allElements.length;j++){contrastControl(allElements[j]);}
		iframeHighContrast();
		$("contrasbutton").setAttribute("value","高对比度");
		$("contrasbutton").setAttribute("title","高对比度");
		$("contrasbutton").style.width = "80px";
		contrastState = false;
		setCookie("contrastState",0);
	}
}
//引用的iframe页高对比度执行函数----------
function iframeHighContrast(){
	for(var i=0;i<allFrame.length;i++){
		var iframeDOM = allFrame[i].contentWindow;
		try{
			contrastControl(iframeDOM.document.getElementsByTagName("body")[0]);
			var iframeAllElements = iframeDOM.document.getElementsByTagName("*");
			iframeElementsHighContrast(iframeAllElements);
		}catch(e){}
	}
}
//iframe子节点高对比度--------------------
function iframeElementsHighContrast(iframeAllElements){
	for(var i=0;i<iframeAllElements.length;i++){
		contrastControl(iframeAllElements[i]);
	}
}
//高对比度功能实现函数--------------------
function contrastControl(thisElement){
	if(thisElement == undefined){return false;};
	if(!contrastState){
		thisElement.style.backgroundColor = "#000";
		thisElement.style.color = "#FFF";
	}
	else{
		thisElement.style.backgroundColor = "";
		thisElement.style.color = "";
	}
}

//----------------------------------------------------------------------
//辅助线执行模块
//----------------------------------------------------------------------
var guidesState = false;
function guidesOpen(){
	if(!guidesState){
		$("guides").style.display = "block";
		$("guidesYLine").style.height = document.body.offsetHeight + "px";
		$("guidesYLine").style.width = guidesWidth+"px";
		$("guidesXLine").style.height = guidesWidth+"px";
		$("guidesXLine").style.backgroundColor = guidesColor;
		$("guidesYLine").style.backgroundColor = guidesColor;
		document.onmousemove = moveGuides;
		guidesState = true;
		$("guidesbutton").setAttribute("value","关闭辅助线");
		$("guidesbutton").setAttribute("title","关闭辅助线");
		setCookie("guidesState",1);
	}
	else{
		$("guides").style.display = "none";
		guidesState = false;
		$("guidesbutton").setAttribute("value","开启辅助线");
		$("guidesbutton").setAttribute("title","开启辅助线");
		setCookie("guidesState",0);
	}
}
//辅助线位置控制函数----------------------
function moveGuides(e){
	if(!guidesState){return false;};
	e = window.event ? window.event : e;
	$("guidesYLine").style.left = browserIsIE?(e.clientX +(document.documentElement.scrollLeft || document.body.scrollLeft))+guidesSkew+"px":e.pageX+guidesSkew+"px";
	$("guidesXLine").style.top = browserIsIE?(e.clientY +document.documentElement.scrollTop || document.body.scrollTop)+guidesSkew+"px":e.pageY+guidesSkew+"px";
}
//辅助线高度刷新函数----------------------
function guidesHeightRefresh(){
	if(guidesState){$("guidesYLine").style.height = document.body.offsetHeight + "px";}
}

//----------------------------------------------------------------------
//界面放大缩小执行模块（只支持IE）
//----------------------------------------------------------------------
var defaultPageSize = 1;
function pageZoom(zoomMode){
	if(zoomMode == "zoomIn"){
		defaultPageSize = defaultPageSize + 0.2;
		if(defaultPageSize>2){defaultPageSize=2;};
	}
	else if(zoomMode == "zoomOut"){
		defaultPageSize = defaultPageSize - 0.2;
		if(defaultPageSize<1){defaultPageSize=1;};
	}
	else{return false;};
	$("container").style.zoom = defaultPageSize;
	setCookie("pageZoomState",defaultPageSize);
}
//界面直接放大函数------------------------
function directPageZoom(){$("container").style.zoom = defaultPageSize;}

//----------------------------------------------------------------------
//栏目跳转及区域跳转执行函数
//----------------------------------------------------------------------
//区域跳转节点内容------------------------
var headerSkipElementHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到顶部内容区域\">已跳转到顶部内容区域</a>";
var footerSkipElementHTML = "<a href=\"#footer\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到底部内容区域\">已跳转到底部内容区域</a>";
var leftSideBarSkipElementHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到左侧区域\">已跳转到左侧区域</a>";
var centerSideBarSkipElementHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到中间内容区域\">已跳转到中间内容区域</a>";
var contentSideBarSkipElementHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到主要内容区域\">已跳转到主要内容区域</a>";
var rightSideBarSkipElementHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\" title=\"已跳转到右侧内容区域\">已跳转到右侧内容区域</a>";
//区域跳转节点创建函数--------------------
function buildAreaSkipElement(elementId,elementHTML){
	if(!$(elementId)){return false;};
	var AreaSkipElement = document.createElement("div");
	AreaSkipElement.setAttribute("class",skipClassName);
	AreaSkipElement.setAttribute("className",skipClassName);
	AreaSkipElement.style.cssText = "width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;";
	AreaSkipElement.innerHTML = elementHTML;
	$(elementId).insertBefore(AreaSkipElement,$(elementId).firstChild);
	AreaSkipElement.firstChild.focus();
}
//跳转节点删除函数------------------------
function delSkipElement(skipElement){
	skipElement.parentNode.parentNode.removeChild(skipElement.parentNode);
}
//栏目跳转节点建立函数--------------------
var columnNum = -1;
var columnSkipElement;
function buildColumnSkipElement(){
	columnSkipElement = document.createElement("div");
	columnSkipElement.setAttribute("class",skipClassName);
	columnSkipElement.setAttribute("className",skipClassName);
	columnSkipElement.style.cssText = "width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;";
	var thisColumnElement = allColumnElement[columnNum];
	while(thisColumnElement.hasChildNodes()){thisColumnElement = thisColumnElement.firstChild;}
	var thisColumnText;
	if(thisColumnElement.nodeName == "IMG"){thisColumnText = thisColumnElement.getAttribute("alt");}
	else{thisColumnText = thisColumnElement.parentNode.innerHTML;}
	if(allColumnElement[columnNum].nodeName=="H3"){
		columnSkipElement.innerHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\">"+thisColumnText+"一级栏目分组</a>";
	}
	else if(allColumnElement[columnNum].nodeName=="H4"){
		columnSkipElement.innerHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\">"+thisColumnText+"二级栏目分组</a>";
	}
	else if(allColumnElement[columnNum].nodeName=="H5"){
		columnSkipElement.innerHTML = "<a href=\"javascript:\" style=\"width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;\" onblur=\"delSkipElement(this)\">"+thisColumnText+"三级栏目分组</a>";
	}
	allColumnElement[columnNum].parentNode.insertBefore(columnSkipElement,allColumnElement[columnNum]);
}
//跳转到下个栏目执行函数------------------
function skipToNextColumn(){
	columnNum++;
	if(columnNum>allColumnElement.length-1){columnNum=allColumnElement.length-1;}
	buildColumnSkipElement();
	columnSkipElement.firstChild.focus();
}
//跳转到上个栏目执行函数------------------
function skipToPreviousColumn(){
	columnNum--;
	if(columnNum<0){columnNum=0;}
	buildColumnSkipElement();
	columnSkipElement.firstChild.focus();
}
//跳转到主要内容区域判断函数--------------
function skipToMain(){
	if($("skiptomain")){buildAreaSkipElement("skiptomain",contentSideBarSkipElementHTML);}
	else if($("maincontent")){buildAreaSkipElement("maincontent",contentSideBarSkipElementHTML);}
	else if($("content")){buildAreaSkipElement("content",contentSideBarSkipElementHTML);}
	else if($("main")){buildAreaSkipElement("main",contentSideBarSkipElementHTML);}
}
function skipToCenter(){
	if($("content")){buildAreaSkipElement("content",centerSideBarSkipElementHTML);}
	else if($("main")){buildAreaSkipElement("content",centerSideBarSkipElementHTML);}
}

//----------------------------------------------------------------------
//cookie部分模块
//----------------------------------------------------------------------
//页面初始cookie读取函数------------------
function beginCookie(){
	//alert(document.cookie);
	if(document.cookie ==""){
		setCookie("toolBarState",0);
		//setCookie("pageFontSize",defaultFontSize);
		//setCookie("contrastState",0);
		//if(browserIsIE){setCookie("pageZoomState",1);}
		//setCookie("guidesState",0);
		//setCookie("textModeState",0);
	}
	else{
		if(getCookie("toolBarState") == 1){toolBarControl();};
		//if(Number(getCookie("pageFontSize"))>defaultFontSize){
//			defaultFontSize = Number(getCookie("pageFontSize"));
//			if(getCookie("toolBarState") == 0){toolBarControl();}
//			directChangeFontSize();
//		}
//		if(getCookie("contrastState") == 1){
//			if(getCookie("toolBarState") == 0){toolBarControl();}
//			highContrast();
//		}
//		if(browserIsIE){
//			if(Number(getCookie("pageZoomState"))>1&&Number(getCookie("pageZoomState"))<=3){
//				defaultPageSize = getCookie("pageZoomState");
//				if(getCookie("toolBarState") == 0){toolBarControl();}
//				directPageZoom();
//			}
//		}
//		if(getCookie("guidesState") == 1){
//			if(getCookie("toolBarState") == 0){toolBarControl();}
//			guidesOpen();
//		}
//		if(getCookie("textModeState") == 1){textMode();}
	}
}
//cookie修改函数--------------------------
function setCookie(setProject,projectValue){
	if(setProject == undefined||projectValue == undefined){return false;};
	var Days = 30;
	var exp = new Date(); 
	exp.setTime(exp.getTime() + Days*24*60*60*1000);
	document.cookie = setProject+"="+ escape(projectValue)+";expires="+exp.toGMTString();
}
//cookie读取函数--------------------------
function getCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null) return unescape(arr[2]); return null;
}

//----------------------------------------------------------------------
//跨iframe的键盘监听功能
//----------------------------------------------------------------------
function iframeKeyListenerWrite(){
	for(var i=0;i<allFrame.length;i++){
		var iframeDOM = allFrame[i].contentWindow;
		try{
			var scriptElement = iframeDOM.document.createElement("script");
			scriptElement.setAttribute("type","text/javascript");
			scriptElement.setAttribute("src",iframeKeyListenerFilesSrc);
			iframeDOM.document.getElementsByTagName("head")[0].appendChild(scriptElement);
		}catch(e){}
	}
}

//----------------------------------------------------------------------
//工具条重置功能模块
//----------------------------------------------------------------------
function resetToolBar(){
	setCookie("toolBarState",1);
	setCookie("pageFontSize",minFontSize);
	setCookie("contrastState",0);
	if(browserIsIE){setCookie("pageZoomState",1);}
	setCookie("guidesState",0);
	setCookie("textModeState",0);
	window.location.reload();
}

//打开无障碍声明页函数--------------------
function openDeclare(){window.open(operateExplainURL);}

//----------------------------------------------------------------------
//工具条打开关闭提示语音功能模块
//----------------------------------------------------------------------
function toolBarStatePrompt(){
	try{document.body.removeChild($("toolbarprompt"))}catch(e){};
	var promptElement;
	promptElement = document.createElement("div");
	promptElement.setAttribute("id","toolbarprompt");
	promptElement.setAttribute("class",skipClassName);
	promptElement.setAttribute("className",skipClassName);
	promptElement.style.cssText = "width:0px;height:0px;font-size:0px;line-height:0px;overflow:hidden;background:#FFF;color:#FFF;position:absolute;left:50%;top:0px;z-index:1;";
	if(toolBarState){
		promptElement.innerHTML = "<a href=\"javascript:\" title=\"无障碍辅助工具条已开启\" onblur=\"delSkipElement(this)\">无障碍辅助工具条已开启</a>";
		document.body.insertBefore(promptElement,$("toolbar"));
	}
	else{
		promptElement.innerHTML = "<a href=\"javascript:\" title=\"无障碍辅助工具条已关闭\" onblur=\"delSkipElement(this)\">无障碍辅助工具条已关闭</a>";
		document.body.insertBefore(promptElement,$("skip"));
	}
	$("toolbarprompt").firstChild.focus();
}

//----------------------------------------------------------------------
//原头部定位控制模块模块
//----------------------------------------------------------------------
function zoombig(){
	document.getElementById("zoom").style.border="1px solid red";
	document.getElementById("zoom").style.fontSize="14px";
	document.getElementById("zoom").style.lineHeight="16px";
	document.getElementById("zoom").style.position="absolute";
	document.getElementById("zoom").style.width="80px";
	document.getElementById("zoom").style.height="16px";
	document.getElementById("zoom").style.zIndex="10";
	document.getElementById("zoom").style.display="block";
	document.getElementById("zoom").style.marginTop="3px";
	document.getElementById("zoom").style.marginleft="10px";
	document.getElementById("zoom").style.backgroundColor = "red";
	document.getElementById("zoom").style.color = "red";
}
function zoomsmall(){
	document.getElementById("zoom").style.border="";
	document.getElementById("zoom").style.fontSize="";
	document.getElementById("zoom").style.lineHeight="";
	document.getElementById("zoom").style.position="";
	document.getElementById("zoom").style.width="";
	document.getElementById("zoom").style.height="";
	document.getElementById("zoom").style.zIndex="";
	document.getElementById("zoom").style.display="";
	document.getElementById("zoom").style.backgroundColor="";
	document.getElementById("zoom").style.marginTop="";
	document.getElementById("zoom").style.marginleft = "";
	document.getElementById("zoom").style.color = "#000000";	
}
function zoomthis(){
	document.getElementById('zoomthis').style.width="80px"
	document.getElementById('zoomthis').style.height="48px"
	document.getElementById('zoomthis').style.position="absolute";
	document.getElementById('zoomthis').style.zIndex=99;
}
function zoomthat(){
	document.getElementById('zoomthis').style.width="70px"
	document.getElementById('zoomthis').style.height="24px"
	document.getElementById('zoomthis').style.position="static";
}
function kqNav(){
	toolBarControl();
}
function skiptomain(){
	if(document.getElementById("head")&&document.getElementById("skip")){
		document.getElementById("skip").innerHTML="<ul style='width:0; height:0; overflow:hidden;font-size:0;line-height:0;position:absolute;z-index:-10;border:none;color:#FFF'><li><a href=\"#content\" title=\"跳过导航\" onclick=\"skipToMain1()\">跳过导航</a></li><li><a href=\"\/wza\/index.html\" id='wzaczsm' title=\"无障碍操作说明\" >无障碍操作说明</a></li><li><a href=\"#\" onclick=\"kqNav()\" title=\"无障碍浏览工具\" ><img src=\"/images/shanghai_s/index_0.gif\" alt=\"无障碍浏览工具\" width=\"82\" height=\"24\" title=\"无障碍浏览工具\" /></a></li></ul>";
	}else if(document.getElementById("skip")){
		document.getElementById("skip").innerHTML="<ul style='width:0; height:0; overflow:hidden;font-size:0;line-height:0;position:absolute;z-index:-10;border:none;color:#FFF'><li><a href=\"#\" title=\"跳转到正文内容区域\" onkeypress=\"skipToMain1()\">跳转到正文内容区域</a></li><li><a href=\"\/wza\/index.html\" title=\"无障碍操作说明\" >无障碍操作说明</a></li><li><a href=\"#\" onclick=\"kqNav()\" title=\"无障碍浏览工具\" ><img src=\"/images/shanghai_s/index_0.gif\" alt=\"无障碍浏览工具\" width=\"82\" height=\"24\" title=\"无障碍浏览工具\" /></a></li></ul>";
	}
}