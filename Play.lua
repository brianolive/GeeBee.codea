function playScene()
    local play = Play()
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
        action(1, 1, gbTrunkExample)
        action(2, stop, gbTrunkUpdate)

        for _, screen in pairs(scene.screens) do
            screen.mesh:draw()
        end
    end
    
    function scene.exit()
        return stop
    end
    
    function scene.touched(t)

    end

    return scene
end

function Play()
    local play = {
        tweens = {}
    }
    
    return play
end
