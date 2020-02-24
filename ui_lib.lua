local going = false
local uis = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local info = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
local library = {
  double = false,
  count = 0,
  tween = {},
  version = "1",
  name = "Aurora",
  status = {
    active = {},
  },
}
local dragger = {}

local function ResizeSlider (part,new,_delay)
  _delay = _delay or 0.5
  local tweenInfo = TweenInfo.new(_delay, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
  local tween = TS:Create(part, tweenInfo, new)
  tween:Play()
end



do
	local mouse = game:GetService("Players").LocalPlayer:GetMouse();
	local inputService = game:GetService('UserInputService');
	local heartbeat = game:GetService("RunService").Heartbeat;
	function dragger.new(frame)
	    local s, event = pcall(function()
	    	return frame.MouseEnter
	    end)

	    if s then
	    	frame.Active = true;

	    	event:connect(function()
	    		local input = frame.InputBegan:connect(function(key)
	    			if key.UserInputType == Enum.UserInputType.MouseButton1 then
	    				local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y);
	    				while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
	    					frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Quad', 0.1, true);
	    				end
	    			end
	    		end)

	    		local leave;
	    		leave = frame.MouseLeave:connect(function()
	    			input:disconnect();
	    			leave:disconnect();
	    		end)
	    	end)
	    end
	end

end



function library:Create(class, props)
	local object = Instance.new(class);

	for i, prop in next, props do
		if i ~= "Parent" then
			object[i] = prop;
		end
	end

	object.Parent = props.Parent;
	return object;
end

function library.status:Create(name)
  if not self.frame and library.screengui then
    local Active = Instance.new("Frame")
    Active.Name = "Active"
    Active.Visible = false
    Active.Parent = library.screengui
    Active.BackgroundColor3 = Color3.new(1, 1, 1)
    Active.BackgroundTransparency = 1
    Active.Position = UDim2.new(0.901666641, 0, 0.0896805972, 0)
    Active.Size = UDim2.new(0, 190, 0, 460)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Active
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.frame = Active
  end


  if not self.active[name] then
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = self.frame
    TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(0, 190, 0, 25)
    TextLabel.Font = Enum.Font.Code
    TextLabel.Text = "> "..name
    TextLabel.TextColor3 = Color3.fromRGB(170, 0, 255)
    TextLabel.TextSize = 20
    TextLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.active[name] = TextLabel
  end

end

function library.status:Remove(name)
  if self.active[name] then
    self.active[name]:Destroy()
    self.active[name] = nil
  end
end



function  library:CreateWindow(textt)
  local window = {
    count = 0,
    toggles = {},
    Frame = Instance.new("ImageLabel"),
    Background = Instance.new("Frame"),
    Minimize = Instance.new("TextButton"),
  }

  self.count = self.count + 1
  library.screengui = library.screengui or self:Create("ScreenGui", {Name = "AuroraUI", Parent = game:GetService("CoreGui")})
  if library.logo == nil then
    local text = Instance.new("TextLabel")
    local version = Instance.new("TextLabel")

    text.Name = "Logo"
    text.Parent = library.screengui
    text.BackgroundColor3 = Color3.new(1, 1, 1)
    text.BackgroundTransparency = 1
    text.Position = UDim2.new(-0.0756458254, 0, -0.0577395558, 0)
    text.Size = UDim2.new(0, 551, 0, 232)
    text.Font = Enum.Font.SourceSans
    text.Text = library.name
    text.TextColor3 = Color3.fromRGB(170, 0, 255)
    text.TextSize = 100

    version.Name = "version"
    version.Parent = text
    version.BackgroundColor3 = Color3.new(1, 1, 1)
    version.BackgroundTransparency = 1
    version.BorderSizePixel = 0
    version.Position = UDim2.new(0.535390198, 0, 0.517241418, 0)
    version.Size = UDim2.new(0, 200, 0, 50)
    version.Font = Enum.Font.SourceSansBold
    version.Text = "V"..library.version
    version.TextColor3 = Color3.fromRGB(170, 0, 255)
    version.TextSize = 14
  end
  local ScreenGui = Instance.new("ScreenGui")
  local Top = Instance.new("Frame")
  local text = Instance.new("TextLabel")
  local bar = Instance.new("Frame")
  local UIListLayout = Instance.new("UIListLayout")

  Top.Name = "Top"
  Top.Parent = self.screengui
  Top.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
  Top.BorderSizePixel = 0
  Top.Size = UDim2.new(0, 190, 0, 30)

  if self.count <= 10 and not self.double  then
    Top.Position = UDim2.new(0, (15 + ((200 * self.count) - 200)), 0, 130)
    if self.count == 10 then
      self.double = true
      self.count = 1
    end
  end

  if self.double then
    if self.count <=10 then
      Top.Position = UDim2.new(0, (15 + ((200 * self.count) - 200)), 0, 500)
    end
  end




  text.Name = "text"
  text.Parent = Top
  text.BackgroundColor3 = Color3.new(1, 1, 1)
  text.BackgroundTransparency = 1
  text.BorderSizePixel = 0
  text.Size = UDim2.new(0, 190, 0, 30)
  text.Font = Enum.Font.Code
  text.Text = textt
  text.TextColor3 = Color3.new(1, 1, 1)
  text.TextSize = 20
  text.TextWrapped = true

  window.Minimize.Name = "Minimize"
  window.Minimize.Parent = Top
  window.Minimize.BackgroundColor3 = Color3.new(1, 1, 1)
  window.Minimize.BackgroundTransparency = 1
  window.Minimize.BorderSizePixel = 0
  window.Minimize.Position = UDim2.new(0.842105269, 0, 0, 0)
  window.Minimize.Size = UDim2.new(0, 30, 0, 30)
  window.Minimize.Font = Enum.Font.Code
  window.Minimize.Text = "-"
  window.Minimize.TextColor3 = Color3.new(1, 1, 1)
  window.Minimize.TextSize = 20
  window.Minimize.TextWrapped = true

  bar.Name = "bar"
  bar.Parent = Top
  bar.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
  bar.BorderSizePixel = 0
  bar.Position = UDim2.new(0, 0, 0.899999976, 0)
  bar.Size = UDim2.new(0, 190, 0, 2)

  window.Background.Name = "background"
  window.Background.Parent = Top
  window.Background.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
  window.Background.BorderSizePixel = 0
  window.Background.ClipsDescendants = true
  window.Background.Position = UDim2.new(0, 0, 1, 0)
  window.Background.Size = UDim2.new(0, 190, 0, 0+(20*window.count))

  window.Frame.Name = "Image"
  window.Frame.Parent = window.Background
  window.Frame.BackgroundColor3 = Color3.new(1, 1, 1)
  window.Frame.BackgroundTransparency = 1
  window.Frame.Size = UDim2.new(0, 604, 0, 604)
  window.Frame.Image = "rbxassetid://3343671401"
  window.Frame.ImageTransparency = 0.89999997615814

  UIListLayout.Parent = window.Frame
  UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

  function resize()
    window.Background.Size = UDim2.new(0, 190, 0, 0+(20*window.count))
  end

  local wclosed = false
  window.Minimize.MouseButton1Click:connect(function()
    wclosed = not wclosed
    if wclosed then
      local info = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
      local tw = TS:Create(window.Background,info,{Size = UDim2.new(0, 190, 0, 0)})
      local tw1 = TS:Create(window.Minimize,info,{Rotation = 180})
      window.Minimize.Text = "+"
      tw1:Play()
      tw:Play()
    else
      local info = TweenInfo.new(0.25,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
      local tw = TS:Create(window.Background,info,{Size = UDim2.new(0, 190, 0, 0+(20*window.count))})
      local tw1 = TS:Create(window.Minimize,info,{Rotation = -180})
      window.Minimize.Text = "-"
      tw1:Play()
      tw:Play()
      window.Minimize.Rotation = 0
    end
  end)

  do
    dragger.new(Top)
  end

  function window:AddButton(text,callback)
    self.count = self.count+1
    callback = callback or function() end
    local ButtonFrame = Instance.new("Frame")
    local Button = Instance.new("TextButton")
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Parent = self.Frame
    ButtonFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    Button.Name = "Button"
    Button.Parent = ButtonFrame
    Button.BackgroundColor3 = Color3.new(1, 1, 1)
    Button.BackgroundTransparency = 1
    Button.Position = UDim2.new(0.0526315793, 0, 0, 0)
    Button.Size = UDim2.new(0, 170, 0, 20)
    Button.Text = text
    Button.Font = Enum.Font.Code
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextSize = 14
    Button.TextXAlignment = Enum.TextXAlignment.Left

    Button.MouseButton1Click:connect(callback)
    resize()
		return Button
  end

  function window:AddText(text,sizey)
    self.count = self.count+ (sizey/20)
    callback = callback or function() end
    local ButtonFrame = Instance.new("Frame")
    local Text = Instance.new("TextLabel")
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Parent = self.Frame
    ButtonFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    Text.Name = "Button"
    Text.Parent = ButtonFrame
    Text.BackgroundColor3 = Color3.new(1, 1, 1)
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0.0526315793, 0, 0, 0)
    Text.Size = UDim2.new(0, 170, 0, sizey)
    Text.Text = text
    Text.Font = Enum.Font.Code
    Text.TextColor3 = Color3.new(1, 1, 1)
    Text.TextSize = 14
    Text.TextXAlignment = Enum.TextXAlignment.Left

    resize()
		return Text
  end

  function window:AddStatusFrame(text,color)
    self.count = self.count + 2
    local StatusFrame = Instance.new("Frame")
    local Text = Instance.new("TextLabel")
    local Status = Instance.new("Frame")

    StatusFrame.Name = "StatusFrame"
    StatusFrame.Parent = self.Frame
    StatusFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    StatusFrame.BackgroundTransparency = 1
    StatusFrame.BorderSizePixel = 0
    StatusFrame.Size = UDim2.new(0.331125826, -10, 0.0331125818, 20)

    Text.Name = "Text"
    Text.Parent = StatusFrame
    Text.BackgroundColor3 = Color3.new(1, 1, 1)
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0.278947383, 0, 0, 0)
    Text.Size = UDim2.new(0, 137, 0, 40)
    Text.Font = Enum.Font.Code
    Text.TextColor3 = Color3.new(1, 1, 1)
    Text.Text = text
    Text.TextSize = 14
    Text.TextXAlignment = Enum.TextXAlignment.Left

    Status.Name = "Status"
    Status.Parent = StatusFrame
    Status.BackgroundColor3 = color
    Status.BorderSizePixel = 0
    Status.Position = UDim2.new(0.0789473653, 0, 0.125, 0)
    Status.Size = UDim2.new(0, 30, 0, 30)
    resize()
    return Text,Status
  end

  function window:AddToggle(text,callback,statustt,startmode)
    self.count = self.count+1
    callback = callback or function() end
    local ToggleFrame = Instance.new("Frame")
    local button = Instance.new("TextButton")
    local status = Instance.new("TextLabel")

    ToggleFrame.Name = "ToggleFrame"
    ToggleFrame.Parent = self.Frame
    ToggleFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    button.Name = "button"
    button.Parent = ToggleFrame
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.BackgroundTransparency = 1
    button.Position = UDim2.new(0.105263159, 0, 0, 0)
    button.Size = UDim2.new(0, 170, 0, 20)
    button.Font = Enum.Font.Code
    button.Text = text
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left

    status.Name = "status"
    status.Parent = ToggleFrame
    status.BackgroundColor3 = Color3.new(1, 1, 1)
    status.BackgroundTransparency = 1
    status.Size = UDim2.new(0, 20, 0, 20)
    status.Font = Enum.Font.Code
    status.Text = ">"
    status.TextSize = 14
    local TS = game:GetService("TweenService")
    local info = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)

    if startmode then
      button.TextColor3 = Color3.fromRGB(155, 67, 170)
      status.TextColor3 = Color3.fromRGB(155, 67, 170)
      self.toggles[text] = true
    else
      self.toggles[text] = false
      button.TextColor3 = Color3.fromRGB(255,255,255)
      status.TextColor3 = Color3.fromRGB(255,255,255)
    end

    resize()
    button.MouseButton1Click:connect(function()
			self.toggles[text] = (not self.toggles[text])
			if self.toggles[text] then
        local a = TS:Create(button,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
        local b = TS:Create(status,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
        a:Play()
        b:Play()
        if statustt then
          library.status:Create(text)
        end
      else
        local a = TS:Create(button,info,{TextColor3 = Color3.fromRGB(255,255,255)})
        local b = TS:Create(status,info,{TextColor3 = Color3.fromRGB(255,255,255)})
        a:Play()
        b:Play()
        if statustt then
          library.status:Remove(text)
        end
      end

			callback(self.toggles[text])
		end)
  end

  function window:AddDevider(text)
    self.count = self.count+1
    local text = text or ""
    local Devider = Instance.new("Frame")
    local text_3 = Instance.new("TextLabel")

    Devider.Name = "Devider"
    Devider.Parent = self.Frame
    Devider.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Devider.BackgroundTransparency = 0.5
    Devider.BorderSizePixel = 0
    Devider.Size = UDim2.new(0.331125826, -10, 0, 20)

    text_3.Name = "text"
    text_3.Parent = Devider
    text_3.BackgroundColor3 = Color3.new(1, 1, 1)
    text_3.BackgroundTransparency = 1
    text_3.BorderSizePixel = 0
    text_3.Size = UDim2.new(0, 190, 0, 20)
    text_3.Font = Enum.Font.Code
    text_3.Text = text
    text_3.TextColor3 = Color3.new(1, 1, 1)
    text_3.TextSize = 14
    resize()
  end

  function window:AddBox(text,callback)
    self.count = self.count+1
    local BoxFrame = Instance.new("Frame")
    local Box = Instance.new("TextBox")

    BoxFrame.Name = "BoxFrame"
    BoxFrame.Parent = self.Frame
    BoxFrame.BackgroundColor3 = Color3.new(0.0823529, 0.0823529, 0.0823529)
    BoxFrame.BackgroundTransparency = 1
    BoxFrame.BorderSizePixel = 0
    BoxFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    Box.Name = "Box"
    Box.Parent = BoxFrame
    Box.BackgroundColor3 = Color3.new(0.247059, 0.247059, 0.247059)
    Box.BorderSizePixel = 0
    Box.BackgroundTransparency = 0.4
    Box.Position = UDim2.new(0.0789473653, 0, 0, 0)
    Box.Size = UDim2.new(0.894736826, -10, 0, 20)
    Box.Font = Enum.Font.SourceSans
    Box.Text = text
    Box.TextColor3 = Color3.new(1, 1, 1)
    Box.TextSize = 14
    Box.TextTransparency = 0.30000001192093

    resize()
    Box.FocusLost:connect(function(...)
			callback(Box, ...)
		end)
  end

  function window:AddToggleDropdown(text,callback,statust,startmode)
    local DROPINFO = TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
    self.count = self.count+1
    local dropdown = {
      count = 0,
      toggles = {},
    }

    local DropFrame = Instance.new("Frame")
    local buttonn = Instance.new("TextButton")
    local status = Instance.new("TextLabel")
    local drop = Instance.new("TextButton")

    local DropdownFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Bar = Instance.new("Frame")

    DropFrame.Name = "DropFrame"
    DropFrame.Parent = self.Frame
    DropFrame.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
    DropFrame.BackgroundTransparency = 0.5
    DropFrame.BorderSizePixel = 0
    DropFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    buttonn.Name = "button"
    buttonn.Parent = DropFrame
    buttonn.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
    buttonn.BackgroundTransparency = 1
    buttonn.Position = UDim2.new(0.105263159, 0, 0, 0)
    buttonn.Size = UDim2.new(0, 170, 0, 20)
    buttonn.Font = Enum.Font.Code
    buttonn.Text = text
    buttonn.TextSize = 14
    buttonn.TextXAlignment = Enum.TextXAlignment.Left

    status.Name = "status"
    status.Parent = DropFrame
    status.BackgroundColor3 = Color3.new(1, 1, 1)
    status.BackgroundTransparency = 1
    status.Size = UDim2.new(0, 20, 0, 20)
    status.Font = Enum.Font.Code
    status.Text = ">"
    status.TextSize = 14

    drop.Name = "drop"
    drop.Parent = DropFrame
    drop.BackgroundColor3 = Color3.new(1, 1, 1)
    drop.BackgroundTransparency = 1
    drop.Position = UDim2.new(0.894736826, 0, 0, 0)
    drop.Size = UDim2.new(0, 20, 0, 20)
    drop.Font = Enum.Font.Code
    drop.Text = "v"
    drop.TextColor3 = Color3.new(1, 1, 1)
    drop.TextSize = 15

    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Parent = self.Frame
    DropdownFrame.BackgroundColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
    DropdownFrame.BackgroundTransparency = 0.40000000596046
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Position = UDim2.new(0, 0, 0.165562913, 0)
    DropdownFrame.Size = UDim2.new(0, 190, 0, 0)
    DropdownFrame.Visible = false
    DropdownFrame.ClipsDescendants = true

    UIListLayout.Parent = DropdownFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Bar.Name = "Bar"
    Bar.Parent = DropdownFrame
    Bar.BackgroundColor3 = Color3.fromRGB(114, 49, 126)
    Bar.BorderSizePixel = 0
    Bar.Position = UDim2.new(0, 0, 0.0714285746, 0)
    Bar.Size = UDim2.new(0, 190, 0, 2)
    Bar.Visible = false

    if startmode then
      buttonn.TextColor3 = Color3.fromRGB(155, 67, 170)
      status.TextColor3 = Color3.fromRGB(155, 67, 170)
      self.toggles[text] = true
    else
      self.toggles[text] = false
      buttonn.TextColor3 = Color3.fromRGB(255,255,255)
      status.TextColor3 = Color3.fromRGB(255,255,255)
    end


    buttonn.MouseButton1Click:connect(function()
      self.toggles[text] = (not self.toggles[text])
      if self.toggles[text] then
        local a = TS:Create(buttonn,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
        local b = TS:Create(status,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
        a:Play()
        b:Play()
        if statust then
          library.status:Create(text)
        end
      else
        local a = TS:Create(buttonn,info,{TextColor3 = Color3.fromRGB(255,255,255)})
        local b = TS:Create(status,info,{TextColor3 = Color3.fromRGB(255,255,255)})
        a:Play()
        b:Play()
        if statust then
          library.status:Remove(text)
        end
      end

      callback(self.toggles[text])
    end)
    local db = false
    drop.MouseButton1Click:connect(function()
      if going then return end

      db = not db
      if db then
        going = true
        drop.Text = "^"
        DropdownFrame.Visible = true
        Bar.Visible = true
        for i,v in pairs(DropdownFrame:GetChildren()) do
          if v:isA("Frame") and v.Name ~= "Bar" then
            v.Visible = true
          end
        end
        local tw = TS:Create(DropdownFrame,DROPINFO,{Size = DropdownFrame.Size + UDim2.new(0,0,0,dropdown.count*20)})
        local tw1 = TS:Create(self.Background,DROPINFO,{Size = self.Background.Size + UDim2.new(0,0,0,dropdown.count*20)})
        tw1:Play()
        tw:Play()
        tw.Completed:wait()
        going = false

      else
        going = true
        drop.Text = "v"
        local tw = TS:Create(DropdownFrame,DROPINFO,{Size = DropdownFrame.Size + UDim2.new(0,0,0,-(dropdown.count*20))})
        local tw1 = TS:Create(self.Background,DROPINFO,{Size = self.Background.Size + UDim2.new(0,0,0,-(dropdown.count*20))})
        tw1:Play()
        tw:Play()
        tw.Completed:wait()
        for i,v in pairs(DropdownFrame:GetChildren()) do
          if v:isA("Frame") and v.Name ~= "Bar" then
            v.Visible = false
          end
        end
        going = false
        Bar.Visible = false
        DropdownFrame.Visible = false


      end

    end)





    function dropdown:AddButton(name,callback)
      self.count = self.count +1
      local ButtonFrame = Instance.new("Frame")
      local Button = Instance.new("TextButton")
      ButtonFrame.Name = "ButtonFrame"
      ButtonFrame.Parent = DropdownFrame
      ButtonFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      ButtonFrame.BackgroundTransparency = 1
      ButtonFrame.BorderSizePixel = 0
      ButtonFrame.Size = UDim2.new(1.0526315, -10, 0, 20)
      ButtonFrame.Visible = false

      Button.Name = "Button"
      Button.Parent = ButtonFrame
      Button.BackgroundColor3 = Color3.new(1, 1, 1)
      Button.BackgroundTransparency = 1
      Button.Position = UDim2.new(0.053342998, 0, 0, 0)
      Button.Size = UDim2.new(0, 170, 0, 20)
      Button.Font = Enum.Font.Code
      Button.TextColor3 = Color3.new(1, 1, 1)
      Button.TextSize = 14
      Button.TextXAlignment = Enum.TextXAlignment.Left
      Button.Text = name
      Button.MouseButton1Click:connect(callback)
    end

    function dropdown:AddToggle(text,callback,statustoggle,startmode)
      self.count = self.count+1
      callback = callback or function() end
      local ToggleFrame = Instance.new("Frame")
      local buttonnnnn = Instance.new("TextButton")
      local statusss = Instance.new("TextLabel")

      ToggleFrame.Name = "ToggleFrame"
      ToggleFrame.Parent = DropdownFrame
      ToggleFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      ToggleFrame.BackgroundTransparency = 1
      ToggleFrame.BorderSizePixel = 0
      ToggleFrame.Size = UDim2.new(0.331125826, -10, 0, 20)
      ToggleFrame.Visible = false

      buttonnnnn.Name = "button"
      buttonnnnn.Parent = ToggleFrame
      buttonnnnn.BackgroundColor3 = Color3.new(1, 1, 1)
      buttonnnnn.BackgroundTransparency = 1
      buttonnnnn.Position = UDim2.new(0.4, 0, 0, 0)
      buttonnnnn.Size = UDim2.new(0, 170, 0, 20)
      buttonnnnn.Font = Enum.Font.Code
      buttonnnnn.Text = text
      buttonnnnn.TextSize = 14
      buttonnnnn.TextXAlignment = Enum.TextXAlignment.Left

      statusss.Name = "status"
      statusss.Parent = ToggleFrame
      statusss.BackgroundColor3 = Color3.new(1, 1, 1)
      statusss.BackgroundTransparency = 1
      statusss.Size = UDim2.new(0, 20, 0, 20)
      statusss.Font = Enum.Font.Code
      statusss.Text = ">"
      statusss.TextSize = 14

      if startmode then
        buttonnnnn.TextColor3 = Color3.fromRGB(155, 67, 170)
        statusss.TextColor3 = Color3.fromRGB(155, 67, 170)
        self.toggles[text] = true
      else
        self.toggles[text] = false
        buttonnnnn.TextColor3 = Color3.fromRGB(255,255,255)
        statusss.TextColor3 = Color3.fromRGB(255,255,255)
      end


      buttonnnnn.MouseButton1Click:connect(function()
  			self.toggles[text] = (not self.toggles[text])
  			if self.toggles[text] then
          local a = TS:Create(buttonnnnn,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
          local b = TS:Create(statusss,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
          a:Play()
          b:Play()
          if statustoggle then
            library.status:Create(text)
          end
        else
          local a = TS:Create(buttonnnnn,info,{TextColor3 = Color3.fromRGB(255,255,255)})
          local b = TS:Create(statusss,info,{TextColor3 = Color3.fromRGB(255,255,255)})
          a:Play()
          b:Play()
          if statustoggle then
            library.status:Remove(text)
          end
        end

  			callback(self.toggles[text])
  		end)
    end

    function dropdown:AddSlider(text,min,max,callback)
      self.count = self.count+1
      local Slider = Instance.new("Frame")
      local SliderFrame = Instance.new("Frame")
      local SliderBar = Instance.new("Frame")
      local SliderPart = Instance.new("TextButton")
      local count = Instance.new("TextLabel")
      local text_2 = Instance.new("TextLabel")

      local slideractions = {}
  		local minvalue = min or 0
  		local maxvalue = max or 100
  		callback = callback or function() end


      Slider.Name = "Slider"
      Slider.Parent = DropdownFrame
      Slider.BackgroundColor3 = Color3.new(0, 0, 0)
      Slider.BackgroundTransparency = 1
      Slider.BorderSizePixel = 0
      Slider.Position = UDim2.new(0.4, 0, 0, 0)
      Slider.Size = UDim2.new(0.331125826, -10, 0, 20)

      SliderFrame.Name = "SliderFrame"
      SliderFrame.Parent = Slider
      SliderFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      SliderFrame.BackgroundTransparency = 1
      SliderFrame.BorderSizePixel = 0
      SliderFrame.Position = UDim2.new(1.71, 0, 0, 0)
      SliderFrame.Size = UDim2.new(0, 81, 0, 20)

      SliderBar.Name = "SliderBar"
      SliderBar.Parent = SliderFrame
      SliderBar.BackgroundColor3 = Color3.new(0.607843, 0.262745, 0.666667)
      SliderBar.BorderSizePixel = 0
      SliderBar.Position = UDim2.new(0, 0, 0.449999988, 0)
      SliderBar.Size = UDim2.new(0, 81, 0, 2)

      SliderPart.Name = "SliderPart"
      SliderPart.Parent = SliderBar
      SliderPart.BackgroundColor3 = Color3.new(0.666667, 0, 1)
      SliderPart.BorderSizePixel = 0
      SliderPart.Position = UDim2.new(0, 0, -4, 0)
      SliderPart.Size = UDim2.new(0, 5, 0, 17)
      SliderPart.Font = Enum.Font.SourceSans
      SliderPart.Text = ""
      SliderPart.TextColor3 = Color3.new(0, 0, 0)
      SliderPart.TextSize = 14

      count.Name = "count"
      count.Parent = SliderFrame
      count.BackgroundColor3 = Color3.new(1, 1, 1)
      count.BackgroundTransparency = 1
      count.Position = UDim2.new(0.32100001, 0, 0, 0)
      count.Size = UDim2.new(0, 27, 0, 18)
      count.Font = Enum.Font.SourceSans
      count.Text = tostring(minvalue)
      count.TextColor3 = Color3.new(1, 1, 1)
      count.TextSize = 14

      text_2.Name = "Text"
      text_2.Parent = Slider
      text_2.BackgroundColor3 = Color3.new(1, 1, 1)
      text_2.BackgroundTransparency = 1
      text_2.BorderSizePixel = 0
      text_2.Position = UDim2.new(0.2, 0, 0, 0)
      text_2.Size = UDim2.new(0, 83, 0, 20)
      text_2.Font = Enum.Font.Code
      text_2.Text = text
      text_2.TextColor3 = Color3.new(1, 1, 1)
      text_2.TextSize = 14
      text_2.TextXAlignment = Enum.TextXAlignment.Left

      do -- Slider math

        local currentvalue = minvalue

        local Dragging
        SliderPart.MouseButton1Down:connect(function()
          Dragging = true
        end)
        uis.InputEnded:Connect(function(inputObject)
          if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
          end
        end)

        local originalpos = SliderPart.Position

        local function GetValue ()
          local maxval = SliderFrame.AbsoluteSize.X
          local currentval = SliderPart.Position.X.Offset
          return math.floor((currentval / maxval) * (maxvalue - minvalue) + minvalue)
        end

        local function SetValue (x)
          local newposition = UDim2.new(
            UDim.new(
              0,
              math.clamp(x, 0, SliderFrame.AbsoluteSize.X)
            ),
            originalpos.Y
          )
          ResizeSlider(SliderPart, {Position = newposition}, 0.14)
          count.Text = tostring(GetValue())
        end

        uis.InputChanged:connect(function(InputObject, GameProcessedEvent)
          if ((not GameProcessedEvent) and Dragging) then
            if (InputObject.UserInputType == Enum.UserInputType.MouseMovement) then
              local set = InputObject.Position.X - SliderFrame.AbsolutePosition.X
              SetValue(set)
            end
          end
        end)

        count:GetPropertyChangedSignal("Text"):Connect(function()
          pcall(callback, GetValue())
        end)
    end

      return count
    end


    resize()
    return dropdown
  end


  function window:AddDropdown(text)
    local DROPINFO = TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
    self.count = self.count+1
    local dropdown = {
      count = 0,
      toggles = {},
    }

    local DropFrame = Instance.new("Frame")
    local buttonn = Instance.new("TextButton")
    local drop = Instance.new("TextButton")

    local DropdownFrame = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Bar = Instance.new("Frame")

    DropFrame.Name = "DropFrame"
    DropFrame.Parent = self.Frame
    DropFrame.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
    DropFrame.BackgroundTransparency = 0.5
    DropFrame.BorderSizePixel = 0
    DropFrame.Size = UDim2.new(0.331125826, -10, 0, 20)

    buttonn.Name = "button"
    buttonn.Parent = DropFrame
    buttonn.BackgroundColor3 = Color3.new(0.0470588, 0.0470588, 0.0470588)
    buttonn.BackgroundTransparency = 1
    buttonn.Position = UDim2.new(0.053342998, 0, 0, 0)
    buttonn.Size = UDim2.new(0, 170, 0, 20)
    buttonn.Font = Enum.Font.Code
    buttonn.Text = text
    buttonn.TextColor3 = Color3.new(1, 1, 1)
    buttonn.TextSize = 14
    buttonn.TextXAlignment = Enum.TextXAlignment.Left

    drop.Name = "drop"
    drop.Parent = DropFrame
    drop.BackgroundColor3 = Color3.new(1, 1, 1)
    drop.BackgroundTransparency = 1
    drop.Position = UDim2.new(0.894736826, 0, 0, 0)
    drop.Size = UDim2.new(0, 20, 0, 20)
    drop.Font = Enum.Font.Code
    drop.Text = "v"
    drop.TextColor3 = Color3.new(1, 1, 1)
    drop.TextSize = 15

    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Parent = self.Frame
    DropdownFrame.BackgroundColor3 = Color3.new(0.0588235, 0.0588235, 0.0588235)
    DropdownFrame.BackgroundTransparency = 0.40000000596046
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Position = UDim2.new(0, 0, 0.165562913, 0)
    DropdownFrame.Size = UDim2.new(0, 190, 0, 0)
    DropdownFrame.Visible = false
    DropdownFrame.ClipsDescendants = true

    UIListLayout.Parent = DropdownFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Bar.Name = "Bar"
    Bar.Parent = DropdownFrame
    Bar.BackgroundColor3 = Color3.fromRGB(114, 49, 126)
    Bar.BorderSizePixel = 0
    Bar.Position = UDim2.new(0, 0, 0.0714285746, 0)
    Bar.Size = UDim2.new(0, 190, 0, 2)
    Bar.Visible = false

    local db = false
    drop.MouseButton1Click:connect(function()
      if going then return end

      db = not db
      if db then
        going = true
        Bar.Visible = true
        drop.Text = "^"
        DropdownFrame.Visible = true
        for i,v in pairs(DropdownFrame:GetChildren()) do
          if v:isA("Frame") and v.Name ~= "Bar" then
            v.Visible = true
          end
        end
        local tw = TS:Create(DropdownFrame,DROPINFO,{Size = DropdownFrame.Size + UDim2.new(0,0,0,dropdown.count*20)})
        local tw1 = TS:Create(self.Background,DROPINFO,{Size = self.Background.Size + UDim2.new(0,0,0,dropdown.count*20)})
        tw1:Play()
        tw:Play()
        tw.Completed:wait()
        going = false

      else
        going = true
        drop.Text = "v"
        local tw = TS:Create(DropdownFrame,DROPINFO,{Size = DropdownFrame.Size + UDim2.new(0,0,0,-(dropdown.count*20))})
        local tw1 = TS:Create(self.Background,DROPINFO,{Size = self.Background.Size + UDim2.new(0,0,0,-(dropdown.count*20))})
        tw1:Play()
        tw:Play()
        tw.Completed:wait()
        for i,v in pairs(DropdownFrame:GetChildren()) do
          if v:isA("Frame") and v.Name ~= "Bar" then
            v.Visible = false
          end
        end
        going = false
        Bar.Visible = false
        DropdownFrame.Visible = false


      end

    end)





    function dropdown:AddButton(name,callback)
      self.count = self.count +1
      local ButtonFrame = Instance.new("Frame")
      local Button = Instance.new("TextButton")
      ButtonFrame.Name = "ButtonFrame"
      ButtonFrame.Parent = DropdownFrame
      ButtonFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      ButtonFrame.BackgroundTransparency = 1
      ButtonFrame.BorderSizePixel = 0
      ButtonFrame.Size = UDim2.new(1.0526315, -10, 0, 20)
      ButtonFrame.Visible = false

      Button.Name = "Button"
      Button.Parent = ButtonFrame
      Button.BackgroundColor3 = Color3.new(1, 1, 1)
      Button.BackgroundTransparency = 1
      Button.Position = UDim2.new(0.053342998, 0, 0, 0)
      Button.Size = UDim2.new(0, 170, 0, 20)
      Button.Font = Enum.Font.Code
      Button.TextColor3 = Color3.new(1, 1, 1)
      Button.TextSize = 14
      Button.TextXAlignment = Enum.TextXAlignment.Left
      Button.Text = name
      Button.MouseButton1Click:connect(callback)
    end

    function dropdown:AddToggle(text,callback,statustoggle,startmode)
      self.count = self.count+1
      callback = callback or function() end
      local ToggleFrame = Instance.new("Frame")
      local buttonnnnn = Instance.new("TextButton")
      local statusss = Instance.new("TextLabel")

      ToggleFrame.Name = "ToggleFrame"
      ToggleFrame.Parent = DropdownFrame
      ToggleFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      ToggleFrame.BackgroundTransparency = 1
      ToggleFrame.BorderSizePixel = 0
      ToggleFrame.Size = UDim2.new(0.331125826, -10, 0, 20)
      ToggleFrame.Visible = false

      buttonnnnn.Name = "button"
      buttonnnnn.Parent = ToggleFrame
      buttonnnnn.BackgroundColor3 = Color3.new(1, 1, 1)
      buttonnnnn.BackgroundTransparency = 1
      buttonnnnn.Position = UDim2.new(0.4, 0, 0, 0)
      buttonnnnn.Size = UDim2.new(0, 170, 0, 20)
      buttonnnnn.Font = Enum.Font.Code
      buttonnnnn.Text = text
      buttonnnnn.TextSize = 14
      buttonnnnn.TextXAlignment = Enum.TextXAlignment.Left

      statusss.Name = "status"
      statusss.Parent = ToggleFrame
      statusss.BackgroundColor3 = Color3.new(1, 1, 1)
      statusss.BackgroundTransparency = 1
      statusss.Size = UDim2.new(0, 20, 0, 20)
      statusss.Font = Enum.Font.Code
      statusss.Text = ">"
      statusss.TextSize = 14

      if startmode then
        buttonnnnn.TextColor3 = Color3.fromRGB(155, 67, 170)
        statusss.TextColor3 = Color3.fromRGB(155, 67, 170)
        self.toggles[text] = true
      else
        self.toggles[text] = false
        buttonnnnn.TextColor3 = Color3.fromRGB(255,255,255)
        statusss.TextColor3 = Color3.fromRGB(255,255,255)
      end


      buttonnnnn.MouseButton1Click:connect(function()
  			self.toggles[text] = (not self.toggles[text])
  			if self.toggles[text] then
          local a = TS:Create(buttonnnnn,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
          local b = TS:Create(statusss,info,{TextColor3 = Color3.fromRGB(155, 67, 170)})
          a:Play()
          b:Play()
          if statustoggle then
            library.status:Create(text)
          end
        else
          local a = TS:Create(buttonnnnn,info,{TextColor3 = Color3.fromRGB(255,255,255)})
          local b = TS:Create(statusss,info,{TextColor3 = Color3.fromRGB(255,255,255)})
          a:Play()
          b:Play()
          if statustoggle then
            library.status:Remove(text)
          end
        end

  			callback(self.toggles[text])
  		end)
    end

    function dropdown:AddSlider(text,min,max,callback)
      self.count = self.count+1
      local Slider = Instance.new("Frame")
      local SliderFrame = Instance.new("Frame")
      local SliderBar = Instance.new("Frame")
      local SliderPart = Instance.new("TextButton")
      local count = Instance.new("TextLabel")
      local text_2 = Instance.new("TextLabel")

      local slideractions = {}
  		local minvalue = min or 0
  		local maxvalue = max or 100
  		callback = callback or function() end


      Slider.Name = "Slider"
      Slider.Parent = DropdownFrame
      Slider.BackgroundColor3 = Color3.new(0, 0, 0)
      Slider.BackgroundTransparency = 1
      Slider.BorderSizePixel = 0
      Slider.Position = UDim2.new(0.4, 0, 0, 0)
      Slider.Size = UDim2.new(0.331125826, -10, 0, 20)

      SliderFrame.Name = "SliderFrame"
      SliderFrame.Parent = Slider
      SliderFrame.BackgroundColor3 = Color3.new(1, 1, 1)
      SliderFrame.BackgroundTransparency = 1
      SliderFrame.BorderSizePixel = 0
      SliderFrame.Position = UDim2.new(1.71, 0, 0, 0)
      SliderFrame.Size = UDim2.new(0, 81, 0, 20)

      SliderBar.Name = "SliderBar"
      SliderBar.Parent = SliderFrame
      SliderBar.BackgroundColor3 = Color3.new(0.607843, 0.262745, 0.666667)
      SliderBar.BorderSizePixel = 0
      SliderBar.Position = UDim2.new(0, 0, 0.449999988, 0)
      SliderBar.Size = UDim2.new(0, 81, 0, 2)

      SliderPart.Name = "SliderPart"
      SliderPart.Parent = SliderBar
      SliderPart.BackgroundColor3 = Color3.new(0.666667, 0, 1)
      SliderPart.BorderSizePixel = 0
      SliderPart.Position = UDim2.new(0, 0, -4, 0)
      SliderPart.Size = UDim2.new(0, 5, 0, 17)
      SliderPart.Font = Enum.Font.SourceSans
      SliderPart.Text = ""
      SliderPart.TextColor3 = Color3.new(0, 0, 0)
      SliderPart.TextSize = 14

      count.Name = "count"
      count.Parent = SliderFrame
      count.BackgroundColor3 = Color3.new(1, 1, 1)
      count.BackgroundTransparency = 1
      count.Position = UDim2.new(0.32100001, 0, 0, 0)
      count.Size = UDim2.new(0, 27, 0, 18)
      count.Font = Enum.Font.SourceSans
      count.Text = tostring(minvalue)
      count.TextColor3 = Color3.new(1, 1, 1)
      count.TextSize = 14

      text_2.Name = "Text"
      text_2.Parent = Slider
      text_2.BackgroundColor3 = Color3.new(1, 1, 1)
      text_2.BackgroundTransparency = 1
      text_2.BorderSizePixel = 0
      text_2.Position = UDim2.new(0.2, 0, 0, 0)
      text_2.Size = UDim2.new(0, 83, 0, 20)
      text_2.Font = Enum.Font.Code
      text_2.Text = text
      text_2.TextColor3 = Color3.new(1, 1, 1)
      text_2.TextSize = 14
      text_2.TextXAlignment = Enum.TextXAlignment.Left

      do -- Slider math

        local currentvalue = minvalue

        local Dragging
        SliderPart.MouseButton1Down:connect(function()
          Dragging = true
        end)
        uis.InputEnded:Connect(function(inputObject)
          if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
          end
        end)

        local originalpos = SliderPart.Position

        local function GetValue ()
          local maxval = SliderFrame.AbsoluteSize.X
          local currentval = SliderPart.Position.X.Offset
          return math.floor((currentval / maxval) * (maxvalue - minvalue) + minvalue)
        end

        local function SetValue (x)
          local newposition = UDim2.new(
            UDim.new(
              0,
              math.clamp(x, 0, SliderFrame.AbsoluteSize.X)
            ),
            originalpos.Y
          )
          ResizeSlider(SliderPart, {Position = newposition}, 0.14)
          count.Text = tostring(GetValue())
        end

        uis.InputChanged:connect(function(InputObject, GameProcessedEvent)
          if ((not GameProcessedEvent) and Dragging) then
            if (InputObject.UserInputType == Enum.UserInputType.MouseMovement) then
              local set = InputObject.Position.X - SliderFrame.AbsolutePosition.X
              SetValue(set)
            end
          end
        end)

        count:GetPropertyChangedSignal("Text"):Connect(function()
          pcall(callback, GetValue())
        end)
    end

      return count
    end


    resize()
    return dropdown
  end


  function window:AddSlider(text,min,max,callback)
    self.count = self.count+1
    local Slider = Instance.new("Frame")
    local SliderFrame = Instance.new("Frame")
    local SliderBar = Instance.new("Frame")
    local SliderPart = Instance.new("TextButton")
    local count = Instance.new("TextLabel")
    local text_2 = Instance.new("TextLabel")

    local slideractions = {}
		local minvalue = min or 0
		local maxvalue = max or 100
		callback = callback or function() end


    Slider.Name = "Slider"
    Slider.Parent = self.Frame
    Slider.BackgroundColor3 = Color3.new(0, 0, 0)
    Slider.BackgroundTransparency = 1
    Slider.BorderSizePixel = 0
    Slider.Position = UDim2.new(0, 0, 0.0662251636, 0)
    Slider.Size = UDim2.new(0.331125826, -10, 0, 20)

    SliderFrame.Name = "SliderFrame"
    SliderFrame.Parent = Slider
    SliderFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Position = UDim2.new(0.489783347, 0, 0, 0)
    SliderFrame.Size = UDim2.new(0, 81, 0, 20)

    SliderBar.Name = "SliderBar"
    SliderBar.Parent = SliderFrame
    SliderBar.BackgroundColor3 = Color3.new(0.607843, 0.262745, 0.666667)
    SliderBar.BorderSizePixel = 0
    SliderBar.Position = UDim2.new(-0.000612894713, 0, 0.449999988, 0)
    SliderBar.Size = UDim2.new(0, 81, 0, 2)

    SliderPart.Name = "SliderPart"
    SliderPart.Parent = SliderBar
    SliderPart.BackgroundColor3 = Color3.new(0.666667, 0, 1)
    SliderPart.BorderSizePixel = 0
    SliderPart.Position = UDim2.new(0, 0, -4, 0)
    SliderPart.Size = UDim2.new(0, 5, 0, 17)
    SliderPart.Font = Enum.Font.SourceSans
    SliderPart.Text = ""
    SliderPart.TextColor3 = Color3.new(0, 0, 0)
    SliderPart.TextSize = 14

    count.Name = "count"
    count.Parent = SliderFrame
    count.BackgroundColor3 = Color3.new(1, 1, 1)
    count.BackgroundTransparency = 1
    count.Position = UDim2.new(0.32100001, 0, 0, 0)
    count.Size = UDim2.new(0, 27, 0, 18)
    count.Font = Enum.Font.SourceSans
    count.Text = tostring(minvalue)
    count.TextColor3 = Color3.new(1, 1, 1)
    count.TextSize = 14

    text_2.Name = "Text"
    text_2.Parent = Slider
    text_2.BackgroundColor3 = Color3.new(1, 1, 1)
    text_2.BackgroundTransparency = 1
    text_2.BorderSizePixel = 0
    text_2.Position = UDim2.new(0.0526315793, 0, 0, 0)
    text_2.Size = UDim2.new(0, 83, 0, 20)
    text_2.Font = Enum.Font.Code
    text_2.Text = text
    text_2.TextColor3 = Color3.new(1, 1, 1)
    text_2.TextSize = 14
    text_2.TextXAlignment = Enum.TextXAlignment.Left

    do -- Slider math

      local currentvalue = minvalue

      local Dragging
      SliderPart.MouseButton1Down:connect(function()
        Dragging = true
      end)
      uis.InputEnded:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
          Dragging = false
        end
      end)

      local originalpos = SliderPart.Position

      local function GetValue ()
        local maxval = SliderFrame.AbsoluteSize.X
        local currentval = SliderPart.Position.X.Offset
        return math.floor((currentval / maxval) * (maxvalue - minvalue) + minvalue)
      end

      local function SetValue (x)
        local newposition = UDim2.new(
          UDim.new(
            0,
            math.clamp(x, 0, SliderFrame.AbsoluteSize.X)
          ),
          originalpos.Y
        )
        ResizeSlider(SliderPart, {Position = newposition}, 0.14)
        count.Text = tostring(GetValue())
      end

      uis.InputChanged:connect(function(InputObject, GameProcessedEvent)
        if ((not GameProcessedEvent) and Dragging) then
          if (InputObject.UserInputType == Enum.UserInputType.MouseMovement) then
            local set = InputObject.Position.X - SliderFrame.AbsolutePosition.X
            SetValue(set)
          end
        end
      end)

      count:GetPropertyChangedSignal("Text"):Connect(function()
        pcall(callback, GetValue())
      end)
  end

    resize()
    return count
  end



  return window
end


local guitoggle = false
function onKeyPress(actionName, userInputState, inputObject)
    if userInputState == Enum.UserInputState.Begin then
        if guitoggle == false then
             guitoggle = true
             if library.screengui then
               for i,v in pairs(library.screengui:GetChildren()) do
                 if v.Name == "Top" or v.Name == "Logo" then
                   v.Visible = false
                 end
               end
               if library.status.frame then
                 library.status.frame.Visible = true
               end
             end
        else
            guitoggle = false
            if library.screengui then
              for i,v in pairs(library.screengui:GetChildren()) do
                if v.Name == "Top" or v.Name == "Logo" then
                  v.Visible = true
                end
              end
              if library.status.frame then
                library.status.frame.Visible = false
              end
            end
        end
    end
end

game.ContextActionService:BindAction("keyPress", onKeyPress, false, Enum.KeyCode.RightShift)


return library
