-- Mag Keycard Door Controller Program

event = require("event")
component = require("component")

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end



function doorCtrl(doorController)
  door = component.proxy(component.get(doorController))  
  door.toggle()
end

while true do
  _,address,user,code = event.pull("magData")
  if code == "99447582" then
  print("Exiting")
  door1 = require("component").os_doorcontroller
  door1.close()
    os.exit()
  end
  require("instructions/" .. address)
  if inTable(accessArray["allowed"], code) then
    print("The code is correct")
    doorCtrl(accessArray["doorController"])
  else
    print("The code is incorrect")
  end
end

