local c = {}

local widget = require( "widget" )
local button = require( "Views.Button")
local math2 = require( "Utils.math2")

c.group = display.newGroup( )

function c.scroll(  )
	local scrl = widget.newScrollView( {
		--backgroundColor = { 34 /255, 49 /255, 63 /255 },
        backgroundColor = { 1,1,1,0 },
        width = screen.right,
        height = screen.bottom ,
        --scrollWidth = u.sceneW/4,
        horizontalScrollDisabled = true,
        leftPadding = 50,
        topPadding = 100
	} )
	scrl.name = "scrl"
	return scrl
end

function c.collectionButton( width, height, label )
	local btn = button.new({
		width = width,
		height = height,
		buttonColor = {1,0,0},
		font = "Avenir Next",
		label = label
	})

	return btn
end

function c.new( columns )
    local coll = c.scroll()
    c.group:insert( coll)

    local width = 0
    if (columns>2) then
        width = screen.right/3 - 20
    else
        width = screen.right/2 - 20
    end
    coll.btns = {}

    function coll.addItems( titles )
        local newX = width+20
        local yOffset = 20
        local newY = yOffset
        local btnHeight = width*0.8
        local rows = math2.ceil( #titles/2 ) 
        local columns = columns
        local id = 1 -- We use id instead of i because i gets repeated every function call

        local function createRow(  )
            for i=1,columns do
                if (titles[id] == nil) then
                    return
                end
                local btn = c.collectionButton(width, btnHeight, "")
                btn.name = "btn "..id
                btn.x = (newX*i) - (newX/2)  
                btn.y = newY
                btn.id = id   
                btn.setLabel( titles[id] )
                coll.btns[#coll.btns+1] = btn       
                coll:insert( btn )
                id = id + 1
            end
        end

        for i=1,rows do
            createRow()
            newY = newY + btnHeight + yOffset
        end
    end

    function coll.setTxt( t  )
        for i=1,#coll.btns do
            if (t.title ~= nil) then
                coll.btns[i].setLabel(t.title[i] or "")
            end
        end
    end

    function coll.disable(  )
        for i=1,#coll.btns do
            coll.btns[i]:setEnabled (false)
        end
    end
    function coll.enable(  )
        for i=1,#coll.btns do
            coll.btns[i]:setEnabled (true)
        end
    end

    return coll
end



return c