local Button = {}

function Button.new( options )
	local group = display.newGroup( )

	-- Options
	local width = options.width or 40
	local height = options.height or 20
	local rectColor = options.buttonColor or {0,0,0}
	local labelColor = options.labelColor or {1,1,1}
	local font = native.newFont( options.font, 16 ) or native.systemFont
	local label = options.label or ""

	-- Create rect
	local rect = display.newRect( group, 0, 0, width, height )
	rect:setFillColor( unpack(rectColor) )

	-- Create text
	local text = display.newText( group, label, 0, 0 , font, 16 )
	text:setFillColor( unpack(labelColor) )

	-- Button functions
	function group.setButtonColor( color )
		rect:setFillColor( unpack(color) )
	end

	function group.setAction( func )
		group:addEventListener( "tap", func )
	end

	function group.removeAction( func )
		group:removeEventListener( "tap", func )
	end

	-- Text functions
	function group.setLabel( label )
		text.text = label
	end

	function group.setfontSize( size )
		text.size = size
	end
	group:insert( rect )
	group:insert( text )
	return group
end

return Button