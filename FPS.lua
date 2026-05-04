-- // SUPREME MENU - OBFUSCATED VERSION
local _v=game;local _s=_v.GetService;local _0x5F={
    [121]=_s(_v,"\80\108\97\121\101\114\115"),
    [122]=_s(_v,"\85\115\101\114\73\110\112\117\116\83\101\114\118\105\99\101"),
    [123]=_s(_v,"\82\117\110\83\101\114\118\105\99\101"),
    [124]=_s(_v,"\67\111\114\101\71\117\105")
}
local _0xLP=_0x5F[121].LocalPlayer

local function _0xCall(id,...)
    local _funcs={
        [1]=function(a) return Instance.new(a) end,
        [2]=function(a,b) a.Parent=b end,
        [3]=function(a,b) return a:FindFirstChild(b) end
    }
    return _funcs[id](...)
end

local _0xOld=_0xCall(3, _0x5F[124], "\83\117\112\114\101\109\101\70\105\110\97\108\67\104\97\116")
if _0xOld then _0xOld:Destroy() end

local _0xSC=_0xCall(1, "\83\99\114\101\101\110\71\117\105")
_0xSC.Name="\83\117\112\114\101\109\101\70\105\110\97\108\67\104\97\116"
_0xCall(2, _0xSC, _0x5F[124])
_0xSC.ResetOnSpawn = false

local _0xM=_0xCall(1, "\70\114\97\109\101")
_0xM.Parent=_0xSC;_0xM.BackgroundColor3=Color3.fromRGB(0,0,0)
_0xM.Position=UDim2.new(0.5,-110,0.5,-130)
_0xM.Size=UDim2.new(0,220,0,260)
_0xM.BorderSizePixel=0;_0xM.Visible=false
_0xCall(1, "\85\73\67\111\114\110\101\114", _0xM).CornerRadius=UDim.new(0,12)

local function _0xBT(t)
    local b=_0xCall(1, "\84\101\120\116\66\117\116\116\111\110")
    b.Parent=_0xM;b.Size=UDim2.new(0.85,0,0,38)
    b.BackgroundColor3=Color3.fromRGB(20,20,20)
    b.Text=t;b.TextColor3=Color3.new(1,1,1)
    b.Font=Enum.Font.GothamMedium
    _0xCall(1,"\85\73\67\111\114\110\101\114", b)
    return b
end

local _0xZ=_0xBT("\90\79\79\77\32\73\78\70\73\78\73\84\79\58\32\79\70\70")
local _0xFP=_0xBT("\70\80\83\32\85\78\76\79\67\75\58\32\79\70\70")

local _0xST=false
_0xZ.MouseButton1Click:Connect(function()
    _0xST=not _0xST
    _0xLP.CameraMaxZoomDistance=_0xST and 999999 or 128
    _0xZ.Text=_0xST and "\90\79\79\77\58\32\79\78" or "\90\79\79\77\58\32\79\70\70"
    _0xZ.BackgroundColor3=_0xST and Color3.fromRGB(0,150,0) or Color3.fromRGB(20,20,20)
end)

_0xLP.Chatted:Connect(function(m)
    if string.find(m:lower(), "\102\120\112") then
        _0xM.Visible=not _0xM.Visible
    end
end)

local _0xD,_0xP,_0xO
_0xM.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        _0xD=true;_0xP=i.Position;_0xO=_0xM.Position
    end
end)
_0x5F[122].InputChanged:Connect(function(i)
    if _0xD and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
        local d=i.Position-_0xP
        _0xM.Position=UDim2.new(_0xO.X.Scale,_0xO.X.Offset+d.X,_0xO.Y.Scale,_0xO.Y.Offset+d.Y)
    end
end)
_0x5F[122].InputEnded:Connect(function() _0xD=false end)
