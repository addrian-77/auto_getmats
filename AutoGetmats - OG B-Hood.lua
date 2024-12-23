script_name("AutoGetmats")
script_author("iAdriaN")

local sampev = require 'lib.samp.events'

local A = {601.3054, -1237.949, 15.5}
local B = {607.3359, -1246.9120, 15.5}
local C = {592.4315, -1252.8440, 15.5}
local D = {588.8086, -1242.1986, 15.5}

local object1 = 0
local object2 = 0
local object3 = 0
local object4 = 0

local enabled = true

function cross_product(p1, p2, p)
    return (p2[1] - p1[1]) * (p[2] - p1[2]) - (p2[2] - p1[2]) * (p[1] - p1[1])
end

function is_point_inside(x, y)
    local cross1 = cross_product(A, B, {x, y})
    local cross2 = cross_product(B, C, {x, y})
    local cross3 = cross_product(C, D, {x, y})
    local cross4 = cross_product(D, A, {x, y})

    if (cross1 > 0 and cross2 > 0 and cross3 > 0 and cross4 > 0) or
       (cross1 < 0 and cross2 < 0 and cross3 < 0 and cross4 < 0) then
        return true
    else
        return false
    end
end

function create_objects_at_points()
    -- Create objects at the points A, B, C, D
    object1 = createObject(18728, A[1], A[2], A[3])  -- Create at point A
    object2 = createObject(18728, B[1], B[2], B[3])  -- Create at point B
    object3 = createObject(18728, C[1], C[2], C[3])  -- Create at point C
    object4 = createObject(18728, D[1], D[2], D[3])  -- Create at point D
end

function main()
    while not isSampAvailable() do wait(0) end
    wait(2000)
    sampAddChatMessage('{6de83c}Auto getmats {FFFFFF}by {ff1900}iAdriaN {FFFFFF}loaded, [/togmats]', 0xFFFFFF)
    sampRegisterChatCommand("togmats", togMats)    
    while true do
        wait(0)
        if enabled == true
        then
            if object1 == 0
            then
                create_objects_at_points()
            end
                
            wait(0)
            local x, y, z = getCharCoordinates(playerPed)
            
            if is_point_inside(x, y) then
                if isCharOnFoot(playerPed) == false
                then
                    sampAddChatMessage("Coboara din masina pentru a lua materiale", 0xFF0000)
                end
                while isCharOnFoot(playerPed) == false do
                    wait(0)
                end
                local x, y, z = getCharCoordinates(playerPed)
                if is_point_inside(x, y) then
                    sampSendChat("/work")
                    wait(20000)
                end
            end
        end
    end
end

function togMats() -- TODO
    enabled = not enabled
    
    if enabled == false then
        deleteObject(object1)
        deleteObject(object2)
        deleteObject(object3)
        deleteObject(object4)
        sampAddChatMessage("Auto getmats {ff1900}Disabled", 0x6de83c)
    else
        create_objects_at_points()
        sampAddChatMessage("Auto getmats {1ed402}Enabled", 0x6de83c)
    end
end
