local defaultGBRadius = 50
local bodySizeFactor = 0.81
local eyeSizeFactor = 0.03

--[[
t = {
    layer,
    trunk,
    id,
    position,
    radius,
    type,
    collidesWith,
    gravityScale
}
]]--
function gb(t)
    -- Create new gb in prop trunk
    t.trunk[#t.trunk + 1] = {}
    
    -- Create physics body
    local body = physics.body(CIRCLE, (t.radius or defaultGBRadius) * bodySizeFactor)
    body.position = t.position
    body.categories = t.type or {1}
    body.mask = t.collidesWith or {1}
    body.gravityScale = t.gravityScale or 1
    
    -- Store attributes
    body.info = {}
    body.info.id = t.id
    
    -- Add texture to rect, add rect to layer, store gb in trunk
    body.info.rect = t.layer:addRect(body.x, body.y, body.radius * 2, body.radius * 2)
    local texture = getGeeBeeTex(body.info.id)
    t.layer:setRectTex(body.info.rect, texture.x, texture.y, 0.125, 0.125)

    t.trunk[#t.trunk] = body
    
    -- Create eyes
    local eyeCenters, eyeOffsets = getEyePositions(t.id, t.radius * 2)
    for k, v in pairs(eyeCenters) do
        -- Create new eye in prop trunk
        t.trunk[#t.trunk + 1] = {}
        
        -- Create physics body
        eyeBody = physics.body(CIRCLE, (t.radius * 2) * eyeSizeFactor)
        eyeBody.position = vec2(body.x + eyeOffsets[k].x, body.y + eyeOffsets[k].y)
        eyeBody.categories = {2}
        eyeBody.mask = {} 
        eyeBody.gravityScale = 40
        
        -- Store attributes
        eyeBody.info = {}
        
        eyeBody.info.rect = t.layer:addRect(body.x + eyeOffsets[k].x, body.y + eyeOffsets[k].y, (t.radius * 2) * eyeSizeFactor,
            (t.radius * 2) * eyeSizeFactor)
        t.layer:setRectTex(eyeBody.info.rect, 0.875, 0, 0.008, 0.008)
        
        eyeBody.info.joint = physics.joint(REVOLUTE, body, eyeBody, vec2(body.x + v.x, body.y + v.y))
        
        t.trunk[#t.trunk] = eyeBody
    end
end

function getRgb(id)
    local r = id:sub(1, 1)
    local g = id:sub(2, 2)
    local b = id:sub(3, 3)
    
    return {["r"] = r, ["g"] = g, ["b"] = b}
end

function getEyePositions(id, size)
    local eyeCenters = {}
    local offset = 0.17
    local c = getRgb(id)
    
    if c.r == "0" then
        eyeCenters["r"] = nil
    elseif c.r == "1" then
        eyeCenters["r"] = vec2(-size * offset, -size * offset)
    elseif c.r == "2" then
        eyeCenters["r"] = vec2(-size * offset, 0)
    elseif c.r == "3" then
        eyeCenters["r"] = vec2(-size * offset, size * offset)
    end
    
    if c.g == "0" then
        eyeCenters["g"] = nil
    elseif c.g == "1" then
        eyeCenters["g"] = vec2(0,  -size * offset)
    elseif c.g == "2" then
        eyeCenters["g"] = vec2(0, 0)
    elseif c.g == "3" then
        eyeCenters["g"] = vec2(0, size * offset)
    end
    
    if c.b == "0" then
        eyeCenters["b"] = nil
    elseif c.b == "1" then
        eyeCenters["b"] = vec2(size * offset, -size * offset)
    elseif c.b == "2" then
        eyeCenters["b"] = vec2(size * offset, 0)
    elseif c.b == "3" then
        eyeCenters["b"] = vec2(size * offset, size * offset)
    end
    
    -- Adjust each eye slightly off center
    local eyeOffsets = {}
    local eyeOffSet = 0.02
    for k, v in pairs(eyeCenters) do
        local eyeStartPosX
        if math.random() < 0.5 then
            eyeStartPosX = -1
        else
            eyeStartPosX = 1
        end
        eyeOffsets[k] = vec2(0, 0)
        eyeOffsets[k].x = v.x + (size * eyeOffSet * eyeStartPosX)
        
        local eyeStartPosY
        if math.random() < 0.5 then
            eyeStartPosY = -1
        else
            eyeStartPosY = 1
        end
        eyeOffsets[k].y = v.y + (size * eyeOffSet * eyeStartPosY)
    end

    return eyeCenters, eyeOffsets
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

function randomGBId()
    local id = "000"
    while id == "000" do
        id = tostring(math.random(0, 3)) .. tostring(math.random(0, 3)) .. tostring(math.random(0, 3))
    end
    
    return id
end
