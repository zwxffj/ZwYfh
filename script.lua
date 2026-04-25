local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui

local MainColor = Color3.fromRGB(15, 15, 15)
local AccentColor = Color3.fromRGB(35, 35, 35)
local TextColor = Color3.fromRGB(255, 255, 255)

-- Botão para Reabrir o Menu
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 120, 0, 40)
OpenBtn.Position = UDim2.new(0.02, 0, 0.9, 0)
OpenBtn.BackgroundColor3 = MainColor
OpenBtn.Text = "Abrir Menu"
OpenBtn.TextColor3 = TextColor
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenBtn

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160) 
MainFrame.Size = UDim2.new(0, 400, 0, 325)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Título com Efeito Preto e Branco (Shiny Effect)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

local Gradient = Instance.new("UIGradient")
Gradient.Parent = Title
-- Configura o gradiente para ter um "ponto de brilho" no meio
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),     -- Preto
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),   -- Branco (Brilho)
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))      -- Preto
})

-- Lógica da Animação Preto e Branco Correndo
task.spawn(function()
    local offset = -1
    while task.wait(0.01) do
        offset = offset + 0.03 -- Velocidade do movimento
        if offset > 1 then
            offset = -1
        end
        Gradient.Offset = Vector2.new(offset, 0)
        
        -- Animação extra de pulsação suave no tamanho (mantida do pedido anterior)
        Title.TextSize = 28 + (math.sin(tick() * 3) * 2)
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 70)
ButtonHolder.Size = UDim2.new(1, 0, 1, -80)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Animação de Entrada
local function AnimateMenu(show)
	if show then
		MainFrame.Visible = true
		MainFrame.Size = UDim2.new(0, 0, 0, 0)
		MainFrame:TweenSize(UDim2.new(0, 400, 0, 325), "Out", "Quart", 0.8, true)
	else
		MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quart", 0.7, true, function()
			MainFrame.Visible = false
			OpenBtn.Visible = true
		end)
	end
end

local function CreateBtn(text, argValue, isClose)
	local btn = Instance.new("TextButton")
	btn.Parent = ButtonHolder
	btn.Size = UDim2.new(0.9, 0, 0, 45)
	btn.Text = text
	btn.BackgroundColor3 = isClose and Color3.fromRGB(180, 0, 0) or AccentColor
	btn.TextColor3 = TextColor
	btn.Font = Enum.Font.SourceSansSemibold
	btn.TextSize = 18
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		if isClose then
			AnimateMenu(false)
		else
			pcall(function()
				game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.7.0").knit.Services.SeasonService.RF.RequestRankedReward:InvokeServer(argValue)
			end)
		end
	end)
end

CreateBtn("Lucky Ability", 4)
CreateBtn("Lucky Estilo", 1)
CreateBtn("YEN", 2)
CreateBtn("FECHAR MENU", nil, true)

OpenBtn.MouseButton1Click:Connect(function()
	OpenBtn.Visible = false
	AnimateMenu(true)
end)

AnimateMenu(true)
