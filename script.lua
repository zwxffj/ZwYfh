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

-- Frame Principal (Altura aumentada em ~75 pixels / "2cm")
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = MainColor
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -160) 
MainFrame.Size = UDim2.new(0, 400, 0, 325) -- Aumentado na vertical
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Título com Efeito RGB Animado (Sem Rosa/Roxo)
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Text = "SUPREME STORE"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 28
Title.BackgroundTransparency = 1

-- Lógica do RGB Suave (Ignorando Rosa/Roxo)
task.spawn(function()
    local hue = 0
    while task.wait() do
        hue = hue + 0.005
        if hue > 1 then hue = 0 end
        
        -- Filtro: Se a cor estiver entre 0.7 e 0.9 (Rosa/Roxo no espectro HUE), pula para o vermelho (0)
        if hue > 0.7 and hue < 0.9 then
            hue = 0.9
        end
        
        Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
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

-- Animação
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
	btn.Size = UDim2.new(0.9, 0, 0, 45) -- Botões levemente maiores
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
