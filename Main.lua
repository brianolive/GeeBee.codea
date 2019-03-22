-- GeeBee

function setup()
    displayMode(FULLSCREEN)
    physics.gravity(0, -10)
    scenes(2)
    
    --table.insert(stage.left, time)
end

function draw()
    background(0, 0, 0, 255)

    time.start()
    scenes.direct()
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
    scene.screens = {}
    
    function scene.enter()
        return true
    end
    
    function scene.act()
        start = start or time.total
        action = action or scene.action(start)

        -- start, stop, method, parameters

        for _, screen in pairs(scene.screens) do
            screen.mesh:draw()
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

function SceneTable()
    local sceneTable = {
        tweens = {}
    }
    
    return sceneTable
end
]]--