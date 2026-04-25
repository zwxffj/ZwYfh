-- Serviços
local RunService = game:GetService("RunService")

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 120)
Frame.Position = UDim2.new(0.5, -150, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- FUNDO PRETO
Frame.BorderSizePixel = 0

-- Texto animado
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SUPREME"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.RichText = true

-- Animação suave (60 FPS)
local text = Title.Text
local speed = 5

RunService.RenderStepped:Connect(function()
    local t = tick() * speed
    local result = ""

    for i = 1, #text
