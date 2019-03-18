function playScene()
    local play = Play()
    local scene = {}
    scene.action = action
    
    -- local variables
    local start
    local stop
    local action
    local layers = {}
    
    function scene.enter()       
        return true
    end
    
    function scene.act()
        start = start or time.total
        action = action or scene.action(start)

        -- start, stop, actionType, object (draw), action (tween)

        for _, l in pairs(layers) do
            l:draw()
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
