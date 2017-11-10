local composer = require( "composer" )

local scene = composer.newScene()

display.setDefault( "background", 1,1,1 )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Modules
local layout = require("UI.Layout")
local animations = require("Views.Animations")
local letters = require("Views.Letters")

-- Variables

local topLetters
local bottomLetters
local topLayout
local bottomLayout
local blocksLayout
local blocks = {}
local answer = {} -- user selected letters will be added here
local currentBlock = 1
-- Functions

local function populateLetters( letters, func )
    for i=1,#letters do
        if i < 7 then
            topLayout.add(letters[i])
        else
            bottomLayout.add(letters[i])
        end
        letters[i].setAction(func)
    end
end

local function createBlocks( answer )
    for i=1,#answer do
        if answer[i] == "" then
            local empty = display.newRect(  0, 0, 40, 40 )
            empty.empty = true
            empty:setFillColor( 1,1,1 )
            blocksLayout.add(empty)
            --topLayout.addBlocks(empty)
        else
            local box = display.newRect(  0, 0, 40, 40 )
            --box:setFillColor( 0,0,0 )
            box:setStrokeColor( 0, 0, 0 )
            box.strokeWidth = 1
            blocksLayout.add(box)
            --topLayout.addBlocks(box)
            box.id = answer[i]
            blocks[#blocks+1] = box
            --print("Box "..box.x.." "..box.y)
        end
    end
end

local function checkAnswer(  )
    for i=1,#blocksLayout.children do
        if blocksLayout.children[i].id == answer[i] then
            print( "Answer is correct" )     
        else
            print( "Answer Is wrong" )
            return false
        end
        print( "Block - Answer: "..blocksLayout.children[i].id, answer[i] )
    end
    print( "Good" )
    return true
end

-- Get the position of the blocks relative to the letters
local function moveObjectToPos( object, target )
    local ox,oy = object:localToContent( 0, 0 )
    local tx,ty = target:localToContent( 0, 0 )
    local x = ox - tx
    local y = oy - ty

    local xPos = object.x - x
    local yPos = object.y - y
    return xPos, yPos
end

-- Events

local function onLetterButton( event )
    local x,y = moveObjectToPos(event.target, blocks[currentBlock])
    animations.letterButtonAnimation(event.target, x,y )
    currentBlock = currentBlock + 1
    answer[#answer+1] = event.target.id
    print( "Answer: "..event.target.id )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    blocksLayout = layout.horizontalLayout(120,10)
    blocksLayout.x = screen.cX
    blocksLayout.y = screen.cY    
    
    topLayout = layout.horizontalLayout(120,10)
    topLayout.x = screen.cX
    topLayout.y = screen.height - 200

    bottomLayout = layout.horizontalLayout(120,10)
    bottomLayout.x = screen.cX
    bottomLayout.y = screen.height - 150  

    createBlocks({"B","O","O","K"})
    
    local l = letters.gLetters({"A","B","D","H","O","Z","H","O","J","K"})
    populateLetters(l, onLetterButton)


    for i=1,#topLayout.children do
        print("Top: "..topLayout.children[i].x, topLayout.children[i].y)
    end   

    for i=1,#blocksLayout.children do
        --print("Blocks: "..blocksLayout.children[i].x, blocksLayout.children[i].y)
        --print( "Blocks id: "..blocksLayout.children[i].id )
    end 

    --timer.performWithDelay( 7000, checkAnswer  )

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene