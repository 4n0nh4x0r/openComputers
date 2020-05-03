-- LUA SWITCH / CASE

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
  

--actions = switch {
--  ["18873940"] = function()
--    print("Door has been opened : " .. user .. " MagReader : " .. address)
--    doorCtrl()
--  end,
--  ["99447582"] = function()
--    print("Exiting process : " .. user)
--    os.exit()
--  end,
--  default = function()
--    print("Code is not correct : " .. user)
--  end,
--}

--actions:case(code)