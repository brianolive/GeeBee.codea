function gbTrunk(input)   
    local t = {}
    t.count = input.count or 1
    t.screen = createGbScreen()
    t.radius = 50
    t.type = {1}
    t.collidesWith = {1}
    t.gravityScale = 1
    
    t.position = input.position or vec2(math.random(100, WIDTH - 100), math.random(100, HEIGHT - 100))
    
    for i = 1, t.count do
        gb(t)
    end
end