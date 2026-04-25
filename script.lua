local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainColor = Color3.fromRGB(15, 15, 15)
local AccentColor = Color3.fromRGB(35, 35, 35)
local TextColor = Color3.fromRGB(255, 255, 255)

-- Botão para Reabrir o Menu (FLUTUANTE E ARRASTÁVEL)
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
OpenBtn.Draggable = true -- Agora você pode mover o botão

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenBtn

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160) 
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.ClipsDescendants = false
MainFrame.Active = true
MainFrame.Draggable = true

-- BORDA ANIMADA VERMELHA
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2.5
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local UIGradientStroke = Instance.new("UIGradient")
UIGradientStroke.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
UIGradientStroke.Parent = UIStroke

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- IMAGEM NO TOPO (ID Fornecido)
local TopImage = Instance.new("ImageLabel")
TopImage.Parent = MainFrame
TopImage.BackgroundTransparency = 1
TopImage.Position = UDim2.new(0.5, -40, 0, -50) -- Fica um pouco acima do menu
TopImage.Size = UDim2.new(0, 80, 0, 80)
TopImage.Image = "rbxassetid://101664983542573"
TopImage.ZIndex = 2

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
})

-- ANIMAÇÕES (Borda, Título e Imagem)
task.spawn(function()
    local rot = 0
    local offset = -1
    while task.wait(0.01) do
        -- Rotação da Borda
        rot = rot + 2
        UIGradientStroke.Rotation = rot
        
        -- Brilho do Título
        offset = offset + 0.03
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)
        Title.TextSize = 28 + (math.sin(tick() * 3) * 2)
        
        -- Animação da Imagem (Levitação)
        TopImage.Position = UDim2.new(0.5, -40, 0, -50 + (math.sin(tick() * 2) * 10))
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 90)
ButtonHolder.Size = UDim2.new(1, 0, 1, -100)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Lógica de Abrir/Fechar
local function AnimateMenu(show)
	if show then
		MainFrame.Visible = true
		MainFrame:TweenSize(UDim2.new(0, 400, 0, 350), "Out", "Quart", 0.5, true)
	else
		MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quart", 0.5, true, function()
			MainFrame.Visible = false
			OpenBtn.Visible = true
		end)
	end
end

-- Filtro para evitar abrir ao arrastar
local dragStart = 0
OpenBtn.MouseButton1Down:Connect(function() dragStart = tick() end)

OpenBtn.MouseButton1Up:Connect(function()
    if tick() - dragStart < 0.3 then -- Só abre se for um clique rápido
        OpenBtn.Visible = false
        AnimateMenu(true)
    end
end)

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

AnimateMenu(true)
