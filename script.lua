local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui

local MainColor = Color3.fromRGB(15, 15, 15)
local AccentColor = Color3.fromRGB(35, 35, 35)
local TextColor = Color3.fromRGB(255, 255, 255)

-- 🔊 SOM
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://12222216"
ClickSound.Volume = 1
ClickSound.Parent = SoundService

-- 🟢 BOTÃO FLUTUANTE (AGORA ARRASTÁVEL)
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
OpenBtn.Draggable = true

Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)

-- 🔳 FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -180)
MainFrame.Size = UDim2.new(0, 400, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- 🔴 GLOW FUNDO
local RedGlow = Instance.new("Frame")
RedGlow.Parent = MainFrame
RedGlow.Size = UDim2.new(1, 0, 1, 0)
RedGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
RedGlow.BackgroundTransparency = 0.9
RedGlow.ZIndex = 0

local GlowGradient = Instance.new("UIGradient", RedGlow)
GlowGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}
GlowGradient.Rotation = 90

-- 🔥 BORDA NEON
local Stroke = Instance.new("UIStroke")
Stroke.Parent = MainFrame
Stroke.Color = Color3.fromRGB(255, 0, 0)
Stroke.Thickness = 2

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Parent = Stroke
StrokeGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,100,100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0))
}

-- animação neon
task.spawn(function()
	local offset = 0
	while task.wait(0.02) do
		offset += 0.02
		StrokeGradient.Offset = Vector2.new(offset,0)
	end
end)

-- 🖼️ LOGO
local Logo = Instance.new("ImageLabel")
Logo.Parent = MainFrame
Logo.Size = UDim2.new(0, 180, 0, 100)
Logo.Position = UDim2.new(0.5, -90, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://SEU_ID_AQUI"

local LogoScale = Instance.new("UIScale", Logo)

task.spawn(function()
	while task.wait(0.02) do
		LogoScale.Scale = 1 + (math.sin(tick()*2)*0.03)
	end
end)

-- 🏷️ TÍTULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 100)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

-- 📦 BOTÕES
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 150)
ButtonHolder.Size = UDim2.new(1, 0, 1, -160)

local Layout = Instance.new("UIListLayout", ButtonHolder)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- animação menu
local function AnimateMenu(show)
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

	-- hover
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

OpenBtn.MouseButton1Click:Connect(function()
	ClickSound:Play()
	OpenBtn.Visible = false
	AnimateMenu(true)
end)

AnimateMenu(true)
