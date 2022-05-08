
component   = require("component")
event       = require("event")
thread      = require("thread")
term        = require("term")
redstone    = component.redstone
gpu         = component.gpu


isDown      = false
w,h         = gpu.getResolution()


buttonName  = {"power"  , "redstone"  }
buttonX1    = {3        , 3           }
buttonX2    = {19       , 19          }
buttonY1    = {3        , 10          }
buttonY2    = {8        , 15          }

function power()
    text = "Test string on power button"
    gpu.set(w-30,1, text)
end

buttonFunc  = {power = power(), redstone = redstone()  }

-- 0x13ba13  green
-- 0xeb1515    red

function startup()
    term.clear()
    -- gpu.setBackground(0xeb1515)  -- Redstone area
    -- gpu.fill(30,20,6,3," ")


    gpu.setBackground(0xcccccc) -- Sidebar
    gpu.fill(1,1,20,h," ")


--  ----------------
--       Power
    gpu.setBackground(0xeb1515)
    gpu.fill(3,3,16,5," ")
    gpu.set(3+5,5, "Power")


--  ----------------
--      Redstone
    gpu.setBackground(0xeb1515)
    gpu.fill(3,10,16,5," ")
    gpu.set(3+4,12, "Redstone")
end

function guiHandling()
    while true do
        local _,_,x,y = event.pull("touch")
        for 
        os.sleep(0)
    end
end
-- function updateGui()
--     while true do
--         if(redstone.getInput(3) ~= 0) then
--             gpu.setBackground(0x13ba13)
--             gpu.fill(3,10,16,5," ")
--         else
--             gpu.setBackground(0xeb1515)
--             gpu.fill(3,10,16,5," ")
--         end
--         gpu.set(3+4,12, "Redstone")
--         gpu.setBackground(0x000000)
--         -- print("Okay")
--         -- gpu.set(31,21,redstone.getInput(3).."")

--         os.sleep(1/2)
--     end
-- end


function powerButton()
    if(redstone.getInput(3) ~= 0) then
        gpu.setBackground(0x13ba13)
        gpu.fill(3,10,16,5," ")
    else
        gpu.setBackground(0xeb1515)
        gpu.fill(3,10,16,5," ")
    end
end



function cleanup()
    event.pull("interrupted")
    term.clear()
    print("Ending process")
    t1:kill()
    t2:kill()
    os.sleep(1)
    print("Processes ended")
    thread.current():kill()
end

startup()
t1 = thread.create(updateGui)
t2 = thread.create(guiHandling)
t3 = thread.create(cleanup)





-- local test = {"a","b","c"}
-- for i=0,table.getn(test) do
--     print(test[i])
-- end