local HttpService = game:GetService("HttpService")

assert(key, "Variabel 'key' harus sudah didefinisikan sebelum loadstring loader dijalankan.")

local function validateKey(token)
    local url = "https://work.ink/_api/v2/token/isValid/" .. token

    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        error("Gagal request Work.ink API: " .. tostring(result))
    end

    local data = HttpService:JSONDecode(result)
    return data.valid == true
end

if not validateKey(key) then
    error("Key tidak valid!")
end

local gameScripts = {
    [7008097940] = "https://raw.githubusercontent.com/kiktzyy/Beta/main/INKGAME.lua",
    -- Tambah gameId dan link script lain disini jika perlu
}

local url = gameScripts[game.GameId]
if not url then
    error("Game tidak didukung")
end

local source = game:HttpGet(url)
loadstring(source)()
