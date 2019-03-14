-- GeeBee

function setup()
    displayMode(FULLSCREEN)  
    scenes(1)
    
    --table.insert(stage.left, time)
    --gb, gbb = geeBee("123", WIDTH / 2, HEIGHT / 2, 100)
    --gbb.gravityScale = 0

    m = mesh()
    m.texture = readImage("Project:atlas")
    i = m:addRect(400, 400, 500, 500)
    m:setRectTex(i, 0.625, 0.5, 0.125, 0.125)
end

function draw()
    background(0, 0, 0, 255)

    time.start()
    scenes.direct()
    --gb()
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