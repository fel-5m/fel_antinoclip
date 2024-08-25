local warningCount = 0
local maxWarnings = 4
local resetTime = 10000 
local lastWarningTime = 0
local nextWarningCheck = 0
local RNE = RegisterNetEvent
local TSE = TriggerServerEvent

local function Init()

    function ResetWarnings()
        warningCount = 0
    end
    
    function AddWarning()
        warningCount = warningCount + 1
        lastWarningTime = GetGameTimer()
    
        if warningCount >= maxWarnings then
            ResetWarnings()
            TSE('fel_antiNoclip:server:bruh')
    end
    
    Citizen.CreateThread(function()
        while true do
            local _ped = PlayerPedId()
            local currentTime = GetGameTimer()
            local aboveground = GetEntityHeightAboveGround(_ped)
            
            if currentTime >= nextWarningCheck then
                if currentTime - lastWarningTime > resetTime and warningCount > 0 then
                    ResetWarnings()
                end
                nextWarningCheck = currentTime + 1000 
            end
    
            if tonumber(aboveground) > 10 then
                if not IsPedInAnyVehicle(_ped, false) and 
                   not IsPedInParachuteFreeFall(_ped) and 
                   not IsPedJumping(_ped) and
                   not IsPedFalling(_ped) and 
                   not IsEntityAttached(_ped) and 
                   not IsPedSwimming(_ped) and 
                   not IsPedSwimmingUnderWater(_ped) and 
                   not IsPedClimbing(_ped) and
                   not IsPlayerDead(_ped) then
    
                    local parachuteState = GetPedParachuteState(_ped)
    
                    if parachuteState == 0 or parachuteState == -1 then
                        if IsPedWalking(_ped) then
                            AddWarning()
                        end
                    end
                end
            end
    
            Wait(250) 
        end
    end)
    
end

RNE('fel_antiNoclip:client:receiveFromServer', function()
    Init()
end)

