warn("loading consts module")

local const_lib = {}

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

local main = getgenv().main
local funcs = getgenv().funcs

if main == nil or funcs == nil then
  return
end


function const_lib:findConst(func,typ,const)
  for i,v in next, getconsts(func) do
    if type(v) == typ and v == const then
      return v
    end
  end
end
function const_lib:matchConsts(func,tabll)
  local found = {}
  for i,v in pairs(tabll) do
    found[v[2]] = const_lib:findConst(func,v[1],v[2])
  end
  for i,v in pairs(tabll) do
    if found[v[2]] == nil then
      return false
    end
  end
  return true
end
function const_lib:warnConsts(func,descend)
  for i,v in next, getconsts(func) do
    warn(i,v,type(v))
    if type(v) == "function" and descend then
      const_lib:warnConsts(func,descend)
    end
  end
end

warn("loaded consts module")

return const_lib
