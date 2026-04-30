local ScreenGui = Instance.new("ScreenGui")
local Alvo = Instance.new("TextButton")
local Menu = Instance.new("TextButton")

-- Tenta colocar no CoreGui
local parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Parent = parent

-- 1. BOTÃO ALVO
Alvo.Name = "Alvo"
Alvo.Parent = ScreenGui
Alvo.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Alvo.BackgroundTransparency = 0.5
Alvo.Position = UDim2.new(0.5, -25, 0.5, -25)
Alvo.Size = UDim2.new(0, 50, 0, 50)
Alvo.Text = "+"
Alvo.TextColor3 = Color3.fromRGB(255, 255, 255)
Alvo.Draggable = true
Alvo.Active = true

-- 2. BOTÃO DE CONTROLE
Menu.Name = "Menu"
Menu.Parent = ScreenGui
Menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Menu.Position = UDim2.new(0, 10, 0.4, 0)
Menu.Size = UDim2.new(0, 80, 0, 40)
Menu.Text = "LIGAR"
Menu.TextColor3 = Color3.fromRGB(255, 255, 255)
Menu.Draggable = true

local clicando = false
local vim = game:GetService("VirtualInputManager")

Menu.MouseButton1Click:Connect(function()
    if not clicando then
        clicando = true
        Menu.Text = "PARAR"
        Menu.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

        local x = Alvo.AbsolutePosition.X + (Alvo.AbsoluteSize.X / 2)
        local y = Alvo.AbsolutePosition.Y + (Alvo.AbsoluteSize.Y / 2) + 36

        Alvo.Visible = false

        task.spawn(function()
            while clicando do
                vim:SendMouseButtonEvent(x, y, 0, true, game, 0)
                task.wait(0.01) 
                vim:SendMouseButtonEvent(x, y, 0, false, game, 0)
                task.wait(0.2) -- VELOCIDADE AJUSTADA PARA 0.2
            end
        end)
    else
        clicando = false
        Menu.Text = "LIGAR"
        Menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Alvo.Visible = true
    end
end)
