--[[ 
    PROJECT: MODULUS HUB V36 - AUTOBOT EDITION
    CREDITS: GEMINI & MARCUS
    KEY: GM
]]--

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- REMOVER MENU ANTIGO
if player.PlayerGui:FindFirstChild("ModulusMenu") then player.PlayerGui.ModulusMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "ModulusMenu"
ScreenGui.ResetOnSpawn = false

local bgBlack = Color3.fromRGB(0, 0, 0)
local neonBlue = Color3.fromRGB(0, 150, 255)

-- VARIÁVEIS DE ESTADO
local EspActive = false
local InfiniteJump = true
local ParkourBot = false

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Visible = false
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = bgBlack
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = neonBlue
Instance.new("UICorner", MainFrame)

-- CRÉDITOS (GEMINI E MARCUS)
local Credits = Instance.new("TextLabel", MainFrame)
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Position = UDim2.new(0, 0, 1, -25)
Credits.BackgroundTransparency = 1
Credits.Text = "Créditos: Gemini e Marcus"
Credits.TextColor3 = Color3.fromRGB(200, 200, 200)
Credits.Font = Enum.Font.GothamBold
Credits.TextSize = 14

-- CONTAINER
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(0, 320, 0, 280)
Container.Position = UDim2.new(0, 120, 0, 10)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0,0,2,0)
local layout = Instance.new("UIListLayout", Container); layout.Padding = UDim.new(0,8)

local function makeBtn(txt, func)
    local b = Instance.new("TextButton", Container)
    b.Size = UDim2.new(0.9, 0, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = txt; b.Font = Enum.Font.Gotham
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
    return b
end

-- ==========================================
-- 1. SISTEMA DE ESP (NOMES E BOX)
-- ==========================================
makeBtn("Ativar ESP (Nomes)", function(btn)
    EspActive = not EspActive
    btn.BackgroundColor3 = EspActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(20, 20, 20)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if not EspActive then return end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                if not p.Character.Head:FindFirstChild("NameTag") then
                    local bg = Instance.new("BillboardGui", p.Character.Head)
                    bg.Name = "NameTag"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 100, 0, 50)
                    local tl = Instance.new("TextLabel", bg)
                    tl.Text = p.Name; tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1
                    tl.TextColor3 = Color3.new(1,0,0); tl.Font = Enum.Font.GothamBold
                end
            end
        end
    end)
end)

-- ==========================================
-- 2. PULO INFINITO (SISTEMA NATIVO)
-- ==========================================
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJump then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

makeBtn("Pulo Infinito: ON", function(btn)
    InfiniteJump = not InfiniteJump
    btn.Text = InfiniteJump and "Pulo Infinito: ON" or "Pulo Infinito: OFF"
end)

-- ==========================================
-- 3. PARKOUR BOT (CONTROLE AUTOMÁTICO)
-- ==========================================
makeBtn("Ativar PARKOUR BOT", function(btn)
    ParkourBot = not ParkourBot
    btn.BackgroundColor3 = ParkourBot and neonBlue or Color3.fromRGB(20, 20, 20)
    
    task.spawn(function()
        while ParkourBot do
            -- Sensor de obstáculos (Raycast frontal)
            local forward = root.CFrame.LookVector
            local ray = Ray.new(root.Position, forward * 5)
            local hit = game.Workspace:FindPartOnRay(ray, char)
            
            hum:Move(Vector3.new(0,0,-1), true) -- Sempre anda pra frente
            
            if hit then
                hum.Jump = true -- Pula se houver algo na frente
            end
            
            -- Se estiver caindo, ativa pulo infinito automático
            if hum:GetState() == Enum.HumanoidStateType.Freefall then
                task.wait(0.1)
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            task.wait()
        end
    end)
end)

-- LOGIN E INTERFACE
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 200, 0, 100); KeyFrame.Position = UDim2.new(0.5, -100, 0.4, 0); KeyFrame.BackgroundColor3 = bgBlack
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, 0, 0
