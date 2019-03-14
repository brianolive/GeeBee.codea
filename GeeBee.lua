--instance = geeBee("300", x, y, size)

function geeBee(id, x, y, size)
    local c = getRgb(id)
    local pupilSize = size * 0.08
    
    local body = physics.body(CIRCLE, size / 2)
    body.position = vec2(x, y)

    eyes = {}
    if c.r == "0" then
        eyes["r"] = nil
    elseif c.r == "1" then
        eyes["r"] = vec2(-size * 0.21, -size * 0.21)
    elseif c.r == "2" then
        eyes["r"] = vec2(-size * 0.21, 0)
    elseif c.r == "3" then
        eyes["r"] = vec2(-size * 0.21, size * 0.21)
    end
    
    if c.g == "0" then
        eyes["g"] = nil
    elseif c.g == "1" then
        eyes["g"] = vec2(0, -size * 0.21)
    elseif c.g == "2" then
        eyes["g"] = vec2(0, 0)
    elseif c.g == "3" then
        eyes["g"] = vec2(0, size * 0.21)
    end
    
    if c.b == "0" then
        eyes["b"] = nil
    elseif c.b == "1" then
        eyes["b"] = vec2(size * 0.21, -size * 0.21)
    elseif c.b == "2" then
        eyes["b"] = vec2(size * 0.21, 0)
    elseif c.b == "3" then
        eyes["b"] = vec2(size * 0.21, size * 0.21)
    end
    
    local pupils = {}
    local joints = {}
    for k, v in pairs(eyes) do
        pupils[k] = physics.body(CIRCLE, 1) 
        pupils[k].position = vec2(body.x + eyes[k].x + (size * 0.03), body.y + eyes[k].y)
        
        joints[k] = physics.joint(REVOLUTE, body, pupils[k], vec2(body.x + eyes[k].x, body.y + eyes[k].y))
    end
    
    local function draw()
        pushStyle()
            
        pushMatrix()
        translate(body.x, body.y)
        rotate(body.angle)
        sprite("Project:GeeBees/" .. id, 0, 0, size) 
        popMatrix()
        
        fill(0, 0, 0, 255)
        for k, v in pairs(pupils) do
            ellipse(v.x, v.y, pupilSize)
        end

        popStyle()
    end
    
    return draw, body
end

function getRgb(id)
    local r = id:sub(1, 1)
    local g = id:sub(2, 2)
    local b = id:sub(3, 3)
    
    return {["r"] = r, ["g"] = g, ["b"] = b}
end
