 composer = require( "composer" )
 scene = composer.newScene()
-- Setting character as global variable
_G.guy = {}
function scene:create( event )
     sceneGroup = self.view

     composer.removeScene(composer.getPrevious())
    -- Setting physics and gravity
    physics = require("physics")
    physics.start()
    physics.setGravity(0, 0)
    physics.setDrawMode( "hybrid" )

    -- Setting Background Image
    image = display.newImageRect( "grassbackground2.png", display.contentWidth, display.contentHeight )
    image.x, image.y = display.contentCenterX-32, display.contentCenterY
    sceneGroup:insert(image)

    -- Setting up button events and icons for buttons
     buttons = require ("buttons")
     for k,v in ipairs(buttons) do
        sceneGroup:insert(v)
     end

    -- Setting up Screen boundaries to prevent player from going off screen
     boundaries = require ("bounds")
     for k,v in ipairs(boundaries) do
        sceneGroup:insert(v)
     end

    -- setting up player
    guy = display.newImage( "guy.png", 29 ,29 )
    physics.addBody( guy, "dynamic", { friction=0, bounce=0 } )
    guy.isFixedRotation = true
    sceneGroup:insert(guy)

    -- setting up walls
     walls =
    {
      display.newRect(80,10,5, 100), display.newRect(0,150,220, 5), display.newRect(220,150,5, 180),
      display.newRect(320,10,5, 50), display.newRect(325,200,5, 150),display.newRect(370,120,90, 5)
    }

    -- adding physics (box2d) to walls
    for k,v in ipairs(walls) do
       sceneGroup:insert(v)
       physics.addBody (v, "static", {friction = 1, bounce = 0} )
    end

    -- adding enemy to game
    enemy = display.newImage("enemy.png", 280,150)
    enemy.isFixedRotation = true
    enemy.movingUp = false
    enemy.id = "enemy"
    physics.addBody( enemy, "dynamic", { friction=0, bounce=0 } )
    enemy:setLinearVelocity(0, 100)
    sceneGroup:insert(enemy)

    -- setup enemy movement
     function moveEnemy()
      if(enemy.movingUp) then
        transition.to( enemy, { time=1000, y=30, onComplete=moveEnemy} )
        enemy.movingUp = false
      else
        transition.to( enemy, { time=1000, y=200, onComplete=moveEnemy} )
        enemy.movingUp = true
      end
    end
    -- start enemy movement
    moveEnemy()

    -- Setting up goal
     goal = display.newImage("goal.png", display.contentWidth-64,150)
    goal.id = "goal"
    physics.addBody( goal, "dynamic", { friction=0, bounce=0 } )
    sceneGroup:insert(goal)
     function onCollision( self, event )
        if ( event.phase == "began" and event.other.id) then
            if(event.other.id == "enemy") then
              print("you die")
              options = {params = { screenCode = 0}}
              composer.gotoScene("gameOver", options)
              composer.removeScene( "level1")
            elseif(event.other.id == "goal") then
              print "you win"
              options = {params = { screenCode = 1}}
              composer.gotoScene("gameOver",options)            
              composer.removeScene( "level1")
            end
        elseif ( event.phase == "ended" ) then
            -- print( self.id .. ": collision ended with " .. event.other.id )
        end
    end

    guy.collision = onCollision
    guy:addEventListener( "collision", guy)

end


-- "scene:show()"
function scene:show( event )

     sceneGroup = self.view
     phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end


-- "scene:hide()"
function scene:hide( event )

     sceneGroup = self.view
     phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end


-- "scene:destroy()"
function scene:destroy( event )
     sceneGroup = self.view
     guy = {}
     enemy:removeSelf()
     goal:removeSelf()
     sceneGroup:insert(goal)
     for k,v in ipairs(walls) do
        v:removeSelf()
     end
     for k,v in ipairs(buttons) do
        v:removeSelf()
     end
     for k,v in ipairs(boundaries) do
        v:removeSelf()
     end
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene
