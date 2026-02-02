--[[ 
    PROJECT: MODULUS HUB V24 (PREMIUM STRUCTURE)
    AUTHORS: GEMINI & MARCUS
    KEY: GM
]]--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local bgBlack = Color3.fromRGB(15, 15, 15)
local neonBlue = Color3.fromRGB(0, 150, 255)
local textColor = Color3.new(1, 1, 1)

-- CONFIGURAÇÕES DE AIMBOT
local AimbotEnabled = false
local FOVSize = 120
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = neonBlue
FOVCircle.Filled = false
FOVCircle.Transparency = 1
FOVCircle.Visible = false

-- 1. MENU PRINCIPAL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Visible = false
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = bgBlack
MainFrame.Draggable = true
MainFrame.Active = true
Instance.new("UICorner", MainFrame)

-- BARRA LATERAL
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(0, 110, 1, 0)
TabFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", TabFrame)

local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -120, 1, -10)
Container.Position = UDim2.new(0, 115, 0, 5)
Container.BackgroundTransparency = 1

local function createTab(name)
    local f = Instance.new("ScrollingFrame", Container)
    f.Size = UDim2.new(1, 0, 1, 0); f.BackgroundTransparency = 1
    f.Visible = false; f.Name = name; f.CanvasSize = UDim2.new(0, 0, 2, 0)
    f.ScrollBarThickness = 2
    local layout = Instance.new("UIListLayout", f); layout.Padding = UDim.new(0, 5)
    return f
end

local TabVisuais = createTab("Visuais")
local TabAlgema = createTab("Algema")
local TabCombat = createTab("Combat")

-- FUNÇÕES AUXILIARES
local function addBtn(txt, parent, func)
    local b = Instance.new("TextButton", parent)
    b.Text = txt; b.Size = UDim2.new(0.95, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = textColor
    Instance.new("UICorner", b); b.MouseButton1Click:Connect(func)
end

-- ==========================================
-- 1. ABA VISUAIS (ESP)
-- ==========================================
addBtn("Ativar ESP Nomes", TabVisuais, function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("Esp") then
            local b = Instance.new("BillboardGui", v.Character)
            b.Name = "Esp"; b.AlwaysOnTop = true; b.Size = UDim2.new(0, 100, 0, 50); b.ExtentsOffset = Vector3.new(0, 3, 0)
            local t = Instance.new("TextLabel", b)
            t.Text = v.Name; t.Size = UDim2.new(1, 0, 1, 0); t.BackgroundTransparency = 1; t.TextColor3 = Color3.new(1, 0, 0)
        end
    end
end)

-- ==========================================
-- 2. ABA ALGEMA (POLICIAL)
-- ==========================================
local dragging = false
addBtn("Puxar/Soltar Algemado", TabAlgema, function()
    local lp = game.Players.LocalPlayer
    if not dragging then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= lp and v.Character and (lp.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 10 then
                dragging = true
                task.spawn(function()
                    while dragging and v.Character do
                        v.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
                        task.wait()
                    end
                end)
                break
            end
        end
    else dragging = false end
end)

-- ==========================================
-- 3. ABA COMBAT (AIMBOT + FOV)
-- ==========================================
addBtn("Ligar Aimbot", TabCombat, function(btn)
    AimbotEnabled = not AimbotEnabled
    FOVCircle.Visible = AimbotEnabled
    btn.Text = AimbotEnabled and "Aimbot: ON" or "Ligar Aimbot"
end)

-- Lógica do Aimbot e Círculo FOV
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(game:GetService("UserInputService"):GetMouseLocation().X, game:GetService("UserInputService"):GetMouseLocation().Y)
    FOVCircle.Radius
