--Create global screen boundaries
local leftWall = display.newRect(0,0,1, display.contentHeight*2 )
local rightWall = display.newRect (display.contentWidth-33, 0, 1, display.contentHeight*2)
local topWall = display.newRect (0, 0, display.contentWidth*2, 1)
local bottomWall = display.newRect(0,display.contentHeight, display.contentWidth*2,1)

physics.addBody (leftWall, "static", {friction = 1, bounce = 0} )
physics.addBody (rightWall, "static", {friction = 1, bounce = 0} )
physics.addBody (topWall, "static", {friction = 1, bounce = 0} )
physics.addBody (bottomWall,"static", {friction = 1, bounce = 0} )

return {topWall,leftWall,rightWall,bottomWall}
