ESX = nil

function DrawMissionText(msg, time)
  ClearPrints()
  SetTextEntry_2('STRING')
  AddTextComponentString(msg)
  DrawSubtitleTimed(time, 1)
end

local Shop = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {255, 255, 255}, --[[R, G, B   R = red G = Green B = Blue ]]Title = 'Location'},
	Data = { currentMenu = "catalogue Location", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
      PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
      local btn = btn.name
          
		  if btn == "~r~→~s~ Voiture" then  
		     OpenMenu ("voiture")
		  elseif btn == "~r~→~s~ Moto" then
		     OpenMenu ("moto")
		  end
		  
		  if btn == "Blista" then
		     TriggerServerEvent('pawal:blista')		 
             ESX.ShowAdvancedNotification('Tropico Base ~r~V1', '~r~Location', "Vous venez de loué une blista pour ~r~$200", 'CHAR_BEWLIFE', 7)
		     spawnCar('blista')
			 CloseMenu (true)
		  elseif btn == "Panto" then
		     TriggerServerEvent('pawal:panto')		 
             ESX.ShowAdvancedNotification('Tropico Base ~r~V1', '~r~Location', "Vous venez de loué une panto pour ~r~$150", 'CHAR_BEWLIFE', 7)
		     spawnCar('panto')
			 CloseMenu (true)
		  elseif btn == "Manchez" then
		     TriggerServerEvent('pawal:manchez')		 
             ESX.ShowAdvancedNotification('Tropico Base ~r~V1', '~r~Location', "Vous venez de loué une manchez pour ~r~$125", 'CHAR_BEWLIFE', 7)
		     spawnCar('manchez')
			 CloseMenu (true)
		  elseif btn == "Faggio Sport" then
		     TriggerServerEvent('pawal:faggio')		 
             ESX.ShowAdvancedNotification('Tropico Base ~r~V1', '~r~Location', "Vous venez de loué un faggio sport pour ~r~$125", 'CHAR_BEWLIFE', 7)
		     spawnCar('faggio')
			 CloseMenu (true)
		  elseif btn == "                  ~r~ → Revenir au menu principal ←" then
		     OpenMenu ("catalogue Location")
		  elseif btn == "                         ~r~ → Fermer le menu ←" then
		     CloseMenu (true)

			 
             end 
	        end,     
	},    
	Menu = {  
		["catalogue Location"] = { 
			b = { 
        {name = "~r~→~s~ Voiture", ask = "", askX = true},
        {name = "~r~→~s~ Moto", ask = "", askX = true},  
        {name = "                         ~r~ → Fermer le menu ←", ask = "", askX = true},  		
			}  
		},
		["voiture"] = { 
			b = { 
        {name = "Blista", ask = "~r~$200", askX = true},   
        {name = "Panto", ask = "~r~$150", askX = true},
        {name = "                  ~r~ → Revenir au menu principal ←", ask = "", askX = true}, 		
			}  
		},
		["moto"] = { 
			b = { 
        {name = "Manchez", ask = "~r~$125", askX = true},   
        {name = "Faggio Sport", ask = "~r~$75", askX = true},
        {name = "                  ~r~ → Revenir au menu principal ←", ask = "", askX = true}, 		
			}  
		}
		

	}
}    


local locationpawal = {
  {x = -1033.59, y= -2728.53, z=13.75}
}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0) 
      for k in pairs(locationpawal) do
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, locationpawal[k].x, locationpawal[k].y, locationpawal[k].z)
          if dist <= 2.0 then 
              ESX.ShowHelpNotification("Appuyez sur [~r~E~s~] pour parler avec le vendeur")
              if IsControlJustPressed(1,38) then 
              DrawMissionText("~r~Vous ~s~: Bonjour ! je voudrai loué un véhicule, Avez vous un catalogue ?",3200)
              Citizen.Wait(1500)
              DrawMissionText("~r~Vendeur ~s~: Bonjour oui bien sur, le voici !",3200)	
              Citizen.Wait(1500)			  
               CreateMenu(Shop)
              DrawMissionText("~r~Catalogue ~s~: Location ", 5000)    
                  end
              end 
          end
      end
  end)

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -1032.11, -2724.59, 13.64, 238.66, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetEntityAsNoLongerNeeded(vehicle)
	SetModelAsNoLongerNeeded(vehicleName)
	SetVehicleWindowTint(vehicle, 3)
	SetVehicleNumberPlateText(vehicle, "Location")
        
end

local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Location", colour=5, id=147, x = -1033.59, y = -2728.53, z = 13.75},
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("csb_prolsec")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "csb_prolsec", -1033.59, -2728.53, 12.75, 148.78, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

local v1 = vector3(310.54, -1107.98, 30.4)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local distance = 20

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance then
            Draw3DText(v1.x,v1.y,v1.z, "Location")
        end
    end
end)
