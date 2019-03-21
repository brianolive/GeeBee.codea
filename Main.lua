-- GeeBee

function setup()
    displayMode(FULLSCREEN)
    physics.gravity(0, -10)
    --scenes(1)
    
    --table.insert(stage.left, time)
    
    screens = {}
    screens[1] = {}
    gbScreen = screens[1]
    
    gbScreen.mesh = mesh()
    gbScreen.mesh.texture = readImage("Project:geebees")    
    gbScreen.trunk = {}
    
    local t = {
        screen = gbScreen,
        radius = 50,
        type = {1},
        collidesWith = {1},
        gravityScale = 1
    }
    
    for i = 1, 100 do
        t.id = randomGBId()
        t.position = vec2(math.random(100, WIDTH - 100), math.random(100, HEIGHT - 100))
        gb(t)
    end
end

function draw()
    background(0, 0, 0, 255)

    gbScreen.mesh:draw()
    
    for _, v in pairs(gbScreen.trunk) do
        gbScreen.mesh:setRect(v.info.rect, v.position.x, v.position.y, v.radius * 2.5, v.radius * 2.5, math.rad(v.angle))
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