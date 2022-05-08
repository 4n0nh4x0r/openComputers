
component   = require("component")
event       = require("event")
thread      = require("thread")
term        = require("term")
redstone    = component.redstone
gpu         = component.gpu
reactor     = component.reactor_chamber


isDown          = true
cooldown        = false
w,h             = gpu.getResolution()


buttonName  = {"power"  , "redstone"  }
buttonX1    = {3        , 3           }
buttonX2    = {19       , 19          }
buttonY1    = {3        , 10          }
buttonY2    = {8        , 15          }


-- 0x13ba13  green
-- 0xeb1515    red

function powerFunc()
    -- -- local textOutput = ""
    if (isDown == true) then
        -- Turn reactor off
        gpu.setBackground(0xeb1515)
        gpu.setForeground(0xffffff)
        gpu.fill(3,3,16,5," ")
        gpu.set(3+5,5, "Power")
        redstone.setOutput(0,0)
        isDown = false
    --     -- textOutput = "Stopped signal"
    else
        -- Turn reactor on
        gpu.setBackground(0x13ba13)
        gpu.setForeground(0x000000)
        gpu.fill(3,3,16,5," ")
        gpu.set(3+5,5, "Power")
        redstone.setOutput(0,1)
        isDown = true
    --     -- textOutput = "Started signal"
    end

    -- -- Setting Backgroun to black and foreground to white again
    gpu.setBackground(0x000000)
    gpu.setForeground(0xffffff)
end
function redstoneFunc()
    -- text = "Test string on redstone button"
    -- gpu.set(w-30,1, text)
    -- print("My Output")
end





buttonFunc  = {power = powerFunc, redstone = redstoneFunc}


function startup()
-- Doing some stuff on startup
    redstone.setOutput(0,0)
    term.clear()

-- General ui
    gpu.setBackground(0xcccccc) -- Sidebar
    gpu.fill(1,1,20,h," ")

    gpu.setBackground(0xe6e6e6) -- Main area
    gpu.fill(21,1,w-20,h," ")

-- Buttons
--  ----------------
--       Power
    gpu.setBackground(0xeb1515)
    gpu.fill(3,3,16,5," ")
    gpu.set(3+5,5, "Power")


-- --  ----------------
-- --      Redstone
--     gpu.setBackground(0xeb1515)
--     gpu.fill(3,10,16,5," ")
--     gpu.set(3+4,12, "Redstone")

-- Display
-- ---------
--    50%
    gpu.setBackground(0x4d8ef7)
    gpu.fill(23,3,11,5," ")
    gpu.set(23+4,5, "0%")
end

function guiHandling()
    while true do
        local _,_,x,y = event.pull("touch")
        local buttonFound = false
        for i,o in pairs(buttonName) do
            if(x >= buttonX1[i] and x <= buttonX2[i] and y >= buttonY1[i] and y <= buttonY2[i]) then
                buttonFound = true
                -- buttonFunc[o]()
                local status,err = pcall(buttonFunc[o])
                -- print(status)
                -- print(err)
            end
        end
        -- if(buttonFound == false) then  -- Obsolete now, but i ll still keep it, who knows if it might kome in handy again at some point
        --     gpu.setBackground(0x000000)
        --     gpu.fill(40,10,50,1," ")
        --     gpu.set(40,10,"No button pressed")
        -- end
        os.sleep(0)
    end
end

function reactorControl()
    while true do
        heat = reactor.getHeat()
        heatp = heat / reactor.getMaxHeat() * 100


        gpu.setBackground(0x4d8ef7)
        gpu.fill(23,3,11,5," ")
        gpu.set(23+4,5, heatp .. "%")



        -- print(heat .. " : " .. heatp)

        if heatp > 60 then
            if(isDown)then powerFunc() end
            cooldown = true
            -- redstone.setOutput(0,0)
        end
        if heatp < 1 and cooldown then
            powerFunc()
            cooldown = false
            -- redstone.setOutput(0,1)
        end

        os.sleep(1/2)
    end
end



function cleanup()
    event.pull("interrupted")
    gpu.setBackground(0x000000)
    gpu.setForeground(0xffffff)
    term.clear()
    print("Ending threads")
    t1:kill()
    t2:kill()
    os.sleep(1/3)
    print("threads ended")
    thread.current():kill()
end

startup()
t1 = thread.create(guiHandling)
t2 = thread.create(reactorControl)
tCleanup = thread.create(cleanup)