local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainColor = Color3.fromRGB(12, 12, 12)
local AccentColor = Color3.fromRGB(25, 25, 25)
local TextColor = Color3.fromRGB(255, 255, 255)
local RedSupreme = Color3.fromRGB(255, 0, 0)

-- Tabela para controlar quais funções estão ativas
local Toggles = {}

-- Função de animação de clique e Hover
local function AddButtonEffects(button, isClose)
    local originalColor = button.BackgroundColor3
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale * 0.95, 0, button.Size.Y.Scale * 0.95, 0)}):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(button.Size.X.Scale / 0.95, 0, button.Size.Y.Scale / 0.95, 0)}):Play()
    end)
    
    button.MouseEnter:Connect(function()
        if not Toggles[button.Name] then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        end
    end)
    button.MouseLeave:Connect(function()
        if not Toggles[button.Name] then
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
        end
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
OpenBtn.Active = true
OpenBtn.Draggable = true 

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = RedSupreme
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn
AddButtonEffects(OpenBtn, false)

-- FRAME PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -175) 
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local Shadow = Instance.new("ImageLabel")
Shadow.Parent = MainFrame
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014264795"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 80)
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Text = "SUPREME STORE"
Title.TextColor3 = TextColor
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 45
Title.BackgroundTransparency = 1

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, RedSupreme),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, RedSupreme)
})

-- STATUS
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 1, -35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "STATUS: ATIVO •"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.SourceSansSemibold
StatusLabel.TextSize = 14

task.spawn(function()
    local offset = -1
    while task.wait(0.01) do
        offset = offset + 0.012
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)
        Title.TextSize = 45 + (math.sin(tick() * 2) * 1.5)
        local pulse = math.abs(math.sin(tick() * 3))
        StatusLabel.TextColor3 = Color3.fromRGB(100 + (pulse * 50), 100 + (pulse * 155), 100 + (pulse * 50))
    end
end)

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Parent = MainFrame
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Position = UDim2.new(0, 0, 0, 110)
ButtonHolder.Size = UDim2.new(1, 0, 1, -150)

local Layout = Instance.new("UIListLayout")
Layout.Parent = ButtonHolder
Layout.Padding = UDim.new(0, 12)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function AnimateMenu(show)
    if show then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 420, 0, 350), "Out", "Back", 0.4, true)
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

-- FUNÇÃO PARA CRIAR BOTÃO COM LOOP
local function CreateBtn(text, argValue, isClose)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Parent = ButtonHolder
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Text = text
    btn.BackgroundColor3 = isClose and Color3.fromRGB(150, 0, 0) or AccentColor
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    AddButtonEffects(btn, isClose)

    btn.MouseButton1Click:Connect(function()
        if isClose then
            AnimateMenu(false)
        else
            Toggles[text] = not Toggles[text] -- Inverte o estado (On/Off)
            
            if Toggles[text] then
                -- Ativou
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(180, 0, 0)}):Play()
                
                -- Inicia o Loop em uma nova thread
                task.spawn(function()
                    while Toggles[text] do
                        pcall(function()
                            game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.7.0").knit.Services.SeasonService.RF.RequestRankedReward:InvokeServer(argValue)
                        end)
                        task.wait(0.5) -- Tempo entre cada repetição (ajustável)
                    end
                end)
            else
                -- Desativou
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = AccentColor}):Play()
            end
        end
    end)
end

CreateBtn("Lucky Ability", 4)
CreateBtn("Lucky Estilo", 1)
CreateBtn("YEN", 2)
CreateBtn("FECHAR MENU", nil, true)
