local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
if CoreGui:FindFirstChild("SupremeStore") then CoreGui.SupremeStore:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeStore"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Configurações de Cores Neon e Fundo
local MainColor = Color3.fromRGB(0, 0, 0)
local AccentColor = Color3.fromRGB(20, 20, 20)
local TextColor = Color3.fromRGB(255, 255, 255)
local NeonRed = Color3.fromRGB(255, 0, 0)
local NeonBlue = Color3.fromRGB(0, 150, 255)

local Toggles = {}

local function AddHoverEffect(button, isClose)
    local originalColor = button.BackgroundColor3
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
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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
OpenStroke.Color = NeonRed
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

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

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- 🔥 LOGO NO TOPO
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Parent = MainFrame
Logo.Size = UDim2.new(0, 260, 0, 130)
Logo.Position = UDim2.new(0.5, -130, 0, -80)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://132519679760432"
Logo.ZIndex = 5

-- ANIMAÇÃO LOGO (LEVITAÇÃO)
task.spawn(function()
    while true do
        TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -130, 0, -90)
        }):Play()
        task.wait(1.2)

        TweenService:Create(Logo, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -130, 0, -80)
        }):Play()
        task.wait(1.2)
    end
end)

-- PULSO DA LOGO
task.spawn(function()
    while true do
        local scale = 260 + math.sin(tick()*3)*8
        Logo.Size = UDim2.new(0, scale, 0, 130 + math.sin(tick()*3)*4)
        task.wait(0.03)
    end
end)

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
    ColorSequenceKeypoint.new(0, NeonRed),
    ColorSequenceKeypoint.new(0.5, NeonBlue),
    ColorSequenceKeypoint.new(1, NeonRed)
})

-- STATUS
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 1, -35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "STATUS: ATIVO •"
StatusLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
StatusLabel.Font = Enum.Font.SourceSansSemibold
StatusLabel.TextSize = 14

-- ANIMAÇÕES GERAIS
task.spawn(function()
    local offset = -1
    while task.wait(0.01) do
        offset = offset + 0.025 
        if offset > 1 then offset = -1 end
        TitleGradient.Offset = Vector2.new(offset, 0)

        Title.TextSize = 45 + (math.sin(tick() * 4) * 2)

        local pulse = math.abs(math.sin(tick() * 3))
        StatusLabel.TextColor3 = Color3.fromRGB(80 + (pulse * 20), 100 + (pulse * 155), 80 + (pulse * 20))
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

local dragPos = nil
OpenBtn.MouseButton1Down:Connect(function() dragPos = OpenBtn.AbsolutePosition end)
OpenBtn.MouseButton1Up:Connect(function()
    if dragPos then
        local mag = (OpenBtn.AbsolutePosition - dragPos).Magnitude
        if mag < 10 then
            OpenBtn.Visible = false
            AnimateMenu(true)
        end
    end
end)

local function CreateBtn(text, argValue, isClose)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Parent = ButtonHolder
    btn.Size = UDim2.new(0, 350, 0, 45)
    btn.Text = text
    btn.BackgroundColor3 = isClose and NeonRed or AccentColor
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.AutoButtonColor = true 
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    AddHoverEffect(btn, isClose)

    btn.MouseButton1Click:Connect(function()
        if isClose then
            AnimateMenu(false)
        else
            Toggles[text] = not Toggles[text]
            if Toggles[text] then
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = NeonRed}):Play()
                task.spawn(function()
                    while Toggles[text] do
                        pcall(function()
                            game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.7.0").knit.Services.SeasonService.RF.RequestRankedReward:InvokeServer(argValue)
                        end)
                        task.wait(0.5)
                    end
                end)
            else
                TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = AccentColor}):Play()
            end
        end
    end)
end

CreateBtn("Lucky Ability", 4)
CreateBtn("Lucky Estilo", 1)
CreateBtn("YEN", 2)
CreateBtn("FECHAR MENU", nil, true)
