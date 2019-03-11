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
        --action{1, stop, play.mixBoard}
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
        mixBoard = {},
        popper = {
            tubes = {}
        },
        theGeeBee = {
            count = 10
        },
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
                tween(0.3, play.popper.tubes[highest][4], {a = 0}, tween.easing.linear,
                    function()
                        play.popper.tubes[highest][2] = false
                        play.popper.tubes[highest][3] = nil
                    end
                )
                
                if c == geeBee.col then
                    play.theGeeBee.count = play.theGeeBee.count - 1
                end
            end
        end
    end
    
    function play.mixBoard.draw()
        pushStyle()
        
        stroke(127, 127, 127, 255)
        strokeWidth(1)
        
        line(0, HEIGHT / 2, 200, HEIGHT / 2)
        line(0, (HEIGHT / 6) * 2, 200, (HEIGHT / 6) * 2)
        line(0, HEIGHT / 6, 200, HEIGHT / 6)
        line(200, 0, 200, HEIGHT / 2)
        
        line(WIDTH - 400, HEIGHT / 2, WIDTH, HEIGHT / 2)
        line(WIDTH - 400, (HEIGHT / 6) * 2, WIDTH, (HEIGHT / 6) * 2)
        line(WIDTH - 400, HEIGHT / 6, WIDTH, HEIGHT / 6)
        line(WIDTH - 400, 0, WIDTH - 400, HEIGHT / 2)
        line(WIDTH - 200, 0, WIDTH - 200, HEIGHT / 2)
        
        popStyle()
    end
    
    function play.popper.ifPop(params)
        for i = 1, numTubes do
            if play.popper.tubes[i][2] == true and play.popper.tubes[i][3].y < 0 then
                play.popper.tubes[i][2] = false
                play.popper.tubes[i][3] = nil
                play.popper.tubes[i][4] = nil
                play.popper.tubes[i][5] = nil
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

            play.popper.tubes[tube][3] = physics.body(CIRCLE, geeBeeSize / 2)
            play.popper.tubes[tube][3].x = play.popper.tubes[tube][1]
            play.popper.tubes[tube][3].y = 0
            play.popper.tubes[tube][3].gravityScale = 8
            play.popper.tubes[tube][3].categories = {1}
            play.popper.tubes[tube][3].mask = {2}
            play.popper.tubes[tube][4] = color(geeBee.col.r, geeBee.col.g, geeBee.col.b, geeBee.col.a)
            
            play.popper.tubes[tube][5] = physics.body(CIRCLE, 2)
            play.popper.tubes[tube][5].x = play.popper.tubes[tube][3].x + 17
            play.popper.tubes[tube][5].y = play.popper.tubes[tube][3].y + 8

            eyeJoint = physics.joint(REVOLUTE, play.popper.tubes[tube][3], play.popper.tubes[tube][5],
                vec2(play.popper.tubes[tube][3].x + 15, play.popper.tubes[tube][3].y + 7))
            eyeJoint.enableMotor = true
            eyeJoint.maxMotorTorque = 100
            eyeJoint.motorSpeed = 500
            
            local sideForce = math.random(-10, 10)
            play.popper.tubes[tube][3]:applyLinearImpulse(vec2(sideForce, 150),
                vec2(play.popper.tubes[tube][3].x + math.random(-1, 1),
                play.popper.tubes[tube][3].y)
            )
        end
    end
    
    function play.popper.draw(params)
        pushStyle()
       
        if geeBee.col then 
            for i = 1, numTubes do
                if play.popper.tubes[i][2] == true then
                    --[[
                    fill(play.popper.tubes[i][4])
                    ellipse(play.popper.tubes[i][3].x, play.popper.tubes[i][3].y, geeBeeSize)
                    
                    pushMatrix()
                    pushStyle()

                    translate(play.popper.tubes[i][3].x, play.popper.tubes[i][3].y)
                    rotate(play.popper.tubes[i][3].angle)
                    
                    stroke(0, 0, 0, 255)
                    strokeWidth(1)
                    fill(255, 255, 255, 255)
                    ellipse(15, 7, 15)

                    popStyle()
                    popMatrix()
                    
                    pushStyle()
                    
                    fill(0, 0, 0, 255)
                    ellipse(play.popper.tubes[i][5].x, play.popper.tubes[i][5].y, 7)
                    
                    popStyle()
                    ]]--
                    print(geeBeeSize)
                    pushMatrix()
                    translate(play.popper.tubes[i][3].x, play.popper.tubes[i][3].y)
                    rotate(play.popper.tubes[i][3].angle)
                    sprite("Dropbox:Apple 2", 0, 0, 75)
                    popMatrix()
                end
            end
        end
        
        popStyle()
    end
    
    function play.theGeeBee.newColor()       
        local c = {0, 0, 0}

        while (c[1] == 0 and c[2] == 0 and c[3] == 0) do
            for i = 1, 3 do
                r = math.random(0, 4)
                while r == 1 do
                    r = math.random(0, 4)
                end
                
                c[i] = math.max((64 * r) - 1, 0)
            end
        end
        
        geeBee.set(color(c[1], c[2], c[3], 255))
    end
    
    function play.theGeeBee.draw()
        geeBee.draw()
        
        pushStyle()
        
        font("AmericanTypewriter-Bold")
        fontSize(20)
        fill(255, 255, 255, 255)
        text(tostring(play.theGeeBee.count), WIDTH - 100, HEIGHT - 175)
        
        popStyle()
    end
    
    return play
end
