function drag(elementToDrag,event)
{
 var startX=event.clientX; startY=event.clientY;//div中间坐标
 var origX=elementToDrag.offsetLeft; origY=elementToDrag.offsetTop;//div左上角的坐标
 
 var deltaX=startX-origX;  deltaY=startY-origY;
 if(document.addEventListener){//firfox and so on
  document.addEventListener('mousemove',moveHandler,true);
        document.addEventListener('mouseup',upHandler,true);
 }else if(document.attachEvent){//IE 5+
      elementToDrag.setCapture();
   elementToDrag.attachEvent('onmousemove',moveHandler);
   elementToDrag.attachEvent('onmouseup',upHandler);
   elementToDrag.attachEvent('onlosecapture',upHandler);
 }else{//IE 4 EVENT MODE
  var oldmoveHandler=document.onmousemove;
  var oldupHandler=document.mouseup;
  document.onmousemove=moveHandler;
  document.onmouseup=upHandler;
 }
 if(event.stopPropagation) event.stopPropagation();//firefox 阻止事件冒泡，使得元素的父节点也响应事件
 else event.cancelBubble=true; //IE
 if(event.preventDefault) event.preventDefault();//阻止默认的方法
 else event.returnValue=false;
 function moveHandler(e)
 {
  if(!e) e=window.event;
  elementToDrag.style.left=(e.clientX-deltaX)+'px';
  elementToDrag.style.top=(e.clientY-deltaY)+'px';
  if(e.stopPropagation) e.stopPropagation();
  else e.cancelBubble=true;
 }
  
     function  upHandler(e)
  {
   if(!e) e=window.event;
   if(document.removeEventListener){
    document.removeEventListener("mouseup",upHandler,true);
    document.removeEventListener("mousemove",moveHandler,true);
   }else if(document.detachEvent)
   {
    elementToDrag.detachEvent("onlosecapture",upHandler);
    elementToDrag.detachEvent("onmouseup",upHandler);
    elementToDrag.detachEvent("onmousemove",moveHandler);
    elementToDrag.releaseCapture;
   }else{
    document.onmouseup=oldupHandler;
    document.onmousemove=oldmoveHandler;
   }
   if(e.stopPropagation) e.stopPropagation();
   else e.cancelBubble=true;
  }
}