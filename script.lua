local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainColor = Color3.fromRGB(15, 15, 15)
local AccentColor = Color3.fromRGB(35, 35, 35)
local TextColor = Color3.fromRGB(255, 255, 255)

-- BOTÃO ABRIR (FLUTUANTE E DISCRETO)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 100, 0, 40)
OpenBtn.Position = UDim2.new(0.02, 0, 0.8, 0)
OpenBtn.BackgroundColor3 = MainColor
OpenBtn.Text = "Abrir Menu"
OpenBtn.TextColor3 = TextColor
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true 

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(120, 0, 180) -- Roxo Gengar
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

-- FRAME PRINCIPAL (Aumentado para caber o Gengar Grande)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -180) 
MainFrame.Size = UDim2.new(0, 400, 0, 380)
MainFrame.ClipsDescendants = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- BORDA ANIMADA (ROXO E VERMELHO)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local UIGradientStroke = Instance.new("UIGradient")
UIGradientStroke.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 255)), -- Roxo
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), -- Vermelho
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 255))
})
UIGradientStroke.Parent = UIStroke

-- GENGAR GRANDE E ANIMADO (Renderizado)
local GengarImage = Instance.new("ImageLabel")
GengarImage.Parent = MainFrame
GengarImage.BackgroundTransparency = 1
-- ID de um Gengar estilizado (Renderizado sem fundo)
GengarImage.Image = "rbxassetid://13426210080" 
GengarImage.Position = UDim2.new(0.5, -75, 0, -110) 
GengarImage.Size = UDim2.new(0, 150, 0, 150)
GengarImage.ZIndex = 10
GengarImage.ScaleType = Enum.ScaleType.Fit

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Position = UDim2.new(0, 0, 0, 45)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 30
Title.BackgroundTransparency = 1

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 80))
})

-- LOOP DE ANIMAÇÕES SUPREME
task.spawn(function()
    local rot = 0
    while task.wait(0.01) do
        -- Rotação da borda
        rot = rot + 3
        UIGradientStroke.Rotation = rot
        
        -- Brilho do título
        TitleGradient.Offset = Vector2.new(math.sin(tick()*2), 0)
        
        -- Animação do Gengar (Levitação Suave + Respiração)
        local float = math.sin(tick() * 2)
        GengarImage.Position = UDim2.new(0.5, -75, 0, -110 + (float * 12))
        GengarImage.Rotation = float * 5
        
        -- Efeito de "Sombra" pulsante no Gengar
        local pulse = 0.8 + (math.sin(tick() * 4) * 0.2)
        GengarImage.ImageColor3 = Color3.new(pulse, pulse, pulse)
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 120)
ButtonHolder.Size = UDim2.new(1, 0, 1, -130)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 12)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- LÓGICA DE CLIQUE REAL (Anti-Arraste)
local function AnimateMenu(show)
	if show then
		MainFrame.Visible = true
		MainFrame:TweenSize(UDim2.new(0, 400, 0, 380), "Out", "Back", 0.5, true)
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
        if dist < 10 then 
            OpenBtn.Visible = false
            AnimateMenu(true)
        end
    end
end)

-- CRIAÇÃO DOS BOTÕES
local function CreateBtn(text, argValue, isClose)
	local btn = Instance.new("TextButton")
	btn.Parent = ButtonHolder
	btn.Size = UDim2.new(0.85, 0, 0, 45)
	btn.Text = text
	btn.BackgroundColor3 = isClose and Color3.fromRGB(180, 0, 0) or AccentColor
	btn.TextColor3 = TextColor
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn
    
    -- Efeito de Hover (Brilho ao passar mouse)
    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = isClose and Color3.fromRGB(180, 0, 0) or AccentColor end)

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
