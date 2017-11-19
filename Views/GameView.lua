local v = {}

local button = require("UI.Button")

v.mainGroup = display.newGroup()

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

return v 