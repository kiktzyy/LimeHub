-- loader.lua
local HttpService = game:GetService("HttpService")
local userKey = key or ""

if userKey == "" then
    error("❌ Key tidak ditemukan! Pastikan sudah mengisi: key = \"TOKEN\"")
end

local function validateKey(token)
    local url = "https://work.ink/_api/v2/token/isValid/" .. token
    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not success then
        error("❌ Gagal menghubungi API Work.ink")
    end
    local data = HttpService:JSONDecode(result)
    return data.valid == true
end

if validateKey(userKey) then
    -- Daftar GameId dan URL script
    local gameScripts = {
        [7008097940] = "https://raw.githubusercontent.com/kiktzyy/Beta/main/INKGAME.lua",
        -- Tambahkan GameId dan URL script l
    }

    local currentGameId = game.GameId
    local scriptUrl = gameScripts[currentGameId]

    if scriptUrl then
        loadstring(game:HttpGet(scriptUrl))()
    else
        error("❌ Game ini belum didukung!")
    end
else
    error("❌ Key invalid!")
end
