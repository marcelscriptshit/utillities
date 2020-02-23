warn("loading upvs module")

getgenv().upvs_lib = {}

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
local upvs_lib = getgenv().upvs_lib

if getgenv().funcs == nil or getgenv().main == nil then
  return
end


function upvs_lib:findWithTable(name)
  for i,v in next, getreg() do
    if type(v) == "function" and not is_synapse_function(v) then
      for i2,v2 in next, getupvals(v) do
        if type(v2) == "table" and rawget(v2,name) then
          return rawget(v2,name)
        end
      end
    end
  end
  return false
end


function upvs_lib:warnUpvs(func,descend)
  for i,v in next, getuvpals(func) do
    warn(i,v,type(v))
    if type(v) == "function" and descend then
      upvs_lib:warnUpvs(func,descend)
    end
  end
end


warn("loaded upvs module")
