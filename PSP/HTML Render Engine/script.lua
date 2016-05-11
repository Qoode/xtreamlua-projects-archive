pge.usb.deactivate()
require "html"
require "render"

local l = io.open("debug.log","w")

local path = "index.html"
local tree = parseHTML(path)
printTree(tree,0,l)
local body = tree.child[1].child[2]
body.parent = nil


pge.gfx.startdrawing()
local layer = html.generateRender(body)

pge.gfx.enddrawing() 

l:close()

while true do
	pge.controls.update()
	if pge.controls.pressedany() then 
		pge.gfx.screenshot("screen.png")
		pge.exit() 
	end
	pge.gfx.startdrawing()
	layer:activate()
	layer:draw(0,0)
	pge.gfx.enddrawing() 
	pge.gfx.swapbuffers()
end
