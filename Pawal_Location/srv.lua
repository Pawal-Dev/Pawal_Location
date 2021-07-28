ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('pawal:blista')
AddEventHandler('pawal:blista', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 200
    xPlayer.removeMoney(200)
end)

RegisterNetEvent('pawal:panto')
AddEventHandler('pawal:panto', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 150
    xPlayer.removeMoney(150)
end)

RegisterNetEvent('pawal:manchez')
AddEventHandler('pawal:manchez', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 125
    xPlayer.removeMoney(125)
end)
  
RegisterNetEvent('pawal:faggio')
AddEventHandler('pawal:faggio', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 75
    xPlayer.removeMoney(75)
end)
  