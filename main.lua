-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
local physics = require "physics"
physics.setDrawMode("hybrid")
physics.start()
physics.setGravity( 0, 0)
display.setDefault("background", 129/500, 0, 0)

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
local data = map.layer[1].tile(6,6)
local player = map.layer[1].tile(2, 2)
for tile in map.layer[1].tilesInRange(1, 1, 1, 10) do
  physics.addBody( tile, "static", {density =1.0, friction = 0.3, bounce =0.1})
end

for tile in map.layer[1].tilesInRange(8, 1, 1, 10) do
  physics.addBody( tile, "static", {density =1.0, friction = 0.3, bounce =0.1})
end

for tile in map.layer[1].tilesInRange(2, 1, 7, 1) do
  physics.addBody( tile, "static", {density =1.0, friction = 0.3, bounce =0.1})
end

for tile in map.layer[1].tilesInRange(2, 10, 7, 10) do
  physics.addBody( tile, "static", {density =1.0, friction = 0.3, bounce =0.1})
end

local player = map.layer[1].tile(2, 2)
physics.addBody( player, "dynamic", {density =1.0, friction = 0.3, bounce =0.1})
function player:touch(event)
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
player:addEventListener("touch", player)
