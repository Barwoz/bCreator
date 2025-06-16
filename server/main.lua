if _bConfig.NewEsx == false then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
else
    ESX = exports["es_extended"]:getSharedObject()
end

-----------------Function to created Informations Personnals                              
                                                                                       
function barwoz_getIdentity(source, callback)
    local identifier = GetPlayerIdentifiers(source)[1]
    local infoP = {}
    MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier',  
    {
        ['@identifier'] = identifier
    },
    function(data)
        if data[1]['firstname'] ~= nil then
            table.insert(infoP, {
                identifier = data[1]['identifier'],
                FirstName = data[1]['firstname'],
                LastName = data[1]['lastname'],
                DateOfBirth = data[1]['dateofbirth'],
                Sex = data[1]['sex'],
                Height = data[1]['height']
            })
            callback(infoP)
        else
            table.insert(infoP, {
                    identifier = '',
                    FirstName = '',
                    LastName = '',
                    DateOfBirth = '',
                    Sex = '',
                    Height = '',
                })
            callback(infoP)
        end
    end)
end

function barwoz_registerIdentity(identifier, datalist)
    local userData = datalist
    print("Identifier enregistrer : "..identifier)
    print(userData.firstname.." "..userData.lastname..' a bien obtenu ses papiers.')
    MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
    {
    ['@identifier']   = identifier,
    ['@firstname']    = userData.firstname,
    ['@lastname']     = userData.lastname,
    ['@dateofbirth']  = userData.dateofbirth,
    ['@sex']        = userData.sex,
    ['@height']       = userData.height
    })
end

RegisterServerEvent('barwoz:saveIdentity')
AddEventHandler('barwoz:saveIdentity', function(identifier, datalist)
    local identifier = GetPlayerIdentifiers(source)[1]
    barwoz_registerIdentity(identifier, datalist)
end)

RegisterCommand('register', function(source, args, user)
    local _src = source
    local identifier = GetPlayerIdentifiers(_src)[1]

    TriggerClientEvent('barwoz:showIdentity', _src, identifier, data)
end)

AddEventHandler('es:playerLoaded', function(source)
    local identifier = GetPlayerIdentifiers(source)[1]

    barwoz_getIdentity(source, function(data)
        if data[1].FirstName == '' then
            TriggerClientEvent('barwoz:showIdentity', source, identifier, data)
        else
            print(data[1].FirstName.." "..data[1].LastName..' vient de se connecter')
            TriggerClientEvent('esx:showNotification', source, 'Vous venez de vous connecter sur~b~ '..Config.Text['ServerName'])
        end
    end)
end)

-----------------Function to Saved the vehicle in to BDD     

RegisterServerEvent('barwoz:SavedVehicleInToBDD')
AddEventHandler('barwoz:SavedVehicleInToBDD', function(vehicle, vehicle_plate)
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', 
        {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicle.plate,
            ['@vehicle'] = json.encode(vehicle)
        })
    end 
end)

