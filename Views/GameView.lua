local v = {}

local button = require("UI.Button")
local layout = require("UI.Layout")

v.mainGroup = display.newGroup()

display.setDefault( "background", color.hex("303F9F") )

function v.resetBtn(  )
	local btn = button.new({
		width = 40,
		height = 40,
		buttonColor = {1,0,0},
		font = "Reset"
	})
	btn.x = screen.cX
	btn.y = screen.cY - 100

	v.mainGroup:insert(btn)
	return btn
end

function v.questionLabel(  )
	local options = 
	{
	    text = "Test",     
	    x = screen.cX,
	    y = 100,
	    font = "Avenir Next",   
	    fontSize = 22,
	    align = "center"  -- Alignment parameter
	}
	local text = display.newText( options )
	text:setFillColor( 0,0,1 )

	return text
end

function v.levelGroup(  )
	local group = display.newGroup()

	local l = layout.horizontalLayout(screen.width - 50, 20)
	l.x = screen.cX
	for i=1,5 do
		local circleOut = display.newCircle( group, 0, 0, 11 )
		circleOut.strokeWidth = 2
		circleOut:setStrokeColor( color.hex("BD10E0") )
		circleOut:setFillColor( color.hex("303F9F") )
		l.add(circleOut)
	end
	-- Order in the group Matters
	group:insert( 3, l  )

	local circles = {}

	for i=1,5 do
		local circleIn = display.newCircle( group, 0, 0, 0.5 )
		local x = l.children[i]:localToContent( 0, 0 )
		circleIn.x = x
		circleIn:setFillColor( color.hex("BD10E0") )
		circles[#circles+1] = circleIn
	end

	-- Get the position of the children and convert it to global coordinates
	local x1,y1 = l.children[1]:localToContent( 0, 0 )
	local x2,y2 = l.children[2]:localToContent( 0, 0 )
	local width = 4 * (x2-x1)
	local lineBack = display.newRect( group, x1, 0, width , 1 )
	lineBack.anchorX = 0
	lineBack:setStrokeColor( color.hex("BD10E0"), 0.3 )
	lineBack.strokeWidth = 2
	-- Order in the group Matters
	group:insert( 1, lineBack  )

	local lineFront = display.newRect( group, x1, 0, 0 , 1 )
	lineFront.anchorX = 0
	lineFront:setStrokeColor( color.hex("BD10E0") )
	lineFront.strokeWidth = 2
	-- Order in the group Matters
	group:insert( 2, lineFront  )
	lineFront.lengthToAdd = x2-x1  -- Used for animation

	group.circles = circles
	group.line = lineFront

	return group
end



return v 