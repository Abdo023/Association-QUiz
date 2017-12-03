local a = {}

function a.letterButtonAnimation( object,x,y )
	--local newX, newY = target:localToContent( 0, 0 )

	--print( newX,newY )
	transition.to( object, {x=x, y=y, time=200} )
end

function a.levelAnimation( circle, line )
	local function animateLine(  )
		transition.to( line, {width= line.width + line.lengthToAdd, time=500} )
		print( "Line" )
	end

	local function animateCircle(  )
		local radius = 14
		transition.to( circle, {xScale=radius, yScale=radius, time=500, onComplete=animateLine} )
	end

	animateCircle()
end

return a