
Gamestate = require"libs.gamestate"
dong2lib = require"libs.dong2"

gamestates = {}

gamestates.main = require("gamestates.main")
gamestates.game = require("gamestates.game")

function anydong(bind)
  for _,dong in pairs(dongs) do
    local v = dong:getBind(bind)
    if v then return v end
  end
end

-- FROM DONG2 EXAMPLE
function love.joystickadded(joystick)
  local dong = dong2lib.new(joystick)
  if dong then 
    setDongBindings(dong)
    table.insert(dongs,dong)
  end
end

function love.load(args)
  dongs = {}
  local keyb_dong = dong2lib.new()
  setDongBindings(keyb_dong)
  table.insert(dongs,keyb_dong)
  Gamestate.registerEvents()
  Gamestate.switch(gamestates.main)

end

function love.update(dt)
  if global_debug_mode then
    require("libs.lovebird").update()
  end
end

function love.keypressed(key)
  if key == "`" then
    global_debug_mode = not global_debug_mode
  end
end

function setDongBindings(dong)
  -- From dong2 example
  dong:setBind("confirm",
    function(self,data) return unpack(data) end,
    {
      XBOX_360={args={"A"}},
      XBOX_360_XINPUT={args={"A"}},
      OUYA={args={"O"}},
      PS3={args={"CROSS"}},
      KEYBMOUSE={args={"return"}},
      LOGITECH_F310={args={"A"}},
    })

  dong:setBind("cancel",
    function(self,data) return unpack(data) end,
    {
      XBOX_360={args={"B"}},
      XBOX_360_XINPUT={args={"B"}},
      OUYA={args={"A"}},
      PS3={args={"CIRCLE"}},
      KEYBMOUSE={args={"backspace"}},
      LOGITECH_F310={args={"B"}},
    })

  dong:setBind("move",
    function(self,data)
      if type(data[1]) == "boolean" then -- WASD
        local x,y = 0,0
        if data[1] == true then y = y - 1 end
        if data[2] == true then x = x - 1 end
        if data[3] == true then y = y + 1 end
        if data[4] == true then x = x + 1 end
        return x,y
      else
        return unpack(data)
      end
    end,
    {
      XBOX_360={args={"LSX","LSY"},name="LS"},
      XBOX_360_XINPUT={args={"LSX","LSY"},name="LS"},
      OUYA={args={"LSX","LSY"},name="LS"},
      PS3={args={"LSX","LSY"},name="LS"},
      KEYBMOUSE={args={"w","a","s","d"},name="WASD"},
      LOGITECH_F310={args={"LSX","LSY",name="LS"}},
    })

  dong:setBind("shoot",
    function(self,data)
      if type(data[1]) == "boolean" then -- IJKL
        local x,y = 0,0
        if data[1] == true then y = y - 1 end
        if data[2] == true then x = x - 1 end
        if data[3] == true then y = y + 1 end
        if data[4] == true then x = x + 1 end
        return x,y
      else
        return unpack(data)
      end
    end,
    {
      XBOX_360={args={"RSX","RSY"},name="RS"},
      XBOX_360_XINPUT={args={"RSX","RSY"},name="RS"},
      OUYA={args={"RSX","RSY"},name="RS"},
      PS3={args={"RSX","RSY"},name="RS"},
      KEYBMOUSE={args={"i","j","k","l"},name="IJKL"},
      LOGITECH_F310={args={"RSX","RSY",name="RS"}},
    })

end
