function playScene()
    local play = Play()
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
        action{1, stop, play.theGeeBee, "newColor"}
        action{2, stop, play.theGeeBee}
        action{60, stop, play.popper, "ifPop"}
    end
    
    function scene.exit()
        return stop
    end
    
    function scene.touched(t)
        action{1, stop, play, "ifTouched", {t}}
    end
    
    return scene
end

function Play()
    local numTubes = 8
    local margin = 300
    local playZone = (WIDTH - (margin * 2))
    local tubeSpacing = playZone / (numTubes - 1)
    local geeBeeSize = tubeSpacing / 2

    local play = {
        popper = {
            tubes = {}
        },
        theGeeBee = {},
        tweens = {}
    }

    for i = 1, numTubes do
        play.popper.tubes[i] = {}
        play.popper.tubes[i][1] = margin + (tubeSpacing * (i - 1))
        play.popper.tubes[i][2] = false
    end
    
    function play.ifTouched(params)
        local t = params[1]

        if mix(t) == true then
            local c = getMixedColor()

            local highest
            local highestHeight = 0
            for i = 1, numTubes do
                if play.popper.tubes[i][2] == true and play.popper.tubes[i][4] == c then
                    if play.popper.tubes[i][3].y > highestHeight then
                        highest =i
                        highestHeight = play.popper.tubes[i][3].y
                    end
                end
            end
            
            if highest then
                tween(0.3, play.popper.tubes[highest][4], {a = 0})
            end
        end
    end
    
    function play.popper.ifPop(params)
        for i = 1, numTubes do
            if play.popper.tubes[i][2] == true and play.popper.tubes[i][3].y < 0 then
                play.popper.tubes[i][2] = false
                play.popper.tubes[i][3] = nil
                play.popper.tubes[i][4] = nil
            end
        end
        
        if time.total % stage.player.popTime == 0 then
            local tube
            while tube == nil do
                local choice = math.random(1, numTubes)
                if play.popper.tubes[choice][2] == false then
                    tube = choice
                    play.popper.tubes[choice][2] = true
                    break
                end
            end

            play.popper.tubes[tube][3] = physics.body(CIRCLE, geeBeeSize)
            play.popper.tubes[tube][3].x = play.popper.tubes[tube][1]
            play.popper.tubes[tube][3].y = 0
            play.popper.tubes[tube][3].gravityScale = 8
            play.popper.tubes[tube][4] = color(geeBee.col.r, geeBee.col.g, geeBee.col.b, geeBee.col.a)
            
            play.popper.tubes[tube][3]:applyLinearImpulse(vec2(0, 60))
        end
    end
    
    function play.popper.draw(params)
        pushStyle()
       
        if geeBee.col then 
            for i = 1, numTubes do
                if play.popper.tubes[i][2] == true then
                    fill(play.popper.tubes[i][4])
                    ellipse(play.popper.tubes[i][3].x, play.popper.tubes[i][3].y, geeBeeSize)              
                end
            end
        end
        
        popStyle()
    end
    
    function play.theGeeBee.newColor()       
        local c = {0, 0, 0}

        while (c[1] == 0 and c[2] == 0 and c[3] == 0) do
            for i = 1, 3 do
                c[i] = math.max((64 * math.random(0, 4)) - 1, 0)
            end
        end
        
        geeBee.set(color(c[1], c[2], c[3], 255))
    end
    
    function play.theGeeBee.draw()
        geeBee.draw()
    end
    
    return play
end
