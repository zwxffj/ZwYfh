local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainColor = Color3.fromRGB(10, 10, 10)
local AccentColor = Color3.fromRGB(25, 25, 25)
local TextColor = Color3.fromRGB(255, 255, 255)
local RedSupreme = Color3.fromRGB(255, 0, 0)

-- BOTÃO ABRIR (ARRASTÁVEL)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 120, 0, 45)
OpenBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
OpenBtn.BackgroundColor3 = MainColor
OpenBtn.Text = "ABRIR MENU"
OpenBtn.TextColor3 = TextColor
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 16
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true 

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = RedSupreme
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

-- FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) 
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- BORDA ANIMADA ESTILO CARREGAMENTO (LOADING BORDER)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 4 -- Borda mais grossa para destacar o efeito
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local UIGradientStroke = Instance.new("UIGradient")
UIGradientStroke.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 0)),   -- Vermelho Escuro
    ColorSequenceKeypoint.new(0.45, RedSupreme),            -- Vermelho Brilhante
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)), -- Centro do Brilho
    ColorSequenceKeypoint.new(0.55, RedSupreme),            -- Vermelho Brilhante
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 0))   -- Vermelho Escuro
})
UIGradientStroke.Parent = UIStroke

-- TÍTULO "SUPREME STORE" (AUMENTADO)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 80) -- Altura aumentada
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Text = "SUPREME STORE"
Title.TextColor3 = TextColor
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 42 -- Texto Gigante
Title.BackgroundTransparency = 1

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
})

-- ANIMAÇÃO DA BORDA E DO TÍTULO
task.spawn(function()
    local rot = 0
    local offset = -1
    while task.wait(0.01) do
        -- Efeito de carregamento girando na borda
        rot = rot + 4 -- Velocidade da rotação
        UIGradientStroke.Rotation = rot
        
        -- Brilho do título (mantendo a sua animação original)
        offset = offset + 0.03
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)
        
        -- Pulsação leve no tamanho do título gigante
        Title.TextSize = 42 + (math.sin(tick() * 3) * 2)
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 100)
ButtonHolder.Size = UDim2.new(1, 0, 1, -110)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- LÓGICA DE ABRIR/FECHAR
local function AnimateMenu(show)
	if show then
		MainFrame.Visible = true
		MainFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Quart", 0.5, true)
	else
		MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quart", 0.5, true, function()
			MainFrame.Visible = false
			OpenBtn.Visible = true
		end)
	end
end

local dragStartPos = nil
OpenBtn.MouseButton1Down:Connect(function() dragStartPos = OpenBtn.AbsolutePosition end)
OpenBtn.MouseButton1Up:Connect(function()
    if dragStartPos then
        local dist = (OpenBtn.AbsolutePosition - dragStartPos).Magnitude
        if dist < 8 then 
            OpenBtn.Visible = false
            AnimateMenu(true)
        end
    end
end)

local function CreateBtn(text, argValue, isClose)
	local btn = Instance.new("TextButton")
	btn.Parent = ButtonHolder
	btn.Size = UDim2.new(0.9, 0, 0, 42)
	btn.Text = text
	btn.BackgroundColor3 = isClose and Color3.fromRGB(150, 0, 0) or AccentColor
	btn.TextColor3 = TextColor
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
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

AnimateMenu(true)
