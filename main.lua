--[[ 
    PROJECT: MODULUS HUB V38 - ELITE PARKOUR
    CREDITS: GEMINI & MARCUS
    KEY: GM
]]--

local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local inputService = game:GetService("UserInputService")

-- Limpeza de UI antiga
if player.PlayerGui:FindFirstChild("ModulusMenu") then player.PlayerGui.ModulusMenu:Destroy() end

local ScreenGui = Instance.new("ScreenGui", player.PlayerGui)
ScreenGui.Name = "ModulusMenu"
ScreenGui.ResetOnSpawn = false

local bgBlack = Color3.fromRGB(0, 0, 0)
local neonBlue = Color3.fromRGB(0, 150, 255)

-- Estados
local espActive = false
local parkourBotActive = false

-- MENU
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
Title.Text = "MODULUS HUB V38"
Title.TextColor3 = neonBlue
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- CRÉDITOS
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Position = UDim2.new(0, 0, 1, -25)
Credits.Text = "Créditos: Gemini e Marcus"
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.BackgroundTransparency = 1
Credits.Font = Enum.Font.Gotham

-- BOTÕES
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

-- 1. ATIVAR ESP E NOMES (MELHORADO)
createBtn("Ativar ESP e Nomes", UDim2.new(0.07
