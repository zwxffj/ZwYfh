-- // SUPREME MENU - WORD DETECTOR VERSION (fxp & bk)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Limpeza de execuções anteriores
local old = game:GetService("CoreGui"):FindFirstChild("SupremeFinalChat")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SupremeFinalChat"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- // FRAME PRINCIPAL (PRETO TOTAL)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -130)
MainFrame.Size = UDim2.new(0, 220, 0, 260)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false -- Abre ao digitar 'fxp' ou 'bk'
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- CRÉDITOS
local Credits = Instance.new("TextLabel", MainFrame)
Credits.Size = UDim2.new(1, 0, 0, 20)
Credits.BackgroundTransparency = 1
Credits.Text = "By supreme_fxp"
Credits.TextColor3 = Color3.new(0.5, 0.5, 0.5)
Credits.Font = Enum.Font.Gotham
Credits.TextSize = 10

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "BLACK MENU"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17

-- ORGANIZADOR
local UIList = Instance.new("UIListLayout", MainFrame)
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Center

local function createBtn(txt)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.85, 0, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamMedium
    b.Text = txt
    Instance.new("UICorner", b)
    return b
end

local ZoomBtn = createBtn("ZOOM INFINITO: OFF")
local FpsToggle = createBtn("FPS UNLOCK: OFF")

-- SLIDER FPS
local SliderCont = Instance.new("Frame", MainFrame)
SliderCont.Size = UDim2.new(0.85, 0, 0, 45)
SliderCont.BackgroundTransparency = 1

local SliderLabel = Instance.new("TextLabel", SliderCont)
SliderLabel.Size = UDim2.new(1, 0, 0, 20)
SliderLabel.Text = "LIMITE: 60 FPS"
SliderLabel.TextColor3 = Color3.new(1, 1, 1)
SliderLabel.Font = Enum.Font.Gotham
SliderLabel.BackgroundTransparency = 1

local SliderBack = Instance.new("Frame", SliderCont)
SliderBack.Size = UDim2.new(1, 0, 0, 4)
SliderBack.Position = UDim2.new(0, 0, 0.75, 0)
SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local SliderFill = Instance.new("Frame", SliderBack)
SliderFill.Size = UDim2.new(0.1, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local SliderKnob = Instance.new("Frame", SliderBack)
SliderKnob.Size = UDim2.new(0, 14, 0, 14)
SliderKnob.Position = UDim2.new(0.1, -7, 0.5, -7)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)

-- // LÓGICAS FUNCIONAIS
local zoomOn = false
ZoomBtn.MouseButton1Click:Connect(function()
    zoomOn = not zoomOn
    LocalPlayer.CameraMaxZoomDistance = zoomOn and 999999 or 128
    ZoomBtn.Text = zoomOn and "ZOOM: ON" or "ZOOM: OFF"
    ZoomBtn.BackgroundColor3 = zoomOn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(20, 20, 20)
end)

local fpsActive = false
local currentFpsLimit = 60
FpsToggle.MouseButton1Click:Connect(function()
    fpsActive = not fpsActive
    if fpsActive then
        FpsToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        FpsToggle.Text = "FPS: ON"
        if setfpscap then setfpscap(currentFpsLimit) end
    else
        FpsToggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        FpsToggle.Text = "FPS: OFF"
        if setfpscap then setfpscap(60) end
    end
end)

-- SLIDER LOGIC
local draggingSlider = false
SliderKnob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end end)
UserInputService.InputEnded:Connect(function() draggingSlider = false end)

RunService.RenderStepped:Connect(function()
    if draggingSlider then
        local mousePos = UserInputService:GetMouseLocation().X
        local percent = math.clamp((mousePos - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        SliderKnob.Position = UDim2.new(percent, -7, 0.5, -7)
        currentFpsLimit = math.floor(30 + (percent * (999 - 30)))
        SliderLabel.Text = "LIMITE: " .. currentFpsLimit .. " FPS"
        if fpsActive and setfpscap then setfpscap(currentFpsLimit) end
    end
end)

-- // DETECTOR DE PALAVRAS-CHAVE (fxp ou bk)
LocalPlayer.Chatted:Connect(function(msg)
    local message = msg:lower()
    if string.find(message, "fxp") or string.find(message, "bk") then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ARRASTE DO MENU
local dToggle, dStart, sPos
MainFrame.InputBegan:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not draggingSlider then
        dToggle = true dStart = i.Position sPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if dToggle and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dStart
        MainFrame.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dToggle = false end)
