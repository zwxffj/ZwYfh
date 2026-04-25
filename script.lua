local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainColor = Color3.fromRGB(10, 10, 10)
local AccentColor = Color3.fromRGB(25, 25, 25)
local TextColor = Color3.fromRGB(255, 255, 255)
local RedNeon = Color3.fromRGB(255, 0, 0)

-- FUNÇÃO DE ANIMAÇÃO DE CLIQUE (AFUNDAR)
local function ClickAnimation(button)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale * 0.95, 0, button.Size.Y.Scale * 0.95, 0)}):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale / 0.95, 0, button.Size.Y.Scale / 0.95, 0)}):Play()
    end)
end

-- BOTÃO ABRIR
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
OpenStroke.Color = RedNeon
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn
ClickAnimation(OpenBtn)

-- FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150) 
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = false -- Importante para o Neon aparecer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- O NEON VERMELHO CORRENDO (BORDA)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 4
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

local UIGradientStroke = Instance.new("UIGradient")
UIGradientStroke.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 0, 0)), -- Escuro
    ColorSequenceKeypoint.new(0.5, RedNeon),                -- Neon Brilhante
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 0))  -- Escuro
})
UIGradientStroke.Parent = UIStroke

-- TÍTULO GIGANTE
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 80)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.Text = "SUPREME STORE"
Title.TextColor3 = TextColor
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 45
Title.BackgroundTransparency = 1

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
})

-- ANIMAÇÕES TÉCNICAS
task.spawn(function()
    local rot = 0
    local offset = -1
    while task.wait(0.01) do
        -- Rotação do Neon na borda
        rot = rot + 5
        UIGradientStroke.Rotation = rot
        
        -- Brilho do título
        offset = offset + 0.03
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)
        Title.TextSize = 45 + (math.sin(tick() * 3) * 2)
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 110)
ButtonHolder.Size = UDim2.new(1, 0, 1, -120)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 12)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- LÓGICA DE ABRIR/FECHAR
local function AnimateMenu(show)
    if show then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 420, 0, 320), "Out", "Back", 0.4, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Quart", 0.4, true, function()
            MainFrame.Visible = false
            OpenBtn.Visible = true
        end)
    end
end

OpenBtn.MouseButton1Up:Connect(function()
    OpenBtn.Visible = false
    AnimateMenu(true)
end)

local function CreateBtn(text, argValue, isClose)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonHolder
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Text = text
    btn.BackgroundColor3 = isClose and Color3.fromRGB(150, 0, 0) or AccentColor
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.AutoButtonColor = false -- Desativado para usar nossa animação custom
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    ClickAnimation(btn)

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
