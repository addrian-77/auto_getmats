script_name("AutoGetmats")
script_author("iAdriaN")

local sampev = require 'lib.samp.events'

local center_x = 597.5239
local center_y = -1246.9698
local radius = 8.5

local checkpoint = 0

local enabled = true

function create_checkpoint()
    
    checkpoint = createCheckpoint(2, 597.5239,-1246.9698, 18.2510, 597.5239,-1246.9698, 18.2510, 8.5)
end

function main()
    while not isSampAvailable() do wait(100) end
    wait(200)
    sampAddChatMessage('{6de83c}Auto getmats {FFFFFF}by {ff1900}iAdriaN {FFFFFF}loaded, [/togmats]', 0xFFFFFF)
    sampRegisterChatCommand("togmats", togMats)
    while true do
        wait(0)
        if enabled == true
        then
            if checkpoint == 0
            then
                create_checkpoint()
            end
                
            wait(0)
            local x, y, z = getCharCoordinates(playerPed)
            
            if ( (x - center_x)^2 + (y - center_y)^2 ) <= radius^2 then
                sampSendChat("/getmats")
                wait(20000)
            end
        end
    end
end

function togMats() -- TODO
    enabled = not enabled
    
    if enabled == false then
        deleteCheckpoint(checkpoint)
        sampAddChatMessage("Auto getmats {ff1900}Disabled", 0x6de83c)
    else
        create_checkpoint()
        sampAddChatMessage("Auto getmats {1ed402}Enabled", 0x6de83c)
    end
end
