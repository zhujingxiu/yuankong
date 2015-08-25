// JavaScript Document
function tab(thisObj,Num){
	if(thisObj.className == "on")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "on"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "off"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
function taber(thisObj,Num){
	if(thisObj.className == "on")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "on"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "off"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
function lis(thisObj,Num){
	if(thisObj.className == "yes")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "yes"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "not"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
function lis(thisObj,Num){
	if(thisObj.className == "yes")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("dt");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "yes"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "not"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
function list(thisObj,Num){
	if(thisObj.className == "yes")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "yes"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "not"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
function clicker(thisObj,Num){
	if(thisObj.className == "on")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "on"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "off"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
//鼠标事件
function tabl(thisObj,Num){
	if(thisObj.className == "yes")return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
	  if (i == Num)
	  {
	   thisObj.className = "yes"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "block";
	  }else{
	   tabList[i].className = "not"; 
	   document.getElementById(tabObj+"_c_"+i).style.display = "none";
	  }
	}
}
//onmousemove事件
var last_fsid = 1;
function change(id){
if(id != last_fsid){
 document.getElementById('change_'+id).className = 'help-zhinan01';
document.getElementById('change_'+last_fsid).className = 'help-zhinan02';
document.getElementById('change_'+id+'1').style.display = 'block';
document.getElementById('change_'+last_fsid+'1').style.display = 'none';
 last_fsid = id;
 }
}

var last_fsid = 1;
function tablist(id){
if(id != last_fsid){
 document.getElementById('tablist_'+id).className = 'at';
document.getElementById('tablist_'+last_fsid).className = 'aa';
document.getElementById('tablist_'+id+'1').style.display = 'block';
document.getElementById('tablist_'+last_fsid+'1').style.display = 'none';
 last_fsid = id;
 }
}
var last_fsid = 1;
function tablistc(id){
if(id != last_fsid){
 document.getElementById('tablistc_'+id).className = 'at';
document.getElementById('tablistc_'+last_fsid).className = 'aa';
document.getElementById('tablistc_'+id+'1').style.display = 'block';
document.getElementById('tablistc_'+last_fsid+'1').style.display = 'none';
 last_fsid = id;
 }
}
 
function changec(sc)
{
	if('none' == document.getElementById(sc).style.display)
	{
		document.getElementById(sc).style.display = 'block';
	}else
	{
		document.getElementById(sc).style.display = 'none';
	}
}

function tihuan(sc)
{
	if('none' == document.getElementById(sc).style.display)
	{
		document.getElementById(sc).style.display = 'block';
		document.getElementById(sc+1).style.display = 'none';
	}else
	{
		document.getElementById(sc).style.display = 'none';
		document.getElementById(sc+1).style.display = 'block';
	}
}
