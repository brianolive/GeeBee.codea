-- GeeBee

function setup()
    displayMode(FULLSCREEN)
    physics.gravity(0, -10)
    --scenes(1)
    
    --table.insert(stage.left, time)
    
    layers = {{}}
    
    geebees = layers[1]
    geebees[1] = mesh()
    geebees[1].texture = readImage("Project:geebees")
    geebees[2] = {}
    
    for i = 1, 400 do
        local id = tostring(math.random(0, 3)) .. tostring(math.random(0, 3)) .. tostring(math.random(0, 3))
        if id == "000" then
            id = "001"
        end
        geeBee(geebees, id, math.random(100, WIDTH - 100), math.random(100, HEIGHT - 100), 100)
    end
end

function draw()
    background(0, 0, 0, 255)

    geebees[1]:draw()

    for _, v in pairs(geebees[2]) do
        local attr = v[1]
        local phy = v[2]
        local meshRect = v[3]

        geebees[1]:setRect(meshRect, phy.x, phy.y, attr.size.x, attr.size.y, math.rad(phy.angle))
    end
    
    --time.start()
    --scenes.direct()
end

--[[
function sceneTemplate()
    local sceneTable = SceneTable()
    local scene = {}
    scene.action = action
    
    -- local variables
    local start
    local stop
    local action
    local meshes = {}
    
    function scene.enter()
        return true
    end
    
    function scene.act()
        start = start or time.total
        action = action or scene.action(start)

        -- start, stop, object (draw), action (tween)
        
        for _, m in pairs(meshes) do
            m:draw()
        end
    end
    
    function scene.exit()
        return stop
    end
    
    function scene.touched()
        -- Do nothing
    end
    
    return scene
end
]]--