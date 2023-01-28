ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Init['ESX'], function(obj) ESX = obj end)
		Wait(0)
	end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local creamenu, name, prenom, sex, date, taille = false, "...", "...", "...", "../../....", "..."
local rightname = true
local nommec, prenomjoueur, sexjoueur, datejoueur, taillejoueur = false, false, false, false, false

local identity = RageUI.CreateMenu(Config.Text["MenuTitle1"], Config.Text["MenuSubTitle1"])
local checkidentity = RageUI.CreateSubMenu(identity, Config.Text["SubMenuTitle1"], Config.Text["SubMenuSubTitle1"])
identity.closed = function() 
    creamenu = false 
    OpenMenuIdentity()
end

local datalist = {}

function OpenMenuIdentity(source, identifier)
    if creamenu then
        creamenu = false
    else 
        creamenu = true
    RageUI.Visible(identity, true)
        CreateThread(function()
            while creamenu do
                Wait(1)
                RageUI.IsVisible(identity, function()

                    RageUI.Separator(Config.Text["Separator1"])

                    RageUI.Button('~r~→~s~ '..Config.Text["ButtonView"], nil, {RightLabel = "→→"}, datejoueur, {}, checkidentity)

                    RageUI.Separator(Config.Text["Separator2"])
                    
                    RageUI.Button('~r~→~s~ '..Config.Text["LastName"], nil, {RightLabel = "~b~"..name.."~s~"}, rightname, {
                        onSelected = function()
                            name = KeyboardInput("Nom :", nil, 10)
                            if tostring(name) == "" or tostring(name) == "Nom" then 
                                name = "[]"
                                nommec = false
                                ESX.ShowNotification(Config.Text["NameValid"])
                            else
                                nommec = true 
                                name = GetOnscreenKeyboardResult()
                                datalist.lastname = name
                            end
                        end
                    })

                    RageUI.Button('~r~→~s~ '..Config.Text["FirstName"], nil, {RightLabel = "~b~"..prenom.."~s~"}, nommec, {
                        onSelected = function()
                            prenom = KeyboardInput("Prénom :", nil, 10)
                            if tostring(prenom) == "" or tostring(prenom) == "Prénom" then 
                                prenom = "[]"
                                prenomjoueur = false
                                ESX.ShowNotification(Config.Text["PrenomValid"])
                            else
                                prenomjoueur = true 
                                prenom = GetOnscreenKeyboardResult()
                                datalist.firstname = prenom
                            end
                        end
                    })

                    RageUI.Button('~r~→~s~ '..Config.Text["Height"], nil, {RightLabel = "~b~"..taille.." cm~s~"}, prenomjoueur, {
                        onSelected = function()
                            taille = KeyboardInput("Taille :", nil, 10)
                            if tostring(taille) == "" or tostring(taille) == "Taille" or #taille < 3 then 
                                taille = "[]"
                                taillejoueur = false
                                ESX.ShowNotification(Config.Text["HeightValid"])
                            else
                                taillejoueur = true 
                                taille = GetOnscreenKeyboardResult()
                                datalist.height = taille
                            end
                        end
                    })

                    RageUI.Button('~r~→~s~ '..Config.Text["Sex"], nil, {RightLabel = "~b~"..sex.."~s~"}, taillejoueur, {
                        onSelected = function()
                            sex = KeyboardInput("Sex :", nil, 10)
                            if tostring(sex) == "m" or tostring(sex) == "f" or tostring(sex) == "M" or tostring(sex) == "F" then
                                sexjoueur = true 
                                sex = GetOnscreenKeyboardResult()
                                datalist.sex = sex
                            else
                                sex = "[]"
                                sexjoueur = false
                                ESX.ShowNotification(Config.Text["SexValid"])
                            end
                        end
                    })

                    RageUI.Button('~r~→~s~ '..Config.Text["DateOfBirth"], nil, {RightLabel = "~b~"..date.."~s~"}, sexjoueur, {
                        onSelected = function()
                            date = KeyboardInput("Date de naissance :", nil, 10)
                            if tostring(date) == "" or tostring(date) == "Date de Naissance" or #date < 8 then 
                                date = "[]"
                                datejoueur = false
                                ESX.ShowNotification(Config.Text["DateValid"])
                            else
                                datejoueur = true 
                                date = GetOnscreenKeyboardResult()
                                datalist.dateofbirth = date
                            end
                        end
                    })

                end)
                    RageUI.IsVisible(checkidentity, function() 

                    RageUI.Separator(Config.Text["Separator3"])

                    RageUI.Button('~r~→~s~ '..Config.Text["GoBack"], nil , {RightLabel = "←←"}, true , {}, identity) 

                    RageUI.Button('~r~→~s~ '..Config.Text["ValidId"], nil , {RightBadge = RageUI.BadgeStyle.Tick}, true , {
                        onSelected = function()
                            RageUI.CloseAll()
                            ESX.ShowNotification("~b~Bravo!~s~ Tu viens de créer ton Identité !")
                            local playerPed = GetPlayerPed(-1)
                            TriggerServerEvent('barwoz:saveIdentity', identifier, datalist)
                            datalist = {}
                            Goto_Cloack(source, identifier)
                        end
                    })

                    RageUI.Separator(Config.Text["YourId"])                            
                    RageUI.Separator(Config.Text["LastName"].." :~b~ "..tostring(name))
                    RageUI.Separator(Config.Text["FirstName"].." :~b~ "..tostring(prenom))
                    RageUI.Separator(Config.Text["Height"].." :~b~ "..tostring(taille))
                    RageUI.Separator(Config.Text["Sex"].." :~b~ "..tostring(sex))
                    RageUI.Separator(Config.Text["DateOfBirth"].." :~b~ "..tostring(date))

                end)
            end
        end)
    end
end

local SettingsMenu = {
    percentage = 1.0,
    ColorHear = {
        primary = { 1, 1},
        secondary = { 1,1 }
    },
    ColorBrow = {
        primary = {1, 1}, 
        secondary = {1, 1}
    },
    ColorBeard = {
        primary = {1, 1}, 
        secondary = {1, 1}
    },
}

local MenuList = {
    List = 1,
    List1 = 1,
    List2 = 1,
    List3 = 1,
    List4 = 1,
    List5 = 1,
    List6 = 1,
    List7 = 1,
    List8 = 1,
    List9 = 1
}

setSkinToPed = function(Numero)
    TriggerEvent("skinchanger:getSkin", function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Config.Tenue[Numero].Homme
        else
            uniformObject = Config.Tenue[Numero].Femme
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
            TriggerServerEvent('esx_skin:save', skin)
            ESX.ShowNotification("Vous venez de vous changer")
            TriggerEvent('skinchanger:getSkin', function(skin4)
                TriggerServerEvent('esx_skin:save', skin4)
            end)
        end
    end)
end

local SkinMenu = false

local skin = RageUI.CreateMenu(Config.Text['MenuTitle2'], Config.Text['MenuSubTitle2'], 10, 10)
local apparence = RageUI.CreateSubMenu(skin, Config.Text['SubMenuTitle2'], Config.Text['SubMenuSubTitle2'])
local cloack = RageUI.CreateSubMenu(skin, Config.Text['SubMenuTitle3'], Config.Text['SubMenuSubTitle3'])
local vehicle = RageUI.CreateSubMenu(skin, Config.Text['SubMenuTitle4'], Config.Text['SubMenuSubTitle4'])
skin.Closed = function() 
    SkinMenu = false
end
apparence.EnableMouse = true

function OpenSkinMenu()
    if SkinMenu then
        SkinMenu = false
    else 
        SkinMenu = true
    RageUI.Visible(skin, true)
        CreateThread(function()
            while SkinMenu do 
                Wait(1)
                RageUI.IsVisible(skin, function()

                    if Config.EnableDesc then
                        RageUI.Separator('_________________')
                        RageUI.Separator("↓ ~b~"..Config.Text['Welcome_to']..""..Config.Text['ServerName'].."~s~ ↓")
                        RageUI.Separator(Config.Text['Desc_1'])
                        RageUI.Separator(Config.Text['Desc_2'])
                        RageUI.Separator('_________________')
                    else
                        RageUI.Separator("↓ ~b~"..Config.Text['Welcome_to']..""..Config.Text['ServerName'].."~s~ ↓")
                    end
                    RageUI.Button('~r~→~s~ '..Config.Text['Start'], nil, {RightLabel = '→→'}, true, {}, apparence)

                end)

                RageUI.IsVisible(apparence, function()

                    RageUI.Separator(Config.Text['Separator2'])

                    RageUI.List('~r~→~s~ '..Config.Text["Sex"], {"~b~Femme~s~","~b~Homme~s~"}, MenuList.List, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List = i;
                            if MenuList.List == 1 then
                                TriggerEvent("skinchanger:change", "sex", 1)
                            elseif MenuList.List == 2 then
                                TriggerEvent("skinchanger:change", "sex", 0)
                            end
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Face"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~","~b~32~s~","~b~33~s~","~b~34~s~","~b~35~s~","~b~36~s~","~b~37~s~","~b~38~s~","~b~39~s~","~b~40~s~","~b~41~s~","~b~42~s~","~b~43~s~","~b~44~s~","~b~45~s~"}, MenuList.List7, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List7 = i;
                            TriggerEvent("skinchanger:change", "face", MenuList.List7)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Skin"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~","~b~32~s~","~b~33~s~","~b~34~s~","~b~35~s~","~b~36~s~","~b~37~s~","~b~38~s~","~b~39~s~","~b~40~s~","~b~41~s~","~b~42~s~","~b~43~s~","~b~44~s~","~b~45~s~"}, MenuList.List8, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List8 = i;
                            TriggerEvent("skinchanger:change", "skin", MenuList.List8)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Hair"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~","~b~32~s~","~b~33~s~","~b~34~s~","~b~35~s~","~b~36~s~","~b~37~s~","~b~38~s~"}, MenuList.List2, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List2 = i;
                            TriggerEvent("skinchanger:change", "hair_1", MenuList.List2)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Beard"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~"}, MenuList.List4, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List4 = i;
                            TriggerEvent("skinchanger:change", "beard_1", MenuList.List4)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["EyeBrows"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~","~b~32~s~","~b~33~s~"}, MenuList.List3, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List3 = i;
                            TriggerEvent("skinchanger:change", "eyebrows_1", MenuList.List3)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Eye_Color"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~"}, MenuList.List5, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List5 = i;
                            TriggerEvent("skinchanger:change", "eye_color", MenuList.List5)
                        end,
                    })

                    RageUI.List('~r~→~s~ '..Config.Text["Moles"], {"~b~1~s~","~b~2~s~","~b~3~s~","~b~4~s~","~b~5~s~","~b~6~s~","~b~7~s~","~b~8~s~","~b~9~s~","~b~10~s~","~b~11~s~","~b~12~s~","~b~13~s~","~b~14~s~","~b~15~s~","~b~16~s~","~b~17~s~","~b~18~s~","~b~19~s~","~b~20~s~","~b~21~s~","~b~22~s~","~b~23~s~","~b~24~s~","~b~25~s~","~b~26~s~","~b~27~s~","~b~28~s~","~b~29~s~","~b~30~s~","~b~31~s~"}, MenuList.List6, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List6 = i;
                            TriggerEvent("skinchanger:change", "moles_1", MenuList.List6)
                        end,
                    })

                    RageUI.ColourPanel("Couleur cheveux", RageUI.PanelColour.HairCut, SettingsMenu.ColorHear.primary[1], SettingsMenu.ColorHear.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorHear.primary[1] = MinimumIndex
                            SettingsMenu.ColorHear.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_1", SettingsMenu.ColorHear.primary[2])
                        end
                    }, 5);

                    RageUI.ColourPanel("Couleur cheveux", RageUI.PanelColour.HairCut, SettingsMenu.ColorHear.secondary[1], SettingsMenu.ColorHear.secondary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorHear.secondary[1] = MinimumIndex
                            SettingsMenu.ColorHear.secondary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "hair_color_2", SettingsMenu.ColorHear.secondary[2])
                        end
                    }, 5);

                    RageUI.ColourPanel("Couleur Barbes", RageUI.PanelColour.HairCut, SettingsMenu.ColorBeard.primary[1], SettingsMenu.ColorBeard.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorBeard.primary[1] = MinimumIndex
                            SettingsMenu.ColorBeard.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "beard_3", SettingsMenu.ColorBeard.primary[2])
                        end
                    }, 6);

                    RageUI.PercentagePanel(SettingsMenu.percentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            SettingsMenu.percentage = Percentage
                            TriggerEvent("skinchanger:change", "beard_2", Percentage * 10)
                        end
                    }, 6);

                    RageUI.ColourPanel("Couleur Sourcils", RageUI.PanelColour.HairCut, SettingsMenu.ColorBrow.primary[1], SettingsMenu.ColorBrow.primary[2], {
                        onColorChange = function(MinimumIndex, CurrentIndex)
                            SettingsMenu.ColorBrow.primary[1] = MinimumIndex
                            SettingsMenu.ColorBrow.primary[2] = CurrentIndex
                            TriggerEvent("skinchanger:change", "eyebrows_3", SettingsMenu.ColorBrow.primary[2])
                        end
                    }, 7);

                    RageUI.PercentagePanel(SettingsMenu.percentage, 'Opacité', '0%', '100%', {
                        onProgressChange = function(Percentage)
                            SettingsMenu.percentage = Percentage
                            TriggerEvent("skinchanger:change", "eyebrows_2", Percentage * 10)
                        end
                    }, 7);

                    RageUI.Separator('_________________')
                    RageUI.Separator(Config.Text['Separator3'])
                    RageUI.Button('~r~→~s~ '..Config.Text['Valid_Appa'], nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                        end
                    }, cloack)
                end)

                RageUI.IsVisible(cloack, function()
                
                    RageUI.Separator(Config.Text['Separator4'])

                    for _,v in pairs(Config.Tenue) do
                        RageUI.Button(v.name, nil, {RightLabel = v.label}, true, {
                            onSelected = function()
                                setSkinToPed(v.numero)
                            end
                        })
                    end

                    RageUI.Separator('_________________')
                    RageUI.Separator(Config.Text['Separator5'])
                    RageUI.Button('~r~→~s~ '..Config.Text['Valid_Cloack'], nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                        end
                    }, vehicle)

                end)

                RageUI.IsVisible(vehicle, function()
                    
                    RageUI.List('~r~→~s~ '..Config.Text['Choose_Vehicle'], ConfigVehicules.label, MenuList.List9, nil, {}, true, {
                        onListChange = function(i, Item)
                            MenuList.List9 = i;
                        end,
                    })

                        RageUI.Separator('_________________')
                        RageUI.Separator(Config.Text['Separator6'])
                        RageUI.Separator(Config.Text['ChosseV']..ConfigVehicules.model[MenuList.List9])
                        RageUI.Button('~r~→~s~ '..Config.Text['Valid_Perso'], nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                vehicle_model = ConfigVehicules.model[MenuList.List9]
                                vehicle_give(vehicle_model)
                                RageUI.CloseAll()
                                SkinMenu = false
                                FinalTask()
                            end
                        })

                end)

            end
        end)
    end
end

local voituregive = {}

function vehicle_give(veh)
	TriggerEvent('esx:showAdvancedNotification', 'Boutique', '', 'Vous avez reçu votre :\n '..veh, img_notif, 3)
    local plyCoords = vector3(0, 0, 0)

    Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            
            plate = exports.esx_vehicleshop:GeneratePlate()

            table.insert(voituregive, vehicle)		
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
			TriggerServerEvent('barwoz:SavedVehicleInToBDD', vehicleProps, vehicle_plate)
            DeleteEntity(vehicle)
	end)
end 