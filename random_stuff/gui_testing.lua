
component   = require("component")
event       = require("event")
colors      = require("colors")
gpu         = component.gpu

while true do
    local _,_,x,y = event.pull("touch")
    if(x <= 50 and x >= 40 and y <= 20 and y >= 10) then
        gpu.setBackground(0x00ff00)
        gpu.fill(x,y,1,1," ")
    else
        gpu.setBackground(0x0000ff)
        gpu.fill(x,y,1,1," ")
    end
end