--[[ 
    PROJECT: MODULUS HUB V34 - BTOOLS EDITION
    CREDITS: GEMINI & MARCUS
    KEY: GM
]]--

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("ModulusMenu") then playerGui.ModulusMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModulusMenu"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

local bgBlack = Color3.fromRGB(0, 0, 0)
local neonBlue = Color3.fromRGB(0, 150, 255)
local textColor = Color3.new(1, 1, 1)

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Visible = false
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = bgBlack
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = neonBlue
Instance.new("UICorner", MainFrame)

-- TEXTO DE CRÉDITOS
local CreditsLabel = Instance.new("TextLabel", MainFrame)
CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
CreditsLabel.Position = UDim2.new(0, 0, 1, -25)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "Créditos: Gemini e Marcus"
CreditsLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
CreditsLabel.Font = Enum.Font.GothamSemibold
CreditsLabel.TextSize = 12

-- BARRA LATERAL E CONTAINER
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 110, 1, -30)
TabFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Instance.new("UICorner", TabFrame)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -120, 1, -40)
Container.Position = UDim2.new(0, 115, 0, 5)
Container.BackgroundTransparency = 1

local function createTab(name)
    local f = Instance.new("ScrollingFrame", Container)
    f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    f.Name = name; f.CanvasSize = UDim2.new(0, 0, 2, 0); f.ScrollBarThickness = 2
    local layout = Instance.new("UIListLayout", f); layout.Padding = UDim.new(0, 5)
    return f
end

local TabF3X = createTab("F3X")
local TabParkour = createTab("Parkour")
local TabVoo = createTab("Voo")
local TabVisuais = createTab("Visuais")

local function addBtn(txt, parent, func)
    local b = Instance.new("TextButton", parent)
    b.Text = txt; b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20); b.TextColor3 = textColor
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(func)
    return b
end

-- ==========================================
-- 1. ABA F3X (BTOOLS)
-- ==========================================
addBtn("Dar F3X (BTools)", TabF3X, function()
    -- Comando clássico de BTools para dar as ferramentas de edição
    local tool1 = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    tool1.BinType = "Hammer"
    local tool2 = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    tool2.BinType = "Clone"
    local tool3 = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    tool3.BinType = "Grab"
end)

addBtn("Limpar Ferramentas", TabF3X, function()
    for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item:IsA("HopperBin") then item:Destroy() end
    end
end)

-- ==========================================
-- OUTRAS FUNÇÕES (RESUMIDAS PARA O CÓDIGO)
-- ==========================================
addBtn("Ativar Auto-Parkour", TabParkour, function() 
    -- Lógica Parkour mantida
end)

-- TROCA DE ABAS
local function addTabBtn(txt, pos, tab)
    local b = Instance.new("TextButton", TabFrame)
    b.Text = txt; b.Size = UDim2.new(1, 0, 0, 45); b.Position = pos; b.BackgroundTransparency = 1; b.TextColor3 = neonBlue
    b.MouseButton1Click:Connect(function()
        TabF3X.Visible = false; TabParkour.Visible = false; TabVoo.Visible = false; TabVisuais.Visible = false; tab.Visible = true
    end)
end

addTabBtn("F3X", UDim2.new(0,0,0,0), TabF3X)
addTabBtn("Parkour", UDim2.new(0,0,0,45), TabParkour)
addTabBtn("Voo", UDim2.new(0,0,0,90), TabVoo)
addTabBtn("Visual", UDim2.new(0,0,0,135), TabVisuais)

-- LOGIN E ABRIR
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 260, 0, 130); KeyFrame.Position = UDim2.new(0.5, -130, 0.4, 0); KeyFrame.BackgroundColor3 = bgBlack; Instance.new("UICorner", KeyFrame)
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.PlaceholderText = "Senha..."; KeyInput.Size = UDim2.new(0.8, 0, 0, 35); KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0); KeyInput.TextColor3 = textColor; KeyInput.BackgroundColor3 = Color3.fromRGB(15,15,15)
local LoginBtn = Instance.new("TextButton", KeyFrame)
LoginBtn.Text = "LOGIN"; LoginBtn.Size = UDim2.new(0.8, 0, 0, 35); LoginBtn.Position = UDim2.new(0.1, 0, 0.7, 0); LoginBtn.BackgroundColor3 = neonBlue

local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, -22); OpenBtn.BackgroundColor3 = bgBlack; OpenBtn.TextColor3 = neonBlue; OpenBtn.Text = "GM"; OpenBtn.Visible = false; Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

LoginBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "GM" then KeyFrame:Destroy(); MainFrame.Visible = true; OpenBtn.Visible = true; TabF3X.Visible = true end
end)
