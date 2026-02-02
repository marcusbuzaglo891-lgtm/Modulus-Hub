--[[ 
    PROJECT: MODULUS HUB V17 (FINAL)
    AUTHORS: GEMINI & MARCUS
    KEY: GM
]]--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local bgBlack = Color3.fromRGB(0, 0, 0)
local neonBlue = Color3.fromRGB(0, 150, 255)

-- 1. BOTÃO FLUTUANTE (MENOR)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 40, 0, 40)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -20)
OpenBtn.BackgroundColor3 = bgBlack
OpenBtn.TextColor3 = neonBlue
OpenBtn.Text = "GM"
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 14
OpenBtn.BorderSizePixel = 2
OpenBtn.BorderColor3 = neonBlue
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)

-- 2. TELA DE LOGIN
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 280, 0, 140)
KeyFrame.Position = UDim2.new(0.5, -140, 0.4, 0)
KeyFrame.BackgroundColor3 = bgBlack
Instance.new("UICorner", KeyFrame)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.PlaceholderText = "Chave: GM"
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KeyInput)

local LoginBtn = Instance.new("TextButton", KeyFrame)
LoginBtn.Text = "ENTRAR"
LoginBtn.Size = UDim2.new(0.8, 0, 0, 30)
LoginBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
LoginBtn.BackgroundColor3 = neonBlue
Instance.new("UICorner", LoginBtn)

-- 3. MENU PRINCIPAL
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Visible = false
MainFrame.Size = UDim2.new(0, 350, 0, 380)
MainFrame.Position = UDim2.new(0.5, -175, 0.3, 0)
MainFrame.BackgroundColor3 = bgBlack
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Credits = Instance.new("TextLabel", MainFrame)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 0.05, 0)
Credits.Text = "Criado por: Gemini & Marcus"
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.Font = Enum.Font.GothamBold
Credits.BackgroundTransparency = 1

-- LÓGICA
LoginBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "GM" then
        KeyFrame:Destroy()
        MainFrame.Visible = true
        OpenBtn.Visible = true
    end
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function createBtn(txt, pos, func)
    local b = Instance.new("TextButton", MainFrame)
    b.Text = txt
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    b.TextColor3 = neonBlue
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

createBtn("CARREGAR SK3", UDim2.new(0.05, 0, 0.25, 0), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucash7bbbb/deltaeb/refs/heads/main/sk3"))()
end)

createBtn("INFINITE YIELD", UDim2.new(0.05, 0, 0.4, 0), function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

createBtn("FECHAR HUB", UDim2.new(0.05, 0, 0.85, 0), function() ScreenGui:Destroy() end)
