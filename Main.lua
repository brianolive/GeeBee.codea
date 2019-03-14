-- GeeBee

function setup()
    displayMode(FULLSCREEN)  
    --scenes(2)
    
    --table.insert(stage.left, time)
    gb, gbb = geeBee("123", WIDTH / 2, HEIGHT / 2, 100)
    gbb.gravityScale = 0
    
    atlas = image(4096, 4096)
    setContext(atlas)
    fill(0, 9, 255, 255)
    ellipse(2000, 2000, 500)
    sprite("Project:GeeBees/300",1000,1000,1000)
    setContext()
    
    saveImage("Dropbox:test", atlas)
end

function draw()
    background(0, 0, 0, 255)
    
    time.start()
    --scenes.direct()
    gb()
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
    
    function scene.enter()
        return true
    end
    
    function scene.act()
        start = start or time.total
        action = action or scene.action(start)

        -- start, stop, object (draw), action (tween)
        
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