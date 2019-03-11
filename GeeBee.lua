geeBee = {}
    
function geeBee.set(c)
    geeBee.col = c
    
    local col = {c.r, c.g, c.b}
    local x = {56, 128, 200} 
    local values = {127, 191, 255}
    local y = {60, 128, 197}
    
    geeBee.img = image(256, 256)
    setContext(geeBee.img)
    
    pushStyle()
    strokeWidth(6)
    
    if c.r + c.g + c.b > 375 then
        fill(0)
        stroke(0)
    else
        fill(255)
        stroke(255)
    end
    
    line(94, 25, 94, 231)
    line(162, 25, 162, 231)

    for i, v in ipairs(col) do
        for j, vv in ipairs(values) do
            if v == vv then
                ellipse(x[i], y[j], 44)
            end
        end
    end
    
    popStyle()
    setContext()
end

function geeBee.draw()
    if geeBee.img and geeBee.col then
        pushStyle()
        fill(geeBee.col)
        strokeWidth(0)
        ellipse(WIDTH - 100, HEIGHT - 100, 100)
        sprite(geeBee.img, WIDTH - 100, HEIGHT - 100, 75)
        popStyle()
    end
end
