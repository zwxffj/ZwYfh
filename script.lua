local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui

local MainColor = Color3.fromRGB(10, 10, 10)
local AccentColor = Color3.fromRGB(35, 35, 35)
local TextColor = Color3.fromRGB(255, 255, 255)

-- 🔊 SOM
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://12222216"
ClickSound.Volume = 1
ClickSound.Parent = SoundService

-- 🟢 BOTÃO FLUTUANTE (DRAG + CLICK REAL)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 120, 0, 40)
OpenBtn.Position = UDim2.new(0.02, 0, 0.8, 0)
OpenBtn.BackgroundColor3 = MainColor
OpenBtn.Text = "Abrir Menu"
OpenBtn.TextColor3 = TextColor
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
OpenBtn.Active = true

Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

-- DRAG SYSTEM (sem abrir ao arrastar)
local dragging = false
local dragStart, startPos
local moved = false

OpenBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		moved = false
		dragStart = input.Position
		startPos = OpenBtn.Position
	end
end)

OpenBtn.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		
		if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
			moved = true
		end
		
		OpenBtn.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

OpenBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
		
		if not moved then
			ClickSound:Play()
			OpenBtn.Visible = false
			MainFrame.Visible = true
			AnimateMenu(true)
		end
	end
end)

-- 🔳 FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -180)
MainFrame.Size = UDim2.new(0, 400, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- 🔴 GLOW
local RedGlow = Instance.new("Frame")
RedGlow.Parent = MainFrame
RedGlow.Size = UDim2.new(1, 0, 1, 0)
RedGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RedGlow.BackgroundTransparency = 0.92

-- 🔥 BORDA NEON
local Stroke = Instance.new("UIStroke")
Stroke.Parent = MainFrame
Stroke.Thickness = 2

task.spawn(function()
	while task.wait(0.03) do
		local glow = (math.sin(tick()*3)+1)/2
		Stroke.Color = Color3.fromRGB(255, glow*120, glow*120)
	end
end)

-- 🏷️ TÍTULO (DESTAQUE)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 80)
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 32
Title.BackgroundTransparency = 1

-- efeito leve no título
task.spawn(function()
	while task.wait(0.03) do
		Title.TextSize = 32 + (math.sin(tick()*3)*2)
	end
end)

-- 📦 BOTÕES
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 110)
ButtonHolder.Size = UDim2.new(1, 0, 1, -120)

local Layout = Instance.new("UIListLayout", ButtonHolder)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- animação menu
function AnimateMenu(show)
	if show then
		MainFrame.Visible = true
		MainFrame.Size = UDim2.new(0,0,0,0)
		MainFrame:TweenSize(UDim2.new(0,400,0,360),"Out","Quart",0.8,true)
	else
		MainFrame:TweenSize(UDim2.new(0,0,0,0),"In","Quart",0.7,true,function()
			MainFrame.Visible = false
			OpenBtn.Visible = true
		end)
	end
end

-- 🔘 BOTÕES
local function CreateBtn(text, argValue, isClose)
	local btn = Instance.new("TextButton")
	btn.Parent = ButtonHolder
	btn.Size = UDim2.new(0.9, 0, 0, 45)
	btn.Text = text
	btn.BackgroundColor3 = isClose and Color3.fromRGB(180,0,0) or AccentColor
	btn.TextColor3 = TextColor
	btn.Font = Enum.Font.SourceSansSemibold
	btn.TextSize = 18
	
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local normal = btn.BackgroundColor3
	local hover = Color3.fromRGB(60,60,60)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hover}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normal}):Play()
	end)

	btn.MouseButton1Click:Connect(function()
		ClickSound:Play()

		if isClose then
			AnimateMenu(false)
		else
			pcall(function()
				game:GetService("ReplicatedStorage").Packages._Index
				:FindFirstChild("sleitnick_knit@1.7.0")
				.knit.Services.SeasonService.RF.RequestRankedReward:InvokeServer(argValue)
			end)
		end
	end)
end

CreateBtn("Lucky Ability", 4)
CreateBtn("Lucky Estilo", 1)
CreateBtn("YEN", 2)
CreateBtn("FECHAR MENU", nil, true)

AnimateMenu(true)
