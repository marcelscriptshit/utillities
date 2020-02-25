warn("loading loop module")

local loops_lib = {}
loops_lib.loops = {}

local r = game:GetService("RunService")
local Players = game:GetService("Players")
local WS = game:GetService("Workspace") or workspace
local L = game:GetService("Lighting")
local http = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local CG = game:GetService("CoreGui")
local P = game:GetService("PathfindingService")
local SG = game:GetService("StarterGui")
local Teams = game:GetService("Teams")
local Debris = game:GetService("Debris")
local Collec = game:GetService("CollectionService")
local LP = Players.LocalPlayer

local getconsts = debug.getconstants
local setconst = debug.setconstant
local getconst = debug.getconstant
local getupval = debug.getupvalue or getupvalue
local getupvals = debug.getupvalues or getupvalues or secret953
local getreg = debug.getregistry or getregistry or getreg
local setupval = debug.setupvalue or setupvalue or secret500
local mt = getrawmetatable(game)
local setreadonly = make_writeable or setreadonly
local copy = setclipboard or clipboard.set or copystring

local main = getgenv().aurora.main
local funcs = getgenv().aurora.funcs

if getgenv().funcs == nil or getgenv().main == nil then
  return
end

function loops_lib:CreateLoop(name, func, wait_time, destroyed, ...)
  local loops = loops_lib.loops
  if loops[name] ~= nil then
    return
  end
  loops[name] = {}
  loops[name].Running = false
  loops[name].Destroy = false
  loops[name].CanBeDestroyed = destroyed
  loops[name].Loop = coroutine.create(function(...)
    while true do
      if loops[name].Running then
        func(...)
      end
      if loops[name].Destroy then
        break
      end

      if type(wait) == "userdata" then
        wait_time:wait()
      else
        wait(wait_time)
      end
    end
  end)
end


function loops_lib:RunLoop(name, func, wait_time, destroyed, ...)
  local loops = loops_lib.loops
  if loops[name] == nil then
    if func ~= nil then
      loops_lib:CreateLoop(name, func, wait_time, destroyed, ...)
    end
  end
  loops[name].Running = true
  local Succes,Failed = coroutine.resume(loops[name].Loop)
  if not Succes then
    warn("Loop: " .. tostring(name) .. " ERROR: " .. tostring(Failed))
  end
end


function loops_lib:StopLoop(name) then
  local loops = loops_lib.loops
  if loops[name] == nil then
    return
  end
  loops[name].Running = false
end


function loops_lib:BreakLoop(name) then
  local loops = loops_lib.loops
  if loops[name] == nil then
    return
  end
  loops_lib:StopLoop(name)
  loops[name].Destroy = true
  loops[name] = nil
end


function loops_lib:BreakAllLoops()
  for i,v in next, loops do
    loops_lib:BreakLoop(v)
  end
end



warn("loaded loop module")

return loops_lib
