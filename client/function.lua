------------------------FUNCTIONS------------------------

whenActive = false

-----KeyboardInput

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do Wait(0) end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500) 
		return result
	else
		Wait(500) 
		return nil 
	end
end

-----Commande Coordonées

RegisterCommand("co", function(source, args, rawCommand)
	local pos = GetEntityCoords(PlayerPedId())
	print(pos.x..", "..pos.y..", "..pos.z)    
end)

-----PlayAnim

function PlayAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 1, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function PlayAnim2(ped, animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, duration, 1, 1, false, false, false)
    RemoveAnimDict(animDict)
end

-----setAnimation

setAnimation = function(coords)
    CinemaMode = true
    TaskGoStraightToCoord(PlayerPedId(), coords, 1.0, 8000, 320.25466, 5)
    CinemaMode = false
end

-----FirstCo

local msg = false
local number = 1
local GoToIdentity = {
	pos = { 
		vector3(327.62, 427.53, 145.60),
		vector3(328.77, 428.46, 145.60),
	}
}

function FirstConnection(source, identifier)
	whenActive = true
	msg = true
    CreateThread(function()
		DoScreenFadeOut(1500)
		Wait(4500)
		SetEntityCoords(PlayerPedId(), vector3(331.13, 423.50, 143.68))
		SetEntityHeading(PlayerPedId(), 100.00)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Wait(2000)
		PlayAnim("timetable@tracy@sleep@", "idle_c", 100000)
		setCameraCreator(1)
		DoScreenFadeIn(1500)
		while msg do
			Wait(0)
			Visual.Subtitle("Pour vous ~b~réveiller~s~ appuyez sur [~r~E~s~] !")
			if IsControlPressed(1, 38) then
				DoScreenFadeOut(500)
				Wait(1000)
				SetEntityCoords(PlayerPedId(), vector3(330.01, 422.80, 145.59))
				SetEntityHeading(PlayerPedId(), 110.00)
				Wait(1000)
				DoScreenFadeIn(0)
				Wait(1000)
                msg = false
				while number ~= 3 do
					setAnimation(GoToIdentity.pos[number])
					if number == 1 then
						Wait(3000)
					elseif number == 2 then
						destroyCameraCreator(1)
						setCameraCreator(2)
						Wait(3000)
					else
						Wait(3000)
					end
					number = number + 1
				end
				Wait(200)
				SetEntityHeading(PlayerPedId(), 215.00)
				FreezeEntityPosition(GetPlayerPed(-1), true)
				PlayAnim("cellphone@", "cellphone_text_read_base", 100000)
                OpenMenuIdentity(source, identifier)
				number = 1
            end
        end
    end)
end

local number_cloack = 1
local GoToCloack = {
	pos = { 
		vector3(329.87, 426.53, 145.57),
		vector3(334.21, 428.57, 145.57),
	}
}

function Goto_Cloack(source, identifier)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	whenActive = true
    CreateThread(function()
		while number_cloack ~= 3 do
			setAnimation(GoToCloack.pos[number_cloack])
			if number_cloack == 1 then
				Wait(3000)
			elseif number_cloack == 2 then
				Wait(3000)
			else
				Wait(3000)
			end
			number_cloack = number_cloack + 1
		end
		Wait(500)
		SetEntityHeading(PlayerPedId(), 110.00)
		setCameraCreator(3)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		OpenSkinMenu(source, identifier)
		number_cloack = 1
    end)
end

local number_final = 1
local GoToFinal = {
	pos = { 
		vector3(330.53, 426.63, 145.57),
		vector3(330.22, 430.14, 145.57),
		vector3(338.27, 435.41, 145.57),
	}
}

function FinalTask()
	destroyCameraCreator(3)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	whenActive = true
	CreateThread(function()
		while number_final ~= 4 do
			setAnimation(GoToFinal.pos[number_final])
			if number_final == 1 then
				Wait(2500)
			elseif number_final == 2 then
				Wait(2500)
			elseif number_final == 3 then
				Wait(2500)
			else
				Wait(3000)
			end
			number_final = number_final + 1
		end
		Wait(4000)
		DoScreenFadeOut(500)
		Wait(1500)
		TpPlayerToOut()
		number_final = 1
	end)
end

function TpPlayerToOut()
	whenActive = false
	ESX.Game.Teleport(GetPlayerPed(-1), Config.OutPlayer, function()
		RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "ERROR", false)
		Wait(100)
		DoScreenFadeIn(0)
		ESX.ShowNotification("Vous venez d'atterrir sur~b~ "..Config.Text['ServerName'])
	end)
	SetEntityHeading(GetPlayerPed(-1), 165.0)	
end

RegisterNetEvent('barwoz:showIdentity')
AddEventHandler('barwoz:showIdentity', function(source, identifier)
    FirstConnection(source, identifier)
end)

setCameraCreator = function(camType)
    if camType == 1 then
        cam1 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam1, true)
        PointCamAtEntity(cam1, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam1, 326.53, 425.29, 146.570, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam1, 50.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 2 then
        cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam2, true)
        PointCamAtEntity(cam2, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam2, 330.29, 425.49, 145.59, 20.0, 0.0, 84.65463, 42.2442, 0, 1, 1, 2)
        SetCamFov(cam2, 50.0)
        RenderScriptCams(1, 1, 8000, 1, 1)
	elseif camType == 3 then
        cam3 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam3, true)
        PointCamAtEntity(cam3, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam3, 331.57, 427.07, 145.57, 20.0, 0.0, 84.65463, 42.2442, 0, 1, 1, 2)
        SetCamFov(cam3, 50.0)
        RenderScriptCams(1, 1, 12000, 1, 1)
	end
end

destroyCameraCreator = function(destroyCam)
    if destroyCam == 1 then
        DestroyCam(cam1, false)
        RenderScriptCams(false, true, 1500, false, false)
    elseif destroyCam == 2 then
        DestroyCam(cam2, false)
        RenderScriptCams(false, true, 800, false, false)
	elseif destroyCam == 3 then
        DestroyCam(cam3, false)
        RenderScriptCams(false, true, 800, false, false)
	end
end

CreateThread(function()
    while true do
        Wait(1)
        if whenActive then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Wait(100)
        end
    end
end)