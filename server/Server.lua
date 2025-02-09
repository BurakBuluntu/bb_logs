if GetCurrentResourceName() == "brkblnt_web" then
    ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --!



    local LogAdmin       = ""
    local LogAmbulance   = ""
    local LogMecano      = ""
    local LogPolice      = ""
    local LogTaxi        = ""
    local LogVehicleShop = ""

    --Discorda mesaj göndermek için gerekli fonksiyon
    function sendToDiscord (webhook, name, message, color)
      local DiscordWebHook = webhook
      local date = os.date('*t')

      if date.day < 10 then date.day = '0' .. tostring(date.day) end
      if date.month < 10 then date.month = '0' .. tostring(date.month) end
      if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
      if date.min < 10 then date.min = '0' .. tostring(date.min) end
      if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "[" .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. "] Kasırga Roleplay Development  ",
           },
        }
    }

    if message == nil or message == '' then return FALSE end
      PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
    end
	sendToDiscord(Config.SistemLogu, "Kasırga Roleplay Log Sistemi", "Bu Log Sistemi Burak Buluntu#0587 Tarafından Özel Olarak Kasırga Roleplay Sunucusuna Yapılmıştır! Log Sistemi Aktif\n ", Config.orange)
    
    --Meslek logları için
    ------------------------------------------------------------------------------------------------
    function loadLogs()
      LogAdmin       = LoadResourceFile("brkblntLOG", "Logs/admin.log")       or ""
      LogAmbulance   = LoadResourceFile("brkblntLOG", "Logs/ambulance.log")   or ""
      LogVehicleShop = LoadResourceFile("brkblntLOG", "Logs/vehicleshop.log") or ""
      LogMecano      = LoadResourceFile("brkblntLOG", "Logs/mecano.log")      or ""
      LogPolice      = LoadResourceFile("brkblntLOG", "Logs/police.log")      or ""
      LogTaxi        = LoadResourceFile("brkblntLOG", "Logs/taxi.log")        or ""
    end

    --sendToDiscord(Config.SistemLogu, "Kasırga Roleplay Log Sistemi", "Bu Log Sistemi Burak Buluntu#0587 Tarafından Özel Olarak Kasırga Roleplay Sunucusuna Yapılmıştır! Log Sistemi Aktif\n ", Config.orange)

    function SaveInLog(job, message)
        if job == "admin" then
            LogAdmin = LogAdmin .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/admin.log", LogAdmin, -1)
            sendToDiscord(Config.webhookadmin, _U('admin_bot_name'), message, Config.orange)
        elseif job == "ambulance" then
            LogAmbulance = LogAmbulance .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/ambulance.log", LogAmbulance, -1)
            sendToDiscord(Config.webhookambulance, _U('ambulance_bot_name'), message, Config.orange)
        elseif job == "vehicleshop" then
            LogVehicleShop = LogVehicleShop .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/vehicleshop.log", LogVehicleShop, -1)
            sendToDiscord(Config.webhookvehicleshop, _U('vehicleshop_bot_name'), message, Config.orange)
        elseif job == "mecano" then
            LogMecano = LogMecano .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/mecano.log", LogMecano, -1)
            sendToDiscord(Config.webhookmecano, _U('mecano_bot_name'), message, Config.orange)
        elseif job == "police" then
            LogPolice = LogPolice .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/police.log", LogPolice, -1)
            sendToDiscord(Config.webhookpolice, _U('police_bot_name'), message, Config.orange)
        elseif job == "taxi" then
            LogTaxi = LogTaxi .. message .. "\n"
            SaveResourceFile("brkblntLOG", "Logs/taxi.log", LogTaxi, -1)
            sendToDiscord(Config.webhooktaxi, _U('taxi_bot_name'), message, Config.orange)
        else
            print(" " ..job.. "meslegi bilinmiyor.")
        end
    end

    RegisterServerEvent('brkblnt:AddInLog')
    AddEventHandler('brkblnt:AddInLog', function(job, localetxt, info1, info2, info3, info4)
      local _job        = job
      local _localetxt  = localetxt
      local _info1      = info1
      local _info2      = ''
      local _info3      = ''
      local _info4      = ''

      if info2 ~= nil then
        _info2 = info2
      end
      if info3 ~= nil then
        _info3 = info3
      end
      if info4 ~= nil then
        _info4 = info4
      end

      local message     = _U(_localetxt, _info1, _info2, _info3, _info4)
      SaveInLog(_job, message)
    end)
else
    print("=========================================")
    print("BU SCRIPT PAKETI Burak Buluntu#0587 TARAFINDAN YAPILMISTIR")
    print("LISANSSIZ KULLANIM TESPIT EDILDI, SUNUCUNUZ KAPATILACAK")
    print("=========================================")
end
---------------------------


AddEventHandler('playerConnecting', function()
	TriggerEvent('brkblnt:ToDiscord', Config.SistemLogu, SystemName, '```fix\n' .. GetPlayerName(source) .. ' bağlanıyor\n```', SystemAvatar, false)
end)

AddEventHandler('playerDropped', function(Reason)
	TriggerEvent('brkblnt:ToDiscord', Config.SistemLogu, SystemName, '```fix\n' .. GetPlayerName(source) .. ' çıktı (' .. Reason .. ')\n```', SystemAvatar, false)
end)

	-- Killing Log
RegisterServerEvent('brkblnt:playerDied')
AddEventHandler('brkblnt:playerDied', function(Message, Weapon)
	local date = os.date('*t')

	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	if Weapon then
		Message = Message .. ' [' .. Weapon .. ']'
	end
	TriggerEvent('brkblnt:ToDiscord', Config.OldurmeLoglari, SystemName, Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`', SystemAvatar, false)
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end
	
function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Bu komut için web hook gir: ' .. String[1])
				return Config.ChatLogu
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end

	local t={} ; i=1

	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	return t
end

function GetIDFromSource(Type, ID)
	local IDs = GetPlayerIdentifiers(ID)
	for k, CurrentID in pairs(IDs) do
		local ID = stringsplit(CurrentID, ':')
		if (ID[1]:lower() == string.lower(Type)) then
			return ID[2]:lower()
		end
	end
	return nil
end

















------------------------------------------------------------------------------------   LOGLAR   ------------------------------------------------------------------------------------
RegisterServerEvent("brkblnt:fazlanakitpara")
AddEventHandler("brkblnt:fazlanakitpara", function(paramiktari)
	print(paramiktari)
    --sendToDiscord(Config.nakit_para_tasima_logu, "Kasırga Roleplay Log Sistemi"," İtem Verme Logu:  ```" .. sourcePlayer.name.. "```   Adlı Oyuncu ```" ..targetPlayer.name.. "``` Oyuncusuna " ..amount.. " Adet " ..itemname.. " Verdi.", 14177041)
end)

RegisterServerEvent("brkblnt:olunceuzerindengidenler")
AddEventHandler("brkblnt:olunceuzerindengidenler", function(oyuncuismi, oyuncuhex, itemismi, itemmiktari)
    sendToDiscord(Config.OlunceUzerindenGidenlerinLogu, "Kasırga Roleplay Log Sistemi"," İtem Gitme Logu: [```" ..oyuncuismi.. "```] [```" ..oyuncuhex.. "```] Oyuncusunun Yaralandığı İçin Envanterinden [```" ..itemismi .. "```] [```" .. itemmiktari .. "```] Alındı.", 14177041)
end)

RegisterServerEvent("brkblnt:faturaloglari")
AddEventHandler("brkblnt:faturaloglari", function(kesen_isim, kesilen_isim, kasaismi, sebebi, tutar)
	--print("KASANIN ISMI: " ..kasaismi)
	if kasaismi == "society_mechanic" then
		sendToDiscord(Config.mekanik1FaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Şirket Adına Fatura Kesti.", 1127128)
	elseif kasaismi == "society_mechanic2" then
		sendToDiscord(Config.mekanik2FaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Şirket Adına Fatura Kesti.", 1127128)
	elseif kasaismi == "society_mechanic3" then
		sendToDiscord(Config.mekanik3FaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Şirket Adına Fatura Kesti.", 1127128)
	elseif kasaismi == "society_police" then
		sendToDiscord(Config.policeFaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Fatura Kesti.", 1127128)
	elseif kasaismi == "society_ambulance" then
		sendToDiscord(Config.ambulanceFaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Fatura Kesti.", 1127128)
	elseif kasaismi == "society_taxi" then
		sendToDiscord(Config.taksiFaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Şirket Adında Fatura Kesti.", 1127128)
	elseif kasaismi == "society_cardealer" then
		sendToDiscord(Config.galeriFaturaLogu, "Kasırga Roleplay Log Sistemi","Fatura Kaydı: [```" ..kesen_isim.. "```] Oyuncusu [```" ..kesilen_isim.. "```] Oyuncusuna [" ..sebebi.. "] Adında [" ..tutar.. "] Tutarında Şirket Adında Fatura Kesti.", 1127128)
	end
end)

RegisterServerEvent("brkblnt:ban")
AddEventHandler("brkblnt:ban", function(name, nametarget, amount, itemname)
	sendToDiscord(Config.banLogu, "Kasırga Roleplay Log Sistemi","", Config.orange)
end)


--TriggerEvent("brkblnt:hirsiz", sourceXPlayer.name, targetXPlayer.name, amount, label)
RegisterServerEvent("brkblnt:hirsiz")
AddEventHandler("brkblnt:hirsiz", function(name, nametarget, amount, itemname)
	sendToDiscord(Config.hirsizLogu, "Kasırga Roleplay Log Sistemi","İllegal Kelepçeyle " .. name.. "oyuncusu " ..nametarget.. " oyuncusundan " ..amount .. " adet " ..itemname .. " eşyasını Çaldı.", Config.orange)
end)

--TriggerEvent("brkblnt:polis", sourceXPlayer.name, targetXPlayer.name, amount, sourceItem)
RegisterServerEvent("brkblnt:polis")
AddEventHandler("brkblnt:polis", function(name, nametarget, amount, itemname)
    sendToDiscord(Config.polisLogu, "Kasırga Roleplay Log Sistemi","Polis ; " .. name.. "oyuncusu " ..nametarget.. " oyuncusundan " ..amount .. " adet " ..itemname .. " eşyasına El Koydu.", Config.orange)
end)

--TriggerEvent("brkblnt:orpbanka_logu", yontem, xPlayer.name, xTarget.name, amount)
RegisterServerEvent("brkblnt:orpbanka_logu")
AddEventHandler("brkblnt:orpbanka_logu", function(deger, name, nametarget, amount)
	if deger == "Banka" then
		sendToDiscord(Config.BankaParaVerme, "Kasırga Roleplay Log Sistemi", "```"..name.."``` Oyuncusu __Banka__'dan " ..nametarget.." Oyuncusunun Hesabına $"..amount .." Para Transfer Etti.", 1127128)
	elseif deger == "Telefon" then
		sendToDiscord(Config.BankaParaVerme, "Kasırga Roleplay Log Sistemi", "```"..name.."``` Oyuncusu __Telefon__'dan " ..nametarget.." Oyuncusunun Hesabına $"..amount .." Para Transfer Etti.", 14177041)
	else
		sendToDiscord(Config.BankaParaVerme, "Kasırga Roleplay Log Sistemi", "HATA VAR !" ..deger.. " BURAKBULUNTU YA BİLDİRİN ! " ..name.." oyuncusu " ..nametarget.." oyuncusunun bankasına $"..amount .." para transfer etti.", 14177041)
	end
end)

--TriggerEvent("brkblnt:me", name, identifier, data)
RegisterServerEvent("brkblnt:me")
AddEventHandler("brkblnt:me", function(name, source, data)
    sendToDiscord(Config.meLogu, "Kasırga Roleplay Log Sistemi"," ```" .. name.. "```[ID: "..source.."]" ..data.. "", Config.orange)
end)

RegisterServerEvent("brkblnt:galeri")
AddEventHandler("brkblnt:galeri", function(meslek, oyuncuismi, oyuncuid, vehicleData, plaka, odemesekli)
	if meslek == "galerici" then
		local aracfiyati = vehicleData.price / 2
		sendToDiscord(Config.galeriLogu2, "Kasırga Roleplay Log Sistemi", "```"..oyuncuismi.."```[ID: " ..oyuncuid.. "] Galeri Çalışanının Aldığı Araç Modeli ["..vehicleData.model.."] Modelindeki Aracı Satın Aldı, Aracın Plakası ["..plaka .."] Ödeme Yöntemi: [" ..odemesekli.. "] || Aracın Fiyati: [" ..aracfiyati.. "].", 1127128)	
	else
		local aracfiyati = vehicleData.price
		sendToDiscord(Config.galeriLogu, "Kasırga Roleplay Log Sistemi", "```"..oyuncuismi.."```[ID: " ..oyuncuid.. "] Adlı Oyuncunun Aldığı Araç Modeli ["..vehicleData.model.."] Modelindeki Aracı Satın Aldı, Aracın Plakası ["..plaka .."] Ödeme Yöntemi: [" ..odemesekli.. "] || Aracın Fiyati: [" ..vehicleData.price.. "].", 14177041)
	end
end)

RegisterServerEvent("brkblnt_logsistemi:itemverme")
AddEventHandler("brkblnt_logsistemi:itemverme", function(verenisim, verenhex, alanisim, alanhex, sourceItem, itemCount)
    sendToDiscord(Config.itemvermeLogu, "Kasırga Roleplay Log Sistemi"," İtem Verme Logu:  ```" .. verenisim .. "["..verenhex.."]```   Adlı Oyuncu ```" .. alanisim .."["..alanhex.."]``` Oyuncusuna __" .. sourceItem.label .."__ Eşyasından __" .. itemCount .. "__ Tane Verdi.", 14177041)
end)

RegisterServerEvent("brkblnt_logsistemi:itematma")
AddEventHandler("brkblnt_logsistemi:itematma", function(atanisim, atanhex, xItem, itemCount)
	sendToDiscord(Config.itematmaLogu, "Kasırga Roleplay Log Sistemi"," İtem Atma Logu:  ```" .. atanisim .. "["..atanhex.."]```   Adlı Oyuncu __" .. xItem.label .."__ Eşyasından __" .. itemCount .. "__ Tane Attı.", 14177041)
end)

RegisterServerEvent("brkblnt_logsistemi:dropalma")
AddEventHandler("brkblnt_logsistemi:dropalma", function(alanisim, alanhex, pickup)
	sendToDiscord(Config.itemalmaLogu, "Kasırga Roleplay Log Sistemi"," İtem Alma Logu:  ```" .. alanisim .. "["..alanhex.."]```   Adlı Oyuncu __" .. pickup.name .."__ Eşyasından __" .. pickup.count .. "__ Tane Yerden Aldı.", 1127128)
end)

