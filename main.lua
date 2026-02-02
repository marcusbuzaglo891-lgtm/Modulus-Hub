--[[ 
    PROJECT: MODULUS HUB V39 - AUTO-PARKOUR & ESP
    CREDITS: GEMINI & MARCUS
    KEY: GM
]]--

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local inputService = game:GetService("UserInputService")

-- Limpeza de interfaces anteriores
if player.PlayerGui:FindFirstChild("ModulusMenu") then player.PlayerGui.ModulusMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "ModulusMenu"
ScreenGui.ResetOnSpawn = false

local bgBlack = Color3.fromRGB(0, 0, 0)
local neonBlue = Color3.fromRGB(0, 150, 255)

-- ESTADOS DAS FUNÇÕES
local espActive = false
local parkourBotActive = false

-- JANELA PRINCIPAL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 320)
Main.Position = UDim2.new(0.5, -200, 0.5, -160)
Main.BackgroundColor3 = bgBlack
Main.BorderSizePixel = 2
Main.BorderColor3 = neonBlue
Main.Visible = false
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "MODULUS HUB - V39"
Title.TextColor3 = neonBlue
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Position = UDim2.new(0, 0, 1, -25)
Credits.Text = "Créditos: Gemini e Marcus"
Credits.TextColor3 = Color3.fromRGB(180, 180, 180)
Credits.BackgroundTransparency = 1
Credits.Font = Enum.Font.Gotham

-- CRIADOR DE BOTÕES
local function createBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.85, 0, 0, 45)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamSemibold
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
    return b
end

-- 1. ATIVAR ESP E NOMES
createBtn("Ativar ESP e Nomes", UDim2.new(0.075, 0, 0.2, 0), function(btn)
    espActive = not espActive
    btn.BackgroundColor3 = espActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(20, 20, 20)
    
    runService.RenderStepped:Connect(function()
        if not espActive then return end
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                if not p.Character.Head:FindFirstChild("ModulusESP") then
                    local bill = Instance.new("BillboardGui", p.Character.Head)
                    bill.Name = "ModulusESP"; bill.AlwaysOnTop = true; bill.Size = UDim2.new(0, 100, 0, 50)
                    bill.ExtentsOffset = Vector3.new(0, 3, 0)
                    local lab = Instance.new("TextLabel", bill)
                    lab.Text = p.Name; lab.Size = UDim2.new(1,0,1,0); lab.BackgroundTransparency = 1
                    lab.TextColor3 = neonBlue; lab.Font = Enum.Font.GothamBold; lab.TextStrokeTransparency = 0
                end
            end
        end
    end)
end)

-- 2. PARKOUR BOT (ANDA E PULA)
createBtn("Ativar PARKOUR BOT", UDim2.new(0.075, 0, 0.4, 0), function(btn)
    parkourBotActive = not parkourBotActive
    btn.Text = parkourBotActive and "BOT: LIGADO" or "Ativar PARKOUR BOT"
    btn.BackgroundColor3 = parkourBotActive and neonBlue or Color3.fromRGB(20, 20, 20)
    
    task.spawn(function()
        while parkourBotActive do
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") then
                -- Move para onde a câmera aponta
                char.Humanoid:Move(Vector3.new(0, 0, -1), true)
                
                -- Detecção de queda/pulo
                if char.Humanoid.FloorMaterial == Enum.Material.Air or char.HumanoidRootPart.Velocity.Y < -1 then
                    char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- 3. PULO INFINITO (SISTEMA NATIVO)
inputService.JumpRequest:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- LOGIN
local Login = Instance.new("Frame", ScreenGui)
Login.Size = UDim2.new(0, 260, 0, 140); Login.Position = UDim2.new(0.5, -130, 0.4, 0)
Login.BackgroundColor3 = bgBlack; Instance.new("UICorner", Login)

local Input = Instance.new("TextBox", Login)
Input.Size = UDim2.new(0.8, 0, 0, 40); Input.Position = UDim2.new(0.1, 0, 0.2, 0)
Input.PlaceholderText = "Senha"; Input.Text = ""; Input.BackgroundColor3 = Color3.fromRGB(30,30,30); Input.TextColor3 = Color3.new(1,1,1)

local Enter = Instance.new("TextButton", Login)
Enter.Size = UDim2.new(0.8, 0, 0, 40); Enter.Position = UDim2.new(0.1, 0, 0.6, 0)
Enter.Text = "ENTRAR"; Enter.BackgroundColor3 = neonBlue; Enter.TextColor3 = bgBlack
Enter.MouseButton1Click:Connect(function()
    if Input.Text == "GM" then Login:Destroy(); Main.Visible = true end
end)
