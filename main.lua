
display.setStatusBar(display.HiddenStatusBar)
local physics = require "physics"
physics.setDrawMode("hybrid")
physics.start()
display.setDefault("background", 129/500, 0, 0)

-- setup gravity
physics.setGravity( 0, 0)
local dusk = require("Dusk.Dusk")
local map = dusk.buildMap("level.json")
local layer = map.layer[1]
--[=====[
function map:touch(event)
  if event.phase == "began" then
    self.markX = self.x
    self.markY = self.y
  elseif event.phase == "moved" then
    local x = (event.x - event.xStart) + self.markX
    local y = (event.y - event.yStart) + self.markY
    self.x, self.y = x, y
  end
  return true
end

map:addEventListener("touch", map)
--]=====]
-- setup wall tiles
for tile in map.layer[1].tilesInRange(1, 1, 1, 10) do
  physics.addBody( tile, "static", {density =0, friction = 0, bounce =0})
  tile.id = "tile"
end

for tile in map.layer[1].tilesInRange(8, 1, 1, 10) do
  physics.addBody( tile, "static", {density =0, friction = 0, bounce =0})
  tile.id = "tile"
end

for tile in map.layer[1].tilesInRange(2, 1, 6, 1) do
  physics.addBody( tile, "static", {density =0, friction = 0, bounce =0})
  tile.id = "tile"
end

for tile in map.layer[1].tilesInRange(2, 10, 7, 10) do
  physics.addBody( tile, "static", {density =0, friction = 0, bounce =0})
  tile.id = "tile"
end

local box = map.layer[1].tile(10,10)
physics.addBody( box, "static")
box.id="box"
-- setup enemy
local enemy = map.layer[1].tile(6,6)
enemy.isFixedRotation = true
enemy.id = "enemy"
enemy.movingRight = false;
physics.addBody( enemy,"static")

-- setup enemy movement
function moveEnemy()
  if(enemy.movingRight) then
    transition.to( enemy, { time=5000, x=50, onComplete=moveEnemy} )
    enemy.movingRight = false
  else
    transition.to( enemy, { time=1000, x=200, onComplete=moveEnemy} )
    enemy.movingRight = true
  end
end
-- start enemy movement
moveEnemy()

-- setup player
local player = map.layer[1].tile(2, 2)
player.y = player.y+1
player.id = "player"
physics.addBody( player, "dynamic", {density =0, friction = 0, bounce =0})
player.isFixedRotation = true

-- make player dragable
function box:touch(event)
  if event.phase == "began" then
    self.hasFocus = true
    self.oldX = self.x
    self.oldY = self.y
  elseif event.phase == "moved" then
    self.x = (event.x - event.xStart) + self.oldX
    self.y = (event.y - event.yStart) + self.oldY
  end
  return true
end
box:addEventListener("touch", box)


-- setup button controls
local buttons = {map.layer[1].tile(9, 5), map.layer[1].tile(11, 5), map.layer[1].tile(10, 4), map.layer[1].tile(10, 6)}
buttons[1].id = "leftBtn"
buttons[2].id = "rightBtn"
buttons[3].id = "upBtn"
buttons[4].id = "downBtn"

function onObjectTouch( self, event )
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. self.id )
        initialId =self.id
      elseif(event.phase == "ended") then
        if(self.id == "leftBtn" and initialId == self.id) then
          player:setLinearVelocity( -100, 0)
        elseif(self.id == "rightBtn" and initialId == self.id) then
          player:setLinearVelocity(100, 0)
        elseif(self.id == "upBtn" and initialId == self.id) then
          player:setLinearVelocity(0, -100)
        elseif(self.id == "downBtn" and initialId == self.id) then
          player:setLinearVelocity(0, 100)
        end
    end
    return true
end

for buttonIdex=1, 4, 1 do
  buttons[buttonIdex].touch = onObjectTouch
  buttons[buttonIdex]:addEventListener( "touch", buttons[buttonIdex] )
end

local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
        if(event.other.id == "enemy") then
          print("you die")
        elseif(event.other.id == "box") then
          print "you win"
        end
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

player.collision = onLocalCollision
player:addEventListener( "collision", player )

box.collision = onLocalCollision
box:addEventListener( "collision", box )
