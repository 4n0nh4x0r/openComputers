component   = require("component")
event       = require("event")
redstone    = component.redstone
reactor     = component.reactor_chamber



while true do
    heat = reactor.getHeat()
    heatp = heat / reactor.getMaxHeat() * 100
    print(heat .. " : " .. heatp)

    if heatp > 60 then
        redstone.setOutput(0,0)
    end
    if heatp < 1 then
        redstone.setOutput(0,1)
    end

    os.sleep(1)
end