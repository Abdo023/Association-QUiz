local drawing = {}


function drawing.rightMark(  )
	local group = display.newGroup( )
	local rectLeftWidth = 30
	local rectRightWidth = 100
	local height = 4

	local p1 = {x=screen.cX, y=screen.cY}
	local p2 = {x=screen.cX - 30, y=screen.cY-30}
	local distance =  math2.round( math2.lengthBetweenPoints(p1,p2) )

	local rectLeft = display.newRoundedRect( group, p2.x+2, p2.y, 0, height, 5 )
	rectLeft.anchorX = 0
	rectLeft:setFillColor( 0,1,0 )
	rectLeft.rotation = 45

	local rectRight = display.newRoundedRect( group, screen.cX, screen.cY, 0, height, 5 )
	rectRight.anchorX = 0
	rectRight:setFillColor( 0,1,0 )
	rectRight.rotation = -45

	group.delay = 500
	function group.remove( ) 
		timer.performWithDelay( group.delay, function() rectLeft.width=0;rectRight.width=0 end )
	end

	function group.animate(  )
		local time = 200
		transition.to( rectLeft, {width=distance, time=time} )
		transition.to( rectRight, {width=100, time=300, delay=time, onComplete=group.remove} )
	end
	return group
end

function drawing.wrongMark(  )
	local group = display.newGroup( )
	local height = 4
	local xOffset = 30
	local yOffset = 60
	local p1 = {x=screen.cX-xOffset, y=screen.cY-yOffset}
	local p2 = {x=screen.cX+xOffset, y=screen.cY-yOffset}
	local pCross = {x=screen.cX, y=screen.cY}

	local distanceRight = math2.round( math2.lengthBetweenPoints(p2,{x=screen.cX-xOffset,y=screen.cY}) )
	local distanceLeft = math2.round( math2.lengthBetweenPoints(p1, {x=screen.cX+xOffset,y=screen.cY}) )

	local rectRight = display.newRoundedRect( group, p2.x, p2.y, 0, height, 5 )
	rectRight.anchorX = 0
	rectRight:setFillColor( 1,0,0 )
	rectRight.rotation = 135

	local rectLeft = display.newRoundedRect( group, p1.x, p1.y, 0, height, 5 )
	rectLeft.anchorX = 0
	rectLeft:setFillColor( 1,0,0 )
	rectLeft.rotation = 45	

	group.delay = 500
	function group.remove( ) 
		timer.performWithDelay( group.delay, function() rectRight.width=0;rectLeft.width=0 end )
	end

	function group.animate(  )
		local time = 300
		transition.to( rectRight, {width=distanceRight, time=time} )
		transition.to( rectLeft, {width=distanceLeft, time=time, delay=time, onComplete=group.remove} )
	end
	return group
end

return drawing