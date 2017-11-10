local screen = {}

 screen.cX  = display.contentCenterX
 screen.cY  = display.contentCenterY

 screen.width    = display.actualContentWidth
 screen.height   = display.actualContentHeight
 screen.left     = screen.cX - screen.width * 0.5
 screen.right    = screen.cX + screen.width * 0.5
 screen.top      = screen.cY - screen.height * 0.5
 screen.bottom   = screen.cY + screen.height * 0.5

return screen