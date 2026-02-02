--[[ 
    PROJECT: MODULUS HUB V35 - FIXED EDITION
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

-- VARIÁVEIS DE CONTROLE
local flying = false
local flySpeed = 50
local EspEnabled = false
local Camera = game.Workspace.CurrentCamera

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Visible = false
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = bgBlack
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = neonBlue
Instance.new("UICorner", MainFrame)

-- CRÉDITOS
local CreditsLabel = Instance.new("TextLabel", MainFrame)
CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
CreditsLabel.Position = UDim2.new(0, 0, 1, -25)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "Créditos: Gemini e Marcus"
CreditsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
CreditsLabel.TextSize = 14

-- CONTAINER DE ABAS
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -120, 1, -40)
Container.Position = UDim2.new(0, 115, 0, 5)
Container.BackgroundTransparency = 1

local function createTab()
    local f = Instance.new("ScrollingFrame", Container)
    f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1; f.Visible = false
    f.CanvasSize = UDim2.new(0, 0, 2, 0); f.ScrollBarThickness = 2
    Instance.new("UIListLayout", f).Padding = UDim.new(0, 5)
    return f
end

local TabVisuais = createTab()
local TabVoo = createTab()
local TabF3X = createTab()
local TabParkour = createTab()

local function addBtn(txt, parent, func)
    local b = Instance.new("TextButton", parent)
    b.Text = txt; b.Size = UDim2.new(0.95, 0, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25); b.TextColor3 = textColor
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(func)
end

-- ==========================================
-- FUNÇÃO VISUAIS (ESP)
-- ==========================================
addBtn("Ativar ESP Nomes", TabVisuais, function(btn)
    EspEnabled = not EspEnabled
    btn.Text = EspEnabled and "ESP: ON" or "Ativar ESP Nomes"
    task.spawn(function()
        while EspEnabled do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    if not v.Character:FindFirstChild("EspGui") then
                        local b = Instance.new("BillboardGui", v.Character)
                        b.Name = "EspGui"; b.AlwaysOnTop = true; b.Size = UDim2.new(0, 100, 0, 50)
                        local t = Instance.new("TextLabel", b); t.Text = v.Name; t.Size = UDim2.new(1, 0, 1, 0)
                        t.BackgroundTransparency = 1; t.TextColor3 = neonBlue
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- ==========================================
-- FUNÇÃO VOO (FLY ITACHI)
-- ==========================================
addBtn("Ligar Fly V3", TabVoo, function(btn)
    flying = not flying
    btn.Text = flying and "FLY: ON" or "Ligar Fly V3"
    local char = game.Players.LocalPlayer.Character
    local bv, bg
    if flying then
        bg = Instance.new("BodyGyro", char.HumanoidRootPart)
        bg.P = 9e4; bg.maxTorque = Vector3.new(9e9, 9e9, 9e9); bg.cframe = char.HumanoidRootPart.CFrame
        bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bv.velocity = Vector3.new(0, 0.1, 0); bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while flying do
                char.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                bv.velocity = Camera.CFrame.LookVector * flySpeed
                bg.cframe = Camera.CFrame
                task.wait()
            end
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
            char.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end)
    end
end)

-- ==========================================
-- OUTRAS FUNÇÕES
-- ==========================================
addBtn("Dar F3X", TabF3X, function()
    Instance.new("HopperBin", game.Players.LocalPlayer.Backpack).BinType = "Hammer"
    Instance.new("HopperBin", game.Players.LocalPlayer.Backpack).BinType = "Grab"
end)

addBtn("Pulo Infinito", TabParkour, function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- BARRA LATERAL (BOTÕES DE ABA)
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 110, 1, -30); TabFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)

local function addTabBtn(txt, pos, tab)
    local b = Instance.new("TextButton", TabFrame)
    b.Text = txt; b.Size = UDim2.new(1, 0, 0, 45); b.Position = pos; b.BackgroundTransparency = 1; b.TextColor3 = neonBlue
    b.MouseButton1Click:Connect(function()
        TabVisuais.Visible = false; TabVoo.Visible = false; TabF3X.Visible = false; TabParkour.Visible = false
        tab.Visible = true
    end)
end

addTabBtn("Visuais", UDim2.new(0,0,0,0), TabVisuais)
addTabBtn("Voo", UDim2.new(0,0,0,45), TabVoo)
addTabBtn("F3X", UDim2.new(0,0,0,90), TabF3X)
addTabBtn("Parkour", UDim2.new(0,0,0,135), TabParkour)

-- LOGIN
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 260, 0, 130); KeyFrame.Position = UDim2.new(0.5, -130, 0.4, 0); KeyFrame.BackgroundColor3 = bgBlack
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.PlaceholderText = "Senha..."; KeyInput.Size = UDim2.new(0.8, 0, 0, 35); KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0); KeyInput.TextColor3 = textColor
local LoginBtn = Instance.new("TextButton", KeyFrame)
LoginBtn.Text = "LOGIN"; LoginBtn.Size = UDim2.new(0.8, 0, 0, 35); LoginBtn.Position = UDim2.new(0.1, 0, 0.7, 0); LoginBtn.BackgroundColor3 = neonBlue

local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, -22); OpenBtn.BackgroundColor3 = bgBlack; OpenBtn.TextColor3 = neonBlue; OpenBtn.Text = "GM"; OpenBtn.Visible = false
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

LoginBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "GM" then KeyFrame:Destroy(); MainFrame.Visible = true; OpenBtn.Visible = true; TabVisuais.Visible = true end
end)
