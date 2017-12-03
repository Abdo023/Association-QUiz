local composer = require( "composer" )

local scene = composer.newScene()

display.setDefault( "background", 1,1,1 )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- Modules
local gameView = require("Views.GameView")
local layout = require("UI.Layout")
local animations = require("Views.Animations")
local drawings = require("Views.Drawing")
local letters = require("Views.Letters")
local questionsData = require("Data.Questions")
local gameData = require("Data.GameData")

-- UI
local resetBtn = gameView.resetBtn()
local questionLabel = gameView.questionLabel()
local levelGroup = gameView.levelGroup()

-- Variables

local topLetters
local bottomLetters
local topLayout
local bottomLayout
local topBlocksLayout
local bottomBlocksLayout
local blocks = {} -- Holds the blocks with the right answer, used in createBlocks, checkAnswer
local answer = {} -- user selected letters will be added here
local tag = 1 -- used to keep track of letters in answer table
local currentBlock = 1

local questions = questionsData.questions.questions
local currentQuestion = {}
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
    -- Re create them aggain iin order to get positioned properly        
    topBlocksLayout = layout.horizontalLayout(120,10)
    topBlocksLayout.x = screen.cX
    topBlocksLayout.y = screen.cY  - 30
    topBlocksLayout:toBack()
    bottomBlocksLayout = layout.horizontalLayout(120,10)
    bottomBlocksLayout.x = screen.cX
    bottomBlocksLayout.y = screen.cY + 30
    bottomBlocksLayout:toBack()
    local size = 40
    for i=1,#answer do
        local box = display.newRect(  0, 0, size, size )
        box:setFillColor( color.hex("806DF7"))
        box:setStrokeColor( 0, 0, 0 )
        --box.strokeWidth = 1
        --topLayout.addBlocks(box)
        box.id = answer[i]
        blocks[#blocks+1] = box
        --print("Box "..box.x.." "..box.y)
        if i < 7 then
            topBlocksLayout.add(box)
        else
            bottomBlocksLayout.add(box)
        end
    end
end

local function animateLevel(  )
    animations.levelAnimation(levelGroup.circles[gameData.levelProgress], levelGroup.line)
end 

local function shuffleArray( tbl )
    local size = #tbl
    for i = size, 1, -1 do
        local rand = math2.random(size)
        tbl[i], tbl[rand] = tbl[rand], tbl[i]
    end
    return tbl 
end

local function getQuestion( func )
    --If all questions have been used, then re-populate them and use them again
    if #questions <= 0 then
        questionsData.repopulateQuestions()
        questions = questionsData.questions.questions
    end
    print("GameSCene Questions: "..#questions)
    local rand = math2.random(1,#questions)
    currentQuestion = questions[rand]
    for i=1,#currentQuestion.correct do
        print(currentQuestion.correct[i])
    end
    createBlocks(currentQuestion.correct)
    local l = letters.gLetters(currentQuestion.letters)
    local l = shuffleArray( l )
    populateLetters(l, func)
    questionLabel.text = currentQuestion.question
end

-- Used in onLetterButton()
local function checkAnswer(  )
    for i=1,#blocks do
        if blocks[i].id == answer[i].id then
            print( "Answer is correct" )     
        else
            print( "Answer Is wrong" )
            return false
        end
        print( "Block - Answer: "..blocks[i].id, answer[i].id )
    end
    questionsData.addUsedQuestion(currentQuestion.id)
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

-- Move letters back
-- used in onLetterButton
local function undo( object )
    animations.letterButtonAnimation(object, object.originalPos.x, object.originalPos.y)
    currentBlock = object.tag
    table.remove(answer, object.tag)
    print("Current Block: "..currentBlock)
    print("Answer Count: "..#answer)
end

-- Reset All leters
local function reset(  )
    for i=1,#answer do
        local btn = answer[i]
        animations.letterButtonAnimation(btn, btn.originalPos.x, btn.originalPos.y)
        btn.isUsed = false
    end
    answer = {}
    tag = 1
    currentBlock = 1
    print("Answer Count: "..#answer)
end

local function nextQuestion( func )
    animateLevel()
    gameData.addLevelProgress()
    reset()
    topLayout.clear()
    bottomLayout.clear()
    topBlocksLayout.clear()
    bottomBlocksLayout.clear()
    blocks = {}
    getQuestion( func )
end

-- Events

local function onLetterButton( event )
    local btn = event.target
    if btn.isUsed then
        -- Move button back
        btn.isUsed = false
        undo(btn)
    else
        local x,y = moveObjectToPos(btn, blocks[currentBlock])
        -- For moving the button back
        btn.originalPos = {x=btn.x, y=btn.y}
        btn.isUsed = true
        btn.tag = tag
        tag = tag + 1

        animations.letterButtonAnimation(btn, x,y )
        --print("Answer step "..#answer+1)
        answer[#answer+1] = btn
        currentBlock = #answer+1
        if #answer == #blocks then
            checkAnswer()
            nextQuestion( onLetterButton )
        end
        print( "Answer: "..btn.id )
        print("Answer Count: "..#answer)
    end
    
end

local function onReset( event )
    reset()
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    sceneGroup:insert(gameView.mainGroup)

    topBlocksLayout = layout.horizontalLayout(120,10)
    topBlocksLayout.x = screen.cX
    topBlocksLayout.y = screen.cY  - 30

    bottomBlocksLayout  = layout.horizontalLayout(120,10)
    bottomBlocksLayout.x = screen.cX
    bottomBlocksLayout.y = screen.cY + 30
    
    topLayout = layout.horizontalLayout(120,10)
    topLayout.x = screen.cX
    topLayout.y = screen.height - 200

    bottomLayout = layout.horizontalLayout(120,10)
    bottomLayout.x = screen.cX
    bottomLayout.y = screen.height - 150  

    getQuestion( onLetterButton )
    --createBlocks({"B","O","O","K"})
    
    local l = letters.gLetters({"A","B","D","H","O","Z","H","O","J","K"})
    --populateLetters(l, onLetterButton)


    for i=1,#topLayout.children do
        print("Top: "..topLayout.children[i].x, topLayout.children[i].y)
    end   

    --animateLevel()
    resetBtn.setAction ( onReset )
    --timer.performWithDelay( 10000, checkAnswer  )

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