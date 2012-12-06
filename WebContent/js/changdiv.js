function ChangeFoldern(el,trid,tcount,class1,class2)

{
          var DocumentReadyTF=false;
          if(document.readyState=='complete') DocumentReadyTF=true;
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