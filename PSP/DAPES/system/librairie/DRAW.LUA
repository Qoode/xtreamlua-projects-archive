--# Draw function
Draw = {}

function Draw.line(x1,y1,x2,y2,c)
local pic = document.img()
if document.zoomN() == 0 then
pic:drawLine(x1,y1,x2,y2,c)
document.imgE(pic)
end
end

function fill (x_start,y_start,color)
       if _first then
	    _first = false
	    x_start = _x
		y_start = _y
		color = _color
        startCO = tempF:pixel(x_start,y_start)
       end    
       tempF:pixel(x_start,y_start,color)
       if ((x_start-1) >= 0) then
       if tempF:pixel(x_start-1,y_start) == startCO then
       fill(x_start-1,y_start,color,false)
       end
       end
       if ((x_start+1) < document.width()) then
         if tempF:pixel(x_start+1,y_start) == startCO then
       fill(x_start+1,y_start,color,false)
       end
       end
         if ((y_start+1) < document.height()) then
       if tempF:pixel(x_start,y_start+1) == startCO then
       fill(x_start,y_start+1,color,false)
       end
       end
         if ((y_start-1) >= 0)  then
       if tempF:pixel(x_start,y_start-1) == startCO then
       fill(x_start,y_start-1,color,false)
       end     
       end
end

function reloadBrush()
if brushSelected == 1 then
   brushPic = Image.createEmpty(15,15)
   brushPic:clear(param.primaryCO)
   brushPic:drawLine(0,0,14,0,Color.new(0,0,0))
   brushPic:drawLine(0,0,0,14,Color.new(0,0,0))
   brushPic:drawLine(14,0,14,14,Color.new(0,0,0))
   brushPic:drawLine(0,14,14,14,Color.new(0,0,0))
elseif brushSelected == 2 then
   brushPic = Image.createEmpty(15,15)
   brushPic:clear(param.primaryCO)
elseif brushSelected == 3 then
   brushPic = Image.createEmpty(15,15)
   brushPic:drawLine(5,0,5,10,param.primaryCO)
   brushPic:drawLine(0,5,10,5,param.primaryCO)
end
end