local a = {}

function a.letterButtonAnimation( object,x,y )
	--local newX, newY = target:localToContent( 0, 0 )

	--print( newX,newY )
	transition.to( object, {x=x, y=y, time=200} )
end

return a