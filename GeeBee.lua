--instance = geeBee("300", x, y, size)

function geeBee(layer, id, x, y, size)
    local geeBeeMesh = layer[1]
    local geeBeeRects = layer[2]
    local phySize = size * 0.81
    
    -- New GeeBee
    geeBeeRects[#geeBeeRects + 1] = {}
    local newGeeBee = geeBeeRects[#geeBeeRects]
    
    newGeeBee[1] = {["size"] = vec2(size, size)}
    
    newGeeBee[2] = physics.body(CIRCLE, phySize / 2)
    newGeeBee[2].position = vec2(x, y)
    newGeeBee[2].categories = {2}
    newGeeBee[2].mask = {2}
    newGeeBee[2].gravityScale = 0
     
    newGeeBee[3] = geeBeeMesh:addRect(newGeeBee[2].x,
        newGeeBee[2].y, newGeeBee[1].size.x, newGeeBee[1].size.y)
    tex = getGeeBeeTex(id)
    geeBeeMesh:setRectTex(newGeeBee[3], tex.x, tex.y, 0.125, 0.125)
    
    -- New GeeBee eyes
    local eyePositions = getEyePositions(id, newGeeBee[1].size.x)
    
    local eyeStartPosX
    if math.random() < 0.5 then
        eyeStartPosX = -1
    else
        eyeStartPosX = 1
    end
    
    local eyeStartPosY
    if math.random() < 0.5 then
        eyeStartPosY = -1
    else
        eyeStartPosY = 1
    end
    
    for k, v in pairs(eyePositions) do
        geeBeeRects[#geeBeeRects + 1] = {}
        local newEye = geeBeeRects[#geeBeeRects]
        
        newEye[1] = {["size"] = vec2(size * 0.08, size * 0.08)}
        
        newEye[2] = physics.body(CIRCLE, 5)
        newEye[2].position = vec2(newGeeBee[2].x + v.x + (size * 0.02 * eyeStartPosX),
            newGeeBee[2].y + v.y + (size * 0.02 * eyeStartPosY))
        newEye[2].categories = {3}
        newEye[2].mask = {} 
        newEye[2].gravityScale = 40

        newEye[3] = geeBeeMesh:addRect(newEye[2].x, newEye[2].y, newEye[1].size.x, newEye[1].size.y)
        geeBeeMesh:setRectTex(newEye[3], 0.875, 0, 0.008, 0.008)

        newEye[2].info = {}
        newEye[2].info.joint = physics.joint(REVOLUTE, newGeeBee[2], newEye[2],
            vec2(newGeeBee[2].x + v.x, newGeeBee[2].y + v.y))
    end
end

function getRgb(id)
    local r = id:sub(1, 1)
    local g = id:sub(2, 2)
    local b = id:sub(3, 3)
    
    return {["r"] = r, ["g"] = g, ["b"] = b}
end

function getEyePositions(id, size)
    local eyePositions = {}
    local c = getRgb(id)
    
    if c.r == "0" then
        eyePositions["r"] = nil
    elseif c.r == "1" then
        eyePositions["r"] = vec2(-size * 0.21, -size * 0.21)
    elseif c.r == "2" then
        eyePositions["r"] = vec2(-size * 0.21, 0)
    elseif c.r == "3" then
        eyePositions["r"] = vec2(-size * 0.21, size * 0.21)
    end
    
    if c.g == "0" then
        eyePositions["g"] = nil
    elseif c.g == "1" then
        eyePositions["g"] = vec2(0,  -size * 0.21)
    elseif c.g == "2" then
        eyePositions["g"] = vec2(0, 0)
    elseif c.g == "3" then
        eyePositions["g"] = vec2(0, size * 0.21)
    end
    
    if c.b == "0" then
        eyePositions["b"] = nil
    elseif c.b == "1" then
        eyePositions["b"] = vec2(size * 0.21, -size * 0.21)
    elseif c.b == "2" then
        eyePositions["b"] = vec2(size * 0.21, 0)
    elseif c.b == "3" then
        eyePositions["b"] = vec2(size * 0.21, size * 0.21)
    end

    return eyePositions
end

function getGeeBeeTex(id)
    local texMap = {
        ["001"] = vec2(1, 1),
        ["002"] = vec2(1, 2),
        ["003"] = vec2(1, 3),
        ["010"] = vec2(1, 4),
        ["011"] = vec2(1, 5),
        ["012"] = vec2(1, 6),
        ["013"] = vec2(1, 7),
        ["020"] = vec2(1, 8),
        ["021"] = vec2(2, 1),
        ["022"] = vec2(2, 2),
        ["023"] = vec2(2, 3),
        ["030"] = vec2(2, 4),
        ["031"] = vec2(2, 5),
        ["032"] = vec2(2, 6),
        ["033"] = vec2(2, 7),
        ["100"] = vec2(2, 8),
        ["101"] = vec2(3, 1),
        ["102"] = vec2(3, 2),
        ["103"] = vec2(3, 3),
        ["110"] = vec2(3, 4),
        ["111"] = vec2(3, 5),
        ["112"] = vec2(3, 6),
        ["113"] = vec2(3, 7),
        ["120"] = vec2(3, 8),
        ["121"] = vec2(4, 1),
        ["122"] = vec2(4, 2),
        ["123"] = vec2(4, 3),
        ["130"] = vec2(4, 4),
        ["131"] = vec2(4, 5),
        ["132"] = vec2(4, 6),
        ["133"] = vec2(4, 7),
        ["200"] = vec2(4, 8),
        ["201"] = vec2(5, 1),
        ["202"] = vec2(5, 2),
        ["203"] = vec2(5, 3),
        ["210"] = vec2(5, 4),
        ["211"] = vec2(5, 5),
        ["212"] = vec2(5, 6),
        ["213"] = vec2(5, 7),
        ["220"] = vec2(5, 8),
        ["221"] = vec2(6, 1),
        ["222"] = vec2(6, 2),
        ["223"] = vec2(6, 3),
        ["230"] = vec2(6, 4),
        ["231"] = vec2(6, 5),
        ["232"] = vec2(6, 6),
        ["233"] = vec2(6, 7),
        ["300"] = vec2(6, 8),
        ["301"] = vec2(7, 1),
        ["302"] = vec2(7, 2),
        ["303"] = vec2(7, 3),
        ["310"] = vec2(7, 4),
        ["311"] = vec2(7, 5),
        ["312"] = vec2(7, 6),
        ["313"] = vec2(7, 7),
        ["320"] = vec2(7, 8),
        ["321"] = vec2(8, 1),
        ["322"] = vec2(8, 2),
        ["323"] = vec2(8, 3),
        ["330"] = vec2(8, 4),
        ["331"] = vec2(8, 5),
        ["332"] = vec2(8, 6),
        ["333"] = vec2(8, 7)
    }
    
    return vec2((texMap[id].y - 1) * 0.125, (8 - texMap[id].x) * 0.125)
end
