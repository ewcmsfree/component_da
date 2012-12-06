/**
 *选项卡切换脚本
 *el当前对像trid选项卡对象tcount选项卡数量； class1,class2样式
 */
function ChangeFoldern(el,trid,tcount,class1,class2)

{
          var DocumentReadyTF=true;
         // if(document.readyState=='complete') DocumentReadyTF=true;
	var OperObj=null;

	var j;

	if (DocumentReadyTF){

	for (var i=0;i<tcount;i++)

	{

		j=i+1;

		OperObj=document.getElementById(trid+j);
		AreaObj=document.getElementById('t'+trid+j);

		if (OperObj!=null)

		{

			if (OperObj.id!=el.id)

			{

				if (AreaObj!=null) {

				AreaObj.style.display='none';
				//OperObj.background=bg2;
				OperObj.className=class2;
				}
			}

			else 

			if (AreaObj!=null) 

			{

			AreaObj.style.display='';

			//OperObj.background=bg1;

			OperObj.className=class1;

			}

			

		}

	}

	}
	
}
function HTMLEncode(text)
{
	text = text.replace(/&/g, "&amp;") ;
	text = text.replace(/"/g, "&quot;") ;
	text = text.replace(/</g, "&lt;") ;
	text = text.replace(/>/g, "&gt;") ;
	text = text.replace(/'/g, "&#146;") ;
	text = text.replace(/\ /g,"&nbsp;");
	text = text.replace(/\n/g,"<br>");
	text = text.replace(/\t/g,"&nbsp;&nbsp;&nbsp;&nbsp;");
	return text;
}