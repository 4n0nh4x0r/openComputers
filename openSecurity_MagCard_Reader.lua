-- Mag Keycard Door Controller Program

magReader = require("component").os_magreader
door = require("component").os_doorcontroller
event = require("event")

function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end
  

actions = switch {
  ["18873940"] = function()
    print("Door has been opened : " .. user)
    doorCtrl()
  end,
  ["99447582"] = function()
    print("Exiting process : " .. user)
    os.exit()
  end,
  default = function()
    print("Code is not correct : " .. user)
  end,
}
  
  


function doorCtrl()
  door.open()
  os.sleep(2)
  door.close()
end

while true do
  _,_,user,code = event.pull("magData")
  actions:case(code)
end