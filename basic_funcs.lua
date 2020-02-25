warn("loading consts module")

local basic_funcs = {}

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
local fakebackups = {}

if getgenv().funcs == nil or getgenv().main == nil then
  return
end

function basic_funcs:getSize(p)
 if p:isA ("BasePart") then
    return p.Size
  end
  if p:IsA ("MeshPart") then
    return p.Size
 end
end

function basic_funcs:getReplicatedScripts()
  local x = {}
  for i,v in pairs(RS:GetDescendants()) do
    if v:isA("LocalScript") or v:isA("ModuleScript") then
      table.insert(x,v)
    end
  end
  return x
end

function basic_funcs:randomizeName(obj)
  if obj:isA("ScreenGui") or obj:isA("Model") then
    for i,v in pairs(obj:GetDescendants()) do
      v.Name = http:GenerateGUID(false)
    end
  end
  if obj:isA("Part") or obj:isA("MeshPart") or obj:isA("UnionOperation") then
    obj.Name = http:GenerateGUID(false)
  end
end

function basic_funcs:findWS(name,class)
  for i,v in pairs(WS:GetDescendants())do
    if v.Name == name and v:isA(class) then
      return v
    end
  end
end

function basic_funcs:findPlayer(str)
  local plrs = {}
  for i,v in pairs(Players:GetPlayers()) do
    if string.find(tostring(v),string.lower(str)) then
      table.insert(plrs,v)
    end
  end
  if #plrs == 1 then
    return "single",plrs[1]
  end
  if #plrs > 1 then
    return "multi",plrs
  end
  return false
end

function basic_funcs:createBackup(name, f)
  fakebackups[name] = { }
  fakebackups[name].func = f
  return fakebackups[name].func
end

function basic_funcs:isImported(name)
  if getgenv().imported == nil then
    return
  end
  if getgenv().imported[name] ~= nil then
    return true
  end
  return false
end

function basic_funcs:waitForImport(name)
  if getgenv().imported == nil then
    return
  end
  repeat
    wait()
  until self:isImported(name) == true
end

function basic_funcs:import(branch,branch2,name)
  local link = "https://raw.githubusercontent.com/marcelscriptshit/"..branch.."/"..branch2.."/"..name..".lua"
  return loadstring(game:HttpGet(link, true))()
end


return basic_funcs
