-- file for setting all buttons related stuff
local widget = require("widget")
local buttons = {}
local function handleUpBtnEvent(event)
  if event.phase == "ended" then
    print ("up button pressed")
    guy:setLinearVelocity(0, -100)
  end
end

local upBtn = widget.newButton{
  left = display.contentWidth - 32,
  top = 0,
  width = 32,
  height = 32,
  defaultFile = "upArrow.png",
  id = "upButton",
  onEvent = handleUpBtnEvent,
}

local function handleRightBtnEvent(event)
  if event.phase == "ended" then
    print ("right button pressed")
    guy:setLinearVelocity(100, 0)
  end
end

local rightBtn = widget.newButton{
  left = display.contentWidth - 32,
  top = 224,
  width = 32,
  height = 32,
  defaultFile = "rightArrow.png",
  id = "rightButton",
  onEvent = handleRightBtnEvent,
}

local function handleLeftBtnEvent(event)
  if event.phase == "ended" then
    print ("left button pressed")
    guy:setLinearVelocity(-100, 0)
  end
end

local leftBtn = widget.newButton{
  left = display.contentWidth - 32,
  top = 64,
  width = 32,
  height = 32,
  defaultFile = "leftArrow.png",
  onEvent = handleLeftBtnEvent,
  id = "leftButton",
}

local function handleDownBtnEvent(event)
  if event.phase == "ended" then
    print ("down button pressed")
    guy:setLinearVelocity(0, 100)
  end
end

local downBtn = widget.newButton{
  left = display.contentWidth - 32,
  top = 288,
  width = 32,
  height = 32,
  defaultFile = "downArrow.png",
  onEvent = handleDownBtnEvent,
  id = "downButton",
}

local function handleQuitBtnEvent(event)
  if event.phase == "ended" then
    if  system.getInfo("platformName")=="Android" then
           native.requestExit()
       else
           os.exit()
      end
  end
end

local quitBtn = widget.newButton{
  left = display.contentWidth - 32,
  top = 160,
  width = 32,
  height = 32,
  defaultFile = "quitBtn.png",
  onEvent = handleQuitBtnEvent,
  id = "quitButton",
}

buttons = {upBtn, leftBtn, rightBtn, downBtn, quitBtn}
return buttons
